function doDialog(sUrl, sWidth, sHeight)
{
	var winleft = (screen.width / 2) - (sWidth / 2); // center the window right to left    ?
	var wintop = (screen.height / 2) - (sHeight / 2); // center the window top to bottom
	return window.open(sUrl, null, "top="+wintop+", left="+winleft+", height="+sHeight+", width="+sWidth+", toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, directories=no, status=no");
}

function _openWindow(sUrl, sWidth, sHeight)
{
	return window.showModalDialog(sUrl, "", "dialogHeight:"+sHeight+"px;dialogWidth:"+sWidth+"px;status:no;help:no;resizable:yes;scroll:no;edge:sunken;unadorned:yes;");		
}

function updateMainFrame(sUrl)
{
	document.getElementById('mainFrm').src=unescape(sUrl);
}

function gotoTask(sType, sUserName, sRoleName, sHash)
{
	var sUrl = "info.aspx?type="+sType;
	if (sUserName!="")
		sUrl += "&user="+escape(sUserName);
	if (sRoleName!="")
		sUrl += "&role="+escape(sRoleName);
	sUrl += "&hash="+sHash;
	window.top.frames.main.updateMainFrame(sUrl);
}

function remove(sType, sItemName, sHash)
{
	var sUrl="";
	if (sType=="user")
		sUrl="action.aspx?task=removeuser"+"&user="+sItemName+"&hash="+sHash;
	else
	if (sType=="role")
		sUrl="action.aspx?task=removerole"+"&role="+sItemName+"&hash="+sHash;
	_openWindow(sUrl, 400, 275);
	_refreshCollectionWindow();
	
	var qs = new Querystring();
	var sQSType=qs.get("type","");

	if ((sQSType=="users") || (sQSType=="roles"))
		_refreshMainWindow();
	else
		window.location="main.aspx?hash="+sHash;
}

function unassign(sUserName, sRoleName, sHash)
{
	_openWindow("action.aspx?task=unassign&user="+sUserName+"&role="+sRoleName+"&hash="+sHash, 400, 275);
	_refreshCollectionWindow();
	_refreshMainWindow();
}

function assign(sType, sDestItemName, sHash)
{
	var sUrl;
	if (sType=="users")
		openDialogue("ActionPage","action.aspx?task=assignusers&role="+sDestItemName+"&hash="+sHash, 400, 275);
	else
	if (sType=="roles")
		openDialogue("ActionPage","action.aspx?task=assignroles&user="+sDestItemName+"&hash="+sHash, 400, 275);
}
	

function modify(sType, sItemName, sHash)
{
	if (sType=="user")
		openDialogue("UserPage","userinfo.aspx?task=modify&user="+sItemName+"&hash="+sHash, 650, 350);
	else
	if (sType=="role")
		openDialogue("RolePage","roleinfo.aspx?task=modify&role="+sItemName+"&hash="+sHash, 475, 350);
}

function add(sType, sHash)
{
	if (sType=="user")
		openDialogue("UserPage","userinfo.aspx?task=addnewuser&hash="+sHash, 650, 350);
	else
	if (sType=="role")
		openDialogue("RolePage","roleinfo.aspx?task=addnewrole&hash="+sHash, 475, 350);
}

function _refreshCollectionWindow()
{
	window.top.frames.collections.location = window.top.frames.collections.location;
}
function _refreshMainWindow()
{
	window.location.reload();
}

function _refreshOpenerWindows()
{
	if (opener!=null)
	{	
		opener.window.top.frames.collections.location.reload();
		opener.window.top.frames.main.document.getElementById('mainFrm').src = opener.window.top.frames.main.document.getElementById('mainFrm').src;
		
	}
}

function Querystring()
{
// get the query string, ignore the ? at the front.
	var querystring=location.search.substring(1,location.search.length);

// parse out name/value pairs separated via &amp;
	var args = querystring.split('&amp;');

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

var subActionPage=null;
var subUserPage=null;
var subRolePage=null;
var subImportPage=null;

function openDialogue(sType,sUrl, sWidth, sHeight)
{
    if(sType=="ActionPage")
    {
        subActionPage=doDialog(sUrl, sWidth, sHeight);
    }
    if(sType=="UserPage")
    {
        subUserPage=doDialog(sUrl, sWidth, sHeight);
    }
    if(sType=="RolePage")
    {
        subRolePage=doDialog(sUrl, sWidth, sHeight);
    }
    if(sType=="ImportPage")
    {
        subImportPage=doDialog(sUrl, sWidth, sHeight); 
    }
}

function   window_onunload()
{       
    if(subActionPage!=null&&!subActionPage.closed)
        subActionPage.close();   
    if(subUserPage!=null&&!subUserPage.closed)
        subUserPage.close();   
    if(subRolePage!=null&&!subRolePage.closed)
        subRolePage.close();   
    if(subImportPage!=null&&!subImportPage.closed)
        subImportPage.close();   
} 