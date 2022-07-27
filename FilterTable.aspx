<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication7.WebForm1" %>

<!DOCTYPE html>
<html>
<head runat="server">
<title></title>

    <script src="JS/xlsx.full.min.js"></script>
    <script src="JS/moment.min.js"></script>
    <script src="JS/datatables.min.js"></script>
    <script src="JS/bootstrap-datepicker.min.js"></script>
    <link href="CSS/datatables.min.css" rel="stylesheet" />

<style>
ul {
  list-style-type: none;
  margin: auto;
  padding: 0;
  overflow: hidden;
  background-color: #3ec3c3;
}
li {
  float: left;
}
li1{
  float: right;
}
.selectdiv {
  position: relative;
  float: left;
  min-width: 200px;
  margin: auto;
  padding: 0px 22px;
}
.date {
  position: relative;
  float: left;
  min-width: 150px;
  display: block;
  height: 50px;
  padding: 0px 22px;
  font-size: 16px;
  margin: auto;
}
select::-ms-expand {
display: none;
}
.selectdiv select {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  display: block;
  width: 100%;
  max-width: 320px;
  height: 50px;
  float: right;
  margin: 5px 0px;
  padding: 0px 24px;
  font-size: 16px;
  line-height: 1.75;
  color: #333;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #cccccc;
  -ms-word-break: normal;
  word-break: normal;
}
.bttn-primary,
.bttn,
.bttn-md {
  color: #1d89ff;
}
.bttn,
.bttn-md {
  margin: 0;
  padding: 0;
  border-width: 0;
  border-color: transparent;
  background: transparent;
  font-weight: 400;
  cursor: pointer;
  position: relative;
}
.bttn-md {
  font-size: 20px;
  font-family: inherit;
  padding: 5px 12px;
}
.bttn-gradient {
  margin: 0;
  padding: 0;
  border-width: 0;
  border-color: transparent;
  background: transparent;
  font-weight: 400;
  cursor: pointer;
  position: relative;
  font-size: 20px;
  font-family: inherit;
  padding: 5px 12px;
  overflow: hidden;
  border-width: 0;
  border-radius: 4px;
  background: rgba(255,255,255,0.4);
  color: #fff;
  -webkit-transition: all 0.3s cubic-bezier(0.02, 0.01, 0.47, 1);
  transition: all 0.3s cubic-bezier(0.02, 0.01, 0.47, 1);
}
.bttn-gradient:hover,
.bttn-gradient:focus {
  opacity: 0.75;
}
.bttn-gradient.bttn-md {
  font-size: 20px;
  font-family: inherit;
  padding: 5px 12px;
}
.bttn-gradient {
  border-radius: 100px;
  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #fff), color-stop(1, #d6e3ff));
  background-image: -webkit-linear-gradient(top, #fff 0%, #d6e3ff 100%);
  background-image: linear-gradient(to bottom, #fff 0%, #d6e3ff 100%);
  background-image: -webkit-linear-gradient(93deg, #d6e3ff 0%, #fff 100%);
  box-shadow: 0 1px 2px rgba(0,0,0,0.25);
  color: #1d89ff;
  text-shadow: 0 1px 0 rgba(255,255,255,0.25);
}
.bttn-gradient.bttn-primary {
  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #00bbd4), color-stop(1, #3f51b5));
  background-image: -webkit-linear-gradient(top, #00bbd4 0%, #3f51b5 100%);
  background-image: linear-gradient(to bottom, #00bbd4 0%, #3f51b5 100%);
  background-image: -webkit-linear-gradient(93deg, #3f51b5 0%, #00bbd4 100%);
  color: #fff;
}
 #tbl {
          font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
        }
 
        #tbl td, #tblStocks th {
          border: 1px solid #ddd;
          padding: 8px;
          text-align: center;
        }
 
        #tbl tr:nth-child(even){background-color: #f2f2f2;}
 
        #tbl tr:hover {background-color: #ddd;}
 
        #tbl th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: center;
            background-color: #294c67;
            color: white;
        }
</style>
</head>
<body>
<ul>
  <li>
  <div class="selectdiv">
  <label>
      <select id="choice1">
          <option value="all1"> ID </option>
          <option value="id123">123</option>
          <option value="id456">456</option>
          <option value="id789">789</option>
          <option value="id555">555</option>
          <option value="id111">111</option>
      </select>
  </label>
  </div>
  </li>
  <li>
  <div class="selectdiv">
  <label>
      <select id="choice2">
          <option value="all2"> Article </option>
          <option value="A">A</option>
          <option value="B">B</option>
          <option value="C">C</option>
          <option value="D">D</option>
      </select>
  </label>
  </div>
  </li>
  <li>
    <div class="input-daterange">
      <input class="date date-range-filter" type="text" id="minDate"  data-date-format="dd-mm-yyyy" placeholder="From:">
      <input class="date date-range-filter" type="text" id="maxDate"  data-date-format="dd-mm-yyyy" placeholder="To:">
    </div>
  </li>
  <li1>
      <button onclick="ExportToExcel('xlsx')" class="bttn-gradient bttn-md bttn-primary">Download</button>
  </li1>
</ul
<br/>
  <table id="tbl" cellpadding="0" cellspacing="0">
      <thead>
            <tr>
                <th>ID</th>
                <th>Article</th>
                <th>Date</th>
            </tr>
      </thead>
      <tbody>
          <tr class="all1 all2 id123 A">
                <td>123</td>
                <td>A</td>
                <td>04-07-2022</td>
              </tr>
              <tr class="all1 all2 id456 A">
                <td>456</td>
                <td>A</td>
                <td>03-07-2022</td>
              </tr>
              <tr class="all1 all2 id789 B">
                <td>789</td>
                <td>B</td>
                <td>04-07-2022</td>
              </tr>
              <tr class="all1 all2 id555 C">
                <td>555</td>
                <td>C</td>
                <td>02-07-2022</td>
              </tr>
              <tr class="all1 all2 id111 D">
                <td>111</td>
                <td>D</td>
                <td>01-07-2022</td>
              </tr>
      </tbody>          
      </table>
    <script type='text/javascript'>
        $('.input-daterange input').each(function () {
            $(this).datepicker('clearDates');
        });
        table = $('#tbl').DataTable({
            paging: false,
            info: false
        });
        $.fn.dataTable.ext.search.push(
            function (settings, data, dataIndex) {
                var min = $('#minDate').val();
                var max = $('#maxDate').val();
                var createdAt = data[2] || 0; 
                if (
                    (min == "" || max == "") ||
                    (moment(createdAt).isSameOrAfter(min) && moment(createdAt).isSameOrBefore(max))
                ) {
                    return true;
                }
                return false;
            }
        );
        $('.date-range-filter').change(function () {
            table.draw();
        });
        $('#tbl_filter').hide();

        function ExportToExcel(type, fn, dl) {
            var elt = document.getElementById('tbl');
            var wb = XLSX.utils.table_to_book(elt, { sheet: "Sheet1" });
            return dl ?
                XLSX.write(wb, { bookType: type, bookSST: true, type: 'base64' }) :
                XLSX.writeFile(wb, fn || ('example.' + (type || 'xlsx')));
        }

        $("#choice1").change(function () {
            $("#tbl tbody tr").hide();
            $("#tbl tbody tr." + $(this).val()).show('fast');
        });
        $("#choice2").change(function () {
            $("#tbl tbody tr").hide();
            $("#tbl tbody tr." + $(this).val()).show('fast');
        });
        $("#tbl").tablesorter({ sortList: [[0, 0]] });
    </script>
</body>
</html>

