/* FUNCTIONS USED ONLY IN dlgImportProperties.aspx */
function handleOnLoad() {
	var maxWidth = 100;
	try {maxWidth=screen.availWidth-50} catch(e) {}
	resizeDlg( 1000, maxWidth );
	initReturnValue('');
}
window.onload = handleOnLoad;

function btnOK_ClickedClient() {
	document.dlgImportProperties.btnImportProperties.click();
}

function btnCancel_ClickedClient() {
	closeDialog('');
}
