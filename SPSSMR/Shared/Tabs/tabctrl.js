//---------------------------------------------------------
// spssTabCtrl object
function spssTabCtrl() {
													/* PARAMETERS */
	this.InitTab		= spssTabCtrl_initTab;		/* (strTabCtrlId, strImagePath) */
	this.AddTab			= spssTabCtrl_addTab;		/* (name, onclick_action, image, imageClass) */
	this.Draw			= spssTabCtrl_drawTabCtrl;	/* (newIdx [optional]) */
	this.Click			= spssTabCtrl_Clicked;		/* (newIdx) */
	this.Select			= spssTabCtrl_Selected;		/* (newIdx) */
	this.SetImagePath	= spssTabCtrl_SetImagePath;	/* (strImagePath) */
	
	this.TabHeight		= '32px';		// default value : must match images height
	this.TabWidth		= '60px';		// minimum width of area where tabtext and images are placed
	this.TabTextAlign	= 'left';		// text alignment for all tab tabs
	this.AutoSelectTabs	= false;		// should a tab automatically be updated when clicked - set this before adding any tabs
	
	//'''''''''''''''''''''''''''''''''''''
	// private stuff - don't mess with it!
	this.selectedIdx	= -1;						// index of the currently selected tab (-1 = no selection)
	this.NBSP			= String.fromCharCode(160);	// &nbsp; const char
	this.imagePath		= './images';				// path where tab images are placed - relative to doc that incudes this file
	this.imgArray		= new Array(9);				// for image caching / preloading
	this.tabCtrlName	= '';
	this.tabs			= new Array(0);
	
	this.adjustTableSize  = spssTabCtrl_adjustTableSize;
}

//---------------------------------------------------------
// spssTabItem - Object for internal use
function spssTabItem(name, onclick_action, image, imageClass, autoSelect, parent, index) {
	this.name	= name;
	
	
	this.onclick_action = function() { 
							if ( autoSelect ) parent.Select(index);
							eval(onclick_action);
						  };
	
	this.image = image;
	this.imageClass = imageClass;
}
//---------------------------------------------------------

//-----------------------------------------------------------------
// Don't call these functions - use the spssTabCtrlObject...
function spssTabCtrl_initTab(strTabCtrlId, strImagePath) {
	this.tabCtrlName = strTabCtrlId;
	
	this.SetImagePath( strImagePath );
}

//---------------------------------------------------------

function spssTabCtrl_addTab(name, onclick_action, image, imageClass) {
	this.tabs.push( new spssTabItem(name, onclick_action, image, imageClass, this.AutoSelectTabs, this, this.tabs.length) );
}

//---------------------------------------------------------

