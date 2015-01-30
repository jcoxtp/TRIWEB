// this script assumes the tabs are located in a division
// named "TabClientDiv" - see index.html
var oTabCtrl = new spssTabCtrl()

cFirst = 0
cConnection = 0
cAdvanced = 1
cAll = 2
cLast = 2

divs = { 0:'ConnectionDiv', 1:'AdvancedDiv', 2:'AllDiv' }			

connectionPropertyGroup = {
	'MR Init MDSC' : 'MDSCDropDownList',
	'Initial Catalog' : 'MDSCSource',
	'Data Source' : 'CDSCDropDownList',
	'Location' : 'CDSCSource',
	'MR Init Project' : 'CDSCProject',
	'MR Init MDM Access' : 'OpenReadWrite'
}

advancedPropertyGroup = {
	'MR Init MDM DataSource Use' : 'MR Init MDM DataSource Use',
	'MR Init Validation' : 'Validation',
	'MR Init Allow Dirty' : 'AllowDirty',
	'MR Init Category Names' : 'MR Init Category Names',
	'User ID' : 'UserName',
	'Password' : 'Password'
}

// used to convert 0, 1 to False, True when building connection string
booleanProperties = {
	'MR Init Validation' : true,
	'MR Init Allow Dirty' : true
}

// the allPropertyGroup is not listed, it is read directly from the HTML table

propertyMap = {}

function getDiv(idx) {
	return wsDoc().getElementById(divs[idx.toString()]);
}

function setValue(input, value) {
	   if (value==undefined||value==null)
		{
	    	return;
	    }
	switch(input.type) {
		case "checkbox":
			v = value.toLowerCase();
			input.checked = (v != "false" && v != "0");
			break;
		
		case "select-one":
			var i = 0;
			var selectPrevious = true;
			var previousIdx = input.selectedIndex;
			while (i < input.length) {
				input.selectedIndex = i++;
				if ( value.toLowerCase() == input.value.toLowerCase() ) {
					// Check if "(none)" or "SPSS MR Metadata Document" must be selected.
					// They both have an empty string as value, but "(none)" is index 0.
					// These are defined in MDSCItems.xml
					if (input.selectedIndex==0 && input.id=="MDSCDropDownList" && propertyMap["Initial Catalog"] != "" && value == "") {
						continue;
					}
					selectPrevious = false;
					break;
				}
			}
			if ( selectPrevious ) {
				input.selectedIndex = previousIdx;
			}
			break;
		
		default:
			input.value = value;
			break;
	}
}

function getValue(input) {
	switch(input.type) {
		case "checkbox":
			return input.checked ? "1" : "0";
		
		default:
			return input.value;
	}
}

function syncProperty(bToMap, propertyName, propertyInput) {
	if(bToMap)
		propertyMap[propertyName] = getValue(propertyInput);
	else {
		setValue(propertyInput, propertyMap[propertyName]);
	}
}

// Some properties may be present on multiple pages
// The sync functions synchronizes each view (a tab) with the underlying model (the propertyMap).
// the flag bToMap indicates the direction of synchronization: to the model (propertyMap) or to the view (inputs).

function initAll() {
	table = wsDoc().getElementById('PropertyList');
	rows = table.rows;
	ni = rows.length;
	// skip row zero, it's the header
	for(i = 1; i < ni; ++i) {
		tr = table.rows(i);
		propertyMap[tr.cells(2).innerText] = '';
		//syncProperty(true, tr.cells(2).innerText, '');
	}
}

// locate input controls in html table
function syncAll(bToMap) {
	table = wsDoc().getElementById('PropertyList');
	rows = table.rows;
	ni = rows.length;
	// skip row zero, it's the header
	for(i = 1; i < ni; ++i) {
		tr = table.rows(i);
		syncProperty(bToMap, tr.cells(2).innerText, tr.cells(1).all(0));
	}
}

function syncPropertyGroup(bToMap, propertyGroup) {
	for(property in propertyGroup) {
		syncProperty(bToMap, property, wsDoc().getElementById(propertyGroup[property]));
	}
}

function syncAdvanced(bToMap) {
	syncPropertyGroup(bToMap, advancedPropertyGroup);
}

function syncConnection(bToMap) {
	syncPropertyGroup(bToMap, connectionPropertyGroup);
}

