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
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!-- #Include File = "Include/HeadStuff.asp" -->
</head>
<body>
<!-- #Include File = "Include/TopBanner.asp" -->
<!-- #Include File = "Include/LeftNavBar.asp" -->
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
	<form name="form_Profile" method="post" action="PDIProfileRepProfile2.asp">
	<input type="hidden" name="Submitted" id="Submitted" value="1">
	<input type="hidden" name="TCID" id="TCID" value="<%=TestCodeID%>">
	<input type="hidden" name="st" id="st" value="<%=Site%>">	
<div align=left style="position:relative;left:125px"><strong><%=strTextYourRepresentativePattern%>:&nbsp;</strong><select name="sel_Profile">
<%
				'[SM] The first item in the popup menu is the "Select a Profile" item.
				'[SM] It will be selected the first time you visit the page
				If (profileID < 1) Then
					Response.Write "<option value=""-1"" selected>" & strTextSelectAPattern & VbCrLf
				Else
					Response.Write "<option value=""-1"">" & strTextSelectAPattern & VbCrLf
				End If
				'[SM] TRI wants profile 0 (Not Chosen) to be the first profile listed.
				'[SM] It is not the first one listed in the PDIRepProfile table (sorted by RepProfileName), so
				'[SM] treat it as a special case.
				'[mlp] Removed "Not Chosen" as an option 7/13/2005
			'	If (profileID = 0) Then
			'		Response.Write "<option value=""0"" selected>" & strTextNoneOfTheseMatchMyGraph & VbCrLf
			'	Else
			'		Response.Write "<option value=""0"">" & strTextNoneOfTheseMatchMyGraph & VbCrLf
			'	End If
				'[SM] TRI wants profile 28 (Flat Pattern) to be the second profile listed.
				'[SM] It is not the second one listed in the PDIRepProfile table (sorted by RepProfileName), so
				'[SM] treat it as a special case.
				If (profileID = 28) Then
					Response.Write "<option value=""28"" selected>" & strTextLevelPattern & VbCrLf
				Else
					Response.Write "<option value=""28"">" & strTextLevelPattern & VbCrLf
				End If
					Response.Write "<option value=""999"">- - - - - - - -" & VbCrLf
				'[SM] Cycle through the list of representative profiles.
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				Set oRs = CreateObject("ADODB.Recordset")
				With oCmd
					.CommandText = "spRepProfileSelectAll"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@intLanguageID", 3, 1, 4, intLanguageID)
				End With
				oConn.Open strDbConnString
				oCmd.ActiveConnection = oConn
				oRs.CursorLocation = 3
				oRs.Open oCmd, , 0, 1
				If oConn.Errors.Count < 1 Then
					oRs.MoveFirst
					Do While oRs.EOF = False
						'[SM] Since we have already addressed profiles 0 and 21, we can skip them.
						If (CInt(oRs("PDIRepProfileID")) = 0 Or CInt(oRs("PDIRepProfileID")) = 28) Then
						Else
							If CInt(oRs("PDIRepProfileID")) = CInt(profileID) Then
								Response.Write "<option value=""" & oRs("PDIRepProfileID") & """ selected>" & oRs("RepProfileName")
							Else
								Response.Write "<option value=""" & oRs("PDIRepProfileID") & """>" & oRs("RepProfileName")
							End If
						End If
						oRs.MoveNext
					Loop
				End If
				Set oConn = Nothing
				Set oCmd = Nothing
				Set oRs = Nothing
%>
</select><br><br><hr width="535px"></div>
	<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
		<tr>
			<td align="center" valign="top" width="20%">
				<img src="DISCCompositeSmall.asp?nD1=<%=nC1%>&nD2=<%=nC2%>&nD3=<%=nC3%>&nD4=<%=nC4%>" alt="" /><br />
				<strong><%=strTextComposite & " " & strTextGraph%></strong>
			</td>
			<td align="center" valign="top" width="50%">
				<p style="line-height:normal; margin-bottom:6px">
				<img src="images/28PatternsSampleRep<%=strLanguageCode%>.gif" width="360" height="680" usemap="#repProfile" alt="" /><br />
				<strong><%=strTextRepresentativePatterns%></strong></p>
				<p class="addtable">

				</p>
				<map name="repProfile">
					<AREA SHAPE=RECT COORDS="80,49,160,117" ALT="Director (1)" href="PDIProfileRepProfileDesc.asp?pID=1&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="33,120,150,194" ALT="Entrepreneur (2)" href="PDIProfileRepProfileDesc.asp?pID=2&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="5,197,92,268" ALT="Organizer (3)" href="PDIProfileRepProfileDesc.asp?pID=3&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="97,196,177,270" ALT="Pioneer (4)" href="PDIProfileRepProfileDesc.asp?pID=4&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="7,277,93,351" ALT="Prevailer (5)" href="PDIProfileRepProfileDesc.asp?pID=5&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=POLY COORDS="99,287,179,287,179,315,156,314,155,333,139,332,138,351,97,351,99,287" ALT="Cooperator (6)" href="PDIProfileRepProfileDesc.asp?pID=6&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="211,49,300,118" ALT="Affiliator (7)" href="PDIProfileRepProfileDesc.asp?pID=7&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="183,122,269,191" ALT="Negotiator (8)" href="PDIProfileRepProfileDesc.asp?pID=8&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="274,121,351,192" ALT="Motivator (9)" href="PDIProfileRepProfileDesc.asp?pID=9&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="182,196,268,276" ALT="Persuader (10)" href="PDIProfileRepProfileDesc.asp?pID=10&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="273,196,349,276" ALT="Colleague (11)" href="PDIProfileRepProfileDesc.asp?pID=11&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="268,277,355,348" ALT="Diplomat (12)" href="PDIProfileRepProfileDesc.asp?pID=12&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=POLY COORDS="182,287,263,287,263,349,212,350,214,331,181,332,183,287,182,288,182,287" ALT="Strategist (13)" href="PDIProfileRepProfileDesc.asp?pID=13&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="269,365,353,441" ALT="Persister (14)" href="PDIProfileRepProfileDesc.asp?pID=14&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="182,449,264,523" ALT="Investigator (15)" href="PDIProfileRepProfileDesc.asp?pID=15&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="271,448,352,520" ALT="Specialist (16)" href="PDIProfileRepProfileDesc.asp?pID=16&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="186,529,264,601" ALT="Advisor (17)" href="PDIProfileRepProfileDesc.asp?pID=17&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="270,524,349,600" ALT="Associate (18)" href="PDIProfileRepProfileDesc.asp?pID=18&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="191,604,303,670" ALT="Coordinator (19)" href="PDIProfileRepProfileDesc.asp?pID=19&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=POLY COORDS="182,424,261,425,262,359,212,359,213,383,181,381,183,423,182,424" ALT="Whirlwind (20)" href="PDIProfileRepProfileDesc.asp?pID=20&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="9,356,93,432" ALT="Perfectionist (21)" href="PDIProfileRepProfileDesc.asp?pID=21&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="12,437,89,511" ALT="Analyst (22)" href="PDIProfileRepProfileDesc.asp?pID=22&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="94,434,166,513" ALT="Adaptor (23)" href="PDIProfileRepProfileDesc.asp?pID=23&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="6,520,80,589" ALT="Creator (24)" href="PDIProfileRepProfileDesc.asp?pID=24&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="83,518,177,597" ALT="Administrator (25)" href="PDIProfileRepProfileDesc.asp?pID=25&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="74,602,171,672" ALT="Advocate (26)" href="PDIProfileRepProfileDesc.asp?pID=26&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=POLY COORDS="95,423,96,355,146,360,147,378,175,379,179,426,95,423" ALT="Individualist (27)" href="PDIProfileRepProfileDesc.asp?pID=27&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
					<AREA SHAPE=RECT COORDS="150,335,211,377" ALT="Level Pattern (28)" href="PDIProfileRepProfileDesc.asp?pID=28&TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>">
				</map>
			</td>
			<td valign="top" width="30%">
				<h1 class="aligncenter"><%=strTextInstructions%></h1>
				<ol>
					<li><%=strTextLookAtYourCompositeGraphAndFindThePattern%></li>
					<li><%=strTextClickOnThatPatternToReadAboutIt%></li>
					<li><%=strTextReturnToThisPageToReadAboutOtherPatternsUntil%></li>
					<li><%=strTextChooseTheTitleOfThatPatternFromThe%></li>
					<li><%=strTextClickTheNextButtonInTheTopRightCornerTo%></li>
				</ol>			
			</td>
		</tr>
	</table>
	</form>
	<p>
		<strong><%=strTextWhatIfTwoRepresentativePatternsLook%></strong>
		<br /><%=strTextClickOnBothPatternsAndReadTheDescriptions%>
	</p>
	<p>
		<strong><%=strTextWhatIfICantFindAPatternThatMatchesMyGraph%></strong>
		<br /><%=strTextAbout95OfThePeopleWhoUseThePersonalDISCernment%>
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
		var choice;
		var profileSelected;
		
		choice = document.form_Profile.sel_Profile.selectedIndex;
		profileSelected = document.form_Profile.sel_Profile.options[choice].value;
		
		if (profileSelected == -1 || profileSelected == 999) {
			window.alert("You must choose a profile before continuing.");
		} else {
			document.form_Profile.submit();
		}
	}
	</script>
</div>
</body>
</html>
