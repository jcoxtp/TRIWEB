// check browser type
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
			top.frames[1].document.getElementById("confirm_button").click();
			break;
		case 27: // esc
			top.frames[1].document.getElementById("close_button").click();
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
	
function takeFocus(){
	window.focus();
}
window.onload=takeFocus;
