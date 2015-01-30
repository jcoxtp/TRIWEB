
<script language="JavaScript1.2">
<!--
var showLevel = 0 ;
var imf = "includes/images" ;
var syncEl = null;
var singleFolder = false;
var autoSync = 2;
var syncBgColor='Yellow';
function doAutoSync(){if(autoSync)synchronize(parent.frames['content'].location);if(autoSync==2)setTimeout("doAutoSync()",2000);}
var bOpenIcon = true ;
var nDays = 30 ;
if(Opera&&!Opera7)
	document.write("<"+"script language='JavaScript1.2' src='includes/scripts/tree_opera.js'><"+"/"+"SCRIPT>");
  else if(DOM||Opera7)
	document.write("<"+"script language='JavaScript1.2' src='includes/scripts/tree_dom.js'><"+"/"+"SCRIPT>");
  else
	document.write("<"+"script language='JavaScript1.2' src='includes/scripts/tree_v4.js'><"+"/"+"SCRIPT>");

//-->
</script>
<a href="javascript:void(0);" onclick="onExpandAll(); return false">
<font class="SXLR">Expand All</font></a>
&nbsp;|&nbsp;
<a href="javascript:void(0);" onclick="onCollapseAll(); return false">
<font class="SXLR">Collapse All</font></a>
<div id="TP" class="TP">&nbsp;</div>

<iframe name='dyntree_frame' frameborder='0' style='width:1;height:1;visibility:hidden'></iframe>

<div id="SXR" class="SXR">
</div>

<div id="I0SXE5SXP" par="root" class="SXP0">
	<a href="javascript:void(0);" onclick="onClicked(null,0,5); return false">
	<img name="MI0SXE5SXP" src="includes/images/sxicon0.gif" align="absmiddle" class="im" border="0" /></a><img name="NI0SXE5SXP" src="includes/images/sxicon2.gif" align="absmiddle" class="im"/>&nbsp;<a href="javascript:void(0);" class="SXLP0" onclick="onClicked(null,0,5); return false">Reports</a>
</div>

<div id="I0SXE5SXC" class="SXC0">
	<table class="TBL" cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="36"></td><td class="SXLC0">
	<img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC0" href="docs/reports/searchByQuestion.asp" target="content">Search By Question</a>
	</td></tr></table>
</div>


<script language="JavaScript1.2">
<!--
	li = "I0SXE5SXC";
onunload=saveCookie;
//-->
</script>
