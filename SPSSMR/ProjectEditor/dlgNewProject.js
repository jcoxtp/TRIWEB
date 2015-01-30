/* FUNCTIONS USED ONLY IN dlgNewProject.aspx */
function handleOnLoad() {
	if ( document.dlgNewProject.doResizeWindow.value == "1" ) {
		resizeDlg( 1000 );
		document.dlgNewProject.doResizeWindow.value = "0";
	}
}
window.onload = handleOnLoad;

function beforeUnload() {
	endSession();
}
window.onbeforeunload = beforeUnload;

function keyWasPressed() {
	switch ( event.keyCode )
	{
		case 13: // enter
			if ( document.activeElement.id == "tbDescription" || 
				 document.activeElement.id == "btnAdvanced" ||
				 document.activeElement.id == "btnCancel" ) {
				return;
			}
			btnOK_ClickedClient();
			break;
		case 27: // esc
			btnCancel_ClickedClient();
			break;
	}
}

// function that will call the EndSession.aspx in an inserted IFRAME, and execute a
// script (finalizeFunction/optional) when the EndSession.aspx has been processed.
// NOTE:
//   The function will actually return before the EndSession.aspx has been processed!
//
// Example of usage (JScript):
//   endSession("document.Form1.submit()");
function endSession(finalizeFunction) {
	var iframe = document.createElement('IFRAME');
	iframe.src='EndSession.aspx';
	iframe.style.display = 'none';
	iframe.id= 'EndSessionIFrame'+Number(new Date()).toString();
	document.body.appendChild(iframe);
	if ( finalizeFunction ) {
		document.getElementById(iframe.id).onload=finalizeFunction;
		setTimeout('waitSessionEnded("'+iframe.id+'")', 200);
	}
}

// internal function used by endSession() that will check if the iframe has loaded 
// the EndSession.aspx in the IFRAME, and will execute the finalizeFunction passed 
// to the endSession() function.
function waitSessionEnded(iframeId) {
	switch ( document.getElementById(iframeId).document.readyState ) {
		case "loaded":
		case "interactive":
		case "complete":
			window.onbeforeunload = null;
			eval(document.getElementById(iframeId).onload);
			break;
		default:
			setTimeout('waitSessionEnded("'+iframeId+'")', 200);
			break;
	}
}

/* VALIDATION FUNCTIONS */
function validateValues() {
	if ( ! validateApplication() )
		return false;
	if ( ! validateLabel() )
		return false;
	
	return true;
}

function validateApplication() {
	return true;
}

function validateLabel() {
	var oElement = document.dlgNewProject.tbLabel;
	
	if ( oElement.value == "" )
	{
		displayError(document.errorMessageForm.LabelInvalid.value);
		oElement.focus();
		oElement.select();
		return false;
	}
	
	return true;
}

/* EVENT HANDLING FUNCTIONS */
function btnOK_ClickedClient() {
	if ( bIsLocked ) return;
	if ( validateValues() ) {
		try { showSavingMessage(); } catch (ex) {}
		window.onbeforeunload = null;
		document.dlgNewProject.btnCreateProject.click();
		changeGUILock( true );
	}
}

function btnAdvanced_ClickedClient() {
	var oProjectId		= document.getElementById('hProjectID');
	var oProjectType	= document.getElementById('cbApplication');
	var oProjectLabel	= document.getElementById('tbLabel');
	var oProjectFolder	= document.getElementById('hProjectFolder');
	var oAssignedRoles	= document.getElementById('hAssignedRoles');
	
	var args = {projectId:oProjectId.value, projectType:oProjectType.value, projectLabel:oProjectLabel.value, projectFolder:oProjectFolder.value, assignedRoles:oAssignedRoles.value};
	var rv = openModalDialog('dlgNewProjectConfigure.aspx', '530px', '300px', args);
	if ( rv != null && rv.status=="ok" )
	{
		oProjectId.value		= rv.projectId;
		oProjectFolder.value	= rv.projectFolder;
		oAssignedRoles.value	= rv.assignedRoles;
	}
}

function openModalDialog(url, width, height, args) {
	if (height==null) height = '0px';
	if (width==null) width = '0px';
	if (args==null)
		args = {opener: window};
	else
		args.opener = window;
	options = "resizable:yes;scroll:off;status:no;help:no;dialogHeight:"+height+";dialogWidth:"+width+";";
	return window.showModalDialog(url,args,options);
}

function btnCancel_ClickedClient() {
	if ( bIsLocked ) return;
	endSession("closeDialog({status:'cancel', project:'', application:''})");
}

var bIsLocked = false;
function changeGUILock( doLock ) {
	bIsLocked = doLock;
	var oElement = null;
	oElement = document.getElementById('btnOK');					if ( oElement != null ) oElement.disabled = doLock;
	oElement = document.getElementById('btnCancel');				if ( oElement != null ) oElement.disabled = doLock;
	oElement = document.getElementById('btnAdvanced');				if ( oElement != null ) oElement.disabled = doLock;
	
	oElement = document.getElementById('cbApplication');			if ( oElement != null ) oElement.disabled = doLock;
	oElement = document.getElementById('tbLabel');					if ( oElement != null ) oElement.disabled = doLock;
	oElement = document.getElementById('tbDescription');			if ( oElement != null ) oElement.disabled = doLock;
}
