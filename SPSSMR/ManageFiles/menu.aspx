<%@ Page language="c#" Codebehind="Menu.aspx.cs" Inherits="ManageFiles.Menu" %>
<%@ OutputCache Location="none" %>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>Menu</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="Shared/coolmenu/spssmenu.css">
	</head>
	<body class="Menu" leftMargin="0" topMargin="0">
		<script type="text/javascript" src="Shared/coolmenu/coolmenus4.js"></script>
		<script type="text/javascript" src="Shared/coolmenu/spssmenu.js"></script>
		<script type="text/javascript" src="Shared/coolmenu/spssinterface.js"></script>
		<script type="text/javascript">
			function getMainFrame() {
				return frames[1];
			}
			
			function menuCheckInFiles() {
				if ( getMainFrame().actionCheckInFiles ) {
					getMainFrame().actionCheckInFiles();
				}
			}
			
			function menuCheckOutFiles() {
				if ( getMainFrame().actionCheckOutFiles ) {
					getMainFrame().actionCheckOutFiles();
				}
			}
			
			function menuUndoCheckOutFiles() {
				if ( getMainFrame().actionUndoCheckOutFiles ) {
					getMainFrame().actionUndoCheckOutFiles();
				}
			}
			
			function menuDeleteFiles() {
				if ( getMainFrame().actionDeleteFiles ) {
					getMainFrame().actionDeleteFiles();
				}
			}
			
			function menuDownloadFiles() {
				if ( getMainFrame().actionDownloadFiles ) {
					getMainFrame().actionDownloadFiles();
				}
			}
			
			function menuUploadFiles() {
				if ( getMainFrame().actionUploadFiles ) {
					getMainFrame().actionUploadFiles();
				}
			}
			
			function menuExit() {
				try {
					getMainFrame().closeCommand();
				}
				catch(e) {}
			}
			
			
			function onShowMenuHandler() {
				var oMainFrame = getMainFrame();
				if ( oMainFrame == null || oMainFrame.taskInProgress ) return;
				
				if ( oMainFrame.menuStateDirty && oMainFrame.menuStateDirty == true ) {
					oMainFrame.menuStateDirty = false;
					
					var bCanCheckInFiles		= true;	// mask:  1
					var bCanCheckOutFiles		= true;	// mask:  2
					var bCanUndoCheckOutFiles	= true;	// mask:  4
					var bCanDeleteFiles			= true;	// mask:  8
					var bCanDownloadFiles		= true;	// mask: 16
					var bCanUploadFiles			= true;	// mask: 32
					
					// Check state of selected files
					try
					{
						var nStateMask = 0;
						var nSelected = 0;
						var oFileList = oMainFrame.FileListArray;
						for ( i in oFileList ) {
							var filename = oFileList[i];
							var oChkSelected = oMainFrame.document.getElementById('chkFile.'+filename);
							if ( oChkSelected.checked ) {
								nSelected++;
								var oHFileStatus = oMainFrame.document.getElementById('hFileStatus.'+filename);
								switch (oHFileStatus.value) {
									case "CheckedIn":
										nStateMask |= 13; // 1+4+8;
										bCanCheckInFiles = false;
										bCanUndoCheckOutFiles = false;
										bCanDeleteFiles = false;
										break;
									
									case "CheckedOut":
										nStateMask |= 10; // 2+8;
										bCanCheckOutFiles = false;
										bCanDeleteFiles = false;
										break;
									
									case "Private":
										nStateMask |= 6; // 2+4;
										bCanCheckOutFiles = false;
										bCanUndoCheckOutFiles = false;
										break;
								}
								
								// Break out of loop if we have already seen one of each states (1+2+4+8=15)
								if ( nStateMask==15 ) throw new Error('All Type of states checked');
							}
						}
					}
					catch (e) {
					}
					
					// Make sure that anything is selected at all
					bCanCheckInFiles &= (nSelected>0);
					bCanCheckOutFiles &= (nSelected>0);
					bCanUndoCheckOutFiles &= (nSelected>0);
					bCanDeleteFiles &= (nSelected>0);
					bCanDownloadFiles &= (nSelected>0);
					
					// Set state of menu items
					try {
						// CheckIn *
						if ( bCanCheckInFiles )
							oCMenu.fnActivateItem('Actions_CheckIn');
						else
							oCMenu.fnDeactivateItem('Actions_CheckIn');
					}
					catch (e) {
					}
					
					try {
						// CheckOut *
						if ( bCanCheckOutFiles )
							oCMenu.fnActivateItem('Actions_CheckOut');
						else
							oCMenu.fnDeactivateItem('Actions_CheckOut');
					}
					catch (e) {
					}
					
					try {
						// UndoCheckOut *
						if ( bCanUndoCheckOutFiles )
							oCMenu.fnActivateItem('Actions_UndoCheckOut');
						else
							oCMenu.fnDeactivateItem('Actions_UndoCheckOut');
					}
					catch (e) {
					}
					
					try {
						// Delete *
						if ( bCanDeleteFiles )
							oCMenu.fnActivateItem('Actions_Delete');
						else
							oCMenu.fnDeactivateItem('Actions_Delete');
					}
					catch (e) {
					}
					
					try {
						// Download *
						if ( bCanDownloadFiles )
							oCMenu.fnActivateItem('Actions_Download');
						else
							oCMenu.fnDeactivateItem('Actions_Download');
					}
					catch (e) {
					}
					
					try {
						// Upload *
						if ( bCanUploadFiles )
							oCMenu.fnActivateItem('Actions_Upload');
						else
							oCMenu.fnDeactivateItem('Actions_Upload');
					}
					catch (e) {
					}
				}
			}
			
			function CreateMainMenu()
			{
				// Menu texts / labels
				var Top_Actions			 = "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_actions")%>";
				var Actions_CheckIn		 = "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_actions_checkin")%>";
				var Actions_CheckOut	 = "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_actions_checkout")%>";
				var Actions_UndoCheckOut = "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_actions_undocheckout")%>";
				var Actions_Delete		 = "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_actions_delete")%>";
				var Actions_Download	 = "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_actions_download")%>";
				var Actions_Upload		 = "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_actions_upload")%>";
				var Top_Help			 = '<img src="shared/images/help.png" title="{0}" />';
				var Top_Exit			 = '<img src="shared/images/home.png" title="{0}" />';
				
				var MenuTopArrow		 = '<img src="shared/images/arrow_blue.png" />';
				var MenuTopSeperator	 = "&nbsp;&nbsp;|";
				
				Top_Help = Top_Help.replace(/\{0\}/, "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_help_tooltip")%>");
				Top_Exit = Top_Exit.replace(/\{0\}/, "<%=ManageFiles.Utilities.I18N.GetResourceString("menu_exit_tooltip")%>");
				
				var wTop_Actions = parseInt(8*Math.max(Actions_CheckIn.length, Actions_CheckOut.length, Actions_UndoCheckOut.length, Actions_Delete.length, Actions_Download.length ));
				
				// The oCMenu object is created and initialized in 'spssmenu.js'
				// Do the final initialization here.
				oCMenu.level[1].arrow = "Shared/coolmenu/images/arrow.gif"
				oCMenu.strRelativeMenuImagePath = "Shared/coolmenu/images/"
				oCMenu.fnAddOnShowHandler('onShowMenuHandler();');
				
				// Create the menu items
				oCMenu.fnAddItem('Top_Actions','',Top_Actions+MenuTopArrow+MenuTopSeperator);
					oCMenu.fnAddItem('Actions_CheckIn','Top_Actions',Actions_CheckIn, 'menuCheckInFiles()');
					oCMenu.m['Actions_CheckIn'].w = wTop_Actions;
					oCMenu.fnAddItem('Actions_CheckOut','Top_Actions',Actions_CheckOut, 'menuCheckOutFiles()'); 
					oCMenu.m['Actions_CheckOut'].w = wTop_Actions;
					oCMenu.fnAddItem('Actions_UndoCheckOut','Top_Actions',Actions_UndoCheckOut, 'menuUndoCheckOutFiles()');
					oCMenu.m['Actions_UndoCheckOut'].w = wTop_Actions;
					oCMenu.fnAddSeparator('Top_Actions');
					oCMenu.m['Actions_UndoCheckOut'].w = wTop_Actions;
					oCMenu.fnAddItem('Actions_Delete','Top_Actions',Actions_Delete, 'menuDeleteFiles()');
					oCMenu.m['Actions_Delete'].w = wTop_Actions;
					oCMenu.fnAddItem('Actions_Download','Top_Actions',Actions_Download, 'menuDownloadFiles()');
					oCMenu.m['Actions_Download'].w = wTop_Actions;
					oCMenu.fnAddItem('Actions_Upload','Top_Actions',Actions_Upload, 'menuUploadFiles()');
					oCMenu.m['Actions_Upload'].w = wTop_Actions;
				oCMenu.fnAddLinkItem('Top_Help','',Top_Help, 'help.aspx','_blank');
				oCMenu.m['Top_Help'].w = 22;
				oCMenu.fnAddLinkItem('Top_Exit','',Top_Exit, 'javascript:menuExit()','_self');
				oCMenu.m['Top_Exit'].w = 22;
				
				oCMenu.construct();
			}
			CreateMainMenu();
		</script>
		
		<form id="Menu" method="post" runat="server">
		</form>
	</body>
</html>
