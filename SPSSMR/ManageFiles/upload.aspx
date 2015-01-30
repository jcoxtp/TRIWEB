<%@ Page language="c#" Codebehind="upload.aspx.cs" AutoEventWireup="false" EnableEventValidation="false" Inherits="ManageFiles.MainUpload" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title> 

			<%=Server.HtmlEncode(ManageFiles.Utilities.I18N.GetResourceString("dlgUploadFiles_dialog_title"))%>
		</title>
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onload="javascript:document.getElementById('panelProgressBar').style.visibility = 'hidden';">
		<base target="_top">
		<form id="Form1" method="post" runat="server">
<!--			<div id="panelBrowse" style="Z-INDEX: 102; WIDTH: 315px; POSITION: absolute; HEIGHT: 125px"> -->
			<div id="panelBrowse" style="Z-INDEX: 102; WIDTH: 100%; POSITION: absolute; HEIGHT: 100%">
				<iframe id="upload" src="UploadFile.aspx" frameBorder="0" width="100%" height="100%" scrolling="no"></iframe>
			</div>
			<div id="panelProgressBar" style="Z-INDEX: 103; WIDTH: 350px; POSITION: absolute; HEIGHT: 125px; top: 180; left:250">
				<iframe id="progress" src="CustomProgress.aspx" frameBorder="0" width="100%" height="100%" scrolling="no"></iframe>
			</div>
		</form>
	</body>
</HTML>
