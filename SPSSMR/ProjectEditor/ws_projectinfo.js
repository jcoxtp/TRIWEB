function handleWindowOnLoad() {
	setFocusToSavedID( "hPropFocus" );
	setFocusToSavedID();
}
window.onload = handleWindowOnLoad;

function getI18N(resourceId) {
	try {
		if ( I18N == null ) {
			return "no resources : "+resourceId;
			return "";
		}
		
		if ( I18N[resourceId] == null ) {
			return "no such string in resources : "+resourceId;
			return "";
		}
		
		return I18N[resourceId];
	}
	catch (e) {
		return e.description;
		return "";
	}
}

function rolesRow_Clicked( roleName ) {
	if (bIsLocked) return;
	document.getElementById(roleName).click();
}

var strPropFocusID = "";
function handlePropertyCtrlFocus( ctrl ) {
	try {
		if ( strPropFocusID != "" ) {
			var ctrlLostFocus = document.getElementById(strPropFocusID);
			var oTR = ctrlLostFocus.parentElement.parentElement;
			oTR.className = ctrlLostFocus.readOnly?"PropertiesTableRowReadOnly":"PropertiesTableRow";
		}
	} catch ( er ) { }
	
	saveFocusCtrlID( ctrl, "hPropFocus" );
	saveFocusCtrlID( ctrl );
	
	try {
		ctrl.parentElement.parentElement.className = "PropertiesTableRowSelected";
		if ( ! ctrl.readOnly )
			ctrl.select();
	} catch ( er ) { }
}

function saveFocusCtrlID( theCtrl, optionalInputID ) {
	if ( optionalInputID == null )
		optionalInputID = "hCtrlFocus";
		
	try {
		var oCtrlFocus = document.getElementById( optionalInputID );
		oCtrlFocus.value = theCtrl.id;
		
		if ( optionalInputID != "hCtrlFocus" )
		{
			strPropFocusID = theCtrl.id;
			
			// save DPM property name to be able to press delete...
			var oCtrlFocusName = document.getElementById( "hPropFocusName" );
			oCtrlFocusName.value = theCtrl.getAttribute("DPMName");
		}
	}
	catch(er) { }
}

function setFocusToSavedID( optionalInputID ) {
	if ( optionalInputID == null )
		optionalInputID = "hCtrlFocus";
	
	try {
		var oCtrlFocus = document.getElementById( optionalInputID );
		var theID = oCtrlFocus.value;
		
		if ( theID != "" ) {
			var oCtrl = document.getElementById(theID);
			oCtrl.focus();
		}
	}
	catch(er) { }
}

function selectGroupClicked() {
	var strSelectedGroup = doDialog( 'dlgSelectProjectGroup.aspx' );
	if ( strSelectedGroup && strSelectedGroup != '' ) {
		var oElement = document.ws_projectinfo.tbGroupName;
		var isGroupRequired = oElement.getAttribute("isRequired");
		var allGroupName	= oElement.getAttribute("allGroupName");
		var commonGroupName = oElement.getAttribute("commonGroupName");
		
		if ( strSelectedGroup == allGroupName || strSelectedGroup == commonGroupName ) {
			strSelectedGroup = '';
		}
		
		if ( isGroupRequired.toLowerCase() == "true" && strSelectedGroup == '' ) {
			displayError(getI18N('projectinfo_err_must_select_groupname'));
			return;
		}
		
		var oOldGroup = document.ws_projectinfo.tbGroupName;
		if ( oOldGroup.value != strSelectedGroup ) {
			oOldGroup.value = strSelectedGroup;
			oOldGroup.blur();
			oOldGroup.focus();
			document.ws_projectinfo.dummyBtn.click();
		}
	}
}


function addApplicationClicked()
{
	var newAppName = doDialog( 'dlgSelectApplication.aspx' );
	
	if ( newAppName != '' )
	{
		// check if the selected app already exists in the list
		var oAppList = document.ws_projectinfo.cbApplication.options;
		for ( i=0; i<oAppList.length; i++ ) {
			if ( oAppList[i].text.toLowerCase() == newAppName.toLowerCase() ) {
				if ( ShowYesNoQuestion( getI18N('projectinfo_confirm_overwrite_app_settings')) )
					break;
				else
					return;
			}
		}
		
		document.getElementById("hAddApplicationName").value = newAppName;
		document.getElementById("AddApplicationBtn").click();
	}
}


function importPropertiesClicked() {
	var newAppName = doDialog( 'dlgImportProperties.aspx' );
	
	if ( newAppName != '' )
	{
		document.getElementById("hAddApplicationName").value = newAppName;
		document.getElementById("reloadProjectBtn").click();
	}
}

function propertTR_Clicked( trCtrl ) {
	var inputID = (trCtrl.id).replace("propertyTR", "property");
	var oInput  = document.getElementById(inputID);
	if ( oInput != null )
		oInput.focus();
}

