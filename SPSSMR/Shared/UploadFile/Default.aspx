<%@ Page language="c#" Codebehind="Default.aspx.cs" Inherits="SPSSMR.Web.UI.UploadFile.Default" AutoEventWireup="false" %>
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
	<body onload="javascript:document.getElementById('panelProgressBar').style.visibility = 'hidden';">
		<base target="_top">
		<form id="Form1" method="post" runat="server">
			<div id="panelBrowse" style="Z-INDEX: 102; WIDTH: 380px; POSITION: absolute; HEIGHT: 125px">
				<iframe id="upload" src="BrowseFile.aspx" frameBorder="0" width="100%" height="100%" scrolling="no"></iframe>
			</div>
			<div id="panelProgressBar" style="Z-INDEX: 103; WIDTH: 380px; POSITION: absolute; HEIGHT: 125px">
				<iframe id="progress" src="Progress.aspx" frameBorder="0" width="100%" height="100%" scrolling="no"></iframe>
			</div>
		</form>
	</body>
</HTML>
