<%
' Declare initial internal variables
	Dim HP(4)
	Dim HPValue(4)
	Dim HPHPT(4)
	Dim CHPT(4)

' Retrieve the most, least and composite numbers from the database
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
	If oConn.Errors.Count < 1 Then
		nM1 = oRs("M_NumberD")
		nM2 = oRs("M_NumberI")
		nM3 = oRs("M_NumberS")
		nM4 = oRs("M_NumberC")
		nL1 = oRs("L_NumberD")
		nL2 = oRs("L_NumberI")
		nL3 = oRs("L_NumberS")
		nL4 = oRs("L_NumberC")
		nC1 = oRs("C_NumberD")
		nC2 = oRs("C_NumberI")
		nC3 = oRs("C_NumberS")
		nC4 = oRs("C_NumberC")
		HP(1) = oRs("HighFactorType1")
		HP(2) = oRs("HighFactorType2")
		HP(3) = oRs("HighFactorType3")
		HP(4) = oRs("HighFactorType4")
		HPValue(1) = oRs("HighFactorType1Value")
		HPValue(2) = oRs("HighFactorType2Value")
		HPValue(3) = oRs("HighFactorType3Value")
		HPValue(4) = oRs("HighFactorType4Value")
	Else
		Response.Write strTextUnableToRetrieveResultsFromDatabasePlease
		Response.End
	End If
	
	If IsNull(HPValue(1)) = True Then
		HPValue(1) = 0
	End If
	If IsNull(HPValue(2)) = True Then
		HPValue(2) = 0
	End If
	If IsNull(HPValue(3)) = True Then
		HPValue(3) = 0
	End If
	If IsNull(HPValue(4)) = True Then
		HPValue(4) = 0
	End If
	
	HPHPT(1) = 0
	HPHPT(2) = 0
	HPHPT(3) = 0
	HPHPT(4) = 0
	CHPT(1) = 0
	CHPT(2) = 0
	CHPT(3) = 0
	CHPT(4) = 0

' Calculate what items are the highpoints
' You have the highpoints in letter in order and their values
' but you have to calculate because you don't know which ones are equal 
' etc, etc. 
' HPValue array contains the value of the highpoint in order of highest point to 
' lowest point
' The HP array contains the character of the highpoint in order of highest point to 
' lowest point
	If CInt(HPValue(1)) = CInt(HPValue(2)) AND CInt(HPValue(2)) = CInt(HPValue(3)) AND CInt(HPValue(3)) = CInt(HPValue(4)) Then
		HPHPT(1) = 1
		HPHPT(2) = 1
		HPHPT(3) = 1
		HPHPT(4) = 1
	Else
		If HPValue(1) = HPValue(2) AND HPValue(2) = HPValue(3) Then
			HPHPT(1) = 1
			HPHPT(2) = 1
			HPHPT(3) = 1
		Else
			' the 4 pts are not equal
			' the 3 pts are not equal
			' then check for 2 points equal
			If HPValue(1) = HPValue(2) Then
				' 2 points are equal
				HPHPT(1) = 1
				HPHPT(2) = 1
			Else
				' display the 2 highest points
				HPHPT(1) = 1
				' [SM] Disabled the following if...end if block because TR only wants the highest point shown, not
				' [SM] the highest and second highest points, unless of course they are equal, which is addressed above.
				'If ISNULL(HP(2)) = False Then
				'	Your second highest point is HP(2)
				'	HPHPT(2) = 1
				'End If
			End If
		End If
	End If

Dim nCounter

' The highpoints are in an array listed in order of the highpoint, convert this to the
' order of the params passed into the asp chart page
' CHPT(1) - if 1 means that D is the highpoint
' CHPT(2) - if 1 means that I is the highpoint
' CHPT(3) - if 1 means that S is the highpoint
' CHPT(4) - if 1 means that C is the highpoint
	For nCounter = 1 To 4
		If HP(nCounter) = "D" And CInt(HPHPT(nCounter)) = 1 Then
			CHPT(1) = 1
		End If
		If HP(nCounter) = "I" and CInt(HPHPT(nCounter)) = 1 Then
			CHPT(2) = 1
		End If
		If HP(nCounter) = "S" and CInt(HPHPT(nCounter)) = 1 Then
			CHPT(3) = 1
		End If
		If HP(nCounter) = "C" and CInt(HPHPT(nCounter)) = 1 Then
			CHPT(4) = 1
		End If
	Next

Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing
%>

<h1><%=strTextBehavioralCharacteristics%></h1>

