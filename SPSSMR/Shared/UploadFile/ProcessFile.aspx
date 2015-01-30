<%@ Page language="c#" Codebehind="ProcessFile.aspx.cs" Inherits="SPSSMR.Web.UI.UploadFile.ProcessFile" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=Server.HtmlEncode(SPSSMR.Web.UI.UploadFile.Utilities.I18N.GetResourceString("dlgUploadFiles_dialog_title"))%>
		</title>
		<!--
		* Warning: this computer program is protected by
		* copyright law and international treaties.
		* Unauthorized reproduction or distribution of this
		* program, or any portion of it, may result in severe
		* civil and criminal penalties, and will be prosecuted 
		* to the maximum extent of the law. 
		* 
		* Copyright ?2003 SPSS Ltd. All rights reserved.
		-->
		<link href="../spssmrNet.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="Shared/Dialog/dialog.js"></script>
		<script type="text/javascript" src="CustomDialog/MessageBox.js"></script>
	</HEAD>
	<body>
		<base target="_top">
		<form id="dlgUploadFiles" method="post" runat="server" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; PADDING-TOP: 5px"
			tabindex="-1">
			<div style="DISPLAY: none">
				<input type="button" id="btnUpload" runat="server" onserverclick="btnUpload_Clicked" value="btnUpload">
				<input type="hidden" id="hConfirmedOverwrite" runat="server" NAME="hConfirmedOverwrite">
				<input type="hidden" id="hConfirmedRename" runat="server" NAME="hConfirmedRename">
				<input type="hidden" id="hCancel" runat="server" NAME="hCancel" value="false">
			</div>
		</form>
	</body>
</HTML>
