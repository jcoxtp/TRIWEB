<%@ Reference Control="Controls/ProjectInfoControl.ascx" %>
<%@ Page language="c#" Codebehind="Main.aspx.cs" AutoEventWireup="false" Inherits="ManageFiles.Main" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Main</title> 
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
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<LINK href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<style type="text/css">
			TABLE.FileInfo
			{
				BORDER: #336699 1pt solid;
				POSITION: relative;
				TOP: expression((document.body.scrollTop)+'px');
				BACKGROUND-COLOR: #ffffc3
			}
			
			TABLE.FileInfo TD 
			{
				WHITE-SPACE: nowrap
			}
			
			TABLE.Style1 TD
			{
				PADDING-RIGHT: 5px;
				WHITE-SPACE: nowrap
			}
			
			TABLE.Style1 TH
			{
				FONT-SIZE: 100%
			}
			
			TH.RoundedTableDarkHeader 
			{
				BORDER-TOP: solid 1px #31569C;
				TEXT-ALIGN: left;
			}
			
			TD.RoundedTableLightInfo
			{
				WHITE-SPACE: nowrap;
			}
		</style>
		<script type="text/javascript" src="Main.js"></script>
		<script src="Shared/Dialog/dialog.js" type="text/javascript"></script>
		<script type="text/javascript" src="CustomDialog/MessageBox.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" tabindex="-1" style="MARGIN: 10px">
		<form id="Main" method="post" runat="server" tabindex="-1">
			<div id="WaitMassageDiv" runat="server" style="DISPLAY: none">
				<asp:Literal ID="WaitMessage" Runat="server" Text="Checking project files. Please wait..."></asp:Literal>
			</div>
			<div id="ContentDiv" runat="server">
				<div style="DISPLAY: none">
					<input type="button" id="btnCheckIn" runat="server" onserverclick="btnCheckIn_Clicked" value="btnCheckIn">
					<input type="button" id="btnCheckOut" runat="server" onserverclick="btnCheckOut_Clicked" value="btnCheckOut">
					<input type="button" id="btnUndoCheckOut" runat="server" onserverclick="btnUndoCheckOut_Clicked" value="btnUndoCheckOut">
					<input type="button" id="btnDelete" runat="server" onserverclick="btnDelete_Clicked" value="btnDelete">
					<input type="button" id="btnDownload" runat="server" onserverclick="btnDownload_Clicked" value="btnDownload">
					<input type="button" id="btnSortFileName" runat="server" onserverclick="btnSortFileName_Clicked" value="btnSortFileName">
					<input type="button" id="btnSortLocation" runat="server" onserverclick="btnSortLocation_Clicked" value="btnSortLocation">
					<input type="button" id="btnSortModified" runat="server" onserverclick="btnSortModified_Clicked" value="btnSortModified">
					<input type="button" id="btnRefresh" runat="server" onserverclick="btnRefresh_Clicked" value="btnRefresh">
					<input type="button" id="btnChangeDirectory" runat="server" onserverclick="btnChangeDirectory_Clicked" value="btnChangeDirectory">
					<input type="hidden" id=hChangeDirectoryTo runat="server">
					<input type="hidden" id="hCopyOptionMoveFile" runat="server">
					<input type="hidden" id="hConfirmDelete" runat="server">
					<input type="button" id="btnClose" runat="server" onserverclick="btnClose_Clicked" value="btnClose">
				</div>
				<asp:PlaceHolder id="phProjectInfo" runat="server"></asp:PlaceHolder>
				<br>
				<table style="WIDTH: 100%">
					<tr>
						<td valign="top">
							<table class="RoundedTable" id="FileList" runat="server" cellpadding="0" cellspacing="0">
								<tr>
									<TH class="RoundedTableDarkHeader" style="PADDING-RIGHT:0px;PADDING-LEFT:0px;PADDING-BOTTOM:0px;WIDTH:17px;PADDING-TOP:0px">
										&nbsp;
									</TH>
									<TH style="WIDTH:20px">
										<INPUT type="checkbox" id="chkSelectAll" onClick="selectAll_Clicked()" title="Select All">
									</TH>
									<TH class="RoundedTableDarkHeader" onclick="document.Main.btnSortFileName.click()" style="CURSOR:hand">
										<!-- This row is generated in Main.aspx.cs when running the application -->
										File Name
									</TH>
									<TH class="RoundedTableDarkHeader" onclick="document.Main.btnSortLocation.click()" style="CURSOR:hand">
										<!-- This row is generated in Main.aspx.cs when running the application -->
										Location
									</TH>
									<TH class="RoundedTableDarkHeader" onclick="document.Main.btnSortModified.click()" style="CURSOR:hand">
										<!-- This row is generated in Main.aspx.cs when running the application -->
										Date
									</TH>
								</tr>
							</table>
						</td>
						<td style="VERTICAL-ALIGN: top; WIDTH: 10%">
							<table id="FileInfoTable" class="FileInfo" style="WIDTH: 100%">
								<!-- The purpose of this row is to make enough room for any date without having the table resize all the time -->
								<!-- Real Table starts here -->
								<tr>
									<td id="tdFileinfoFileNameLabel" runat="server" colSpan="2">
										File Name:
									</td>
								</tr>
								<tr>
									<td id="fileinfoFileName" style="FONT-WEIGHT: bold" colSpan="2">
										-
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td>
										<div id="SampleDateDiv" runat="server" style="VISIBILITY: ">
										sss</div>
									</td>
								</tr>
								<tr>
									<td id="tdSharedFolderNameLabel" runat="server" colSpan="2">
										Shared Folder
									</td>
								</tr>
								<tr>
									<td id="tdSharedLastModifiedLabel" runat="server">
										Last Modified:
									</td>
									<td id="sharedLastModified">
										-
									</td>
								</tr>
								<tr>
									<td id="tdSharedFileSizeLabel" runat="server">
										File Size:
									</td>
									<td id="sharedFileSize">
										-
									</td>
								</tr>
								<tr>
									<td colSpan="2">&nbsp;
									</td>
								</tr>
								<tr>
									<td id="tdUserFolderNameLabel" runat="server" colSpan="2">
										My Folder
									</td>
								</tr>
								<tr>
									<td id="tdUserLastModifiedLabel" runat="server">
										Last Modified:
									</td>
									<td id="userLastModified">
										-
									</td>
								</tr>
								<tr>
									<td id="tdUserFileSizeLabel" runat="server">
										File Size:
									</td>
									<td id="userFileSize">
										-
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</HTML>