function spssTabCtrl_drawTabCtrl(newIdx) {

	if ( newIdx != null && newIdx >= 0 && newIdx < this.tabs.length ) {
		this.selectedIdx = newIdx;
	}
	
	if ( this.tabCtrlName == '' ) return;
	
	var oDiv = document.getElementById(this.tabCtrlName);
	if ( oDiv == null ) return;
	
	while ( oDiv.childNodes.length > 0 ) {
		var oDOMNode = oDiv.childNodes[0];
		oDiv.removeChild( oDOMNode );
	}
	
	var oTable1 = document.createElement('table');
	oTable1.style.padding = '0px';
	oTable1.cellPadding = '0';
	oTable1.cellSpacing = '0';
	oTable1.border = '0';
	oTable1.width = '100%';
	
	var oTBody1 = document.createElement('tbody');
	oTable1.appendChild(oTBody1);
	
	var oTR1 = document.createElement('tr');
	oTBody1.appendChild(oTR1);
	
	var oTD11 = document.createElement('td');
	oTR1.appendChild(oTD11);
	oTD11.style.padding = '0px';
	
	var oTD12 = document.createElement('td');
	oTD12.appendChild( document.createTextNode(this.NBSP) );
	oTD12.width = '100%';
	oTR1.appendChild(oTD12);
	oTD12.className = 'tabBorderLight';
	
	var oTable2 = document.createElement('table');
	oTable2.setAttribute('id', this.tabCtrlName+this.tabCtrlName+'SPSS');
	oTD11.appendChild(oTable2);
	oTable2.style.padding = '0px';
	oTable2.cellPadding = '0';
	oTable2.cellSpacing = '0';
	oTable2.border = '0';
	
	var oTBody2 = document.createElement('tbody');
	oTable2.appendChild(oTBody2);
	
	var oTR2 = document.createElement('tr');
	oTBody2.appendChild(oTR2);
	
	var oTD2 = document.createElement('td');
	oTR2.appendChild(oTD2);
	oTD2.appendChild( document.createTextNode(this.NBSP) );
	oTD2.width = '1px';
	oTD2.height = this.TabHeight;
	oTD2.style.padding = '0px';
	oTD2.className = 'tabBorderLight';
	
	var strTabOnOff;
	for ( nCurrentTab=0; nCurrentTab<this.tabs.length; nCurrentTab++ ) {
		// check if this tab is the selected tab
		strTabOnOff = (nCurrentTab==this.selectedIdx)?'on':'off';
		
		if ( nCurrentTab == 0 ) {
			// First image cell + image (first.on / first.off)
			oTD2 = document.createElement('td');
			oTD2.setAttribute('background', this.imgArray['first.'+strTabOnOff].src);
			oTR2.appendChild(oTD2);
			oTD2.style.padding = '0px';
			oTD2.width = '15px';
			oTD2.height = this.TabHeight;
			oTD2.onclick = this.tabs[nCurrentTab].onclick_action;
			oTD2.innerHTML = '<table style="WIDTH: '+oTD2.width+'; TABLE-LAYOUT: fixed"><tr><td></td></tr></table>';
		}
		else {
			// Seperator image cell + image (on.off / off.off / off.on)
			var strPrevTabOnOff = (nCurrentTab==this.selectedIdx+1)?'on.':'off.';
			oTD2 = document.createElement('td');
			
			oTD2.setAttribute('background', this.imgArray[strPrevTabOnOff+strTabOnOff].src);
			oTR2.appendChild(oTD2);
			oTD2.style.padding = '0px';
			oTD2.width = '16px';
			oTD2.height = this.TabHeight;
			oTD2.innerHTML = '<table style="WIDTH: '+oTD2.width+'; TABLE-LAYOUT: fixed"><tr><td></td></tr></table>';
		}
		
		// Cell for tab text
		oTD2 = document.createElement('td');
		oTD2.setAttribute('background', this.imgArray['main.'+strTabOnOff].src);
			
		oTR2.appendChild(oTD2);
		oTD2.style.padding = '0px';
		oTD2.className = 'tabArea';
		oTD2.align = this.TabTextAlign;
		oTD2.height = this.TabHeight;
		oTD2.width = this.TabWidth;
		oTD2.onclick = this.tabs[nCurrentTab].onclick_action;
		oTD2.style.whiteSpace = 'nowrap';
		oTD2.style.verticalAlign = 'middle';
		
		// Tab text anchor
		var oAnc = document.createElement('a');
		oAnc.appendChild( document.createTextNode(this.tabs[nCurrentTab].name) );
		oAnc.className = 'tabText';
		oAnc.href = 'javascript:void(0);';
		oAnc.style.whiteSpace = 'nowrap';
		oAnc.style.textDecoration = 'none';
		oAnc.style.verticalAlign = 'middle';
		oTD2.appendChild(oAnc)
				
		// End image cell + image (end.on / end.off)
		if ( nCurrentTab == this.tabs.length-1 ) {
			oTD2 = document.createElement('td');
			oTD2.setAttribute('background', this.imgArray['end.'+strTabOnOff].src);
			oTR2.appendChild(oTD2);
			oTD2.style.padding = '0px';
			oTD2.width = '13px';
			oTD2.height = this.TabHeight;
			oTD2.onclick = this.tabs[nCurrentTab].onclick_action;
			oTD2.innerHTML = '<table style="WIDTH: '+oTD2.width+'; TABLE-LAYOUT: fixed"><tr><td></td></tr></table>';
		}
	}
	oTD2 = document.createElement('td');
	oTD2.appendChild( document.createTextNode(this.NBSP) );
	oTR2.appendChild(oTD2);
	oTD2.className = 'tabBorderLight';
	
	oDiv.appendChild(oTable1);
	this.adjustTableSize()
}

//---------------------------------------------------------

function spssTabCtrl_Clicked(newIdx) {
	this.tabs[newIdx].onclick_action();
}

//---------------------------------------------------------

