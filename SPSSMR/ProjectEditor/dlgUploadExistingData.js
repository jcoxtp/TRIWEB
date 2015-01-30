/* FUNCTIONS USED ONLY IN dlgUploadExistingData.aspx */
function handleOnLoad() {
	if ( document.dlgUploadExistingData.doResizeWindow.value == "1" ) {
		resizeDlg( 1000 );
		document.dlgUploadExistingData.doResizeWindow.value = "0";
	}
}
window.onload = handleOnLoad;

function beforeUnload() {
	endSession();
}
window.onbeforeunload = beforeUnload;

function keyWasPressed() {
	if ( document.activeElement.id == "tbDescription" ) {
		return;
	}
	
	switch ( event.keyCode ) {
		case 13: // enter
			btnFinish_ClickedClient();
			break;
		case 27: // esc
			break;
	}
}

function uploadFile_KeyPressed() {
	switch ( event.keyCode ) {
		case 13: // enter
			if ( document.dlgUploadExistingData.fUploadFile.value == '' ) {
				return false;
			}
			try { showUploadingBanner(); } catch(e) {}
			window.onbeforeunload = null;
			document.dlgUploadExistingData.btnUpload.click();
			disableUI();
			return false;
			break;
		
		case 27: // esc
			return false;
			break;
	}
	return true;
}

function endSession() {
	var iframe = document.createElement('IFRAME');
	iframe.src='EndSession.aspx';
	iframe.style.display = 'none';
	document.body.appendChild(iframe);
	document.body.removeChild(iframe);
}

function uploadFile_Changed() {
	try { showUploadingBanner(); } catch(e) {}	
	window.onbeforeunload = null;
	document.dlgUploadExistingData.btnUpload.click();
	disableUI();
}

function disableUI()
{
    document.dlgUploadExistingData.cbDataType.disabled = true;
    document.dlgUploadExistingData.fUploadFile.disabled = true;
    document.dlgUploadExistingData.btnTestConnection.disabled = true;
    document.dlgUploadExistingData.btnFinish.disabled = true;
}

function btnFinish_ClickedClient() {
	if ( ! validateSelections() ) return;
	
	if (document.dlgUploadExistingData.cbDataType.selectedIndex == document.dlgUploadExistingData.cbDataType.length-1) {
		alert(I18N['dlgUploadExistingData_other_use_edit_project']);
	}
	try { showWaitingBanner(); } catch(e) {}
	window.onbeforeunload = null;	
	document.dlgUploadExistingData.btnFinishServer.click();
}

function btnTestConnection_ClickedClient() {
	if ( ! validateSelections() ) return;
	
	if (document.dlgUploadExistingData.cbDataType.selectedIndex != document.dlgUploadExistingData.cbDataType.length-1) {
		window.onbeforeunload = null;
		document.dlgUploadExistingData.btnTestConnectionServer.click();
	}
}

function validateSelections() {
	if (document.dlgUploadExistingData.cbDataType.selectedIndex == 0) {
		try {
			document.dlgUploadExistingData.cbDataType.focus();
			alert(I18N['dlgUploadExistingData_err_SelectDataType']);
		}
		catch(e) {}
			return false;
	}
	return true;
}