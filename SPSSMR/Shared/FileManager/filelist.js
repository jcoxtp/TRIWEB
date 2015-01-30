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
			if( previousrow != "" )
				top.frames[1].document.getElementById("confirm_button").click();
			break;
		case 27: // esc
			top.frames[1].document.getElementById("close_button").click();
			break;
		case 38: // arrow up
			handleKeyUp();
			break;
		case 40: // arrow down
			handleKeyDown();
			break;
	}
}

var previousrow = "";

// ************************************************************
// remove whitespaces from beginning and end of string
function trimString(str) {
	str = this != window? this : str;
	return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
}

function handleKeyUp() {
	try {
		if ( previousrow == "" ) return;
		
		var preNode = document.getElementById("tr"+previousrow).previousSibling;
		while ( preNode != null && preNode.nodeType != 1 ) {
			preNode = preNode.previousSibling;
		}
		
		if ( preNode == null ) return;
		
		var newID = '';
		if ( preNode.attributes.getNamedItem != null ) {
			newID = preNode.attributes.getNamedItem("id").nodeValue.slice(2);
		}
		else {
			for ( var i = 0; i < preNode.attributes.length; i++ ) {
				if ( preNode.attributes[i].nodeName == 'id' ) {
					newID = preNode.attributes[i].nodeValue.slice(2);
					break;
				}
			}
		}
		
		if ( newID != '' ) {
			var colNode = document.getElementById("cola"+newID);
			selectrow( newID, trimString( colNode.childNodes[0].nodeValue ) );
		}
		
		if (ie){
			evt.returnValue = false;
			window.scrollBy(0, -rowHeight);
		}
	}
	catch ( theError ) {}
	finally {}
}
	
function handleKeyDown() {
	try {
		if ( previousrow == "" ) return;
		
		var nxtNode = document.getElementById("tr"+previousrow).nextSibling;
		while ( nxtNode != null && nxtNode.nodeType != 1 ) {
			nxtNode = nxtNode.nextSibling;
		}
		
		if ( nxtNode == null ) return;
		
		var newID = '';
		if ( nxtNode.attributes.getNamedItem != null ) {
			newID = nxtNode.attributes.getNamedItem("id").nodeValue.slice(2);
		}
		else {
			for ( var i = 0; i < nxtNode.attributes.length; i++ ) {
				if ( nxtNode.attributes[i].nodeName == 'id' ) {
					newID = nxtNode.attributes[i].nodeValue.slice(2);
					break;
				}
			}
		}
		
		if ( newID != '' ) {
			var colNode = document.getElementById("cola"+newID);
			selectrow( newID, trimString( colNode.childNodes[0].nodeValue ) );
		}
		
		if (ie){
			evt.returnValue = false;
			window.scrollBy(0, rowHeight);
		}
	}
	catch ( theError ) {}
	finally {}
}
	
function rowchosen(row, rowdata)
{
	selectrow(row, rowdata);
	top.frames[1].document.getElementById("confirm_button").click();
}

function selectrow(row, rowdata)
{
	if( row != -1 )
	{
		if( previousrow != "" )
			this.document.getElementById("tr"+previousrow).bgColor = "white";
		
		this.document.getElementById("tr"+row).bgColor = "#DBE9F7";
		previousrow = row;
	}
	
	if( top.frames[1].document.getElementById("fileentryitem") != null )
	{
		top.frames[1].document.getElementById("aliasentryitem").innerHTML = document.filelist_form.aliasentryitem.value;
		top.frames[1].document.getElementById("direntryitem").innerHTML = document.filelist_form.reldirentryitem.value;
		
		top.frames[1].document.getElementById("fileentryitem").value = rowdata;
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

function showPopupMessage(strDivID) {
	var oDiv = document.getElementById(strDivID);
	oDiv.style.visibility = "visible";
	
	document.body.style.cursor = 'wait';
}

function hidePopupMessage(strDivID) {
	var oDiv = document.getElementById(strDivID);
	oDiv.style.visibility = "hidden";
}

