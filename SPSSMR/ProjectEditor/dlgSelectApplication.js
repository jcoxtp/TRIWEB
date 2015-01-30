/* FUNCTIONS USED ONLY IN dlgSelectAppllication.aspx */
function handleOnLoad() {
	resizeDlg( 1000 );
	initReturnValue('');
}
window.onload = handleOnLoad;

function btnOK_ClickedClient() {
	closeDialog(document.dlgSelectApplication.cbApplication.value);
}

function btnCancel_ClickedClient() {
	closeDialog('')
}

