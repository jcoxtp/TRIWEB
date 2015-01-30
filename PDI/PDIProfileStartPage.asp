<%@  language="VBScript" codepage="65001" %>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 38	' PDI Profile Start Page
%>
<!-- #Include File="Include/CheckLogin.asp" -->
<!-- #Include File="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title><%=strTextPageName%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<body>
    <!-- #Include File="Include/TopBanner.asp" -->
    <div id="main">
        <div id="maincontent">
            <%
	Dim TestCodeID
	TestCodeID = Request.QueryString("TCID")
	' You should test here if it's ok to start this TCID
	' If so then set some cookies that determines that this TCID is active and that
	' the questions are not complete
	
	Dim bStartPDI
	bStartPDI = 1
	Dim strNextPage
	If bStartPDI = "1" Then
		Dim oConn
		Dim oCmd
		Dim oRs
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		Dim nQuestionsCompleted
		Dim nTestCompleted
		With oCmd
			.CommandText = "spTestSummarySelect"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
		If oConn.Errors.Count < 1 Then
			If oRs.EOF = False Then
				nTestCompleted = oRs("TestCompleted")
				nQuestionsCompleted = oRs("QuestionsCompleted")
			Else
				nTestCompleted = 0
				nQuestionsCompleted = 0
			End If
			' Check the status of the PDI Profile code
			' If the test has been completed and the report printed then post a msg
			' telling the user that this code has already been used
			If CInt(nTestCompleted) = 1 Then
				Response.Write strTextThisPDIProfileCodeHasBeenCompletedPlease
				Response.End
			End if
			' If the questions have been answered but the report hasn't been printed
			' then redirect to the scoring summary page
			If  CInt(nQuestionsCompleted) = 1 Then
				strNextPage = "PDIProfileScoringSummary2.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID
			Else
				' If the questions have not been finished then go to questions page 1
				strNextPage = "PDIProfileQuestions1.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID
			End if
		Else
			Response.Write strTextUnableToRetrieveProfileCodeInformationPlease
			Response.End
		End If
	End If
	Response.Write "<h1>" & strTextWelcomeToThePDI & "</h1>" & VbCrLf
	If CInt(nQuestionsCompleted) = 1 Then
		Response.Write "<p><strong>" & UCase(Application("strTextNote" & strLanguageCode)) & "</strong>: " & strTextYouHaveAlreadySubmittedYourAnswersBut & "</p>" & VbCrLf
		Response.Write "<p class=""aligncenter""><a HREF=""" & strNextPage & """><img src=""images/begin_now.gif"" width=""167"" height=""48"" alt="""" /></a></p>" & VbCrLf
	Else
		Response.Write "<h2>" & strTextInstructions & "</h2>" & VbCrLf
		Response.Write "<p>" & strTextOnEachOfTheNextFourPagesYou & "</p>" & VbCrLf
		Response.Write "<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
		Response.Write "	<tr>" & VbCrLf
		Response.Write "		<td valign=""top"" align=""right"" width=""250""><img src=""images/PDIStartExample" & strLanguageCode & ".gif"" width=""227"" height=""163"" alt="""" /></td>" & VbCrLf
		Response.Write "		<td valign=""middle""><a href=""" &strNextPage & """><img src=""images/BeginNow" & strLanguageCode & ".gif"" width=""167"" height=""48"" alt="""" /></a></td>" & VbCrLf
		Response.Write "	</tr>" & VbCrLf
		Response.Write "</table>" & VbCrLf
		Response.Write "<p>" & strTextHereAreSomeTipsThatWillIncrease & "</p>" & VbCrLf
		Response.Write "<ol>" & VbCrLf
		If intResellerID <> 2 And intResellerID <> 10 Then
			Response.Write "<li>" & strTextPictureYourselfInTheWorkSettingAs & "</li>" & VbCrLf
		End If
		Response.Write "<li>" & strTextMoveQuicklyThroughTheInstrumentAnd & "</li>" & VbCrLf
		Response.Write "<li>" & strTextThereAreNoRightOrWrongAnswersSo & "</li>" & VbCrLf
		Response.Write "</ol>" & VbCrLf
	End If
	Response.Write "<script>" & VbCrLf
	Response.Write "<!--" & VbCrLf
	If CInt(nQuestionsCompleted) = 1 Then
		Response.Write "SetCookie(""qcompleted"",""1"");" & VbCrLf
	Else
		Response.Write "SetCookie(""qcompleted"",""0"");" & VbCrLf
	End If
            %>
	function SetCookie (name, value) {
		var argv = SetCookie.arguments;
		var argc = SetCookie.arguments.length;
		var expires = (2 < argc) ? argv[2] : null;
		var path = (3 < argc) ? argv[3] : null;
		var domain = (4 < argc) ? argv[4] : null;
		var secure = (5 < argc) ? argv[5] : false;
		document.cookie = name + "=" + escape (value) +
		((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
		((path == null) ? "" : ("; path=" + path)) +
		((domain == null) ? "" : ("; domain=" + domain)) +
		((secure == true) ? "; secure" : "");
	}
	-->
	</script>
        </div>
    </div>
</body>
</html>
