// These variables should be initialized, before 
// calling doCommand(). The variables are used
// to construct error and confirmation messages 
// to display in doCommand().
//										    Example:
var msg_upload_confirm_upload		= "";	// "Do you want to upload "
var msg_upload_confirm_to			= "";	// " to "
var msg_please_select_file			= "";	// "Please make selection"
var msg_filename_absolute_invalid	= "";	// "Filename invalid. Can not be an absolute path."

var frmFilemgrActionIdx = 0;

function doCommand(command)
{
	var strFileSelection = escape(document.cmdstatus_form.fileentryitem.value);
	var strRelDirSelection = escape(top.frames[1].document.getElementById("direntryitem").innerHTML);
	var strAliasSelection = escape(top.frames[2].frames[1].document.filelist_form.aliasentryitem.value);
	
	if( command == "upload" )
	{
		var elmFile1 = top.frames[frmFilemgrActionIdx].document.getElementById("File1");
		if ( elmFile1.clearAttributes )
			elmFile1.clearAttributes();
		
		if ( ie )
		{
			elmFile1.click();
			
			var strfiledlgselection = elmFile1.value;
			
			if( strfiledlgselection != "" )
			{
				var txt = msg_upload_confirm_upload + "[" + strfiledlgselection + "] " + msg_upload_confirm_to + " [" + unescape(strAliasSelection) + "\\" + unescape(strRelDirSelection) + "]";
				
				if( confirm(txt) == true )
				{
					top.frames[frmFilemgrActionIdx].document.action_form.action="uploadfileaction.asp?uploadpath="+strRelDirSelection+"&alias="+strAliasSelection;
					top.frames[frmFilemgrActionIdx].document.action_form.submit();
					try { top.frames[2].frames[1].showPopupMessage('popupUploadDIV'); } catch ( e ){ }
				}
			}
		}
		else
		{
			doDialog( 'dlg_upload.asp?uploadpath='+strRelDirSelection+'&alias='+strAliasSelection );
			top.frames[2].frames[1].location.replace("filelist.asp?path="+strRelDirSelection+"&alias="+strAliasSelection);
			return;
		}
	}
	else if( command == "download" ) {
		if ( ! validateFileName() )
			return;
		
		if( strFileSelection == "" )
			alert(msg_please_select_file);
		else
			top.frames[frmFilemgrActionIdx].location.replace("action_download.asp?relpath="+strRelDirSelection+"&filesel="+strFileSelection+"&alias="+strAliasSelection);
	}
	else { // open / openfavorite / save / saveas / select
		if ( ! validateFileName() )
			return;
		
		if( strFileSelection == "" ) {
			alert(msg_please_select_file);
			return;
		}
		
		var url = "action.asp?returnvalue=ok&selection="+strRelDirSelection+strFileSelection+"&alias="+strAliasSelection+"&command="+command;
		top.frames[frmFilemgrActionIdx].location.replace(url);
	}
}

function doClose()
{
	var url = "action.asp?returnvalue=cancel";
	
	top.frames[frmFilemgrActionIdx].location.replace(url);
	closeDialog('');
}

//**************************************************************
// Code to enable key press handling
// 
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
	
	var rowHeight = 20; // used to scroll
	switch ( nKeyCode )
	{
		case 13: // enter
			document.getElementById("confirm_button").click();
			break;
		case 27: // esc
			document.getElementById("close_button").click();
			break;
		case 38: // arrow up
			top.frames[2].frames[1].focus();
			top.frames[2].frames[1].handleKeyUp();
			break;
		case 40: // arrow down
			top.frames[2].frames[1].focus();
			top.frames[2].frames[1].handleKeyDown();
			break;
	}
}

if ( ie )
	document.onkeydown = keyWasPressed;
else
	window.addEventListener("keydown", keyWasPressed, false);
	// deprecated in NS 6 :(
	//window.captureEvents(Event,KEYDOWN);
	//window.onKeyDown = keyWasPressed;

function fnameKeyPressed(evt) {
	var nKeyCode;
	if ( ie ) {
		evt = event;
		nKeyCode = evt.keyCode;
	}
	if (ns)
		nKeyCode = evt.which;
	
	switch( nKeyCode ) {
		case 35: // HOME
		case 36: // END
		case 37: // <-
		case 39: // ->
		case  9: // TAB
		case 16: // SHIFT
		case 17: // CTRL
			return true;
	}
	return false;
}

function initFrame() {
	try {
		if ( ie )
			document.cmdstatus_form.fmask.onkeydown = fnameKeyPressed;
		else
			document.getElementById("fmask").addEventListener("keydown", fnameKeyPressed, false);
	}
	catch ( err ) { }
}
window.onload = initFrame;

function validateFileName() {
	var strFileSelection = document.cmdstatus_form.fileentryitem.value;
	
	if ( strFileSelection.search(/(\/)/) != -1 || strFileSelection.search(/(\\)/) != -1 ) {
		alert(msg_filename_absolute_invalid);
		document.cmdstatus_form.fileentryitem.focus();
		document.cmdstatus_form.fileentryitem.select();
		return false;
	}
	return true;
}
