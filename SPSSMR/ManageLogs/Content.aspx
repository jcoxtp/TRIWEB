<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Content.aspx.cs" Inherits="SPSS.ManageLogs.View.Content" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <script type="text/javascript">
     function GetValue()
     {
        document.getElementById("content").value = top.window.dialogArguments;
        document.getElementById("form1").submit();       
     }
    
     </script>
</head>
<body onload = "GetValue();">
    
    <form id="form1" method="post" action="DetailedInfo.aspx">
    
    <input id="content" name="content" type="hidden" runat="server"/> 
    <input id="a" name="a" type="hidden" runat="server" value="haha"/> 
       
    </form>
</body>
</html>
