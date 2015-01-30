
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
  else if(DOM||IE4||Opera7)
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
	<img name="MI0SXE5SXP" src="includes/images/sxicon0.gif" align="absmiddle" class="im" border="0" /></a><img name="NI0SXE5SXP" src="includes/images/sxicon2.gif" align="absmiddle" class="im"/>&nbsp;<a href="javascript:void(0);" class="SXLP0" onclick="onClicked(null,0,5); return false">Surveys</a>
</div>

<div id="I0SXE5SXC" class="SXC0">
	<table class="TBL" cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="36"></td><td class="SXLC0">
	<img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC0" href="docs/surveys/createSurvey.asp" target="content">Create Survey</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC0" href="docs/surveys/editSurvey/general.asp" target="content">Edit Survey</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC0" href="docs/surveys/inviteUsers.asp" target="content">Inviting Users</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC0" href="docs/surveys/items/numberAnsweInputs.asp" target="content">Number of Answer Inputs</a>
	</td></tr></table>
</div>

<div id="I1SXE6SXP" par="I0SXE5SXP" class="SXP1">
	<table cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="20"></td><td class="SXLP1">
	<a href="javascript:void(0);" onclick="onClicked(null,1,6); return false">
	<img name="MI1SXE6SXP" src="includes/images/sxicon0.gif" align="absmiddle" class="im" border="0" /></a><img name="NI1SXE6SXP" src="includes/images/sxicon2.gif" align="absmiddle" class="im"/>&nbsp;<a href="javascript:void(0);" class="SXLP1" onclick="onClicked(null,1,6); return false">Survey Properties</a>
	</td></tr></table>
</div>

<div id="I1SXE6SXC" class="SXC1">
	<table class="TBL" cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="56"></td><td class="SXLC1">
	<img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/allowResume.asp" target="content">Allow Resume</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/completionAction.asp" target="content">Completion Action</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/description.asp" target="content">Description</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/displayMessage.asp" target="content">Display Message</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/emailResponsesTo.asp" target="content">Email Responses To</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/endDate.asp" target="content">End Date</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/maxRespondents.asp" target="content">Max Respondants</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/numberLabels.asp" target="content">Number Labels</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/privacyLevel.asp" target="content">Privacy Level</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/redirectToURL.asp" target="content">Redirect To URL</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/responsesPerUser.asp" target="content">Responses Per User</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/scoredSurvey.asp" target="content">Scored</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/showProgress.asp" target="content">Show Progress</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/startDate.aso" target="content">Start Date</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/surveyTitle.asp" target="content">Survey Title</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/properties/surveyType.asp" target="content">Survey Type</a>
	</td></tr></table>
</div>

<div id="I1SXE7SXP" par="I0SXE5SXP" class="SXP1">
	<table cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="20"></td><td class="SXLP1">
	<a href="javascript:void(0);" onclick="onClicked(null,1,7); return false">
	<img name="MI1SXE7SXP" src="includes/images/sxicon0.gif" align="absmiddle" class="im" border="0" /></a><img name="NI1SXE7SXP" src="includes/images/sxicon2.gif" align="absmiddle" class="im"/>&nbsp;<a href="javascript:void(0);" class="SXLP1" onclick="onClicked(null,1,7); return false">Branching</a>
	</td></tr></table>
</div>

<div id="I1SXE7SXC" class="SXC1">
	<table class="TBL" cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="56"></td><td class="SXLC1">
	<img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/branching/general.asp" target="content">About Branching</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/branching/questionToBranch.asp" target="content">Question to Branch From</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/branching/response.asp" target="content">Branch If Response Is</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/branching/goToPage.asp" target="content">Go to Page</a>
	</td></tr></table>
</div>

<div id="I1SXE8SXP" par="I0SXE5SXP" class="SXP1">
	<table cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="20"></td><td class="SXLP1">
	<a href="javascript:void(0);" onclick="onClicked(null,1,8); return false">
	<img name="MI1SXE8SXP" src="includes/images/sxicon0.gif" align="absmiddle" class="im" border="0" /></a><img name="NI1SXE8SXP" src="includes/images/sxicon2.gif" align="absmiddle" class="im"/>&nbsp;<a href="javascript:void(0);" class="SXLP1" onclick="onClicked(null,1,8); return false">Conditions</a>
	</td></tr></table>
</div>

<div id="I1SXE8SXC" class="SXC1">
	<table class="TBL" cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="56"></td><td class="SXLC1">
	<img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/conditions/createNew.asp" target="content">Create New</a>
	<br /><img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC1" href="docs/surveys/conditions/addExisting.asp" target="content">Add Existing</a>
	</td></tr></table>
</div>

<div id="I0SXE9SXP" par="root" class="SXP0">
	<a href="javascript:void(0);" onclick="onClicked(null,0,9); return false">
	<img name="MI0SXE9SXP" src="includes/images/sxicon0.gif" align="absmiddle" class="im" border="0" /></a><img name="NI0SXE9SXP" src="includes/images/sxicon2.gif" align="absmiddle" class="im"/>&nbsp;<a href="javascript:void(0);" class="SXLP0" onclick="onClicked(null,0,9); return false">Reports</a>
</div>

<div id="I0SXE9SXC" class="SXC0">
	<table class="TBL" cellpadding="0" cellspacing="0" border="0"><tr><td nowrap="nowrap" width="36"></td><td class="SXLC0">
	<img src="includes/images/sxicon4.gif" align="absmiddle" class="im" />&nbsp;<a class="SXLC0" href="docs/reports/searchByQuestion.asp" target="content">Search By Question</a>
	</td></tr></table>
</div>


<script language="JavaScript1.2">
<!--
	li = "I0SXE9SXC";
onunload=saveCookie;
//-->
</script>
