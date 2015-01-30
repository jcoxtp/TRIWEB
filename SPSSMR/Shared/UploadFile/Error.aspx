<%@ Page language="c#" Codebehind="Error.aspx.cs" AutoEventWireup="false" Inherits="SPSSMR.Web.UI.UploadFile.Error" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=Server.HtmlEncode(SPSSMR.Web.UI.UploadFile.Utilities.I18N.GetResourceString("dlgUploadFiles_dialog_title"))%>
		</title>
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table width="330px" height="150px">
				<tr>
					<td align="left"><asp:Label id="lblError" Runat="server"></asp:Label><br></td>
				</tr>
				<tr valign="bottom">
					<td align="right"><input id="btnClose" onclick="javascript:window.top.close();" type="button" runat="server" NAME="btnClose"></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
