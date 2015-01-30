<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MergeOverwriteCancel.aspx.cs" Inherits="ManageFiles.MergeOverwriteCancelDialog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat=server> </title>
    <LINK href="../../shared/spssmrNet.css" type="text/css" rel="stylesheet">
</head>
<body bgcolor="buttonface" bottommargin="0" topmargin="0">
    <form id="form1" runat="server">
      <div style="vertical-align:bottom; height:100%; width:100%;" align="center">
          <asp:Panel ID="Panel1" runat="server">
              <table align="center" height="100%" style="vertical-align: top" width="100%">
                  <tr>
                      <td>
                          &nbsp;</td>
                      <td>
                          &nbsp;</td>
                  </tr>
                  <tr>
                      <td rowspan="2" style="padding-left: 10px">
                          <span style="display:inline-block; filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='Image/Question.png');">
<img style="filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);" src="Image/Question.png" border="0" alt="">
</span>&nbsp;</td>
                      <td id="MessageText" align="left" rowspan="2" >
                    Demo1.mdd already exits.&nbsp;</td>
                  </tr>
                  <tr>
                  </tr>
                  <tr>
                      <td align="center" colspan="2">
                       <br />
                <input id="btnMerge" onclick="mergeClose()" style="width: 80px" type="button" value=<%= GetBtnMergeText() %> />&nbsp;
                <input id="btnOverwrite" onclick="overwriteClose()" style="width: 80px" type="button" value=<%=GetBtnOverwriteText() %> />&nbsp;
                <input id="btnCancel" name="btnYes" onclick="cancelClose();" style="width: 80px" type="button" value=<%=GetBtnCancelText() %> />
                   &nbsp;</td>
                  </tr>
              </table>
          </asp:Panel>
        </div>
        <script language=javascript>
            window.returnValue='Cancel';
            var tableCell=document.getElementById('MessageText');
            var fileArg = window.dialogArguments;
                tableCell.innerText=fileArg;
            function mergeClose()
             {
                window.returnValue='Merge';
                window.close();
             }
             function overwriteClose()
             {
                window.returnValue='Overwrite';
                window.close();
             }  
               function cancelClose()
             {
                window.returnValue='Cancel';
                window.close();
             }  
        </script>      
    </form>
</body>
</html>
