<%@ Page language="c#" Codebehind="dlgMddCopyOption.aspx.cs" AutoEventWireup="false" Inherits="ManageFiles.dlgMddCopyOption" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><%=Server.HtmlEncode(ManageFiles.Utilities.I18N.GetResourceString("dlgMddCopyOption_dialog_title"))%></title> 
		<!--
		* Warning: this computer program is protected by
		* copyright law and international treaties.
		* Unauthorized reproduction or distribution of this
		* program, or any portion of it, may result in severe
		* civil and criminal penalties, and will be prosecuted 
		* to the maximum extent of the law. 
		* 
		* Copyright © 2003 SPSS Ltd. All rights reserved.
		-->
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script src="Shared/Dialog/dialog.js" type="text/javascript"></script>
		<script type="text/javascript">
		<!--
			function initDialog() {
				resizeDlg( 1000 );
			}
			window.onload = initDialog;
			
			function btnOK_ClickedClient() {
				closeDialog({status:'ok', option:document.dlgMddCopyOption.selCopyOption.value });
			}
			
			function btnCancel_ClickedClient() {
				closeDialog({status:'cancel', option:0 });
			}
		-->
		</script>
		<style type="text/css">
			TABLE.Style1 { MARGIN: 5px}
			TABLE.Style1 TD { WHITE-SPACE: nowrap; PADDING-RIGHT: 5px}
			TABLE.Style1 TH { FONT-SIZE: 100%;}
		</style>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="dlgMddCopyOption" method="post" runat="server">
			<table class="Style1">
				<tr>
					<td colSpan="2">
						<div id="explanatoryText" runat="server"></div>
					</td>
				</tr>
				<tr>
					<td id="label_copyoption" runat="server">
						Copy option:
					</td>
					<td>
						<select id="selCopyOption" runat="server">
						</select>
					</td>
				</tr>
			</table>
			<table style="WIDTH: 100%" border="0">
				<tr>
					<td style="TEXT-ALIGN: right">
						<div style="OVERFLOW: visible; WHITE-SPACE: nowrap">
							<input id="btnOK" type="button" class="stdbutton" onclick="javascript:btnOK_ClickedClient()" value=" OK " runat="server">
							&nbsp; <input id="btnCancel" type="button" class="stdbutton" onclick="javascript:btnCancel_ClickedClient()" value="Cancel" runat="server">
							&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
