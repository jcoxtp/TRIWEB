/* FUNCTIONS USED ONLY IN dlgSelectProjectGroup.aspx */
function handleOnLoad() {
	resizeDlg( 1000 );
	initReturnValue('');
}
window.onload = handleOnLoad;

function btnOK_ClickedClient() {
	closeDialog(document.dlgSelectProjectGroup.projectGroupList.value);
}

function btnCancel_ClickedClient() {
	closeDialog('')
}
