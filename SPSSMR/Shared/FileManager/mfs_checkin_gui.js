//**************************************************************
// Variables that should be initialized before calling 
// some of the functions in this file.

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
	
	//document.getElementById("checkallfiles").click();
}
window.onload = initDialog;

//**************************************************************
// event handling
function doOK() {
	confirmMissingAndOverwrite()
}

function doCancel() {
	document.mfs_form.target=top.frames[0].name;
	document.mfs_form.action="mfs_action.asp?returnvalue=cancel";
	document.mfs_form.submit();
}

function lockGUI() {
/*	for ( var i = 0; i < document.mfs_form.projectfileoption.length; i++ ) {
		document.mfs_form.projectfileoption[i].readOnly = true;
		document.mfs_form.projectfileoption[i].disabled = true;
	}
	document.getElementById("btn_ok").disabled = true;
	document.getElementById("btn_cancel").disabled = true;
	document.getElementById("maintable").style.cursor = 'wait';*/
}

function unlockGUI() {
/*
	for ( var i = 0; i < document.mfs_form.projectfileoption.length; i++ ) {
		document.mfs_form.projectfileoption[i].readOnly = false;
		document.mfs_form.projectfileoption[i].disabled = false;
	}
	document.getElementById("btn_ok").disabled = false;
	document.getElementById("btn_cancel").disabled = false;
	document.getElementById("maintable").style.cursor = 'default';
*/
}

function confirmMissingAndOverwrite() {
	// check for missing required files
	// (files missing in both master and user workspace)
	
	// ... TODO ... confirm any overwrites
	
	submitSelection();
}
/*
function CFileObject( strFileName ) {
	this.name	= strFileName;
	this.master = false;
	this.user	= false;
}
*/
function submitSelection() {
    // top.frames[0] = top.frames["frmMFS_gui"]
	document.mfs_form.target=top.frames[0].name;
	document.mfs_form.action="mfs_checkin_action.asp?returnvalue=ok";
	document.mfs_form.submit();
}

function toggleDisplayFiles() {
	var oTBody	 = document.getElementById( 'filelistbody' );
	var oAllSign = document.getElementById( 'f_all' );
	
	if ( oTBody.style.display == '' ) {
		oTBody.style.display = 'none';
		oAllSign.src = 'images/f_plus.png';
	}
	else {
		oTBody.style.display = '';
		oAllSign.src = 'images/f_minus.png';
	}
}

function forceDisplayFiles() {
	var oTBody	 = document.getElementById( 'filelistbody' );
	var oAllSign = document.getElementById( 'f_all' );
	
	oTBody.style.display = '';
	oAllSign.src = 'images/f_minus.png';
}

function allFileOptionClicked(oInput, strAction) {
	var oInputList = document.getElementsByTagName('input');
	
	for( i=0; i<oInputList.length; i++ ) {
		var isCheckinOption  = false;
		var isKeepFileOption = false;
		var oOptionTypeAttr = oInputList.item(i).attributes.getNamedItem( "optiontype" );
		
		if ( oOptionTypeAttr != null ) {
			isCheckinOption  = oOptionTypeAttr.nodeValue == 'checkin';
			isKeepFileOption = oOptionTypeAttr.nodeValue == 'keep';
		}
		
		if ( isCheckinOption && strAction == 'checkin' ) {
			if ( oInputList.item(i).checked != oInput.checked )
				oInputList.item(i).click();
		}
		else if ( isKeepFileOption && strAction == 'keep' ) {
			if ( oInputList.item(i).checked != oInput.checked )
				oInputList.item(i).click();
		}
	}
}

function fileCheckinOptionClicked(oInput) {
	if ( ! oInput.checked ) {
		var oInputAll = document.getElementById('checkallfiles');
		oInputAll.checked = oInput.checked;
	}
	return true;
}

function fileKeepOptionClicked(oInput) {
	if ( ! oInput.checked ) {
		var oInputAll = document.getElementById('checkallfileskeep');
		oInputAll.checked = oInput.checked;
	}
	return true;
}

function fileInformationClicked( fname ) {
	doDialog('mfs_fileinfo.asp?selectedfile='+fname);
	return false;
}

function mfs_showFormattedAlert( strMessage ) {
	strMessage = strMessage.replace(/\\n/g, '\n');
	alert(strMessage);
}
