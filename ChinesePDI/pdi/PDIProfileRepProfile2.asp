<%@ Language=VBScript %>

<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "repProfile2"
Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
Dim oConn, oCmd, oRs ' [SM] To avoid redefinition errors in condensed summary
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Representative Profile</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="tabgraphic">
	<img src="images/s4p2.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape=poly alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" href="PDIProfileRepProfile1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
		<area shape=poly alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" href="javascript:isProfileSelected()">
	</map>
</div>
<div id="maincontent_tab">
	<%
	Dim profileID, bSubmitted
	bSubmitted = Request.Form("Submitted")
	
	'[SM] If the form has been submitted, then update the database to reflect the selected profile, and
	'[SM] then move to the next page.
	
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
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
	
		If oConn.Errors.Count < 1 Then '[SM] Update was successful
			Response.Redirect("PDIProfileCustom.asp?TCID=" & TestCodeID & "&res=" & intResellerID)
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
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 Then
			profileID = oRs("ProfileID1")
			If ISNULL(profileID) = TRUE Then ' [SM] This is true the first time you visit a page.
				profileID = -1 				 ' [SM] This will display "Select a Profile" in the form popup menu.
			End If
		Else
			Response.Write "Unable to retrieve representative profile from database. Please try again."
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
	oConn.Open strDBaseConnString
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
		Response.Write "Unable to retrieve results from database. Please try again."
		Response.End
	End If
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	%>
	
	<p>For each factor (D, I, S, and C), there are five possible patterns. Four out of five are defined by which points are <em>high</em>; a very <em>low</em> point defines the fifth pattern. The very lack of that factor defines personality. In other words, the virtual absence of a particular element can also control the way one behaves.</p>
	
	<form name="form_Profile" method="post" action="PDIProfileRepProfile2.asp">
	<input type="hidden" name="Submitted" id="Submitted" value="1">
	<input type="hidden" name="TCID" id="TCID" value="<%=TestCodeID%>">
	<input type="hidden" name="st" id="st" value="<%=Site%>">
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
		<tr>
			<td align="center" valign="top" width="20%">
				<img src="disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" /><br />
				<strong>Composite Graph</strong>
			</td>
			
			<td align="center" valign="top" width="50%">
				<p style="line-height:normal; margin-bottom:6px">
				<img src="images/PDI-DISC-Patternslg2.gif" width="358" height="452" usemap="#repProfile" alt="" /><br />
				<strong>Representative Patterns</strong></p>
							
				<p class="addtable">
				<select name="sel_Profile">
				<%
				'[SM] The first item in the popup menu is the "Select a Profile" item.
				'[SM] It will be selected the first time you visit the page
				If (profileID = -1) Then	%>
					<option value="-1" selected>Select a Pattern
				<%
				Else %>	
					<option value="-1">Select a Pattern
				<%
				End If %>
				<%
				'[SM] TRI wants profile 0 (Not Chosen) to be the first profile listed.
				'[SM] It is not the first one listed in the PDIRepProfile table (sorted by RepProfileName), so
				'[SM] treat it as a special case.
				If (profileID = 0) Then %>
					<option value="0" selected>None of These Match My Graph
				<%
				Else %>	
					<option value="0">None of These Match My Graph
				<%
				End If %>	
				<%
				'[SM] TRI wants profile 21 (Flat Pattern) to be the second profile listed.
				'[SM] It is not the second one listed in the PDIRepProfile table (sorted by RepProfileName), so
				'[SM] treat it as a special case.
				If (profileID = 21) Then %>
					<option value="21" selected>Flat Pattern
				<%
				Else %>	
					<option value="21">Flat Pattern
				<%
				End If %>
					<option value="999">- - - - - - - -
				<%
				'[SM] Cycle through the list of representative profiles.
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				Set oRs = CreateObject("ADODB.Recordset")
				With oCmd
					.CommandText = "spRepProfileSelectAll"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oRs.CursorLocation = 3
				oRs.Open oCmd, , 0, 1
				If oConn.Errors.Count < 1 then
					oRs.MoveFirst
					do while oRs.EOF = FALSE
						'[SM] Since we have already addressed profiles 0 and 21, we can skip them.
						If (CInt(oRs("PDIRepProfileID")) = 0 OR CInt(oRs("PDIRepProfileID")) = 21) Then
						Else
							If CInt(oRs("PDIRepProfileID")) = CInt(profileID) Then %>
								<option value="<%=oRs("PDIRepProfileID")%>" selected><%=oRs("RepProfileName")%>
				<%			Else %>
								<option value="<%=oRs("PDIRepProfileID")%>"><%=oRs("RepProfileName")%>
				<%
							End If
						End If
						oRs.MoveNext
					loop
				End If
				Set oConn = Nothing
				Set oCmd = Nothing
				Set oRs = Nothing
				%>
				</select>
				</p>
				<map name="repProfile">
					<area alt="" coords="47,8,145,72" href="PDIProfileRepProfile_Desc.asp?pID=3&pName=Organizer&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="219,8,304,72" href="PDIProfileRepProfile_Desc.asp?pID=8&pName=Motivator&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="6,75,102,144" href="PDIProfileRepProfile_Desc.asp?pID=2&pName=Entrepreneur&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="107,74,176,142" href="PDIProfileRepProfile_Desc.asp?pID=4&pName=Pioneer&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="183,75,266,146" href="PDIProfileRepProfile_Desc.asp?pID=9&pName=Persuader&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="270,78,354,144" href="PDIProfileRepProfile_Desc.asp?pID=7&pName=Negotiator&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="7,151,89,220" href="PDIProfileRepProfile_Desc.asp?pID=1&pName=Director&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" shape="poly" coords="159,158,94,158,95,216,128,217,171,158" href="PDIProfileRepProfile_Desc.asp?pID=5&pName=Cooperator&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" shape="poly" coords="190,156,266,156,266,217,221,216" href="PDIProfileRepProfile_Desc.asp?pID=10&pName=Strategist&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="273,153,349,219" href="PDIProfileRepProfile_Desc.asp?pID=6&pName=Affiliator&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="9,230,91,302" href="PDIProfileRepProfile_Desc.asp?pID=16&pName=Perfectionist&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" shape="poly" coords="177,295,96,295,96,227,139,228" href="PDIProfileRepProfile_Desc.asp?pID=20&pName=Individualist&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" shape="poly" coords="262,295,190,295,190,278,227,231,264,231" href="PDIProfileRepProfile_Desc.asp?pID=15&pName=Whirlwind&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" shape="CIRCLE" coords="181,226,33" href="PDIProfileRepProfile_Desc.asp?pID=21&pName=Flat%20Pattern&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="273,229,348,305" href="PDIProfileRepProfile_Desc.asp?pID=11&pName=Persister&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="12,307,87,379" href="PDIProfileRepProfile_Desc.asp?pID=17&pName=Analyst&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="97,307,175,376" href="PDIProfileRepProfile_Desc.asp?pID=19&pName=Creator&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="183,306,266,378" href="PDIProfileRepProfile_Desc.asp?pID=14&pName=Advisor&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="270,308,348,378" href="PDIProfileRepProfile_Desc.asp?pID=12&pName=Investigator&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="54,383,130,442" href="PDIProfileRepProfile_Desc.asp?pID=18&pName=Adaptor&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
					<area alt="" coords="219,382,311,443" href="PDIProfileRepProfile_Desc.asp?pID=13&pName=Specialist&TCID=<%=TestCodeID%>&res=<%=intResellerID%>">
				</map>
			</td>
			<td valign="top" width="30%">
				<h1 class="aligncenter">Instructions</h1>
				<ol>
					<li>Look at your <strong>composite</strong> graph and find the pattern in the Representative Patterns Chart that is the closest match. It doesn't have to be exactly the same shape, but pay particular attention to which elements (D,I,S, and C) are above or below the center line.</li>
					<li>Click on that pattern to read about it.</li>
					<li>Return to this page to read about other patterns until you have chosen the one that best matches your graph.</li>
					<li>Choose the title of that pattern from the pull-down list (below the pattern chart).</li>
					<li>Click the "Next" button in the top right corner to continue to the next page.</li>
				</ol>			
			</td>
		</tr>
	</table>
	
	</form>
	
	<p><strong>What if two Representative Patterns look similar to my composite graph?</strong><br />
	
	Click on both patterns and read the descriptions of each one. Choose the pattern that <em>best</em> describes you as the Representative Pattern to be included in your report.</p>
				
	<p><strong>What if I can't find a pattern that matches my graph?</strong><br />
	
	About 95% of the people who use the <!--#INCLUDE FILE="include/pdi.asp" --> can find their own pattern or one that is close to it within the patterns above. If you are one of the few whose pattern differs significantly from the representative patterns, you can use behavioral relationships to define your profile. Please choose "None of These Match My Graph" from the pull-down list above and click the "Next" button in the top right corner to view your behavioral relationships.</p>
	
	<% if (SPN <> "0") and (oldButtons = true) then %>
		<table border="0" cellspacing="0" cellpadding="0" width="570">
			<tr>
				<td align="right">
					<a href="PDIProfileRepProfile1.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img src="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:isProfileSelected()"><img src="images/PDINextPage.gif" alt="" /></a>
				</td>
			</tr>
		</table>
	<% end if %>
	
	<script type="text/javascript">
	// checks to see if a 1st Choice is selected before going to the next page
	function isProfileSelected()
	{
		var choice;
		var profileSelected;
		
		choice = document.form_Profile.sel_Profile.selectedIndex;
		profileSelected = document.form_Profile.sel_Profile.options[choice].value;
		
		if (profileSelected == -1 || profileSelected == 999)
		{
			window.alert("You must choose a profile before continuing.");
		}	
		else
		{
			document.form_Profile.submit();
		}
	}
	</script>
</div>
</body>
</html>
