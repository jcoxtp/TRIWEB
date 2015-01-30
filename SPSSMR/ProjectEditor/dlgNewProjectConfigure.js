/* FUNCTIONS USED ONLY IN dlgNewProjectConfigure.aspx */
function handleOnLoad() {
	if ( document.dlgNewProjectConfigure.doResizeWindow.value == "1" ) {
		resizeDlg( 1000 );
		document.dlgNewProjectConfigure.doResizeWindow.value = "0";
		document.dlgNewProjectConfigure.tbProjectId.focus();
		document.dlgNewProjectConfigure.tbProjectId.select();
	}
}
window.onload = handleOnLoad;

function keyWasPressed() {
	switch ( event.keyCode )
	{
		case 13: // enter
			if ( document.activeElement.id == "Okcancel_btnCancel" ||
				 document.activeElement.id == "ancCheckProjectId" ||
				 document.activeElement.id == "btnSelectGroupName" ||
				 document.activeElement.id == "TabMain_0_anchor" ||
				 document.activeElement.id == "TabMain_1_anchor" ) {
				return;
			}
			btnOK_ClickedClient();
			break;
		case 27: // esc
			btnCancel_ClickedClient();
			break;
	}
}

var bIsLocked = false;
function rolesRow_Clicked( roleName ) {
	if (bIsLocked) return;
	document.getElementById(roleName).click();
}

function initDialog() {
	document.getElementById('hProjectType').value = window.dialogArguments.projectType;
	document.getElementById('hProjectLabel').value = window.dialogArguments.projectLabel;
	document.getElementById('tbProjectId').value = window.dialogArguments.projectId;
	////document.getElementById('tbProjectFolder').value = window.dialogArguments.projectFolder;
	document.getElementById('projectGroupList').value = window.dialogArguments.projectFolder;
	document.getElementById('hAssignedRoles').value = window.dialogArguments.assignedRoles;
	
	document.getElementById('btnInitPage').click();
}

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
function btnOK_ClickedClient() {
	if ( bIsLocked ) return;
	if ( validateValues() ) {
		sProjectId = document.getElementById('tbProjectId').value;
		//sProjectFolder = document.getElementById('tbProjectFolder').value;
		sProjectFolder = document.getElementById('projectGroupList').value;
		if(sProjectFolder == getI18N("top_level"))
		{
		    sProjectFolder ='';
		}
		sAssignedRoles = getSelectedRoles();
	 	
		closeDialog({status:'ok', projectId:sProjectId, projectFolder:sProjectFolder, assignedRoles:sAssignedRoles});
	}
}

function btnCancel_ClickedClient() {
	if ( bIsLocked ) return;
	closeDialog({status:'cancel'});
}

function showTab( name ) {
	if ( bIsLocked ) return;
	var oSelectedTab = document.getElementById('hSelectedTab');
	var oProjectContent = document.getElementById('ProjectTabTable');
	var oPermissionsContent = document.getElementById('RolesTabTable');
	
	var nWidth = Math.max(oProjectContent.clientWidth, oPermissionsContent.clientWidth);
	switch( name )
	{
		case 'Project':
			oPermissionsContent.style.display = 'none';
			oProjectContent.style.display = '';
			oProjectContent.style.width = nWidth+'px';
			oSelectedTab.value = 0;
			break;
		case 'Permissions':
			oProjectContent.style.display = 'none';
			oPermissionsContent.style.display = '';
			oPermissionsContent.style.width = nWidth+'px';
			oSelectedTab.value = 1;
			break;
	}
}

function checkProjectIdClicked() {
	if ( bIsLocked ) return;
	if ( validateProjectId() )
		document.dlgNewProjectConfigure.btnCheckProjectId.click();
}

