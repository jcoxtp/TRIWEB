function init() {
	var qs = new Querystring();
	var refreshtree=qs.get("refreshtree","");		
	if (refreshtree=="1")
		window.top.frames.frmeLHS.location = window.top.frames.frmeLHS.location;
}

function newProjectDialog() {
	var url = '../ProjectEditor/dlgNewProject.aspx?lang=' + document.ProjListClass.tbPreferredLanguage.value;
	var rv = doDialog(url);
	refreshLauncher(rv, false);
}
//Called after deleted a project
function refreshLauncher2(default2aspxPath)
{
	var sUrl = default2aspxPath;
	sUrl = sUrl + "?hash=" + getHash(top.location);
	sUrl = sUrl + "&id=refresh";	
	top.location = sUrl;
}
//Called after created new project
function refreshLauncher(obj, isDeleted) {
	if (obj)
	{
		if (obj.status=="cancel") {		
			//top.location.reload(false);
		}
		else
		{
			var sUrl = "default2.aspx";
			var sHash = getHash(top.location);
			if (sHash!="")
				sUrl+="?hash="+sHash;
			sUrl += "&id=refresh";
			if (!isDeleted)
			{
				if (obj.project!="")
					sUrl+="&proj="+obj.project;
			}
			top.location = sUrl;
		}
	}
	else
		top.location.reload(true);
}
	
function getHash(sLocation)
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
		if (pair[0]=="hash")
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

function showChangePassword(hash)
{
	var url = "changepassword.aspx?hash=" + hash;
	if (window.showModalDialog) 
		window.showModalDialog(url, "", "dialogHeight:400px;dialogWidth:400px;status:no;help:no;resizeable:yes;scroll:no;edge:sunken;unadorned:yes;");
	else 
		window.open(url,"","height=400,width=400,toolbar=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,modal=yes");
}

function addBookmark(url, title)
{
	if (document.all)
		window.external.AddFavorite(url, title);
	else
	if (window.sidebar)
		window.sidebar.addPanel(title, url, "");
}