<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="570">
	<tr>
		<td valign="top" align="center" width="120">
			<img src="DISCCompositeSmallWithHPtsCircled.asp?nD1H=<%=CHPT(1)%>&amp;nD2H=<%=CHPT(2)%>&amp;nD3H=<%=CHPT(3)%>&amp;nD4H=<%=CHPT(4)%>&amp;nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" /><br />
			<strong><%=strTextCompositeGraph%></strong>
		</td>
		<td valign="top" width="450">
			<table border="0" cellspacing="0" cellpadding="6" width="450">
				<tr>
					<td valign="top" align="center" colspan="2"><strong><%=strTextClickOnALetterToReadMoreAboutThatStyle%></strong></td>
				</tr>
				<tr>
					<td valign="top" align="center" colspan="2"><span id="discimage"></span>
						<map name="disc">
							<area shape=poly alt="" coords="310,1,381,1,381,14,345,28,310,14" href="javascript:CClicked()">
							<area shape=poly alt="" coords="222,1,293,1,293,14,257,28,222,14" href="javascript:SClicked()">
							<area shape=poly alt="" coords="135,1,206,1,206,14,170,28,135,14" href="javascript:IClicked()">
							<area shape=poly alt="" coords="48,1,119,1,119,14,83,28,48,14" href="javascript:DClicked()">
						</map>
					</td>
				</tr>
				<tr>
					<td valign="top" align="left" colspan="2"><span id="instrtext"></span></td>
				</tr>
				<tr>
					<td valign="top" align="right" width="150"><strong><span id="othertermsttl"></strong></span></td>
					<td valign="top" align="left" width="300"><span id="otherterms"></span></td>
				</tr>
				<tr>
					<td valign="top" align="right" width="150"><strong><span id="emphasisttl"></strong></span></td>
					<td valign="top" align="left" width="300"><span id="emphasis"></span></td>
				</tr>
				<tr>
					<td valign="top" align="right" width="150"><strong><span id="keytomotivationttl"></strong></span></td>
					<td valign="top" align="left" width="300"><span id="keytomotivation"></span></td>
				</tr>
				<tr>
					<td valign="top" align="right" width="150"><strong><span id="basicintentttl"></strong></span></td>
					<td valign="top" align="left" width="300"><span id="basicintent"></span></td>
				</tr>
				<tr>
					<td valign="top" align="center" colspan="2"><span id="pdiimage"></span></td>
				</tr>
				<tr>
					<td valign="top" align="left" colspan="2"><span id="description"></span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<% If strSiteType <> "Focus3" Then %>
<!--#Include File="PrintProfileLink.asp" -->
<% End If %>
<% If (SPN <> "0") And (oldButtons = True) Then %>
	<table border="0" cellspacing="0" cellpadding="0" width="570">
			<tr>
				<td align="right">
					<a href="PDIProfileBehavioralChar1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>"><img alt="" src="images/PDIPrevPage.gif" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="PDIProfileRepProfile1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>"><img alt="" src="images/PDINextPage.gif" /></a>
				</td>
			</tr>
	</table>
<% End If %>
<script>
<!--
InstClicked();
function ShowTitles() {
	document.getElementById("othertermsttl").innerHTML = "<%=strTextOtherTerms%>:";
	document.getElementById("emphasisttl").innerHTML = "<%=strTextEmphasis%>:";
	document.getElementById("keytomotivationttl").innerHTML = "<%=strTextKeyToMotivation%>:";
	document.getElementById("basicintentttl").innerHTML = "<%=strTextBasicIntent%>:";
	//document.getElementById("greatestfearttl").innerHTML = "Greatest Fear:";
}

function HideTitles() {
	document.getElementById("othertermsttl").innerHTML = "";
	document.getElementById("emphasisttl").innerHTML = "";
	document.getElementById("keytomotivationttl").innerHTML = "";
	document.getElementById("basicintentttl").innerHTML = "";
	//document.getElementById("greatestfearttl").innerHTML = "";
}

function DClicked() {
	ShowTitles();
	document.getElementById("otherterms").innerHTML = "<%=strTextDriving & ", " & strTextDirecting%>";
	document.getElementById("emphasis").innerHTML = "<%=strTextControllingTheEnvironmentByOvercoming%>";
	document.getElementById("keytomotivation").innerHTML = "<%=strTextChallenge%>";
	document.getElementById("basicintent").innerHTML = "<%=strTextToOvercome%>";
	//document.getElementById("greatestfear").innerHTML = "Loss of Control";
	document.getElementById("description").innerHTML = "<p><%=strTextDQuadrantPeopleAreSelfStartersWho%></p>";
	document.getElementById("pdiimage").innerHTML = "<img src='images/dominance.gif' alt='' width='370' height='213' />"
	document.getElementById("instrtext").innerHTML = "<span class='headertext'><%=strTextDominant%></span>";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox_d.gif' alt='' width='431' height='28' usemap='#disc' />";
}

