//**************************************************************
// Variables that should be initialized before calling 
// some of the functions in this file.

// function confirmOverwrite()
var masterFileExists					= false;
var userFileExists						= false;

var strConfirmMasterOverwriteUser       = '';
var strConfirmNewOverwriteMasterUser    = '';
var strConfirmNewOverwriteMaster        = '';
var strConfirmNewOverwriteUser          = '';
var strConfirmUploadOverwriteMasterUser = '';
var strConfirmUploadOverwriteMaster     = '';
var strConfirmUploadOverwriteUser       = '';

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
	window.addEventListener("keydown", keyWasPressed, false);

//**************************************************************
// onload handling
function initDialog() {
	resizeDlg(100);
	window.focus();
	
	// select the first radio element
	if ( document.pfs_form.projectfileoption.length > 0 )
		document.pfs_form.projectfileoption[0].checked = true;
	else if ( document.pfs_form.projectfileoption != null )
		document.pfs_form.projectfileoption.checked = true;
}

window.onload = initDialog;

//**************************************************************
// event handling
function doOK() {
	confirmOverwrite()
}

function doCancel() {
	document.pfs_form.target=top.frames[0].name;
	document.pfs_form.action="pfs_action.asp?returnvalue=cancel";
	document.pfs_form.submit();
}

function lockGUI() {
	for ( var i = 0; i < document.pfs_form.projectfileoption.length; i++ ) {
		document.pfs_form.projectfileoption[i].readOnly = true;
		document.pfs_form.projectfileoption[i].disabled = true;
	}
	document.getElementById("btn_ok").disabled = true;
	document.getElementById("btn_cancel").disabled = true;
	document.getElementById("maintable").style.cursor = 'wait';
}

function unlockGUI() {
	for ( var i = 0; i < document.pfs_form.projectfileoption.length; i++ ) {
		document.pfs_form.projectfileoption[i].readOnly = false;
		document.pfs_form.projectfileoption[i].disabled = false;
	}
	document.getElementById("btn_ok").disabled = false;
	document.getElementById("btn_cancel").disabled = false;
	document.getElementById("maintable").style.cursor = 'default';
}

function confirmOverwrite() {
	// get the selection
	var selectedValue = '';
	var projectfileopt = document.getElementsByName('projectfileoption');
	if ( projectfileopt != null ) {
		for ( var i = 0; i < projectfileopt.length; i++ ) {
			if ( projectfileopt[i].checked )
				selectedValue = projectfileopt[i].value;
		}
	}
	
	// masterworkspace selected
	if ( selectedValue == 'masterworkspace' ) {
		if ( userFileExists ) {
			if ( ! confirm(strConfirmMasterOverwriteUser) )
				return;
		}
		submitSelection();
		return;
	}
	
	// userworkspace selected
	if ( selectedValue == 'userworkspace' ) {
		submitSelection();
		return;
	}
	
	// newfile selected
	if ( selectedValue == 'newfile' ) {
		if ( userFileExists && masterFileExists ) {
			if ( ! confirm(strConfirmNewOverwriteMasterUser) )
				return;
		}
		else if ( masterFileExists ) {
			if ( ! confirm(strConfirmNewOverwriteMaster) )
				return;
		}
		else if ( userFileExists ) {
			if ( ! confirm(strConfirmNewOverwriteUser) )
				return;
		}
		// it is safe to create the new file or
		// the user has confirmed
		submitSelection();
		return;
	}
	
	// uploadfile selected
	if ( selectedValue == 'uploadfile' ) {
		if ( userFileExists && masterFileExists ) {
			if ( ! confirm(strConfirmUploadOverwriteMasterUser) )
				return;
		}
		else if ( masterFileExists ) {
			if ( ! confirm(strConfirmUploadOverwriteMaster) )
				return;
		}
		else if ( userFileExists ) {
			if ( ! confirm(strConfirmUploadOverwriteUser) )
				return;
		}
		// it is safe to create the new file or
		// the user has confirmed
		doUpload();
		return;
	}
	// no valid selection...
}

function submitSelection() {
	// top.frames[0] = top.frames["frmPFS_gui"]
	document.pfs_form.target=top.frames[0].name;
	document.pfs_form.action="pfs_action.asp?returnvalue=ok";
	document.pfs_form.submit();
}

function doUpload() {
	var doc = top.frames[0].document;
	doc.getElementById("File1").clearAttributes();
	doc.getElementById("File1").click();
	
	var strfiledlgselection = doc.getElementById("File1").value;

	if( strfiledlgselection != "" )
	{
		doc.pfs_upload_form.target=top.frames[0].name;
		doc.pfs_upload_form.action="pfs_upload.asp";
		doc.pfs_upload_form.submit();
		lockGUI();
	}
}
