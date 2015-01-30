<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuestionYesNo.aspx.cs" Inherits="ManageFiles.CustomDialog.QuestionYesNo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
 <HEAD runat=server>
        <title runat=server>
        
        </title>
        <LINK href="../../shared/spssmrNet.css" type="text/css" rel="stylesheet">
  		<script type="text/javascript" src="MessageBox.js"></script>
</HEAD><body bottommargin="30" bgcolor="buttonface">
    <form id="form1" runat="server">
        <asp:Panel ID="Panel1" runat="server">
            <table align="center" height="100%" style="vertical-align: top" width="100%">
                <tr>
                    <td>
                        &nbsp;</td>
                    <td >
                        &nbsp;</td>
                </tr>
                <tr>
                    <td rowspan="2" style="padding-left: 10px">
                        <span style="display:inline-block; filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='Image/Question.png');">
<img style="filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);" src="Image/Question.png" border="0" alt="">
</span>
&nbsp;</td>
                    <td id="MessageText" align="left" rowspan="2">
                        Demo1.mdd already exits.&nbsp;</td>
                </tr>
                <tr>
                </tr>
                <tr>
						<TD align="center" colspan=2><BR>
							<INPUT  id="btnYes" onclick="closeWindowWithYes();" type="button" name="btnYes" value=<%= GetBtnYesText() %> style="width:80px"  />  &nbsp;
							<INPUT  id="btnNo" onclick="closeWindowWithNo();" type="button" name="btnNo" value=<%=GetBtnNoText() %> style="width:80px"  
					>&nbsp;</TD>					
                </tr>
            </table>  
        </asp:Panel>
        <script language="javascript">
             window.returnValue='No';
            var tableCell=document.getElementById('MessageText');
            var fileArg = window.dialogArguments;
                tableCell.innerText=fileArg;

             function closeWindowWithYes()
             {
                window.returnValue='Yes';
                window.close();
             }  
             function closeWindowWithNo()
             {
                window.returnValue='No';
                window.close();
             }  
        </script>
   </form>
</body>
</html>