function updateConnectionStringInfo(connectionString, connectionStringMap) {
	var oDataLocation = document.getElementById('tbDataLocation');
	oDataLocation.value = connectionString;
	
	try { 
		var sMrInitMDSC = connectionStringMap['MR Init MDSC'];
		var sInitialCatalog = connectionStringMap['Initial Catalog'];
		if(sMrInitMDSC==''&&sInitialCatalog!='') {
			sMrInitMDSC = 'SPSS MR Metadata Document';
		}
		document.getElementById('tbMetaDataType').innerText = sMrInitMDSC;
	} catch (e) {}
	try { document.getElementById('tbMetaDataLocation').innerText = connectionStringMap['Initial Catalog']; } catch (e) {}
	try { document.getElementById('tbMetaDataReadWrite').innerText = (connectionStringMap['MR Init MDM Access']==1)?getI18N('ReadWrite'):getI18N('ReadOnly'); } catch (e) {}
	try { document.getElementById('tbCaseDataType').innerText = connectionStringMap['Data Source']; } catch (e) {}
	try { document.getElementById('tbCaseDataLocation').innerText = connectionStringMap['Location']; } catch (e) {}
	try { document.getElementById('tbCaseDataProject').innerText = connectionStringMap['MR Init Project']; } catch (e) {}

	// Redraw CsDiv
	var sInner = document.getElementById('CsDiv').innerHTML;
	document.getElementById('CsDiv').innerHTML = '';
	document.getElementById('CsDiv').innerHTML = sInner;	

	// Reload
	document.ws_projectinfo.dummyBtn.click();
}

/* TABS */
var bIsLocked;
function showTab(tabselected) 
{
  	if ( bIsLocked ) return;
	var oSelectedTab = document.getElementById('hSelectedTab');
	var oProjectInfoTab = document.getElementById('ProjectInfoTabTable');
	var oRolesTab = document.getElementById('RolesTabTable');
	var oConnectionTab = document.getElementById('ConnectionTabTable');
	var PropertiesTab = document.getElementById('PropertiesTabTable');
	
	if ( oSelectedTab == null || oProjectInfoTab == null || oRolesTab== null || oConnectionTab== null || PropertiesTab== null) 
	{
	    alert("No tab");
		return;
	}
	
	switch(tabselected)
	{
		case 0: // ProjectInfo
			oSelectedTab.value = 0;
			oProjectInfoTab.style.display = '';
			oRolesTab.style.display = 'none';
			oConnectionTab.style.display = 'none';
			PropertiesTab.style.display = 'none';
			break;
		case 1: // Roles
			oSelectedTab.value = 1;
			oProjectInfoTab.style.display = 'none';
			oRolesTab.style.display = '';
			oConnectionTab.style.display = 'none';
			PropertiesTab.style.display = 'none';
			break;
		case 2: // Connection
			oSelectedTab.value = 2;
			oProjectInfoTab.style.display = 'none';
			oRolesTab.style.display = 'none';
			oConnectionTab.style.display = '';
			PropertiesTab.style.display = 'none';
			break;
		case 3: // Properties
			oSelectedTab.value = 3;
			oProjectInfoTab.style.display = 'none';
			oRolesTab.style.display = 'none';
			oConnectionTab.style.display = 'none';
			PropertiesTab.style.display = '';
			break;
	}
	parent.oTabCtrl.Select(tabselected);
}

function SynchMenuAndContent()
{
    var oSelectedTab = document.getElementById('hSelectedTab');
    var menu = parent.oTabCtrl;
    if(oSelectedTab && menu)
    {
        if(menu.selectedIdx != oSelectedTab.value)
        {
	        menu.Select(oSelectedTab.value);
	    }
	}
}
var postbackTimeout;
function delayedPostBack( ctrl ) {
	// this is just to give time for saving the id of the
	// control that has recieved focus before the form is posted
	postbackTimeout = setTimeout( "__doPostBack( '"+ctrl.id+"', '')", 200 );
}

var oSorter = new TableSortObject('properetiesTable');
function doSortProperties(idx) {
	switch(idx) {
		case 0:
			oSorter.sortTable( idx )
			break;
		case 1:
			oSorter.sortTable( idx )
			break;
		case 2:
			oSorter.sortTable( idx )
			break;
	}
}

// used from other frames
function getProjectName() {
	try {
		return document.getElementById("hProjectName").value;
	}
	catch(e) {
		return "";
	}
}

function closeCommand() {
	try { clearTimeout(postbackTimeout); } catch(e) {}
	document.getElementById('btnClose').click();
}

function groupSelected() 
{
    var groupList = document.getElementById('projectGroupList');
    var group = groupList.value;
    if(group == getI18N("create_new_folder"))
    {
        var url = "Dialognew.aspx?temp=" + Math.random();
        var newGroupName = doDialog(url);
        var hiddenField = document.getElementById('newGroupName');
     
	    if ( newGroupName && newGroupName != '' ) 
	    {
            newGroupName = unescape(newGroupName);
	        hiddenField.value = newGroupName;
        }
	    else
	    {
	        groupList.value =  getI18N("top_level");  
	        hiddenField.value = '';
	    }
	}
}

