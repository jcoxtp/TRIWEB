
function InitHandler()
{
	
	var form = document.getElementById("frmUpload");
       
	form.SubmitHandler = SubmitHandler;
	
	AddHandler(form, "submit", this, "SubmitHandler");	
}

function generateUploadId()
{
	var hex = new Array('0','1','2','3','4','5','6','7','8', '9','a','b','c','d','e','f');
	var outB = '';
	
	for (count = 0; count < 32; count++)
		outB += hex[Math.floor(Math.random() * 16)];
	return outB;
}

function SubmitHandler(e)
{	
    var	fileCount=document.getElementById("hFileCount");
    
    var uploadId = generateUploadId();
	var form = document.getElementById("frmUpload");

    form.action += (form.action.indexOf("?") >= 0) ? "&" : "?";
    form.action += "uploadId=" + uploadId+"&FileCount="+(fileCount.value-1);
    form.uploadId = uploadId;
	
	if (window.top.document.getElementById("panelBrowse"))
		window.top.document.getElementById("panelBrowse").style.visibility = 'hidden';
	window.top.document.getElementById("panelProgressBar").style.visibility = 'visible';
	
	var form = document.getElementById("frmUpload");
	window.top.frames["progress"].location = window.top.frames["progress"].location + "?uploadId=" + form.uploadId;
}

function AddHandler(eventSource, eventName, handlerObject, handlerName)
{
	var eventHandler = function(e) {handlerObject[handlerName](e, eventSource);};
	
	if (eventSource.addEventListener)
		eventSource.addEventListener(eventName, eventHandler, false);
	else 
	if (eventSource.attachEvent)
		eventSource.attachEvent("on" + eventName, eventHandler);
	else
	{
		var originalHandler = eventSource["on" + eventName];
		
		if (originalHandler)
			eventHandler = function(e) {originalHandler(e); handlerObject[handlerName](e, eventSource);};

		eventSource["on" + eventName] = eventHandler;
	}
}

function getUploadId(sLocation)
{
	// get the query string, ignore the ? at the front.
	var querystring="";
	if (sLocation=="")
		querystring=location.search.substring(1,location.search.length);		
	else
		querystring=sLocation.search.substring(1,sLocation.search.length);		
	
	// parse out name/value pairs separated via &amp;
	var args = querystring.split('&');

	// split out each name = value pair
	for (var i=0;i<args.length;i++)
	{
		var pair = args[i].split('=');
		if (pair[0]=="uploadid")
			return pair[1];		
	}			
	return "";
}

function Querystring()
{
// get the query string, ignore the ? at the front.
	var querystring=location.search.substring(1,location.search.length);

// parse out name/value pairs separated via &amp;
	var args = querystring.split('&');

// split out each name = value pair
	for (var i=0;i<args.length;i++)
	{
		var pair = args[i].split('=');

		// Fix broken unescaping
		var temp = unescape(pair[0]).split('+');
		var temp0 = temp.join(' ');
		
		temp = unescape(pair[1]).split('+');
		var temp1 = temp.join(' ');
		
		this[temp0]=temp1;
	}

	this.get=Querystring_get;
}

function Querystring_get(strKey,strDefault)
{
	var value=this[strKey];
		if (value==null){value=strDefault;}
	
	return value;
}

function showStatus(id) {
	document.getElementById(id+"_show").style.visibility = 'hidden';
	document.getElementById(id+"_hide").style.visibility = 'visible';
}

function hideStatus(id) {
	document.getElementById(id+"_show").style.visibility = 'visible';
	document.getElementById(id+"_hide").style.visibility = 'hidden';
}