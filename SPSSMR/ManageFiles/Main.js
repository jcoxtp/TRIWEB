/*********************************************************
 * Warning: this computer program is protected by
 * copyright law and international treaties.
 * Unauthorized reproduction or distribution of this
 * program, or any portion of it, may result in severe
 * civil and criminal penalties, and will be prosecuted 
 * to the maximum extent of the law. 
 * 
 * Copyright ?2003 SPSS Ltd. All rights reserved.
 *********************************************************/
var menuStateDirty = true;
var taskInProgress = false;
var nRoundAddedRows = 1; // Rows added to show rounded corners

function closeCommand() {
	if ( taskInProgress ) return;
	try { clearTimeout(postbackTimeout); } catch(e) {}
	document.getElementById('btnClose').click();
}


function updateFileInfo( a_filename, a_sharedLastModified, a_sharedFileSize, a_userLastModified, a_userFileSize ) {
	document.getElementById('fileinfoFileName').innerHTML = a_filename;
	document.getElementById('sharedLastModified').innerHTML = a_sharedLastModified;
	document.getElementById('sharedFileSize').innerHTML = a_sharedFileSize;
	document.getElementById('userLastModified').innerHTML = a_userLastModified;
	document.getElementById('userFileSize').innerHTML = a_userFileSize;
}

function moveFileInfoTable() {
	try
	{
		document.getElementById('FileInfoTable').style.top = (document.body.scrollTop)+'px';
	}
	catch (err) {}
}
window.onscroll = moveFileInfoTable;

function fileRow_Clicked( a_sFilename ) {
	if ( taskInProgress ) return;
	menuStateDirty = true;
	document.getElementById('chkFile.'+a_sFilename).click();
}

function directoryRow_Clicked( a_sFilename ) {
	if ( taskInProgress ) return;
	menuStateDirty = true;
}

function selectAll_Clicked() {
	try {
		menuStateDirty = true;
		var oSelectAll = document.getElementById('chkSelectAll');
		
		for ( i in FileListArray ) {
			try {
				document.getElementById("chkFile."+FileListArray[i]).checked = oSelectAll.checked;
			}
			catch(e) {}
		}
	}
	catch(e) {}
}

function actionCheckInFiles() {
	if ( taskInProgress ) return;
	taskInProgress = true;
	// All selected files must be 'Checked Out' or 'Private'
	try
	{
		for ( i in FileListArray ) {
			var filename = FileListArray[i];
			var oChkSelected = document.getElementById('chkFile.'+filename);
			if ( oChkSelected && oChkSelected.checked && filename.toLowerCase().match(/.*\.mdd/) != null) {
				var oHFileStatus = document.getElementById('hFileStatus.'+filename);
				switch (oHFileStatus.value) {
					case "CheckedIn":
						taskInProgress = false;
						return;
						break;
					case "CheckedOut":
						break;
					case "Private":
						break;
				}
			}
		}
		document.Main.btnCheckIn.click();
	}
	catch ( err ) {
		taskInProgress = false;
		return;
	}
}

function promptForCopyOptions() {
	taskInProgress = true;
	
	// Prompt for CopyOption for each entry in MergeActionPromptArray
	for ( i in MergeActionPromptArray ) {
		// Get merge option for all files
		if ( ! promptCopyOptionForFile(MergeActionPromptArray[i]) ) {
			
			// Clear all selections that the user may already have made
			for ( j in MergeActionPromptArray ) {
				document.getElementById('hFileCopyOption.'+MergeActionPromptArray[j]).value = '';
			}
			
			// Cancel the action
			taskInProgress = false;
			return;
		}
	}
	
	// Submit form again - now with CopyOption for each selected mdd file that already exist in shared
	document.Main.btnCheckIn.click();
}

function promptCopyOptionForFile(a_sFileName) {
	var fileOption = doDialog('dlgMddCopyOption.aspx?fn='+escape(a_sFileName));
	if ( fileOption == null || fileOption.status == 'cancel' ) {
		return false;
	}
	var oFileCopyOption = document.getElementById('hFileCopyOption.'+a_sFileName);
	oFileCopyOption.value = fileOption.option;
	return true;
}

function actionCheckOutFiles() {
	if ( taskInProgress ) return;
	taskInProgress = true;
	document.Main.btnCheckOut.click();
}

function actionUndoCheckOutFiles() {
	if ( taskInProgress ) return;
	taskInProgress = true;
	document.Main.btnUndoCheckOut.click();
}

function actionDeleteFiles() {
	if ( taskInProgress ) return;
	taskInProgress = true;
	if ( ShowYesNoQuestion(document.Main.hConfirmDelete.value) ) {
		document.Main.btnDelete.click();
	}
	else {
		taskInProgress = false;
	}
}

function actionDownloadFiles() {
	if ( taskInProgress ) return;
	taskInProgress = true;
	document.Main.btnDownload.click();
}

function actionUploadFiles() {
	if ( taskInProgress ) return;
	taskInProgress = true;
	
	doDialog('upload.aspx', "560px", "800px");	
	document.Main.btnRefresh.click();
	
}

function changeDirectory(a_changeToDirectory) {
	if ( taskInProgress ) return;
	taskInProgress = true;
	
	document.getElementById('hChangeDirectoryTo').value = a_changeToDirectory;
	document.getElementById('btnChangeDirectory').click();
	return false;
}