function syncInputConnectionString() {
	re = /[ \t\r\n]*(.*?)[ \t\r\n]*=[ \t\r\n]*(\'[^\']*\'|\"[^\"]*\"|[^;]*?)[ \t\r\n]*(;|$)/g;
	cs = getInputArguments().ConnectionString;
	m = re.exec(cs);
	while(m) {
		property = m[1];
		value = m[2];
		switch(property.toLowerCase()) {
			case "initial catalog":
			//case "location":
				// remove single- and double quotes
				value = value.replace(/\"/g, "").replace(/\'/g, "");
				break;
		}
		propertyMap[property] = value;
		m = re.exec(cs);
	}
}

function syncDefaultValues() {
	initAll();
	syncInputConnectionString();
	syncConnection(false);
	syncAdvanced(false);
	syncAll(false)
	
	
	// make sure that Provider is "mrOleDB.Provider.2"
	if( propertyMap['Provider'] == null ) {
		if( confirm(getI18NString('index_e_no_provider')) ) {
			propertyMap['Provider'] = "mrOleDB.Provider.2";
		}
		else {
			// return by simulation cancel...
			returnProperties(true);
		}
	}
	else if ( propertyMap['Provider'] != 'mrOleDB.Provider.2' ) {
		propertyMap['Provider'] = "mrOleDB.Provider.2";
		if( confirm(getI18NString('index_e_unsupported_provider')) ) {
			propertyMap['Provider'] = "mrOleDB.Provider.2";
		}
		else {
			// return by simulation cancel...
			returnProperties(true);
		}
	}
}

function getI18NString(resourceId) {
	try {
		if ( I18N == null ) {
			//return "no resources : "+resourceId;
			return "";
		}
		
		if ( I18N[resourceId] == null ) {
			//return "no such string in resources : "+resourceId;
			return "";
		}
		
		return I18N[resourceId];
	}
	catch (e) {
		//return e.description;
		return "";
	}
}

syncMap = {
	'ConnectionDiv' : syncConnection,
	'AdvancedDiv' : syncAdvanced,
	'AllDiv' : syncAll
}

function sync(name, bToMap) {
	return syncMap[name](bToMap);
}

function currentTabIdx() {
	return wsDoc().getElementById('CurrentDivState').value;
}

function syncCurrent(bToMap) {
	sync(currentTabIdx(), bToMap);
}

function getProperty(property) {
	// load from gui to map
	syncCurrent(true);
	return propertyMap[property];
}

function setProperty(property, value) {
	propertyMap[property] = value;
	syncCurrent(false);
}

function selectTab(idx) {
	// ignore tab-click if doc is not loaded
	if (wsDoc().readyState!="interactive" && wsDoc().readyState!="complete") {
		return;
	}
	oTabCtrl.Select(idx);
	
	for(i = cFirst; i <= cLast; ++i)
	    getDiv(i).style.display = 'none';
	getDiv(idx).style.display = '';
	
	// so server roundtrip lands on same tab - info used by window.onload in TabClientDiv page
	prevDiv = currentTabIdx();
	nextDiv = divs[idx.toString()];
	wsDoc().getElementById('CurrentDivState').value = nextDiv;
	sync(prevDiv, true);
	sync(nextDiv, false);
}

function buildConnectionString() {
	// make sure propertyMap is up to date
	syncCurrent(true);
	pm = propertyMap;
	cs = '';
	for(property in pm ) {
		value = pm[property];
		if(value) {
			if (booleanProperties[property])
			    value = (value && value != "" && value != 0) ? 'True' : 'False';
			if(cs.length > 0)
				cs += ';';
			switch (property.toLowerCase() ) {
				case 'location':
				case 'initial catalog':
					if (value.charAt(0)!='"' && value.charAt(value.length-1)!='"' ) {
						value = '"'+value+'"';
					}
					break;
			}
			cs += property;
			cs += '=';
			cs += value;
		}
	}
	return cs;
}

function returnProperties(bCancel) {
	if(bCancel) {
	  initReturnValue( { cs: "", map:{} } );
	}
	else {
	  s = buildConnectionString();
	  initReturnValue( { cs: s, map:propertyMap } );
	}
	
	closeDialog();
}

function wsDoc() {
	return top.frames[0].document;
}

function doInitTabs() {
	top.closeDataLinkDialog = returnProperties;
	// called by window.onload in tab clientdiv
	//top.syncDefaultProperties = syncDefaultValues
	top.getProperty = getProperty;
	top.setProperty = setProperty;
	top.getInputArguments = getInputArguments;
	
	//oTabCtrl.ImagePath = 'images';	// only needed if images are placed in another subdir than images
	
	oTabCtrl.AutoSelectTabs = false;	// should the tabctrl itself select the clicked tab
	oTabCtrl.InitTab('TabClientDiv');	// 'TabClientDiv' = id of div to use...
	
	oTabCtrl.AddTab( getI18NString('tab_connection'), 'selectTab(cConnection)' );
	oTabCtrl.AddTab( getI18NString('tab_advanced'), 'selectTab(cAdvanced)' );
	oTabCtrl.AddTab( getI18NString('tab_all'), 'selectTab(cAll)' );
	
	oTabCtrl.selectedIdx = 0;
}