function IClicked() {
	ShowTitles();
	document.getElementById("otherterms").innerHTML = "<%=strTextExpressive & ", " & strTextPersuasive%>";
	document.getElementById("emphasis").innerHTML = "<%=strTextCreatingTheEnvironmentByMotivatingAnd%>";
	document.getElementById("keytomotivation").innerHTML = "<%=strTextRecognition%>";
	document.getElementById("basicintent").innerHTML = "<%=strTextToPersuade%>";
	//document.getElementById("greatestfear").innerHTML = "Fear Itself";
	document.getElementById("description").innerHTML = "<p><%=strTextIQuadrantPeopleThriveOnSocial%></p>";
	document.getElementById("pdiimage").innerHTML = "<img src='images/influence.gif' alt='' border='0' width='331' height='209' />"
	document.getElementById("instrtext").innerHTML = "<span class='headertext'><%=strTextInfluential%></span>";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox_i.gif' alt='' width='431' height='28' usemap='#disc' />";
}

function SClicked() {
	ShowTitles();
	//document.form1.DESC.value = "S Description";
	document.getElementById("otherterms").innerHTML = "<%=strTextAmicable & ", " & strTextSupportive%>";
	document.getElementById("emphasis").innerHTML = "<%=strTextMaintainingTheEnvironmentToCarryOut%>";
	document.getElementById("keytomotivation").innerHTML = "<%=strTextAppreciation%>";
	document.getElementById("basicintent").innerHTML = "<%=strTextToSupport%>";
	//document.getElementById("greatestfear").innerHTML = "Fear Itself";
	document.getElementById("description").innerHTML = "<p><%=strTextTheSQuadrantPersonThrivesInARelaxed%></p>";
	document.getElementById("pdiimage").innerHTML = "<img src='images/steadiness.gif' alt='' border='0' width='344' height='200'>"
	document.getElementById("instrtext").innerHTML = "<span class='headertext'><%=strTextSteady%></span>";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox_s.gif' alt='' width='431' height='28' usemap='#disc' />";
}

function CClicked() {
	ShowTitles();
	//document.form1.DESC.value = "C Description";
	document.getElementById("otherterms").innerHTML = "<%=strTextCautious & ", " & strTextAnalytical%>";
	document.getElementById("emphasis").innerHTML = "<%=strTextStructuringTheEnvironmentToProduce%>";
	document.getElementById("keytomotivation").innerHTML = "<%=strTextProtectionSecurity%>";
	document.getElementById("basicintent").innerHTML = "<%=strTextToBeCorrect%>";
	//document.getElementById("greatestfear").innerHTML = "Fear Itself";
	document.getElementById("description").innerHTML = "<p><%=strTextTheCQuadrantPersonThrivesOnOrder%></p>";
	document.getElementById("pdiimage").innerHTML = "<img src='images/conscientiousness.gif' alt='' width='372' height='187'>"
	document.getElementById("instrtext").innerHTML = "<span class='headertext'><%=strTextConscientious%></span>";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox_c.gif' alt='' width='431' height='28' usemap='#disc' />";
}

function InstClicked() {
	HideTitles();
<% If HP(1) = "D" Then %>
	DClicked();
<% End If %>	
<% If HP(1) = "I" Then %>
	IClicked();
<% End If %>	
<% If HP(1) = "S" Then %>
	SClicked();
<% End If %>	
<% If HP(1) = "C" Then %>	
	CClicked();
<% End If %>
//	document.getElementById("otherterms").innerHTML = "";
//	document.getElementById("emphasis").innerHTML = "";
//	document.getElementById("keytomotivation").innerHTML = "";
//	document.getElementById("basicintent").innerHTML = "";
//	//document.getElementById("greatestfear").innerHTML = "";
//	document.getElementById("description").innerHTML = "";
//	document.getElementById("pdiimage").innerHTML = "";
//	document.getElementById("instrtext").innerHTML = "<%=strTextTheCQuadrantPersonThrivesOnOrder%>";
//	document.getElementById("discimage").innerHTML = "<img src='images/discbox.gif' alt='' width='431' height='28' usemap='#disc' />";
}

-->
</script>
