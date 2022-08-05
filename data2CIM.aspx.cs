using ClosedXML.Excel;
using System;
using System.Data;
using System.Web;
using System.IO;
using System.Text;

namespace data2CIM
{
    public partial class Page1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
                 
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            //Create a string from date time to avoid overwriting.
            DateTime localDate = DateTime.Now;
            string DateTimeNow = localDate.Year.ToString() + localDate.Month.ToString() + localDate.Day.ToString() + localDate.Hour.ToString() + localDate.Minute.ToString() + localDate.Second.ToString();
            
            //Text file
            string filenametxt = DateTimeNow+FileTxt.FileName;
            var pathfile = System.IO.Path.Combine(Server.MapPath("~/CIM_Import/"), filenametxt);
            FileTxt.SaveAs(pathfile);
            string OriginalTemplate = File.ReadAllText(Server.MapPath("~/CIM_Import/" + filenametxt)).ToString();
            

            //file excel
            foreach (HttpPostedFile uploadedFile in FileExcel.PostedFiles)
            {
                var xmlPath = System.IO.Path.Combine(Server.MapPath("~/Excel_Import/"), DateTimeNow+uploadedFile.FileName);
                uploadedFile.SaveAs(xmlPath);
            }
            DataTable dt = new DataTable();
            using (XLWorkbook workBook = new XLWorkbook(FileExcel.PostedFile.InputStream))
            {
                IXLWorksheet workSheet = workBook.Worksheet(1);
                bool firstRow = true;
                string readRange = "1:1";
                foreach (IXLRow row in workSheet.Rows())
                {
                    if (firstRow)
                    {
                        readRange = string.Format("{0}:{1}", 1, row.LastCellUsed().Address.ColumnNumber);
                        foreach (IXLCell cell in row.Cells(readRange))
                        {
                            dt.Columns.Add(cell.Value.ToString());
                        }
                        firstRow = false;
                    }
                    else
                    {
                        dt.Rows.Add();
                        int i = 0;
                        foreach (IXLCell cell in row.Cells(readRange))
                        {
                            dt.Rows[dt.Rows.Count - 1][i] = cell.Value.ToString();
                            i++;
                        }
                    }
                }

            }
            MergFile(dt, OriginalTemplate);            
        }

        public void MergFile(DataTable dataTable, string FullString)
        {
            DateTime localDate = DateTime.Now;
            string DateTimeNow = localDate.Year.ToString() + localDate.Month.ToString() + localDate.Day.ToString() + localDate.Hour.ToString() + localDate.Minute.ToString() + localDate.Second.ToString();
            
            //divide string text
            var pos = FullString.ToString().IndexOf("@@format");
            string[] FormatString = FullString.ToString().Remove(0, pos).Split(' '); //remove string before @@format
            string OriginalString = FullString.ToString().Remove(pos); //remove string after @@format
            
            string indexDate = FormatString[FormatString.Length - 2].Trim('[', ']');
            string formatDate = FormatString[FormatString.Length - 1].Trim('[', ']');
            
            string[] CleanStr = OriginalString.Replace("\r\n", " ").Split(' ');      
            string[] HalfClean = OriginalString.Replace("\n", " ").Split(' ');

            bool[] NonnumberPosition = new bool[OriginalString.Length];
            bool[] EndlinePosition = new bool[OriginalString.Length];
            bool[] SpacingPosition = new bool[OriginalString.Length];

            //Reset to identification string to false
            for (int Index = 0; Index < HalfClean.Length; Index++)
            {
                NonnumberPosition[Index] = false;
                EndlinePosition[Index] = false;
                SpacingPosition[Index] = true;
            }
            
            SpacingPosition[0] = false;// no need for spacing in front of the first words

            //Scanning the half clean string to determine wherever the positon is non number and containing line feed
            for (int Index = 0; Index<HalfClean.Length;Index++)
            {
                if(HalfClean[Index].Contains("\""))
                {
                    NonnumberPosition[Index] = true;
                }
                if(HalfClean[Index].Contains("\r"))
                {
                    EndlinePosition[Index] = true;
                }
                if (Index > 0)
                {
                    if (HalfClean[Index - 1].Contains("\r"))
                        SpacingPosition[Index] = false;
                }
                
            }           

            //Create header string from data table
            string[] headerTable = new string[dataTable.Columns.Count];
            for (int i = 0; i < dataTable.Columns.Count; i++)
            {
                headerTable[i] = (dataTable.Columns[i].ColumnName);
            }
            
            //Position Date
            var posDate = 0;
            for (int i = 0; i < headerTable.Length; i++)
            {
                if (headerTable[i].Contains(indexDate))
                {
                    posDate = i;
                    break;
                }
            }

            //Convert value of header to corresponding position in the CIM string
            for (int Index =0; Index<headerTable.Length;Index++)
            {                
                for(int I2 = 0; I2 < CleanStr.Length;I2++)
                {
                    if(headerTable[Index].Contains(CleanStr[I2].Trim('\"')))
                    {                        
                        headerTable[Index] = I2.ToString();
                        break;
                    }
                }
            }
          
            //Data forming
            string StringFile = null;
            for (int rowIndex = 0; rowIndex<dataTable.Rows.Count; rowIndex++)//Scanning along the side of data pack
            {
                //String line formation
                string[] lineStr = OriginalString.Replace("\r\n", " ").Split(' ');                                      
                for (int colIndex = 0; colIndex < headerTable.Length; colIndex++)
                {
                    string value = dataTable.Rows[rowIndex][colIndex].ToString();
                    if (colIndex == posDate)
                    {
                        var Date = dataTable.Rows[rowIndex][posDate];
                        try
                        {
                            Date = Convert.ToDateTime(Date).ToString(formatDate);
                            value = Date.ToString();
                        }
                        catch
                        {
                        }
                    }
                    int jumpedPosition = int.Parse(headerTable[colIndex]);
                    lineStr[jumpedPosition] = value;
                }
               
                //Formatting the new line
                for(int txtIndex = 0; txtIndex<lineStr.Length;txtIndex++)
                {
                    if (NonnumberPosition[txtIndex])
                        lineStr[txtIndex] = '\"' + lineStr[txtIndex] + '\"';
                    if (EndlinePosition[txtIndex])
                        lineStr[txtIndex] = lineStr[txtIndex] + '\n';
                    if (SpacingPosition[txtIndex])
                        lineStr[txtIndex] = ' ' + lineStr[txtIndex];
                }

                //String file joining
                for (int index = 0; index <lineStr.Length;index++)
                {
                    string value = lineStr[index];                                      
                    StringFile += value;                    
                }
                StringFile += '\n';
            }            
            
            Encoding W1252 = Encoding.GetEncoding(1252);
            string pathCIM = Server.MapPath(@"~/file_download/"+ DateTimeNow + "file.cim");

            using (FileStream fs = File.Create(pathCIM))
            {
                byte[] info = Encoding.Convert(Encoding.Unicode, W1252, Encoding.Unicode.GetBytes(StringFile.Trim('\n')));
                fs.Write(info, 0, info.Length);
            }

            string file = DateTimeNow + "file.cim";
            System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
            response.ClearContent();
            response.Clear();           
            response.AddHeader("Content-Disposition", "attachment; filename=" + file + ";");            
            response.TransmitFile(pathCIM);
            response.Flush();
            response.End();
        }            

        public void PrintTable(DataTable dt)
        {
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                Response.Write($"{dt.Columns[i]} ");
            }
            Response.Write("<br>");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    Response.Write($"{dt.Rows[i][j]} ");
                }
                Response.Write("<br>");
            }
        }               
    }
}
