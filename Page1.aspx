<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page1.aspx.cs" Inherits="data2CIM.Page1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <a>
                Data File:
            </a>
            <asp:FileUpload ID="FileExcel" runat="server" />
             <a>
                CIM Templae:
            </a>
            <asp:FileUpload ID="FileTxt" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="Download" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>
