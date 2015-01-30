function getWebExplorerFrame( a_frameName ) {
	switch ( a_frameName ) {
		case 'action':
			return top.frames[0];
			break;
		case 'command':
			return top.frames[1];
			break;
		case 'srctree':
			return top.frames[2];
			break;
		case 'filelist':
			return top.frames[3];
			break;
	}
}

function loadActionFrameAndRetry( exprRetryCall ) {
	getWebExplorerFrame('action').location.replace('action.aspx');	
	setTimeout(exprRetryCall, 600);
}

function doCommand(command)
{
	var strFileSelection = "";
	var strRelDirSelection = "";
	var strAliasSelection = "";
	
	try {
		strFileSelection = escape(document.cmdstatus_form.fileentryitem.value);
		strRelDirSelection = escape(getWebExplorerFrame('command').document.getElementById("direntryitem").innerHTML);
		strAliasSelection = escape(getWebExplorerFrame('filelist').document.filelist_form.aliasentryitem.value);
	}
	catch(e) {
		// some of the frames are not loaded yet
		return;
	}
	
	if( command == "upload" )
	{
		var elmFile1 = null;
		try {
			elmFile1 = getWebExplorerFrame('action').document.getElementById("File1");
		}
		catch (e) {
			loadActionFrameAndRetry('doCommand(\''+command+'\')');
			return;
		}
		
		if ( elmFile1.clearAttributes )
			elmFile1.clearAttributes();
		
		elmFile1.click();
		
		var strfiledlgselection = elmFile1.value;
		
		if( strfiledlgselection != "" )
		{
			var bExtensionOK = true;
			
			var sFileMask = getWebExplorerFrame('command').document.getElementById("fmask").value;
			if ( ! doesFileMatchFilemask(strfiledlgselection, sFileMask) ) {
				bExtensionOK = confirm(I18N['upload_confirm_filemask']);
			}
			
			var sConfirm = I18N['upload_confirm_upload'];
			sConfirm = sConfirm.replace("{0}", strfiledlgselection).replace("{1}", unescape(strAliasSelection) + "\\" + unescape(strRelDirSelection));
			if( bExtensionOK && confirm(sConfirm) == true )
			{
				getWebExplorerFrame('action').document.action_form.action='action.aspx?cmd=upload&alias='+strAliasSelection+'&folderselection=' + strRelDirSelection;
				getWebExplorerFrame('action').document.action_form.submit();
				try { getWebExplorerFrame('filelist').showPopupMessage('popupUploadDIV'); } catch ( e ){ }
			}
		}
	}
	else if( command == "download" ) {
		if ( ! validateFileName() )
			return;
		
		if( strFileSelection == "" ) {
			alert(I18N['please_select_file']);
		}
		else {
			getWebExplorerFrame('action').location.replace("action_download.aspx?relpath="+strRelDirSelection+"&filesel="+strFileSelection+"&alias="+strAliasSelection);
		}
	}
	else { // open / openfavorite / save / saveas / select
		if ( ! validateFileName() )
			return;
		
		if( strFileSelection == "" ) {
			alert(I18N['please_select_file']);
			return;
		}
		
		var folderselection = "";
		if ( strRelDirSelection == "" ) {
			folderselection = strFileSelection
		}
		else {
			folderselection = strRelDirSelection+"\\"+strFileSelection
		}
		
		var url = 'action.aspx?cmd=selection&alias='+strAliasSelection+'&folderselection=' + folderselection + '&returnvalue=ok';
		getWebExplorerFrame('action').location.replace(url);
	}
}

function doesFileMatchFilemask(sFile, sFilemasks) {
	var aFileName = sFile.replace('/','\\').split('\\');
	var sFileName = aFileName[aFileName.length-1];
	var aFileMasks = sFilemasks.split(';');
	for ( nMaskIndex in aFileMasks ) {
		var sExp = '^'+aFileMasks[nMaskIndex].replace('.', '\\.').replace('*', '.*').replace('?','.')+'$';
		var re = new RegExp(sExp, "i");
		if ( re.test(sFileName) ) {
			return true;
		}
	}
	return false;
}

function doClose()
{
	var url = "action.aspx?cmd=selection&returnvalue=cancel";
	getWebExplorerFrame('action').location.replace(url);
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
			try {
				getWebExplorerFrame('filelist').focus();
				getWebExplorerFrame('filelist').handleKeyUp();
			}
			catch(e) {
				// the filelist frame was probaly not loaded
				return;
			}
			break;
		case 40: // arrow down
			try {
				getWebExplorerFrame('filelist').focus();
				getWebExplorerFrame('filelist').handleKeyDown();
			}
			catch(e) {
				// the filelist frame was probaly not loaded
				return;
			}
			break;
	}
}

if ( ie )
	document.onkeydown = keyWasPressed;
else
	window.addEventListener("keydown", keyWasPressed, false);

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
		alert(I18N['filename_relative_invalid']);
		document.cmdstatus_form.fileentryitem.focus();
		document.cmdstatus_form.fileentryitem.select();
		return false;
	}
	return true;
}
