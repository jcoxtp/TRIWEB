<%
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRsLanguages = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spLanguagesSelectPublic"
		.CommandType = 4
	    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
	    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 255, Null)
	End With
	oConn.Open Application("strDbConnString")
	oCmd.ActiveConnection = oConn
	oRsLanguages.CursorLocation = adOpenStatic
	oRsLanguages.Open oCmd, , adOpenForwardOnly, adOpenKeyset
	intRsLanguagesErrorCode = oCmd.Parameters("@intErrorCode").value
	strRsLanguagesErrorMessage = oCmd.Parameters("@strErrorMessage").value
%>
<form name="langChooser" method="get"><select name="LanguageID" onChange="javascript:changeLanguage();">
<%
	If intRsLanguagesErrorCode < 1 Then
		oRsLanguages.MoveFirst
		While NOT oRsLanguages.EOF
			Response.Write "<option value=""" & oRsLanguages("LanguageID") & """"
			If CInt(oRsLanguages("LanguageID")) = CInt(intLanguageID) Then
				Response.Write " selected "
			End If
			Response.Write ">"
			If CInt(oRsLanguages("LanguageID")) <> 1 Then
				Response.Write oRsLanguages("NameNative")
				Response.Write " - "
			End If
			Response.Write oRsLanguages("NameEnglish")
			Response.Write "</option>" & VbCrLf
			oRsLanguages.MoveNext
		Wend
	End If %>
</select></form>
