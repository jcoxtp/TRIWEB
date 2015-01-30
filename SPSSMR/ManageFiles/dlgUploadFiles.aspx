<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="dlgUploadFiles.aspx.cs" AutoEventWireup="false"  EnableEventValidation="false"  Inherits="ManageFiles.dlgUploadFiles" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
		 	<%=Server.HtmlEncode(ManageFiles.Utilities.I18N.GetResourceString("dlgUploadFiles_dialog_title"))%>
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
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="Shared/Dialog/dialog.js"></script>
		<script type="text/javascript" src="CustomDialog/MessageBox.js"></script>
		<script type="text/javascript" src="dlgUploadFiles.js"></script>
		<base target="_top" />
	</HEAD>
	<body onkeydown="body_keyWasPressed()">
		<form id="dlgUploadFiles" method="post" runat="server" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; PADDING-TOP: 5px"
			tabindex="-1">
			<div style="DISPLAY: none">
				<input type="button" id="btnUpload" runat="server" onserverclick="btnUpload_Clicked" value="btnUpload">
				<input type="hidden" id="hConfirmedOverwrite" runat="server" NAME="hConfirmedOverwrite">
				<input type="hidden" id="hConfirmedRename" runat="server" NAME="hConfirmedRename">
				<input type="hidden" id="hCancel" runat="server" NAME="hCancel" value="false">
				<input type="hidden" id="hConfirmedMerge" runat="server" NAME="hConfirmedMerge">
                <br />
                <input type="hidden" id="hExeFileChecked" runat="server" NAME="hExeFileChecked" value="false">
 <input type="hidden" id="hLongestFileNameChecked" runat="server" NAME="hLongestFileNameChecked" value="false">
                <input type="hidden" id="hMddVersionChecked" runat="server" NAME="hMddVersionChecked" value="false"></div>
		</form>
	</body>
</HTML>
