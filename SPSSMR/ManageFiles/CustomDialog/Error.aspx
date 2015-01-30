<%@ Page language="c#" Codebehind="Error.aspx.cs" AutoEventWireup="false" Inherits="SPSSMR.Web.UI.UploadFile.Error" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD runat=server>
		<title runat=server>			
		</title>
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table width="95%" height="150px" cellpadding="12">
				<tr valign=top><td id="MessageText" align="left" >
                        Demo1.mdd already exits.&nbsp;</td>
                </tr>                       
				<tr valign="middle">
					<td align=center><input id="btnClose" onclick="javascript:window.top.close();" type="button" runat="server" NAME="btnClose"></td>
				</tr>
			</table>
			 <script language="javascript">
             var tableCellMsg=document.getElementById('MessageText');
             var fileArg = window.dialogArguments;                 
                 tableCellMsg.innerText=fileArg;
             </script>

           
		</form>
	</body>
</HTML>
