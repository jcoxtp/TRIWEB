<%@ Page Language="vb" CodeBehind="cmdstatus.aspx.vb" AutoEventWireup="false" Inherits="mrWebExplorer.Internal.Page.cmdstatus" %>
<%@ OutputCache Location="none" %>
<html>
	<head>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="dialog.js"></script>
		<script type="text/javascript" src="cmdstatus.js"></script>
		<link rel="stylesheet" type="text/css" href="mrWebExplorer.css">
	</head>
	<body tabindex="-1" topmargin="3" leftmargin="0" class="cmdstatusbody">
		<form tabindex="-1" method="post" name="cmdstatus_form" id="cmdstatus_form" runat="server">
			<table width="100%" border="0" cellspacing="0">
				<tr>
					<td style="WIDTH: 1%; PADDING-LEFT: 5px" nowrap>
						<input type="button" id="btnUpload" runat="server" value="Upload" onclick="javascript:doCommand('upload')">
						<input type="button" id="btnDownload" runat="server" value="Download" onclick="javascript:doCommand('download')">
					</td>
					<td align="left" nowrap>
						<div style="DISPLAY: none">
							<div id="aliasentryitem" class="dirfile_selection" style="DISPLAY: inline; COLOR: red"></div>
							<div id="direntryitem" class="dirfile_selection" style="DISPLAY: inline; COLOR: green"></div>
						</div>
						<table>
							<tr>
								<td id="tdFileNameLabel" runat="server" align="left" class="dirfile_selection" nowrap>
									selectedfile_label
								</td>
								<td align="left">
									<input type="text" id="fileentryitem" name="fileentryitem" size="25" class="dirfile_selection">
								</td>
							</tr>
						</table>
					</td>
					<td align="right" width="1%" nowrap>
						<table cellspacing="0" cellpadding="0">
							<tr>
								<td class="dirfile_selection">
									<div id="divFileMask" runat="server"  style="DISPLAY: inline; white-space: nowrap">
										filemask_label
									</div>
								</td>
								<td>
									<input type="text" id="fmask" runat="server" name="fmask" style="WIDTH: 60px" class="dirfile_selection">
								</td>
							</tr>
						</table>
					</td>
					<td align="right" style="WIDTH:1%; PADDING-RIGHT: 5px" nowrap>
						<input type="button" id="confirm_button" runat="server" style="WIDTH: 80px">
						<input type="button" id="close_button" runat="server" style="WIDTH: 80px" onclick="javascript:doClose()">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
