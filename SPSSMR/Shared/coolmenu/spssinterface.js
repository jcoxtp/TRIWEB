//------------------------------------------------------
// Additions to the interface for the coolmenu object
// include this file AFTER the "spssmenu.js" because
// the oCMenu object is created in "spssmenu.js"
//------------------------------------------------------

// relative path to images of like "bluedots.gif"
oCMenu.strRelativeMenuImagePath = "./";

// SPSS proprietary menu interface
oCMenu.fnAddItem = function (a_sItemName, a_sParent, a_sItemLabel, a_sOnClick, a_bActive, a_nWidth)
{
	oCMenu.makeMenu(a_sItemName, 
				    a_sParent, 
				    a_sItemLabel, 
					'', 
					'', 
					null, 
					null, 
					null, null, null, null, null, null, null, 
					a_sOnClick, 
					null, null);
	oCMenu.m [a_sItemName].lnk2 = "";
	oCMenu.m [a_sItemName].targ2 = "";
	oCMenu.m [a_sItemName].onclck2 = a_sOnClick;
	oCMenu.m [a_sItemName].txt2 = a_sItemLabel;
	
	if ( a_bActive != null && a_bActive == false ) {
		oCMenu.fnDeactivateItem(a_sItemName);
	}
	
	if ( a_nWidth != null ) oCMenu.m[a_sItemName].w = a_nWidth;
}

oCMenu.fnAddLinkItem = function (a_sItemName, a_sParent, a_sItemLabel, a_sLink, a_sTarget, a_bActive, a_nWidth)
{
	oCMenu.makeMenu(a_sItemName, 
				    a_sParent, 
				    a_sItemLabel, 
					a_sLink, 
					a_sTarget, 
					null, 
					null, 
					null, null, null, null, null, null, null, 
					null, null, null);
	oCMenu.m [a_sItemName].lnk2 = a_sLink;
	oCMenu.m [a_sItemName].targ2 = a_sTarget;
	oCMenu.m [a_sItemName].onclck2 = "";
	oCMenu.m [a_sItemName].txt2 = a_sItemLabel;
	
	if ( a_bActive != null && a_bActive == false ) {
		oCMenu.fnDeactivateItem(a_sItemName);
	}
	
	if ( a_nWidth != null ) oCMenu.m[a_sItemName].w = a_nWidth;
}

oCMenu.nMenuSeps = 0;
oCMenu.fnAddSeparator = function (a_sParent, a_nWidth)
{
    var sSepName = "menuSep" + this.nMenuSeps++;
	oCMenu.makeMenu(sSepName, 
				    a_sParent, 
				    "<table><tr><td width='1200px' height='1px' style='background-color:#31569C'></td></tr></table>",
				    '','',
				    null, 8);
				    		    
    oCMenu.m[sSepName].cl = "clInactiveMenuItem";
    oCMenu.m[sSepName].cl2 = "clInactiveMenuItem";				    
    
    if ( a_nWidth != null ) oCMenu.m[sSepName].w = a_nWidth;
}				    

oCMenu.fnActivateItem = function (a_sItemName)
{
	oCMenu.m[a_sItemName].lnk = oCMenu.m[a_sItemName].lnk;
	oCMenu.m[a_sItemName].targ = oCMenu.m[a_sItemName].targ2;
	oCMenu.m[a_sItemName].onclck = oCMenu.m[a_sItemName].onclck2;
	oCMenu.m[a_sItemName].cl = "clActiveMenuItemOff";
	oCMenu.m[a_sItemName].cl2 = "clActiveMenuItemOn";
	oCMenu.m[a_sItemName].txt = oCMenu.m[a_sItemName].txt2;		
}


oCMenu.fnDeactivateItem = function (a_sItemName)
{
	oCMenu.m[a_sItemName].lnk = "";
	oCMenu.m[a_sItemName].targ = "";
	oCMenu.m[a_sItemName].onclck = "";
	oCMenu.m[a_sItemName].cl = "clInactiveMenuItem";
	oCMenu.m[a_sItemName].cl2 = "clInactiveMenuItem";
	oCMenu.m[a_sItemName].txt = oCMenu.m[a_sItemName].txt2;		
}

oCMenu.fnAddOnShowHandler = function (a_sExpr)
{
	oCMenu.onshow += a_sExpr;
}

oCMenu.fnSetOnClickHandler = function (a_sItemName, a_sExpr)
{
	oCMenu.m[a_sItemName].onclck2 = a_sExpr;
	if (oCMenu.m[a_sItemName].cl == "clActiveMenuItemOff")
	{
		oCMenu.m[a_sItemName].onclck = a_sExpr;		
	}	
}
