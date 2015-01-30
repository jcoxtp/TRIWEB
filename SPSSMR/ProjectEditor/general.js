/* Function for generation a unique return a unique id */
function GetUniqueWinName()
{
	return Number(new Date()).toString();
}

/* Functions used in onmouseover and onmousemove.
   Displays the value of the "title" attribute in the 
   status bar. */
function ShowTitleInStatus( elm ) {
	if ( elm != null && elm.title != null )
		top.status = elm.title;
	else
		top.status = "";
	return true;
}

/* Functions used in onmouseout*/
function ClearStatus() {
	top.status = "";
	return false;
}

function displayError( strErrorText ) {
	// support ' and " in error messages
	strErrorText = unescape(strErrorText);
	strErrorText = strErrorText.replace(/\\'/g, "\'");
	strErrorText = strErrorText.replace(/\\n/gi, '\n');
	strErrorText = escape(strErrorText);
	alert(unescape(strErrorText));
	//setTimeout( "alert(unescape('"+strErrorText+"'))", 10 );
}

//--Functions for waiting dialg
function EnableFrame(aFrame)
{
    try
    {
        if(null != aFrame.document.getElementById("modalContainer"))
        {
            aFrame.document.getElementsByTagName("body")[0].removeChild(aFrame.document.getElementById("modalContainer"));
        }
    }
    catch(e)
    {
    }
}

function DisableFrame(aFrame)
{
    try
    {

        if(aFrame.document.getElementById("modalContainer")) return;

        var o;
        o = aFrame.document.getElementsByTagName("body")[0].appendChild(aFrame.document.createElement("div"));
        o.id = "modalContainer";
    }
    catch (e)
    {
    }
}

function getWindow(strWinname)
{
    switch( strWinname )
    {
        case "collections":
            return top.frames[0];
            break;
        case "main":
            return top.frames[1];
            break;
        default: return null; 
    }
    
    return null;
}

function DisableAllFrames()
{
    CreateWaitDialog();
    DisableFrame(getWindow("collections"));
    DisableFrame(getWindow("main"));
}

function EnableAllFrames()
{
    EnableFrame(getWindow("collections"));
    EnableFrame(getWindow("main"));
    RemoveWaitDialog();
}

function GetWaitString()
{
    var ret = "";
    ret += "<table width=100% height=100%><tr><td class=waitlayertext>";
    ret += GetWaitStringFromHiddenVariable();
    ret += "</td></tr></table>";
    return ret;
}
function GetWaitStringFromHiddenVariable()
{
    var ret = "";
    try
    {
        ret = getI18N('waitlayerstring');
        if (ret == null)
        {
            ret = "Please wait...";
        }
    }
    catch (e)
    {
        ret = e.description + "Please Wait...";
    }
    return ret;
}

function CreateWaitDialog()
{
    try
    {
        var aFrame = getWindow("main");
        aFrame.scrollTo(0, 0);

        if(aFrame.document.getElementById("waitlayer")) return;

        var o = aFrame.document.getElementsByTagName("body")[0].appendChild(aFrame.document.createElement("div"));
        o.id = "waitlayer";

        o.innerHTML = GetWaitString();
    
        var _left = (aFrame.document.body.clientWidth-200)/2;
        if (0 > _left)
        {
            _left = 0;
        }

        var _top = (aFrame.document.body.clientHeight-100)/2;
        if (_top + 100 > aFrame.document.body.clientHeight)
        {
            _top = 0;
        }

        var newtop = _top + 'px';
        var newleft = _left + 'px';
        o.style.top = _top + 'px';
        o.style.left = _left + 'px';
    }
    catch (e)
    {
        alert(e.description);
    }
}

function RemoveWaitDialog()
{
    try
    {
        var aFrame = getWindow("main");
        if(null != aFrame.document.getElementById("waitlayer"))
        {
            aFrame.document.getElementsByTagName("body")[0].removeChild(aFrame.document.getElementById("waitlayer"));
        }
    }
    catch(e)
    {
    }
}
//--End