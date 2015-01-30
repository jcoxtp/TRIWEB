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
		case 27: // esc
			doOK();
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
}
window.onload = initDialog;

//**************************************************************
// event handling
function doOK() {
	top.close();
}
