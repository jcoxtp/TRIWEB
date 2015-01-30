<%@ Page Language="vb" CodeBehind="filelist.aspx.vb" AutoEventWireup="false" Inherits="mrWebExplorer.Internal.Page.filelist" %>
<%@ OutputCache Location="none" %>
<HTML>
	<HEAD>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<script language="javascript" src="filelist.js"></script>
		<link rel="stylesheet" type="text/css" href="mrWebExplorer.css">
	</HEAD>
	<body style="BACKGROUND-COLOR: white" leftMargin="0" topMargin="0">
		<div id="popupUploadDIV" style="position: absolute; top: 100px; left 3px; z-index: 99; visibility: hidden">
			<table class="PopupMessageTable">
				<tr>
					<td id="tdUploadBanner" runat="server" style="padding: 10px" />
				</tr>
			</table>
		</div>
		<form name="filelist_form" method="post">
			<input id="aliasentryitem" runat="server" type="hidden" name="aliasentryitem"> <input id="reldirentryitem" type="hidden" name="reldirentryitem" runat="server">
			<table id="filelistbody" width="100%" border="0" runat="server">
				<thead>
					<tr class="filelistheader">
						<th align="left">
							<input class="headerbutton" id="FileHeaderName" type="button" runat="server">
						</th>
						<th align="left">
							<input id="FileHeaderType" runat="server" type="button" class="headerbutton">
						</th>
						<th align="left">
							<input id="FileHeaderDate" runat="server" type="button" class="headerbutton">
						</th>
					</tr>
				</thead>
				<tbody>
					<!-- code will insert additional rows here -->
				</tbody>
			</table>
		</form>
		<script language="javascript">selectrow('-1', '')</script>
		<!--A href="javascript:var w = window.open(); w.document.write(document.body.innerHTML)">Body Source</A-->
	</body>
</HTML>
