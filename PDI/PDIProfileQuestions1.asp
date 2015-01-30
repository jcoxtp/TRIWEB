<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 44	' PDI Profile Questions 1 Page
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>-->
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body onload="initpage()">
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="tabgraphic">
	<form name="form1" id="form1" method="post">
	<img src="images/S1P1<%=strLanguageCode%>.gIf" alt="" width="692" height="82" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="633,53,672,53,680,59,673,65,632,66,617,59,634,53,637,53" href="javascript:GoToNextPage()">
	</map>
</div>
<div id="maincontent_tab">
<%
	' first check the QCompleted cookie - If the questions
	' were completed Then don't allow the user to see this
	' page - redirect them to the scoring summary page
	Dim strTempAns
	strTempAns = "false"
	Dim TestCodeID
	Dim nQuestionNumber
	' increment this for every question page
	' question page 1 = 1 
	' question page 2 = 13
	' question page 3 = 25
	' question page 4 = 37
	nQuestionNumber = 1
	
	' every page must acquire this value
	TestCodeID = Request.QueryString("TCID")
	
	Dim Submitted
	' tells you If this page has been submitted
	' the form calls the same page
	Submitted = Request.Form("Submitted")
	
	If Submitted = "1" Then
		' record the entries to the database and move to the next page
		' every question page (1-6) except the last page does this
		' If an answer already exists Then the answer is updated 
		TestCodeID = Request.Form("TCID")
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "spTestResultsDetail12AnsInsert"
			.CommandType = 4
			.Parameters.AppEnd .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.AppEnd .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
			.Parameters.AppEnd .CreateParameter("@TestTakerID", 3, 1, 4, Request.Cookies("UserID"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber1", 3, 1, 4, nQuestionNumber)
			.Parameters.AppEnd .CreateParameter("@Answer1", 129, 1, 1, Request.Form("MostAns1"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber2", 3, 1, 4, nQuestionNumber + 1)
			.Parameters.AppEnd .CreateParameter("@Answer2", 129, 1, 1, Request.Form("LeastAns1"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber3", 3, 1, 4, nQuestionNumber + 2)
			.Parameters.AppEnd .CreateParameter("@Answer3", 129, 1, 1, Request.Form("MostAns2"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber4", 3, 1, 4, nQuestionNumber + 3)
			.Parameters.AppEnd .CreateParameter("@Answer4", 129, 1, 1, Request.Form("LeastAns2"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber5", 3, 1, 4, nQuestionNumber + 4)
			.Parameters.AppEnd .CreateParameter("@Answer5", 129, 1, 1, Request.Form("MostAns3"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber6", 3, 1, 4, nQuestionNumber + 5)
			.Parameters.AppEnd .CreateParameter("@Answer6", 129, 1, 1, Request.Form("LeastAns3"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber7", 3, 1, 4, nQuestionNumber + 6)
			.Parameters.AppEnd .CreateParameter("@Answer7", 129, 1, 1, Request.Form("MostAns4"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber8", 3, 1, 4, nQuestionNumber + 7)
			.Parameters.AppEnd .CreateParameter("@Answer8", 129, 1, 1, Request.Form("LeastAns4"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber9", 3, 1, 4, nQuestionNumber + 8)
			.Parameters.AppEnd .CreateParameter("@Answer9", 129, 1, 1, Request.Form("MostAns5"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber10", 3, 1, 4, nQuestionNumber + 9)
			.Parameters.AppEnd .CreateParameter("@Answer10",129, 1,1, Request.Form("LeastAns5"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber11", 3, 1, 4, nQuestionNumber + 10)
			.Parameters.AppEnd .CreateParameter("@Answer11", 129, 1, 1, Request.Form("MostAns6"))
			.Parameters.AppEnd .CreateParameter("@QuestionNumber12", 3, 1, 4, nQuestionNumber + 11)
			.Parameters.AppEnd .CreateParameter("@Answer12", 129, 1, 1, Request.Form("LeastAns6"))
			' we don't do the final submit on this page
			.Parameters.AppEnd .CreateParameter("@FinalSubmit", 3, 1, 4, 0)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		If oConn.Errors.Count < 1 Then
		Else
			Response.Write Err.Description
			Response.Write "<br><br>"
			Response.Write strTextUnableToRecordAnswersInDatabasePlease
			Response.End
		End If
		' move to the next question page
		' except when you are on the last page (question page 4)
		' Then move to the next page in the profile
		Response.Redirect("PDIProfileQuestions2.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID)
	Else
		' every question page must aquire the the test code id
		If TestCodeID = "" Then
			Response.Write "<br><br>" & strTextInvalidPDICodeIDTheTestCannotBeStartedPlease
			Response.End
		End If
		' insert an entry in the database that the test has started
		' only the first question page does this
		' the stored procedure will not insert a duplicate entry in the testresults table
		Dim oConn
		Dim oCmd
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "ins_TestResults_TestStart"
			.CommandType = 4
			.Parameters.AppEnd .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.AppEnd .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		If oConn.Errors.Count < 1 Then
		Else
			Response.Write Err.Description
			Response.Write "<br><br>"
			Response.Write strTextErrorStartingTestPleaseTryAgain
			Response.End
		End If
	End If
	
	Dim Words(24)
	Dim DISC(24)
	Dim MostChoice(6)
	Dim LeastChoice(6)
	Dim nCount
	Dim nWord
	
	nWord = 1
	
	' Page 1
	Words(nWord) = strTextExpressive
	DISC(nWord) = "I"
	nWord = nWord + 1
	Words(nWord) = strTextCompliant
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = strTextForceful
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = strTextRestrained
	DISC(nWord) = "S"
	nWord = nWord + 1
	
	Words(nWord) = strTextPrecise
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = strTextDomineering
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = strTextWilling
	DISC(nWord) = "S"
	nWord = nWord + 1
	Words(nWord) = strTextAttractive
	DISC(nWord) = "I"
	nWord = nWord + 1
	
	Words(nWord) = strTextStrongMinded
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = strTextCareful
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = strTextEmotional
	DISC(nWord) = "I"
	nWord = nWord + 1
	Words(nWord) = strTextSatisfied
	DISC(nWord) = "S"
	nWord = nWord + 1
	
	Words(nWord) = strTextEvenTempered
	DISC(nWord) = "S"
	nWord = nWord + 1
	Words(nWord) = strTextStimulating
	DISC(nWord) = "I"
	nWord = nWord + 1
	Words(nWord) = strTextMeticulous
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = strTextDetermined
	DISC(nWord) = "D"
	nWord = nWord + 1
	
	Words(nWord) = strTextCorrect
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = strTextPioneering
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = strTextCalm
	DISC(nWord) = "S"
	nWord = nWord + 1
	Words(nWord) = strTextInfluential
	DISC(nWord) = "I"
	nWord = nWord + 1
	
	Words(nWord) = strTextTimid
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = strTextDemanding
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = strTextPatient
	DISC(nWord) = "S"
	nWord = nWord + 1
	Words(nWord) = strTextCaptivating
	DISC(nWord) = "I"
	nWord = nWord + 1
	%>
	<!--<form name="form1" id="form1" method="post" onsubmit="return GoToNextPage()">-->
	<input type="hidden" name="MostAns1" id="MostAns1">
	<input type="hidden" name="MostAns2" id="MostAns2">
	<input type="hidden" name="MostAns3" id="MostAns3">
	<input type="hidden" name="MostAns4" id="MostAns4">
	<input type="hidden" name="MostAns5" id="MostAns5">
	<input type="hidden" name="MostAns6" id="MostAns6">
	<input type="hidden" name="LeastAns1" id="LeastAns1">
	<input type="hidden" name="LeastAns2" id="LeastAns2">
	<input type="hidden" name="LeastAns3" id="LeastAns3">
	<input type="hidden" name="LeastAns4" id="LeastAns4">
	<input type="hidden" name="LeastAns5" id="LeastAns5">
	<input type="hidden" name="LeastAns6" id="LeastAns6">
	<input type="hidden" name="Submitted" id="Submitted" value="1">
	<input type="hidden" name="TCID" id="TCID" value="<%=TestCodeID%>">
	<table border="0" cellspacing="0" cellpadding="4" width="<%=tableWidth%>">
		<tr>
			<td valign="top" width="200">
				<h2><%=strTextInstructions%></h2>
				<p><%=strTextInEachOfTheseFourWordGroupsPlease%>
<%
		If intResellerID = 2 Then
			Response.Write "<p>" & strTextRememberToGoWithYourFirstInstinct & "</p>"
		Else
			Response.Write "<p>" & strTextRememberToPictureYourselfInTheWork & "</p>"
		End If
%>
				<p><%=strTextWhenYouFinishEachPageClickTheNext%></p>
			</td>
			<td valign="top">
				<table border="0" cellspacing="0" cellpadding="3" width="100%">
					<tr>
						<td valign="middle" align="right"><strong><%=strTextMost%></strong></td>
						<td valign="middle" align="center">|</td>
						<td valign="middle" align="left"><strong><%=strTextLeast%></strong></td>
						<td colspan="2" valign="middle" align="left">&nbsp;</td>
						<td valign="middle" align="right"><strong><%=strTextMost%></strong></td>
						<td valign="middle" align="center">|</td>
						<td valign="middle" align="left"><strong><%=strTextLeast%></strong></td>
						<td valign="middle" align="left">&nbsp;</td>
					</tr>
<%
			nCount = 0
			For nWord = 1 To 12
			If (nWord <= 4) Or (nWord >= 9) Then
%>
					<tr>
						<td valign="middle" align="right">
							<input type="radio" name="chkMostAns<%=nWord%>" id="chkMostAns<%=nWord%>" onclick="CheckedMostAns(<%=nWord%>)">
						</td>
						<td valign="middle" align="center">&nbsp;</td>
						<td valign="middle" align="left">
							<input type="radio" name="chkLeastAns<%=nWord%>" id="chkLeastAns<%=nWord%>" onclick="CheckedLeastAns(<%=nWord%>)">
						</td>
						<td valign="middle" align="left"><%=Words(nWord)%></td>
						<td width="1">|</td>
						<td valign="middle" align="right">
							<input type="radio" name="chkMostAns<%=nWord+12%>" id="chkMostAns<%=nWord+12%>" onclick="CheckedMostAns(<%=nWord+12%>)">
						</td>
						<td valign="middle" align="center">&nbsp;</td>
						<td valign="middle" align="left">
							<input type="radio" name="chkLeastAns<%=nWord+12%>" id="chkLeastAns<%=nWord+12%>" onclick="CheckedLeastAns(<%=nWord+12%>)">
						</td>
						<td valign="middle" align="left"><%=Words(nWord+12)%></td>
					</tr>
		<%	Else %>
					<tr>
						<td valign="middle" align="right" bgcolor="#cccccc">
							<input type="radio" name="chkMostAns<%=nWord%>" id="chkMostAns<%=nWord%>" onclick="CheckedMostAns(<%=nWord%>)">
						</td>
						<td valign="middle" align="center" bgcolor="#cccccc">&nbsp;</td>
						<td valign="middle" align="left" bgcolor="#cccccc">
							<input type="radio" name="chkLeastAns<%=nWord%>" id="chkLeastAns<%=nWord%>" onclick="CheckedLeastAns(<%=nWord%>)">
						</td>
						<td valign="middle" align="left" bgcolor="#cccccc"><%=Words(nWord)%></td>
						<td width="1" bgcolor="#cccccc">|</td>
						<td valign="middle" align="right" bgcolor="#cccccc">
							<input type="radio" name="chkMostAns<%=nWord+12%>" id="chkMostAns<%=nWord+12%>" onclick="CheckedMostAns(<%=nWord+12%>)">
						</td>
						<td valign="middle" align="center" bgcolor="#cccccc">&nbsp;</td>
						<td valign="middle" align="left" bgcolor="#cccccc">
							<input type="radio" name="chkLeastAns<%=nWord+12%>" id="chkLeastAns<%=nWord+12%>" onclick="CheckedLeastAns(<%=nWord+12%>)">
						</td>
						<td valign="middle" align="left" bgcolor="#cccccc"><%=Words(nWord+12)%></td>
					</tr>
<%	End If
	nCount = nCount + 1
	If nCount = 4 Then
%>
					<tr>
						<td colspan="9"><img src="images/spacer.gIf" alt="" width="1" height="10" /><br><img src="/pdi/images/black_line.jpg" width="100%" height="1"><br></td>
					</tr>
<% 
			nCount = 0
			End If
		 	Next
			If oldButtons = True Then %>
					<tr>
						<td colspan="9" align="right"><input Type="IMAGE" Name="<%=strTextNextPage%>" SRC="images/PDINextPage_Narrow.gIf"></td>
					</tr>
		<%	End If %>
				</table>
			</td>
		</tr>
	</table>
	</form>
	<script>
	<!--
	/*
	document.form1.chkMostAns1.checked = true;
	document.form1.chkLeastAns2.checked = true;
	document.form1.chkMostAns5.checked = true;
	document.form1.chkLeastAns6.checked = true;
	document.form1.chkMostAns9.checked = true;
	document.form1.chkLeastAns10.checked = true;
	document.form1.chkMostAns13.checked = true;
	document.form1.chkLeastAns14.checked = true;
	document.form1.chkMostAns17.checked = true;
	document.form1.chkLeastAns18.checked = true;
	document.form1.chkMostAns21.checked = true;
	document.form1.chkLeastAns22.checked = true;
	*/
<%
	If bSubmitted <> "1" Then
		' try and retrieve answers from the database here
		Set oConn = Nothing
		Set oCmd = Nothing
		Dim oRs
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			.CommandText = "spTestResultsDetailTCIDSelect"
			.CommandType = 4
			.Parameters.AppEnd .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.AppEnd .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
		If oConn.Errors.Count < 1 Then
			If oRs.EOF = False Then
				oRs.MoveFirst
				While oRs.EOF = False
					If CInt(oRs("QuestionNumber")) = 1 Then
						' This must be done so that the javascript on the client will know that
						' all questions have been answered. This is done below in the
						' javascript section. This defaults to false at the top of the page.
						' This is only marked true because answers exist in the database.
						strTempAns = "true"
						If oRs("Answer") = "I" Then
							Response.Write "document.form1.chkMostAns1.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "C" Then
							Response.Write "document.form1.chkMostAns2.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkMostAns3.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkMostAns4.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 2 Then
						If oRs("Answer") = "I" Then
							Response.Write "document.form1.chkLeastAns1.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "C" Then
							Response.Write "document.form1.chkLeastAns2.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkLeastAns3.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkLeastAns4.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 3 Then
						If oRs("Answer") = "C" Then
							Response.Write "document.form1.chkMostAns5.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkMostAns6.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkMostAns7.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkMostAns8.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 4 Then
						If oRs("Answer") = "C" Then
							Response.Write "document.form1.chkLeastAns5.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkLeastAns6.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkLeastAns7.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkLeastAns8.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 5 Then
						If oRs("Answer") = "D" Then
							Response.Write "document.form1.chkMostAns9.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "C" Then
							Response.Write "document.form1.chkMostAns10.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkMostAns11.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkMostAns12.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 6 Then
						If oRs("Answer") = "D" Then
							Response.Write "document.form1.chkLeastAns9.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "C" Then
							Response.Write "document.form1.chkLeastAns10.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkLeastAns11.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkLeastAns12.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 7 Then
						If oRs("Answer") = "S" Then
							Response.Write "document.form1.chkMostAns13.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkMostAns14.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "C" Then
							Response.Write "document.form1.chkMostAns15.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkMostAns16.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 8 Then
						If oRs("Answer") = "S" Then
							Response.Write "document.form1.chkLeastAns13.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkLeastAns14.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "C" Then
							Response.Write "document.form1.chkLeastAns15.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkLeastAns16.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 9 Then
						If oRs("Answer") = "C" Then
							Response.Write "document.form1.chkMostAns17.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkMostAns18.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkMostAns19.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkMostAns20.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 10 Then
						If oRs("Answer") = "C" Then
							Response.Write "document.form1.chkLeastAns17.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkLeastAns18.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkLeastAns19.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkLeastAns20.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 11 Then
						If oRs("Answer") = "C" Then
							Response.Write "document.form1.chkMostAns21.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkMostAns22.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkMostAns23.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkMostAns24.checked = true;" & VbCrLf
						End If
					ElseIf CInt(oRs("QuestionNumber")) = 12 Then
						If oRs("Answer") = "C" Then
							Response.Write "document.form1.chkLeastAns21.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "D" Then
							Response.Write "document.form1.chkLeastAns22.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "S" Then
							Response.Write "document.form1.chkLeastAns23.checked = true;" & VbCrLf
						ElseIf oRs("Answer") = "I" Then
							Response.Write "document.form1.chkLeastAns24.checked = true;" & VbCrLf
						End If
					End If
					oRs.MoveNext
				WEnd
			End If
		Else
			Response.Write "<br><br>"
			Response.Write strTextUnableToRetrieveRepliesFromDatabasePlease
			Response.End
		End If
	End If
	%>
	var bQuestion1MostAns;
	var bQuestion2MostAns;
	var bQuestion3MostAns;
	var bQuestion4MostAns;
	var bQuestion5MostAns;
	var bQuestion6MostAns;
	
	var bQuestion1LeastAns;
	var bQuestion2LeastAns;
	var bQuestion3LeastAns;
	var bQuestion4LeastAns;
	var bQuestion5LeastAns;
	var bQuestion6LeastAns;
	
	bQuestion1MostAns = <%=strTempAns%>;
	bQuestion2MostAns = <%=strTempAns%>;
	bQuestion3MostAns = <%=strTempAns%>;
	bQuestion4MostAns = <%=strTempAns%>;
	bQuestion5MostAns = <%=strTempAns%>;
	bQuestion6MostAns = <%=strTempAns%>;
	
	bQuestion1LeastAns = <%=strTempAns%>;
	bQuestion2LeastAns = <%=strTempAns%>;
	bQuestion3LeastAns = <%=strTempAns%>;
	bQuestion4LeastAns = <%=strTempAns%>;
	bQuestion5LeastAns = <%=strTempAns%>;
	bQuestion6LeastAns = <%=strTempAns%>;
	
	function SeeIfBoxesAreCheckedOnLoad() {
		// check If least are checked
		if(document.form1.chkLeast1Ans.checked == true || document.form1.chkLeast2Ans.checked == true || document.form1.chkLeast3Ans.checked == true || document.form1.chkLeast4Ans.checked == true) {
			bQuestion1LeastAns = true;
		}

		if(document.form1.chkLeast5Ans.checked == true || document.form1.chkLeast6Ans.checked == true || document.form1.chkLeast7Ans.checked == true || document.form1.chkLeast8Ans.checked == true) {
			bQuestion2LeastAns = true;
		}
		
		if(document.form1.chkLeast9Ans.checked == true || document.form1.chkLeast10Ans.checked == true || document.form1.chkLeast11Ans.checked == true || document.form1.chkLeast12Ans.checked == true) {
			bQuestion3LeastAns = true;
		}
		
		if(document.form1.chkLeast13Ans.checked == true || document.form1.chkLeast14Ans.checked == true || document.form1.chkLeast15Ans.checked == true || document.form1.chkLeast16Ans.checked == true) {
			bQuestion4LeastAns = true;
		}
		
		if(document.form1.chkLeast17Ans.checked == true || document.form1.chkLeast18Ans.checked == true || document.form1.chkLeast19Ans.checked == true || document.form1.chkLeast20Ans.checked == true) {
			bQuestion5LeastAns = true;
		}
		
		if(document.form1.chkLeast21Ans.checked == true || document.form1.chkLeast22Ans.checked == true || document.form1.chkLeast23Ans.checked == true || document.form1.chkLeast24Ans.checked == true) {
			bQuestion6LeastAns = true;
		}
		
		// check If most are checked
		if(document.form1.chkMost1Ans.checked == true || document.form1.chkMost2Ans.checked == true || document.form1.chkMost3Ans.checked == true || document.form1.chkMost4Ans.checked == true) {
			bQuestion1MostAns = true;
		}
		
		if(document.form1.chkMost5Ans.checked == true || document.form1.chkMost6Ans.checked == true || document.form1.chkMost7Ans.checked == true || document.form1.chkMost8Ans.checked == true) {
			bQuestion2MostAns = true;
		}
		
		if(document.form1.chkMost9Ans.checked == true || document.form1.chkMost10Ans.checked == true || document.form1.chkMost11Ans.checked == true || document.form1.chkMost12Ans.checked == true) {
			bQuestion3MostAns = true;
		}
		
		if(document.form1.chkMost13Ans.checked == true || document.form1.chkMost14Ans.checked == true || document.form1.chkMost15Ans.checked == true || document.form1.chkMost16Ans.checked == true) {
			bQuestion4MostAns = true;
		}
		
		if(document.form1.chkMost17Ans.checked == true || document.form1.chkMost18Ans.checked == true || document.form1.chkMost19Ans.checked == true || document.form1.chkMost20Ans.checked == true) {
			bQuestion5MostAns = true;
		}
		
		if(document.form1.chkMost21Ans.checked == true || document.form1.chkMost22Ans.checked == true || document.form1.chkMost23Ans.checked == true || document.form1.chkMost24Ans.checked == true) {
			bQuestion6MostAns = true;
		}
	}
<%  Dim strMost
	Dim strLeast
	strMost = "Most"
	strLeast = "Least"
%>
	
	function CheckedMostAns(nItem) {
		//alert(nItem);
		<%
		Dim nItem
		nCount = 1
		For nItem = 1 to 21 step 4 %>
		if(nItem >= <%=nItem%> && nItem <= <%=nItem+3%>) {
			if(nItem==<%=nItem%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = false;			
					return;
				}
			}
			else if(nItem==<%=nItem+1%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+1%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = false;			
					return;
				}
			}
			else if(nItem==<%=nItem+2%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+2%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = false;			
					return;
				}
			}
			else if(nItem==<%=nItem+3%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+3%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = false;			
					return;
				}
			}
			bQuestion<%=nCount%>MostAns = true;		
					
			if(nItem!=<%=nItem%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = false;			
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = true;
			}
			
			if(nItem!=<%=nItem+1%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = true;
			}
			
			if(nItem!=<%=nItem+2%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = true;
			}
			
			if(nItem!=<%=nItem+3%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = true;
			}
			
			<% nCount = nCount + 1 %>
		}
		<% next %>
	}
<%
		strMost = "Least"
		strLeast = "Most"
%>
	function CheckedLeastAns(nItem) {
		//alert(nItem);
		<%
		nCount = 1
		For nItem = 1 to 21 step 4 %>
		if(nItem >= <%=nItem%> && nItem <= <%=nItem+3%>) {
			if(nItem==<%=nItem%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = false;
					return;
				}
			}
			else if(nItem==<%=nItem+1%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+1%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = false;
					return;
				}
			}
			else if(nItem==<%=nItem+2%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+2%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = false;
					return;
				}
			}
			else if(nItem==<%=nItem+3%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+3%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = false;
					return;
				}
			}
			bQuestion<%=nCount%>LeastAns = true;
			
			if(nItem!=<%=nItem%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = true;
			}
			
			if(nItem!=<%=nItem+1%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = true;
			}
			
			if(nItem!=<%=nItem+2%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = true;
			}
			
			if(nItem!=<%=nItem+3%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = true;
			}
			<% nCount = nCount + 1 %>
		}
		<% next %>
	}
	
	function GoToNextPage() {
		<% For nItem = 1 To 6 %>
		if(!bQuestion<%=nItem%>MostAns) {
			
            alert("<%=strTextPleaseChooseMostAndLeast%>");
			return;
		}
		
		if(!bQuestion<%=nItem%>LeastAns) {
			
            alert("<%=strTextPleaseChooseMostAndLeast%>");
			return;
		}
		<% Next
		nCount = 1
		For nItem = 1 To 21 Step 4 %>
		if(document.form1.chkMostAns<%=nItem%>.checked) {
			document.form1.MostAns<%=nCount%>.value = "<%=DISC(nItem)%>";
		}
		else if(document.form1.chkMostAns<%=nItem+1%>.checked) {
			document.form1.MostAns<%=nCount%>.value = "<%=DISC(nItem+1)%>";
		}
		else if(document.form1.chkMostAns<%=nItem+2%>.checked) {
			document.form1.MostAns<%=nCount%>.value = "<%=DISC(nItem+2)%>";
		}
		else if(document.form1.chkMostAns<%=nItem+3%>.checked) {
			document.form1.MostAns<%=nCount%>.value = "<%=DISC(nItem+3)%>";
		}
		if(document.form1.chkLeastAns<%=nItem%>.checked) {
			document.form1.LeastAns<%=nCount%>.value = "<%=DISC(nItem)%>";
		}
		else if(document.form1.chkLeastAns<%=nItem+1%>.checked) {
			document.form1.LeastAns<%=nCount%>.value = "<%=DISC(nItem+1)%>";
		}
		else if(document.form1.chkLeastAns<%=nItem+2%>.checked) {
			document.form1.LeastAns<%=nCount%>.value = "<%=DISC(nItem+2)%>";
		}
		else if(document.form1.chkLeastAns<%=nItem+3%>.checked) {
			document.form1.LeastAns<%=nCount%>.value = "<%=DISC(nItem+3)%>";
		}
<%
		nCount = nCount + 1
		next %>
		document.form1.submit();
	}

	function initpage() {
		qsubmitted();
		//SeeIfBoxesAreCheckedOnLoad();
	}

	function qsubmitted() {
		// If the questions are completed Then
		// automatically redirect the user to the
		// scoring summary page
		// this cookie is set on the PDI start page
		var qcompleted = GetCookie("qcompleted");
		if(qcompleted == 1) {
			window.location="PDIProfileScoringSummary2.asp?TCID=<%=TestCodeID%>"
		}
	}

	function getCookieVal (offset) {
		var Endstr = document.cookie.indexOf (";", offset);
		if (Endstr == -1)
		Endstr = document.cookie.length;
		return unescape(document.cookie.substring(offset, Endstr));
	}
	
	function GetCookie (name) {
		var arg = name + "=";
		var alen = arg.length;
		var clen = document.cookie.length;
		var i = 0;
		while (i < clen) {
			var j = i + alen;
			if (document.cookie.substring(i, j) == arg)
			return getCookieVal (j);
			i = document.cookie.indexOf(" ", i) + 1;
			if (i == 0)
			break;
		}
		return null;
	}
	-->
	</script>
</div>
        </div>
    <script type="text/javascript" src="./Scripts/FooterLoader.js"></script>
</body>
</html>
