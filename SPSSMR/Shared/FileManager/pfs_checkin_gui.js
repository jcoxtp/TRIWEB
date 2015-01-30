//**************************************************************
// Variables that should be initialized before calling 
// some of the functions in this file.
var strConfirmLooseChanges = ''; // Your changes will be lost.

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
	document.pfs_form.applyoption[0].focus();
}

window.onload = initDialog;

//**************************************************************
// event handling
function doOK() {
	if ( validateSelection() ) {
		submitSelection();
		lockGUI();
	}
}

function validateSelection() {
	// get the selection
	var applyopt = document.pfs_form.applyoption;
	for ( var i = 0; i < applyopt.length; i++ ) {
		if ( applyopt[i].checked ){
			selectedValue = applyopt[i].value;
			break;
		}
	}
	
	if ( selectedValue=='userworkspace' && !document.pfs_form.keepfile.checked ) {
		return confirm(strConfirmLooseChanges);
	}
	
	return true;
}

function submitSelection() {
	// top.frames[0] = top.frames["frmPFS_gui"]
	document.pfs_form.target=top.frames[0].name;
	document.pfs_form.action="pfs_checkin_action.asp?returnvalue=ok";
	document.pfs_form.submit();
}

function doCancel() {
	document.pfs_form.target=top.frames[0].name;
	document.pfs_form.action="pfs_checkin_action.asp?returnvalue=cancel";
	document.pfs_form.submit();
}

function lockGUI() {
	for ( var i = 0; i < document.pfs_form.applyoption.length; i++ ) {
		document.pfs_form.applyoption[i].readOnly = true;
		document.pfs_form.applyoption[i].disabled = true;
	}
	document.pfs_form.keepfile.disabled = true;
	document.getElementById("btn_ok").disabled = true;
	document.getElementById("maintable").style.cursor = 'wait';
}

function unlockGUI() {
	for ( var i = 0; i < document.pfs_form.applyoption.length; i++ ) {
		document.pfs_form.applyoption[i].readOnly = false;
		document.pfs_form.applyoption[i].disabled = false;
	}
	document.pfs_form.keepfile.disabled = false;
	document.getElementById("btn_ok").disabled = false;
	document.getElementById("maintable").style.cursor = 'default';
}

var previousSelectedValue = '';
function applyoptionChanged(){
	// get the selection
	var applyopt = document.pfs_form.applyoption;
	for ( var i = 0; i < applyopt.length; i++ ) {
		if ( applyopt[i].checked ){
			selectedValue = applyopt[i].value;
			break;
		}
	}
	
	if ( previousSelectedValue!=selectedValue ) {
		if ( selectedValue=='masterworkspace') {
			document.pfs_form.keepfile.checked=false;
		}
		else if ( selectedValue=='userworkspace' ) {
			document.pfs_form.keepfile.checked=true;
		}
		previousSelectedValue=selectedValue;
	}
}

function clickItem( elmID ) {
	var e = document.getElementById(elmID);
	if ( e != null ) {
		e.click();
	}
}
