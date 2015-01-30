 var currentPanel;
      function showTabPanel(panelName) {
	    //hide visible panel, show selected panel
	    if (currentPanel != null) {
		    hidePanel(currentPanel);
		    hideSubPanel(currentPanel) 
	    }
	    showPanel(panelName);
	    showSubPanel(panelName);
	    currentPanel = panelName;
	    document.getElementById('TabID').value = currentPanel;
    }
    function showPanel(panelName) {
	document.getElementById(panelName).style.visibility = 'visible';
	}

    function hidePanel(panelName) {
	    document.getElementById(panelName).style.visibility = 'hidden';
    }
    function hideSubPanel(panelName) {
	if (panelName=='SendLog')
		hidePanel('dateSelecterCompress_normal');
	if (panelName == 'ViewSetting')
	    hidePanel('dateSelecterSettings_normal');
}

function showSubPanel(panelName) {
	if (panelName=='SendLog')
		{
		    ShowCustomPanelInControl();
		}
	if(panelName == 'ViewSetting')
	    {
	        ShowCustomPanelInSettings();
	    }
	
}
    function initPanels() 
	{
	    hidePanel('LogList');
	    hidePanel('SendLog');
	    hidePanel('ViewSetting');
	    
	    if (document.getElementById('TabID').value!='')
		    showTabPanel(document.getElementById('TabID').value); 
	    else
	    if (currentPanel==null)
		    showTabPanel('SendLog');
	    else
		    showTabPanel(currentPanel);
    }
    
   function doDialog(URL, height, width)
{
	if (height==null) height = '0px';
	if (width==null) width = '0px';
	
	return dialog_openDialog(URL, height, width);
}
function dialog_openDialog(URL, height, width)
{
	var theHeight = height;
	var theWidth = width;
	var theURL = URL;
	if(navigator.appName == "Microsoft Internet Explorer")
	{
//		var args = {opener: window};
		var args = document.getElementById("cellContent").value;
		options = "resizable:yes;scroll:off;status:no;help:no;dialogHeight:" + theHeight + ";dialogWidth:" + width + ";";
		return window.showModalDialog(theURL,args,options);
	}
	else
	{
		var dlgX = top.screenX + (top.innerWidth/2) - parseInt(theWidth)/2;
		var dlgY = top.screenY + (top.innerHeight/2) - parseInt(theHeight)/2;
		
		window.dialog_return_value = "";
		options = "menubar=no,status=no,location=no,dependent=yes,scrollbars=yes,resizable=yes,height=" + theHeight + ",width=" + theWidth + ",screenX=" + dlgX + ",screenY=" + dlgY + ",modal=yes";
		window.open(theURL,"",options);
		return window.dialog_return_value;
	}
}
function closeDialog()
{
	window.returnValue=null;
	window.close();
}
function CreateWaitDialog()
{
    try
    {
        SaveDropDownListValue();
        var aFrame = top.frames[1];
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
    DisableFrame(top.frames[0]);
    DisableFrame(top.frames[1]);
    DivSetVisible(aFrame,'waitlayer','DivWaiting',true);
    
    document.getElementById('lstMachines').disabled = true;
    document.getElementById('lstMachine').disabled = true;
    document.getElementById('ddlPriority').disabled = true;
    document.getElementById('ddlPages').disabled = true;
    document.getElementById('dateSelecterCompress_rad').disabled = true;
    document.getElementById('dateSelecterSettings_rad').disabled = true;
  
    
}

function GetWaitString()
{
    var ret = "";
    ret += "<table width=100% height=100%><tr><td class=waitlayertext>";
//    ret += "<iframe style='position:absolute;z-index:-1;width:100%;height:100%;top:0;left:0;' scrolling='no' frameborder='0' src='Waiting.aspx'></iframe>";
    ret += GetWaitStringFromHiddenVariable();
    ret += "</td></tr></table>";
    
    return ret;
}

function GetWaitStringFromHiddenVariable()
{
    var ret = "";
    try
    {
        var aFrame = top.frames[1];
        if(null != document.getElementById("waitlayerstring"))
           ret = document.getElementById("waitlayerstring").value;
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

function RemoveWaitDialog()
{
    try
    {
        var aFrame = top.frames[1];
        if(null != aFrame.document.getElementById("waitlayer"))
        {
            DivSetVisible(aFrame,'waitlayer','DivWaiting',false);
            aFrame.document.getElementsByTagName("body")[0].removeChild(aFrame.document.getElementById("waitlayer"));
        }
    }
    catch(e)
    {
    }
   
    EnableFrame(top.frames[0]);
    EnableFrame(top.frames[1]);
    document.getElementById('lstMachines').disabled = false;
    document.getElementById('lstMachine').disabled = false;
    document.getElementById('ddlPriority').disabled = false;
    document.getElementById('ddlPages').disabled = false;
    document.getElementById('dateSelecterCompress_rad').disabled = false;
    document.getElementById('dateSelecterSettings_rad').disabled = false;
    BindDropDownListValue();

   
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
function ValidateSql()
{
    if (document.forms[0].txtSQL.value == "")
        {alert("Please enter an SQL query."); return false;}
    else if (document.forms[0].txtSQL.value.toLowerCase().indexOf("select") != 0)
        {alert("SQL queries must start with SELECT."); return false;}
    else
         return true;
}

function DivSetVisible(aFrame,popupDiv,frame,state)
{
    var DivRef = aFrame.document.getElementById(popupDiv);
    var IfrRef = aFrame.document.getElementById(frame);
    if(state)
    {
        DivRef.style.display = "block";
        IfrRef.style.width = DivRef.offsetWidth;
        IfrRef.style.height = DivRef.offsetHeight;
        IfrRef.style.top = DivRef.style.top ;
        IfrRef.style.left = DivRef.style.left ;
        IfrRef.style.display = "block";
    }
    else
    {
        IfrRef.style.display = "none";
    }
}
function CreateIframe(name)
{
    var aFrame = top.frames[1];
    aFrame.scrollTo(0, 0);
    if(aFrame.document.getElementById(name)) return;
    var f = aFrame.document.getElementsByTagName("body")[0].appendChild(aFrame.document.createElement("iframe"));
    f.src = "javascript:false;";
    f.id = name;
    f.style.position = 'absolute';
    f.style.top = '0px';
    f.style.left = '0px';
    f.style.display = "none";
    f.scroll   =   'no';   
    f.scrolling   =   'no';   
    f.frameborder   =   0;  
    f.style.zIndex = "9999";
    
}
function updateTableHeight()
{
    try
    {
        refreshTableHeight();
    }
    catch (e)
    {
        //alert("ERROR (updateTableHeight): " + e.description);
    }    
}
function ShowCustomPanelInSettings()
{
    if(document.forms[0].dateSelecterSettings_rad.selectedIndex == 5)
    {
        document.getElementById("dateSelecterSettings_normal").style.visibility = 'visible';
        document.getElementById("dateSelecterSettings_normal").style.position = 'relative';
    }
    else
    {
        document.getElementById("dateSelecterSettings_normal").style.visibility = 'hidden';
        document.getElementById("dateSelecterSettings_normal").style.position = 'absolute';
    }
}
function ShowCustomPanelInControl()
{
    if(document.forms[0].dateSelecterCompress_rad.selectedIndex == 5)
    {
        document.getElementById("dateSelecterCompress_normal").style.visibility = 'visible';
        document.getElementById("dateSelecterCompress_normal").style.position = 'relative';
    }
    else
    {
        document.getElementById("dateSelecterCompress_normal").style.visibility = 'hidden';
        document.getElementById("dateSelecterCompress_normal").style.position = 'absolute';
    }
}
function OpenWindow()
{
    if (document.getElementById('Archive').value == 'true')
    {
        doDownload();
        document.getElementById('Archive').value = '';
    }
} 
function doDownload()
{
    var iframe = document.getElementById('DivBody');
    iframe.src='Waiting.aspx';
}
function GoToPage(i)
        {
            var p = document.getElementById("paging_currentpage");
            p.value = i;
            document.form1.submit();
        }  
function SaveDropDownListValue()
{
// download
    var machine = document.getElementById("lstMachine");
    var machineValue = "";
	for(var i = 0; i < machine.options.length; i++)
	{
		if(machine.options[0].selected == true)
		{
				machineValue = "All Machines";
				break;
		}
		if(machine.options[i].selected == true)
				machineValue += machine.options[i].value + ";";
	}
	var date = document.getElementById("dateSelecterCompress_rad");
	var priority = document.getElementById("ddlPriority");
	document.getElementById("DownloadMachine").value = machineValue;
	document.getElementById("DownloadDate").value = date.options[date.selectedIndex].value;
	document.getElementById("DownloadPriority").value = priority.options[priority.selectedIndex].value;
// view 
    var viewMachine = document.getElementById("lstMachines");
    document.getElementById("ViewMachine").value = viewMachine.options[viewMachine.selectedIndex].value;
//setting
    var dateFilter = document.getElementById("dateSelecterSettings_rad");
	var page = document.getElementById("ddlPages");
	document.getElementById("SettingDate").value = dateFilter.options[dateFilter.selectedIndex].value;
	document.getElementById("SettingPages").value = page.options[page.selectedIndex].value;
}
function BindDropDownListValue()
{
//download
    var machine = document.getElementById("DownloadMachine").value;
    var date = document.getElementById("DownloadDate").value;
	var priority = document.getElementById("DownloadPriority").value;
	SetValues(machine,document.getElementById("lstMachine"));
	SetValue(date,document.getElementById("dateSelecterCompress_rad"));
	SetValue(priority,document.getElementById("ddlPriority"));
//view
    var viewMachine = document.getElementById("ViewMachine").value;
    SetValue(viewMachine,document.getElementById("lstMachines"));
//setting
    var dateFilter = document.getElementById("SettingDate").value;
	var page = document.getElementById("SettingPages").value;
	SetValue(dateFilter,document.getElementById("dateSelecterSettings_rad"));
	SetValue(page,document.getElementById("ddlPages"));
}
function SetValue(defaultValue,control)
{
    var flag = true;
    for(var i = 0; i < control.options.length; i++)
    {
        if (control.options[i].value == defaultValue)
            {
                control.options[i].selected = true;
                flag = false;
                break;
            }   
    }
    if (flag)
        control.options[0].selected = true;
}
function SetValues(defaultValue,control)
{
    var flag = true;
    var singleValue = defaultValue.split(";");
    for(var i = 0; i < control.options.length; i++)
    {
        for(var j=0;j<singleValue.length;j++)
        {
            if (control.options[i].value == singleValue[j])
            {
                control.options[i].selected = true;
                flag = false;
                break;
            }   
        }
        
    }
    if (flag)
        control.options[0].selected = true;
} 