function getSelectedRoles() {
	var rv  = "";
	var oRolesTable		= document.getElementById('RolesList');
	var oRolesTableBody	= oRolesTable.getElementsByTagName('TBODY').item(0);
	var nPrefixLength = (new String('chkRole.')).length;
	
	if ( oRolesTable.getAttribute('RoleCount') && parseInt(oRolesTable.getAttribute('RoleCount')) > 0 ) {
		for (r=0; r<oRolesTableBody.childNodes.length; r++) {
			oTR = oRolesTableBody.childNodes.item(r);
			oTD = oTR.childNodes.item(1);
			oCtrl = oTD.childNodes.item(0);
			if ( oCtrl.checked ) rv+=oCtrl.id.substring(nPrefixLength)+",";
		}
	}
	return rv;
}

/* VALIDATION FUNCTIONS */
function validateValues() {
	if ( ! validateProjectId() )
		return false;
	//if ( ! validateProjectFolder() )
	//	return false;
	
	return true;
}

// Limit project names to
// - 16 characters or less long
// - must start with a letter
// - must contain letters (single byte), numbers, @, $, or _
// - there are also reserved names that cannot be used as SQL databases.
//   These are master, model, tempdb, msdb. These names cannot be used.
//   These names are stored in the registry at "HKEY_LOCAL_MACHINE\SOFTWARE\SPSS\DimensionNet\Projects\Reserved"
//   but could be moved elsewhere for ease of use
function validateProjectId() {
	var oElement = document.dlgNewProjectConfigure.tbProjectId;
	
	// accept empty which will generate the name when creating the project
	if ( oElement.value.length == 0 ) return true;
	
	if ( oElement.value.length > 16 ) {
		displayError(document.errorMessageForm.ProjectNameTooLong.value);
		return false;
	}
	
	var validationRegExp = /[a-zA-Z][\w]*/;
	var resultArr = validationRegExp.exec(oElement.value);
	
	if ( resultArr==null || resultArr.length<1 || resultArr[0] != oElement.value ) {
		displayError(document.errorMessageForm.ProjectNameInvalid.value);
		return false;
	}
	
	var oReservedNames = document.getElementById('hReservedProjectNames');
	var reservedNames = oReservedNames.value.split(';');
	for ( i=0; i<reservedNames.length; i++ ) {
		if ( reservedNames[i].toLowerCase() == oElement.value.toLowerCase() ) {
			var strError = document.errorMessageForm.ProjectNameReserved.value;
			for ( n=0; n<reservedNames.length; n++ ) {
				strError += '\n - '+reservedNames[n];
			}
			displayError(strError);
			return false;
		}
	}
	
	return true;
}

//function validateProjectFolder() {
	//var oElement = document.dlgNewProjectConfigure.tbProjectFolder;
	
	//var isGroupRequired = oElement.getAttribute('isRequired');
	//var allGroupName	= oElement.getAttribute("allGroupName");
	//var commonGroupName = oElement.getAttribute("commonGroupName");
	
	
	//if ( oElement.value == "" || oElement.value == allGroupName || oElement.value == commonGroupName )
	//{
	//	displayError(document.errorMessageForm.GroupNameInvalidRequired.value);
	//	oElement.focus();
	//	oElement.select();
	//	return false;
	//}
	
	
	//return true;
//}


function selectGroupClicked() {
	var strSelectedGroup = doDialog("dlgSelectProjectGroup.aspx");
	if ( strSelectedGroup && strSelectedGroup != '' ) {
		var oElement = document.dlgNewProjectConfigure.tbProjectFolder;
		var isGroupRequired = oElement.getAttribute("isRequired");
		var allGroupName	= oElement.getAttribute("allGroupName");
		var commonGroupName = oElement.getAttribute("commonGroupName");
		
		if ( strSelectedGroup == allGroupName || strSelectedGroup == commonGroupName ) {
			strSelectedGroup = '';
		}
		
		if ( isGroupRequired.toLowerCase() == "true" && strSelectedGroup == '' ) {
			displayError(document.errorMessageForm.MustSelectValidGroupName.value);
			return;
		}
		oElement.value = strSelectedGroup;
	}
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

