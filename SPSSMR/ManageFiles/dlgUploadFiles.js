function body_keyWasPressed() {
	switch ( event.keyCode )
	{
		case 27: // esc
			/*
			if ( document.activeElement.id == 'fUploadFile' ) {
				return true;
			}
			*/
			btnClose_ClickedClient();
			break;
	}
	return true;
}

function uploadFile_KeyPressed() {
	switch ( event.keyCode )
	{
		case 13: // enter
			if ( document.dlgUploadFiles.fUploadFile.value == '' ) {
				return false;
			}
			try { showUploadingBanner(); } catch(e) {}
			document.dlgUploadFiles.btnUpload.click();
			return false;
			break;
		
		case 27: // esc
			return false;
			break;
	}
	return true;
}

function btnClose_ClickedClient() {
	closeDialog({status:'close'});
}
