<%@ Language=VBScript CodePage=65001 %>
<!-- #Include File = "Include/CheckLogin.asp" -->
<!-- #Include File = "Include/Common.asp" -->
<!-- #Include File = "Include/ADOVBS.asp" -->
<% pageID = "startPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8" />
	<title>DISC Profile System | PDI Profile Start Page</title>
	<link rel="stylesheet" href="_system.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
<%
	Dim TestCodeID
	TestCodeID = Request("TCID")
	Dim intLanguageID
	intLanguageID = 6 'Simplied Chinese

	' you should test here if it's ok to start this TCID
	' if so then set some cookies that determines that this TCID is active and that
	' the questions are not complete
	
	Dim bStartPDI : bStartPDI = 1
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
			.Parameters.Append .CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue, 0)
			.Parameters.Append .CreateParameter("@TestCodeID", adInteger, adParamInput, 4, TestCodeID)
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 Then
			If Not oRs.EOF Then
				nTestCompleted = oRs("TestCompleted")
				nQuestionsCompleted = oRs("QuestionsCompleted")
			Else
				nTestCompleted = 0
				nQuestionsCompleted = 0
			End If
			' check the status of the PDI Profile code
			 ' if the test has been completed and the report printed then post a msg 
			' telling the user that this code has already been used
			If CInt(nTestCompleted) = 1 Then
				Response.Write "This PDI profile code has been completed. Please choose a different profile code." & VbCrLf
				Response.End
			End If
			' if the questions have been answered but the report hasn't been printed
			' then redirect to the scoring summary page
			If  CInt(nQuestionsCompleted) = 1 Then
				strNextPage = "PDIProfileScoringSummary2.asp?TCID=" & TestCodeID & "&res=" & intResellerID
			Else
				' if the questions have not been finished then go to questions page 1
				strNextPage = "PDIProfileQuestions1.asp?TCID=" & TestCodeID & "&res=" & intResellerID
			End If
		Else
			Response.Write "Unable to retrieve profile code information. Please try again." & VbCrLf
			Response.End
		End If
	End If

	Response.Write "<h1><b>欢迎使用个性鉴别清单</b><b>DISC</span></b><sup>&reg;</sup>！</h1>" & VbCrLf
	If CInt(nQuestionsCompleted) = 1 Then
		Response.Write "<p><strong>NOTE: </strong>You have already submitted your answers, but the rest of the profile has not been completed. As a result, you will be taken directly to the scoring summary page.</p>" & VbCrLf
		Response.Write "<p class=""aligncenter""><a HREF=" & strNextPage & "><img src=""images/begin_now.gif"" width=""167"" height=""48"" alt="""" /></a></p>" & VbCrLf
	Else
		Response.Write "<h2><strong>指南</strong></h2>" & VbCrLf
		Response.Write "<p>以下四页当中，每一页你将看到六套形容词，四词一组。请在每一组当中选择一个最能形容你的词，一个最不能形容你的词。</p>" & VbCrLf
		Response.Write "<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
		Response.Write "	<tr>" & VbCrLf
		Response.Write "		<td valign=""top"" align=""right"" width=""250""><img src=""images/PDIStartExample.gif"" width=""227"" height=""163"" alt="""" /></td>" & VbCrLf
		Response.Write "		<td valign=""middle""><a HREF=" & strNextPage & "><img src=""images/begin_now.gif"" width=""167"" height=""48"" alt="""" /></a></td>" & VbCrLf
		Response.Write "	</tr>" & VbCrLf
		Response.Write "</table>" & VbCrLf
		Response.Write "<p>下列建议可以提高你的测试结果的准确性：</p>" & VbCrLf
		Response.Write "<ol>" & VbCrLf

		If intResellerID = 2 Then
				Response.Write ""
		Else
				Response.Write "<li>在描述你自己的过程中，想象你身处工作环境。</li>"
		End If
				Response.Write "<li>测试要迅速，以你的第一直觉为准，因为第一直觉往往是最准确的。这一节所花的时间不应超过8到10分钟。</li>"
				Response.Write "<li>没有正确或错误的回答，所以回答要尽可能坦诚。</li>"
		End If
		Response.Write "</ol>" & VbCrLf
		Response.Write "<script>" & VbCrLf
		Response.Write "<!--" & VbCrLf
		If CInt(nQuestionsCompleted) = 1 Then
			Response.Write "SetCookie(""qcompleted"",""1"");"
		Else
			Response.Write "SetCookie(""qcompleted"",""0"");"
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
</body>
</html>
