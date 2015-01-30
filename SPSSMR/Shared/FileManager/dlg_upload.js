// These variables should be initialized, before 
// calling doOK(). The variables are used
// to construct error and confirmation messages 
// to display in doOK().
//									   Example:
var msg_upload_confirm_upload = '';	// 'Do you want to upload '
var msg_upload_confirm_to     = '';	// ' to '
var msg_please_select_file    = '';	// 'Please make selection'

var strRelDirSelection	= '';
var strAliasSelection   = '';


//**************************************************************
// Code to enable key press handling
var ns = (navigator.appName.toUpperCase().match(/NETSCAPE/) != null);
var ie = (navigator.appName.toUpperCase().match(/MICROSOFT INTERNET EXPLORER/) != null);

function keyWasPressed(evt) {
	var nKeyCode;
	if ( ie ) {
		evt = event;
		nKeyCode = evt.keyCode;
	}
	if (ns)
		nKeyCode = evt.which;
	
	switch ( nKeyCode )
	{
		case 13: // enter
			doOK();
			break;
		case 27: // esc
			doCancel();
			break;
	}
}

if ( ie )
	document.onkeydown = keyWasPressed;
else
	window.addEventListener('keydown', keyWasPressed, false);

//**************************************************************
// onload handling
function initDialog() {
	resizeDlg(100);
}
window.onload = initDialog;



function doOK() {
	var strfiledlgselection = document.getElementById('File1').value;

	if( strfiledlgselection != '' )
	{
		var txt = msg_upload_confirm_upload + ' [' + strfiledlgselection + '] ' + msg_upload_confirm_to + ' [' + unescape(strAliasSelection) + unescape(strRelDirSelection) + ']';
		
		if( confirm(txt) == true )
		{
			document.action_form.action='uploadfileaction.asp?uploadpath='+strRelDirSelection+'&alias='+strAliasSelection+'&closedialog=true';
			document.action_form.submit();
		}
	}
}


function doCancel() {
	closeDialog('');
}