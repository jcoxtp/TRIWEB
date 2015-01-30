<%
	Response.Write "<h2><i>" & strTextYourRepresentativePattern & "</i></h2>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
	'Response.Write strTextBelowYouWillFindThePatternsThatMostClosely & VbCrLf
	Response.Write "Below you will find the pattern that most closely matches your COMPOSITE Graph. " & _
						 "Remember, these representative patterns are based on behavioral profile only, without information " & _
						 "about intelligence, personal values, versatility, and other factors that could affect your behavior." & _
						 "Knowing your pattern should enable you to understand yourself and others in a way that " & _
						 "maximizes your potential and your abilities."
	Response.Write "<br><br>" & VbCrLf
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Dim strLeftTitle1, strLeftText1
	Dim strRightTitle1, strRightText1
	Dim strLeftTitle2, strLeftText2
	Dim strRightTitle2, strRightText2
	Dim strDreamTitle, strDreamText
	Dim profileName
	strLeftTitle1 = strTextOutstandingTraits
	strRightTitle1 = strTextPotentialForGrowth
	strLeftTitle2 = strTextBasicDesiresAndInternalDrive
	If strSiteType = "DG" Then
		strRightTitle2 = strTextIdealEnvironment
		strDreamTitle = strTextDreamJourney
	Else
		strRightTitle2 = strTextIdealWorkSetting
		strDreamTitle = ""
	End If
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spRepProfileDescProfileID"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@profileID", 3, 1, 4, nRepProfile1)
		.Parameters.Append .CreateParameter("@intLanguageID", 3, 1, 4, intLanguageID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	If oConn.Errors.Count < 1 And oRs.RecordCount > 0 Then
		strLeftText1 = oRs("outstandingTraits")
		strRightText1 = oRs("potentialGrowth")
		strLeftText2 = oRs("basicDesires")
		strRightText2 = oRs("workSetting")
		strDreamText = oRs("dreamJourney")
		profileName = oRs("RepProfileName")
	Else
		Response.Write strTextErrorTryingToRetrieveProfileDescription
	End If
%>
<img style="float:left;margin-right:30px;" src="../images/RepProfile<%=nRepProfile1%>.gif" alt="" />
				<h1>(<%=nRepProfile1%>)&nbsp;<%=profileName%></h1>
				<h2><%=strLeftTitle1%></h2>
				<p><%=strLeftText1%></p>
				<h2><%=strLeftTitle2%></h2>
				<p><%=strLeftText2%></p>
				<h2><%=strRightTitle1%></h2>
				<p><%=strRightText1%></p>
				<h2><%=strRightTitle2%></h2>
				<p><%=strRightText2%></p>
				<% If strSiteType = "DG" Then %>
					<p style="page-break-after: always">&nbsp;</p>
					<h2><%=strDreamTitle%></h2>
					<p><%=strDreamText%></p>
				<% End If %>
			