function spssTabCtrl_Selected(newIdx) {
	if ( newIdx > this.tabs.length ) return null;
	if ( newIdx == this.selectedIdx ) return this.selectedIdx;
	
	var prev = this.selectedIdx;

	var oDiv = document.getElementById(this.tabCtrlName);
	if ( oDiv == null ) return prev;

	var oTable2 = document.getElementById(this.tabCtrlName+this.tabCtrlName+'SPSS');
	if ( oTable2 == null ) return prev;
	
	var oTBody2 = oTable2.getElementsByTagName('tbody').item(0);
	var oTR2 = oTBody2.childNodes.item(0);
	var oTDs = oTR2.childNodes;
	
	var strSepName1;
	var strSepName2;
	
	if ( this.selectedIdx != -1 ) {
		var currentSelectedTD = this.selectedIdx*2 + 1;
		if ( currentSelectedTD+2 >= oTDs.length ) return prev ;
		
		strSepName1 = (this.selectedIdx==0)?'first.off':'off.off';
		strSepName2 = (this.selectedIdx==this.tabs.length-1)?'end.off':'off.off';
		
		oTDs.item(currentSelectedTD).setAttribute('background', this.imgArray[strSepName1].src );
		oTDs.item(currentSelectedTD+1).setAttribute('background', this.imgArray['main.off'].src );
		oTDs.item(currentSelectedTD+2).setAttribute('background', this.imgArray[strSepName2].src );
	}
	
	if ( newIdx>=0 && newIdx<this.tabs.length ) {
		var newSelectedTD = newIdx*2 + 1;
		if ( newSelectedTD+2 >= oTDs.length ) return prev;
		
		strSepName1 = (newIdx==0)?'first.on':'off.on';
		strSepName2 = (newIdx==this.tabs.length-1)?'end.on':'on.off';
		
		oTDs.item(newSelectedTD).setAttribute('background', this.imgArray[strSepName1].src );
		oTDs.item(newSelectedTD+1).setAttribute('background', this.imgArray['main.on'].src );
		oTDs.item(newSelectedTD+2).setAttribute('background', this.imgArray[strSepName2].src );
	}
	
	this.selectedIdx = newIdx;
	
	return prev;
}

//---------------------------------------------------------

function spssTabCtrl_SetImagePath(strImagePath) {
	var isPathChanged = (this.imagePath != strImagePath);
	
	if ( strImagePath != null )
		this.imagePath = strImagePath;
	
	if ( isPathChanged || this.imgArray["first.on"] == null ) {
		this.imgArray["first.on"]  = new Image(); this.imgArray["first.on"].src = this.imagePath + '/tabfirst.on.gif';
		this.imgArray["first.off"] = new Image(); this.imgArray["first.off"].src = this.imagePath + '/tabfirst.off.gif';
		this.imgArray["on.off"]    = new Image(); this.imgArray["on.off"].src = this.imagePath + '/tab.on.off.gif';
		this.imgArray["off.off"]   = new Image(); this.imgArray["off.off"].src = this.imagePath + '/tab.off.off.gif';
		this.imgArray["off.on"]    = new Image(); this.imgArray["off.on"].src = this.imagePath + '/tab.off.on.gif';
		this.imgArray["main.on"]   = new Image(); this.imgArray["main.on"].src = this.imagePath + '/tabmain.on.gif';
		this.imgArray["main.off"]  = new Image(); this.imgArray["main.off"].src = this.imagePath + '/tabmain.off.gif';
		this.imgArray["end.on"]    = new Image(); this.imgArray["end.on"].src = this.imagePath + '/tabend.on.gif';
		this.imgArray["end.off"]   = new Image(); this.imgArray["end.off"].src = this.imagePath + '/tabend.off.gif';
	}
}

//---------------------------------------------------------

function spssTabCtrl_adjustTableSize() {
	try {
		var nWidth = 0;
		var oElem;
		
		oElem = document.getElementById(this.tabCtrlName+this.tabCtrlName+'SPSS');
		if ( oElem == null) return;
		
		var oTBODY = oElem.getElementsByTagName("TBODY").item(0);
		var oTR    = oTBODY.childNodes.item(0);
		var oTDs    = oTR.childNodes;
		
		if ( oElem.clientWidth ) {
			for ( i=0; i<oTDs.length-1; i++ ) {
				nWidth += Math.max(parseInt(oTDs[i].clientWidth), parseInt(oTDs[i].width));
			}
		}
		
		if ( nWidth > 0 )
		{
			oElem.width = nWidth + 'px'
		}
		else
		{
			// set width to (#TD * 200) px (really big)
			oElem.width = oTR.childNodes.length*200 + 'px'
		}
	} catch ( e ) { }
	
}

//-----------------------------------------------------------------
