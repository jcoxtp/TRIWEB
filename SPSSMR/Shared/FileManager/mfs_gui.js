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
	
	document.getElementById("radioallfilesuser").click();
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
	var oTBody	 = document.getElementById( 'filelistbody' );
	var oAttrReq = oTBody.attributes.getNamedItem('totalRequiredMissing');
	
	nMissing = parseInt(oAttrReq.nodeValue, 10);
	if ( nMissing == 1 ) {
		forceDisplayFiles();
		mfs_showFormattedAlert(String(document.getElementById('errCheckOneRequiredFileMissing').value).replace(/\{0\}/g, nMissing));
		return false;
	}
	else if ( nMissing > 1 ) {
		forceDisplayFiles();
		mfs_showFormattedAlert(String(document.getElementById('errCheckMoreRequiredFileMissing').value).replace(/\{0\}/g, nMissing));
		return false;
	}
	
	var arrFileObjects = new Array();
	var arrFileNames = new Array();
	
	// check for overwrites and missing selection of required
	var oInputList = document.getElementsByTagName('input');
	var bShowConfirmOverwrite = false;
	var strFileList = "";
	var strConfirmOverWriteMsg = document.getElementById('confirmOverWriteUserFiles').value;
	for ( i=0; i<oInputList.length; i++ ) {
		var attM = oInputList.item(i).attributes.getNamedItem('ismasteroption');
		var attU = oInputList.item(i).attributes.getNamedItem('isuseroption');
		var oFilename	= oInputList.item(i).attributes.getNamedItem('filename');
		var strFileName	= "";
			
		if ( oFilename != null ) {
			var oRequired = oInputList.item(i).attributes.getNamedItem('requiredfile');
			
			strFileName	= oFilename.nodeValue;
			if ( oRequired.nodeValue == 'true' && arrFileObjects[strFileName] == null ) {
				arrFileObjects[strFileName] = new CFileObject(strFileName);
				arrFileNames.push(strFileName);
			}
		}
		
		if ( attM != null && attM.nodeValue == 'true' )
		{
			if ( arrFileObjects[strFileName] != null ) {
				arrFileObjects[strFileName].master = oInputList.item(i).checked;
			}
			
			if ( oInputList.item(i).checked == true ) {
				if ( strFileName != "" ) {
					var oUserRadio = document.getElementById('radiouserid'+strFileName);
					if ( oUserRadio != null ) {
						bShowConfirmOverwrite = true;
						strFileList += '\n - '+strFileName;
					}
				}
			}
		}
		else if ( attU != null && attU.nodeValue == 'true' ) {
			if ( arrFileObjects[strFileName] != null ) {
				arrFileObjects[strFileName].user = oInputList.item(i).checked;
			}
		}
	}
	
	var nFileIdx;
	for ( nFileIdx=0; nFileIdx<arrFileNames.length; nFileIdx++ ) {
		strFileName = arrFileNames[nFileIdx];
		if ( ! arrFileObjects[strFileName].master && ! arrFileObjects[strFileName].user ) {
			mfs_showFormattedAlert(document.getElementById('errRequiredFileSelectionMissing').value)
			return false;
		}
	}
	
	if ( bShowConfirmOverwrite ) {
		strConfirmOverWriteMsg = strConfirmOverWriteMsg.replace(/\{0\}/g, strFileList).replace(/\\n/g, '\n');
		if ( ! confirm(strConfirmOverWriteMsg) ) {
			return false;
		}
	}
	
	submitSelection();
}

function CFileObject( strFileName ) {
	this.name	= strFileName;
	this.master = false;
	this.user	= false;
}

function submitSelection() {
	// top.frames[0] = top.frames["frmMFS_gui"]
	document.mfs_form.target=top.frames[0].name;
	document.mfs_form.action="mfs_action.asp?returnvalue=ok";
	document.mfs_form.submit();
}

function doUpload( strFileName ) {
	var doc = top.frames[0].document;
	doc.getElementById("File1").clearAttributes();
	doc.getElementById("File1").click();
	
	var strfiledlgselection = doc.getElementById("File1").value;
	
	if( strfiledlgselection != "" )
	{
		doc.mfs_upload_form.target=top.frames[0].name;
		doc.mfs_upload_form.action="mfs_upload.asp?destinationfilename="+strFileName;
		doc.mfs_upload_form.submit();
		lockGUI();
	}
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

function allFileOptionClicked(oInput, nRequiredMissing) {
	var oInputList = document.getElementsByTagName('input');
	var attrNameSet = 'isuseroption';
	var attrNameClr = 'ismasteroption';
	
	if ( oInput.value == 'master' ) {
		attrNameSet = 'ismasteroption';
		attrNameClr = 'isuseroption';
	}
	
	for( i=0; i<oInputList.length; i++ ) {
		var attS = oInputList.item(i).attributes.getNamedItem( attrNameSet );
		var attC = oInputList.item(i).attributes.getNamedItem( attrNameClr );
		if ( attS != null && attS.nodeValue == 'true' )
		{
			oInputList.item(i).click();
		}
		
		if ( attC != null && attC.nodeValue == 'true' && attrNameClr == 'ismasteroption' )
		{
			try { oInputList.item(i).checked = false; } catch ( e ) { }
		}
	}
	
	var strError = "";
	if ( nRequiredMissing > 1 ) {
		strError = String(document.getElementById('errMoreRequiredFileMissing').value).replace(/\{0\}/g, nRequiredMissing);
	}
	else if ( nRequiredMissing > 0 ) {
		strError = String(document.getElementById('errOneRequiredFileMissing').value).replace(/\{0\}/g, nRequiredMissing);
	}
	
	if ( nRequiredMissing > 0 ) {
		forceDisplayFiles();
		mfs_showFormattedAlert(strError);
	}
}

function fileOptionClicked(oInput) {
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
