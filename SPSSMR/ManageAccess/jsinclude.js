var subActionPage=null;
function _openWindow(sUrl, sWidth, sHeight)
{
	var winleft = (screen.width / 2) - (sWidth / 2); // center the window right to left    ?
	var wintop = (screen.height / 2) - (sHeight / 2); // center the window top to bottom
	subActionPage=window.open(sUrl, null, "top="+wintop+", left="+winleft+", height="+sHeight+", width="+sWidth+", toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, directories=no, status=no");
}

function   window_onunload()
{       
    if(subActionPage!=null&&!subActionPage.closed)
        subActionPage.close();   
} 

function showConfirmBox(sMsg, sUrl)
{
	if (confirm(sMsg))
		_openWindow(sUrl, 460, 320);
}

function showWindow(sUrl)
{
	_openWindow(sUrl, 460, 320);
}

function updateMainFrame(sUrl)
{
	document.getElementById('mainFrm').src= sUrl;
}

function gotoTask(sUrl)
{
	window.top.frames.main.updateMainFrame(sUrl);
}

function _refreshCollectionWindow()
{
	window.top.frames.collections.location.url = window.top.frames.collections.location.url;
}
function _refreshMainWindow()
{
	window.location.url = window.location.url; 
}

function _refreshOpenerWindows()
{
	if (opener!=null)
	{	
		opener.window.top.frames.collections.location.reload();
	}
}

