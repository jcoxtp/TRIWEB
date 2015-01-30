<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 52	' Representative Profile Page 2
	Dim TestCodeID, nextLink
	TestCodeID = Request.QueryString("TCID")
%>
<!-- #Include File = "Include/CheckLogin.asp" -->
<!-- #Include File = "Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>-->
<script type="text/javascript">
_uacct = "UA-368995-2";
//urchinTracker();

var algoSelect = new Array();

function suggestPatterns() {
	var imgPath = "images/en/";
	for(var idx = 0; idx < algoSelect.length; idx++) {
		var imgID = "img_" + algoSelect[idx];
		var img = document.getElementById(imgID);
		
		var imgSrc = imgPath + algoSelect[idx]
		if(idx < 1) 
			imgSrc += "_TOP.GIF";
		else
			imgSrc += "_SEL.GIF";
			
		img.src = imgSrc;
	}
}

</script>
	<!-- #Include File = "Include/HeadStuff.asp" -->
	<% 
	Dim rpIdx, rpImgName
	Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			.CommandText = "get_PatternsFromPDITestSummary"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@testcodeID", 3, 1, 4, TestCodeID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
		rpIdx = 0
		If oConn.Errors.Count < 1 Then
			oRs.MoveFirst
			Response.Write "<script>" & Chr(13)
			Do While oRs.EOF = False
			
				If Len(oRs("RepPatternID")) < 2 Then
					rpImgName = "0"
				Else
					rpImgName = ""
				End If
				rpImgName = rpImgName & oRs("RepPatternID") &  "_" & oRs("Pattern")
				
				Response.Write "algoSelect[" & rpIdx & "] = """ & rpImgName & """; " & Chr(13)
				
				rpIdx = rpIdx + 1
				oRs.MoveNext
			Loop
			Response.Write "</script>"
		End If
		Set oConn = Nothing
		Set oCmd = Nothing
		Set oRs = Nothing
	%>
</head>
<body onload="suggestPatterns()">
<!-- #Include File = "Include/TopBanner.asp" -->
    <div id="main">
<div id="tabgraphic">
	<img src="images/S4P2<%=strLanguageCode%>.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape=poly alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" href="PDIProfileRepProfile1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
		<area shape=poly alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" href="javascript:isProfileSelected()">
	</map>
</div>
<div id="maincontent_tab">
<%
	Dim profileID, bSubmitted
	bSubmitted = Request.Form("Submitted")
	
	'If the form has been submitted, then update the database to
	'reflect the selected profile, and then move to the next page.
	
	If (bSubmitted <> "") Then
		TestCodeID = Request.Form("TCID")
		profileID = Request.Form("sel_Profile")
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "spTestSummaryProfileIDTCIDUpdate"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@ProfileID1",3, 1,4, profileID)
			.Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		If oConn.Errors.Count < 1 Then '[SM] Update was successful
			Response.Redirect("PDIProfileCustom.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID)
		Else
			Response.Write "Error updating representative profile. Please try again."
		End If
		Set oConn = Nothing
		Set oCmd = Nothing
	Else
	' [SM] Retrieve the selected profile from the database
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			.CommandText = "spTestSummaryProfileIDTCIDSelect"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 Then
			profileID = oRs("ProfileID1")
			If ISNULL(profileID) = TRUE Then ' [SM] This is true the first time you visit a page.
				profileID = -1 				 ' [SM] This will display "Select a Profile" in the form popup menu.
			End If
		Else
			Response.Write "<br><br>" & strTextErrorUnableToRetrieveRepresentativeProfileFrom
			Response.End
		End If 
		Set oConn = Nothing
		Set oCmd = Nothing
		Set oRs = Nothing
	End If
	
	' Retrieve the most, least, and composite numbers for the composite graph
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		  .CommandText = "spTestSummarySelect"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	Dim SPN
	If oConn.Errors.Count < 1 then
		oRs.MoveFirst
		Dim nC1, nC2, nC3, nC4
		nC1 = oRs("C_NumberD")
		nC2 = oRs("C_NumberI")
		nC3 = oRs("C_NumberS")
		nC4 = oRs("C_NumberC")
	Else
		Response.Write "<br><br>" & strTextUnableToRetrieveResultsFromDatabasePlease
		Response.End
	End If
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
%>
	<p><%=strTextForEachFactorThereAreFivePossiblePatternsFour%></p>
	<p><%=strTextClickonanyrepresentativepattern%></p>
	<form name="form_Profile" method="post" action="PDIProfileRepProfile2.asp">
	<input type="hidden" name="Submitted" id="Submitted" value="1">
	<input type="hidden" name="TCID" id="TCID" value="<%=TestCodeID%>">
	<input type="hidden" name="st" id="st" value="<%=Site%>">	

	<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%" ID="Table1">
					<tr>
						<td align="center" valign="top" width="20%">
				<img src="DISCCompositeSmall.asp?nD1=<%=nC1%>&nD2=<%=nC2%>&nD3=<%=nC3%>&nD4=<%=nC4%>" alt="" /><br />
				<strong><%=strTextComposite & " " & strTextGraph%></strong>
			</td>
						<td align="center" valign="top" width="50%">
							<div id="canvas" style="POSITION:relative">
								<img id="imgRepChart" style="BORDER-RIGHT:0px; BORDER-TOP:0px; BORDER-LEFT:0px; BORDER-BOTTOM:0px"
									src="images/en/chart.GIF"> <a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=1&res=<%=intResellerID%>" style="LEFT:59px; POSITION:absolute; TOP:9px"
								title="Director (1)"><img id="img_01_Director" src="images/en/01_Director.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=2&res=<%=intResellerID%>" style="LEFT:143px; POSITION:absolute; TOP:10px"
								title="Entrepreneur (2)"><img id="img_02_Entrepreneur" src="images/en/02_Entrepreneur.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=3&res=<%=intResellerID%>" style="LEFT:226px; POSITION:absolute; TOP:11px"
								title="Organizer (3)"><img id="img_03_Organizer" src="images/en/03_Organizer.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=4&res=<%=intResellerID%>" style="LEFT:12px; POSITION:absolute; TOP:132px"
								title="Pioneer (4)"><img id="img_04_Pioneer" src="images/en/04_Pioneer.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=5&res=<%=intResellerID%>" style="LEFT:101px; POSITION:absolute; TOP:133px"
								title="Prevailer (5)"><img src="images/en/05_Prevailer.GIF" name="img_05_Prevailer" id="img_05_Prevailer" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=6&res=<%=intResellerID%>" style="LEFT:216px; POSITION:absolute; TOP:119px"
								title="Cooperator (6)"><img id="img_06_Cooperator" src="images/en/06_Cooperator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=7&res=<%=intResellerID%>" style="LEFT:343px; POSITION:absolute; TOP:9px"
								title="Affiliator (7)"><img id="img_07_Affiliator" src="images/en/07_Affiliator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=8&res=<%=intResellerID%>" style="LEFT:425px; POSITION:absolute; TOP:10px"
								title="Negotiator (8)"><img id="img_08_Negotiator" src="images/en/08_Negotiator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=9&res=<%=intResellerID%>" style="LEFT:508px; POSITION:absolute; TOP:12px"
								title="Motivator (9)"><img id="img_09_Motivator" src="images/en/09_Motivator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=10&res=<%=intResellerID%>" style="LEFT:591px; POSITION:absolute; TOP:58px"
								title="Persuader (10)"><img id="img_10_Persuader" src="images/en/10_Persuader.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=11&res=<%=intResellerID%>" style="LEFT:491px; POSITION:absolute; TOP:149px"
								title="Colleague (11)"><img id="img_11_Colleague" src="images/en/11_Colleague.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=12&res=<%=intResellerID%>" style="LEFT:589px; POSITION:absolute; TOP:145px"
								title="Diplomat (12)"><img id="img_12_Diplomat" src="images/en/12_Diplomat.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=13&res=<%=intResellerID%>" style="LEFT:395px; POSITION:absolute; TOP:120px"
								title="Strategist (13)"><img id="img_13_Strategist" src="images/en/13_Strategist.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=14&res=<%=intResellerID%>" style="LEFT:599px; POSITION:absolute; TOP:247px"
								title="Persister (14)"><img id="img_14_Persister" src="images/en/14_Persister.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=15&res=<%=intResellerID%>" style="LEFT:494px; POSITION:absolute; TOP:254px"
								title="Investigator (15)"><img id="img_15_Investigator" src="images/en/15_Investigator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=16&res=<%=intResellerID%>" style="LEFT:596px; POSITION:absolute; TOP:348px"
								title="Specialist (16)"><img id="img_16_Specialist" src="images/en/16_Specialist.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=17&res=<%=intResellerID%>" style="LEFT:522px; POSITION:absolute; TOP:393px"
								title="Advisor (17)"><img id="img_17_Advisor" src="images/en/17_Advisor.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=18&res=<%=intResellerID%>" style="LEFT:442px; POSITION:absolute; TOP:394px"
								title="Associate (18)"><img id="img_18_Associate" src="images/en/18_Associate.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=19&res=<%=intResellerID%>" style="LEFT:349px; POSITION:absolute; TOP:392px"
								title="Coordinator (19)"><img id="img_19_Coordinator" src="images/en/19_Coordinator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=20&res=<%=intResellerID%>" style="LEFT:372px; POSITION:absolute; TOP:290px"
								title="Whirlwind (20)"><img id="img_20_Whirlwind" src="images/en/20_Whirlwind.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=21&res=<%=intResellerID%>" style="LEFT:13px; POSITION:absolute; TOP:250px"
								title="Perfectionist (21)"><img id="img_21_Perfectionist" src="images/en/21_Perfectionist.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=22&res=<%=intResellerID%>" style="LEFT:116px; POSITION:absolute; TOP:253px"
								title="Analyst (22)"><img id="img_22_Analyst" src="images/en/22_Analyst.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=23&res=<%=intResellerID%>" style="LEFT:95px; POSITION:absolute; TOP:398px"
								title="Adaptor (23)"><img id="img_23_Adaptor" src="images/en/23_Adaptor.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=24&res=<%=intResellerID%>" style="LEFT:181px; POSITION:absolute; TOP:397px"
								title="Creator (24)"><img id="img_24_Creator" src="images/en/24_Creator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=25&res=<%=intResellerID%>" style="LEFT:262px; POSITION:absolute; TOP:395px"
								title="Administrator (25)"><img id="img_25_Administrator" src="images/en/25_Administrator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=26&res=<%=intResellerID%>" style="LEFT:7px; POSITION:absolute; TOP:352px"
								title="Advocate (26)"><img id="img_25_Advocate" src="images/en/26_Advocate.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=27&res=<%=intResellerID%>" style="LEFT:233px; POSITION:absolute; TOP:278px"
								title="Individualist (27)"><img id="img_27_Individualist" src="images/en/27_Individualist.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
								<a href="PDIProfileRepProfileDesc.asp?TCID=<%= TestCodeID %>&amp;lid=<%= intLanguageID %>&amp;pID=28&res=<%=intResellerID%>" style="LEFT:303px; POSITION:absolute; TOP:204px"
								title="Level Patter (28)"><img id="img_28_LevelPattern" src="images/en/28_LevelPattern.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a></div>
						</td>
						<td valign="top" width="30%"></td>
						
					</tr>
				</table>
	</form>
	<p>
		<strong><%=strTextWhatIfTwoRepresentativePatternsLook%></strong>
		<br /><%=strTextClickOnBothPatternsAndReadTheDescriptions%>
	</p>

	<% If (SPN <> "0") And (oldButtons = True) Then %>
		<table border="0" cellspacing="0" cellpadding="0" width="570">
			<tr>
				<td align="right">
					<a href="PDIProfileRepProfile1.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>"><img src="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:isProfileSelected()"><img src="images/PDINextPage.gif" alt="" /></a>
				</td>
			</tr>
		</table>
	<% End If %>
		<br><br>
	<script type="text/javascript">
	// checks to see if a 1st Choice is selected before going to the next page
	function isProfileSelected()
	{
		alert("<%= strTextChooseProfileFromChart %>");
	}
	</script>
</div>
        </div>
</body>
</html>
