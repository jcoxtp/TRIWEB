<%@ Language=VBScript Codepage = 65001 %>
<%
' Set initial critical page parameters
	Response.Buffer = True
'	On Error Resume Next
	intPageID = 4	' TextSearchList Page
	isDebugOn = False
	'isDebugOn = True
%>
<!--#Include virtual="/pdi/include/common.asp" -->
<!--#Include virtual="/pdi/include/adovbs.asp" -->
<%
' Declare Internal Variables (alphabetical)
	Dim intAlt
	Dim intPageSelectID
	Dim intRsLanguagesErrorCode
	Dim intRsTextCount
	Dim intRsTextErrorCode
	Dim intRsTextTypesErrorCode
	Dim intTextExceptionID
	Dim intTextTypeID
	Dim isDebugOn
	Dim isSubmitted
	Dim oConn
	Dim oCmd
	Dim oRs
	Dim strAlpha
	Dim strAlphaCharacter
	Dim strErrorMessage
	Dim strExceptionNameSelected
	Dim strSelectedLanguageName
	Dim strPageName
	Dim strPageNameSelected
	Dim strRsLanguagesErrorMessage
	Dim strRsTextErrorMessage
	Dim strRsTextTypesErrorMessage
	Dim strSearchMode
	Dim strText
	Dim strTextTypeSelected

' Set Initial Values for Internal Variables
	If intTranslationLanguageID = "" Then
		intTranslationLanguageID = Request.Form("intTranslationLanguageID")
	End If
	If intTranslationLanguageID = "" Then
		intTranslationLanguageID = 1
	Else
		intTranslationLanguageID = CInt(intTranslationLanguageID)
	End If
	intPageSelectID = Request.Form("intPageSelectID")
	If intPageSelectID = "" Then
		intPageSelectID = 1
	Else
		intPageSelectID = CInt(intPageSelectID)
	End If
	intTextTypeID = Request.Form("intTextTypeID")
	If intTextTypeID = "" Then
		intTextTypeID = 1
	Else
		intTextTypeID = CInt(intTextTypeID)
	End If
	intTextExceptionID = Request.Form("intTextExceptionID")
	If intTextExceptionID = "" Then
		intTextExceptionID = 1
	Else
		intTextExceptionID = CInt(intTextExceptionID)
	End If
	intUserID = Request.Cookies("UserID")
	If intUserID <> "" Then
		intUserID = CLng(intUserID)
	Else
		intUserID = 1
	End If
	isSubmitted = Request.Form("isSubmitted")
	If isSubmitted = "1" Or isSubmitted = "99" Then
		isSubmitted = True
	Else
		isSubmitted = False
	End If
	strAlphaCharacter = Request.Form("strAlphaCharacter")
	strErrorMessage = Request.QueryString("isSuccess")
	strPageName = "TextSearchList.asp"
	strText = Request.Form("strText")
	If strText = "" Then
		strText = Request.Form("SearchText")
	End If
	strSearchMode = Request.Form("strSearchMode")

If isDebugOn Then
	Response.Write "<br>Exec spLanguagesSelectActive " & intResellerID & ", NULL, NULL"
	Response.Write "<br>Exec spTextSelectSearchAlpha " & intUserID & ", " & intTranslationLanguageID & ", '" & strAlphaCharacter & "', '" & strText & "', '" & strPageName & "', 0, Null"
End If

' Get List of Active Pages
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRsPages = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spPagesSelectActive"
		.CommandType = 4
	    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
	    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 255, Null)
	End With
	oConn.Open Application("strDbConnString")
	oCmd.ActiveConnection = oConn
	oRsPages.CursorLocation = adOpenStatic
	oRsPages.Open oCmd, , adOpenForwardOnly, adOpenKeyset
	intRsPagesErrorCode = oCmd.Parameters("@intErrorCode").value
	strRsPagesErrorMessage = oCmd.Parameters("@strErrorMessage").value

' Get List of Active Languages
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRsLanguages = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spLanguagesSelectActive"
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
	
	If isDebugOn Then
		Response.Write "<br>Exec spTextSelectSearchAlpha " & intUserID & ", " & intTranslationLanguageID & ", '" & strAlphaCharacter & "', '" & strText & "', '" & strPageName & "', 0, Null"
	End If

' Get List of Active TextTypes
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRsTextTypes = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spTextTypesSelectActive"
		.CommandType = 4
	    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
	    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 255, Null)
	End With
	oConn.Open Application("strDbConnString")
	oCmd.ActiveConnection = oConn
	oRsTextTypes.CursorLocation = adOpenStatic
	oRsTextTypes.Open oCmd, , adOpenForwardOnly, adOpenKeyset
	intRsTextTypesErrorCode = oCmd.Parameters("@intErrorCode").value
	strRsTextTypesErrorMessage = oCmd.Parameters("@strErrorMessage").value
	
	If isDebugOn Then
		Response.Write "<br>Exec spTextSelectSearchAlpha " & intUserID & ", " & intTranslationLanguageID & ", '" & strAlphaCharacter & "', '" & strText & "', '" & strPageName & "', 0, Null"
	End If

' Perform the search against the database
	If isSubmitted Then
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRsText = CreateObject("ADODB.Recordset")
		Select Case strSearchMode
		Case "Alpha"
			With oCmd
				.CommandText = "spTextTranslationAlphaSearch"
				.CommandType = 4
				' Input parameters
					.Parameters.Append .CreateParameter("@intUserID", adInteger, adParamInput, 4, intUserID)
					.Parameters.Append .CreateParameter("@intLanguageID", adInteger, adParamInput, 4, intTranslationLanguageID)
				    .Parameters.Append .CreateParameter("@strAlpha", adVarChar, adParamInput, 3, strAlphaCharacter)
				    .Parameters.Append .CreateParameter("@strCallingPageName", adVarChar, adParamInput, 50, strPageName)
			    ' Output parameters
				    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
				    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 500, Null)
			End With
		Case "Search"
			With oCmd
				.CommandText = "spTextTranslationStringSearch"
				.CommandType = 4
				' Input parameters
					.Parameters.Append .CreateParameter("@intUserID", adInteger, adParamInput, 4, intUserID)
					.Parameters.Append .CreateParameter("@intLanguageID", adInteger, adParamInput, 4, 1)
				    .Parameters.Append .CreateParameter("@strText", adVarWChar, adParamInput, 500, strText)
				    .Parameters.Append .CreateParameter("@strCallingPageName", adVarChar, adParamInput, 50, strPageName)
			    ' Output parameters
				    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
				    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 500, Null)
			End With
		Case "TextType"
			With oCmd
				.CommandText = "spTextTranslationTextTypeSearch"
				.CommandType = 4
				' Input parameters
					.Parameters.Append .CreateParameter("@intUserID", adInteger, adParamInput, 4, intUserID)
					.Parameters.Append .CreateParameter("@intLanguageID", adInteger, adParamInput, 4, intTranslationLanguageID)
					.Parameters.Append .CreateParameter("@intTextTypeID", adInteger, adParamInput, 4, intTextTypeID)
				    .Parameters.Append .CreateParameter("@strCallingPageName", adVarChar, adParamInput, 50, strPageName)
			    ' Output parameters
				    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
				    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 500, Null)
			End With
		Case "Exceptions"
			With oCmd
				.CommandText = "spTextTranslationExceptionSearch"
				.CommandType = 4
				' Input parameters
					.Parameters.Append .CreateParameter("@intUserID", adInteger, adParamInput, 4, intUserID)
					.Parameters.Append .CreateParameter("@intLanguageID", adInteger, adParamInput, 4, intTranslationLanguageID)
					.Parameters.Append .CreateParameter("@intTextExceptionID", adInteger, adParamInput, 4, intTextExceptionID)
				    .Parameters.Append .CreateParameter("@strCallingPageName", adVarChar, adParamInput, 50, strPageName)
			    ' Output parameters
				    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
				    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 500, Null)
			End With
			If isDebugOn Then
				Response.Write "<br>Exec spTextExceptionSelect " & intUserID & ", " & intTranslationLanguageID & ", " & intTextExceptionID & ", '" & strPageName & "', @intErrorCode output, @strErrorMessage output"
			End If
		Case Else
			With oCmd
				.CommandText = "spTextTranslationPageSearch500"
				.CommandType = 4
				' Input parameters
					.Parameters.Append .CreateParameter("@intUserID", adInteger, adParamInput, 4, intUserID)
					.Parameters.Append .CreateParameter("@intLanguageID", adInteger, adParamInput, 4, intTranslationLanguageID)
					.Parameters.Append .CreateParameter("@intPageID", adInteger, adParamInput, 4, intPageSelectID)
				    .Parameters.Append .CreateParameter("@strCallingPageName", adVarChar, adParamInput, 50, strPageName)
			    ' Output parameters
				    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
				    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 500, Null)
			End With
		End Select
		oConn.Open Application("strDbConnString")
		oCmd.ActiveConnection = oConn
		oRsText.CursorLocation = adOpenStatic
		oRsText.Open oCmd, , adOpenForwardOnly, adOpenKeyset
		intRsTextErrorCode = oCmd.Parameters("@intErrorCode").value
		strRsTextErrorMessage = oCmd.Parameters("@strErrorMessage").value
		If intRsTextErrorCode > 0 Then
			strErrorMessage = strRsTextErrorMessage
			Response.Write "<BR><BR>" & strRsTextErrorMessage & "<BR><BR>"
		End If
		If Not oRsText.EOF Then
			intRsTextCount = 0
			While Not oRsText.EOF
				intRsTextCount = intRsTextCount + 1
				oRsText.MoveNext
			Wend
			oRsText.MoveFirst
		End If
	End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Text Translation Alphabetical List</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="Default.css" type="text/css">
	<!-- #Include virtual="/pdi/include/HeadStuff.asp" -->

	<script language="JavaScript">
	<!--
		function getValues () {
			// Get all of the dropdown values with any change so that those values are always preserved
			// Get Language Selection Values
				val = document.FormChooser.LanguageSelection.options[document.FormChooser.LanguageSelection.selectedIndex].value;
				document.FormChooser.intTranslationLanguageID.value = val;
			// Get Page Selection Values
				val = document.FormChooser.PageSelection.options[document.FormChooser.PageSelection.selectedIndex].value;
				document.FormChooser.intPageSelectID.value = val;
			// Get TextType Selection Values
				val = document.FormChooser.TextTypeSelection.options[document.FormChooser.TextTypeSelection.selectedIndex].value;
				document.FormChooser.intTextTypeID.value = val;
			// Get Exceptions Selection Values
				val = document.FormChooser.ExceptionSelection.options[document.FormChooser.ExceptionSelection.selectedIndex].value;
				document.FormChooser.intTextExceptionID.value = val;
			// Get Search Text Values
				document.FormChooser.strText.value = document.FormChooser.SearchText.value;
		}

		function changeLanguage() {
			// make sure that we update the database whenever we access it next...
			getValues();
			document.FormChooser.isSubmitted.value = 0;
			document.FormChooser.action="TextSearchList.asp";
			document.FormChooser.submit();
		}

		function changePageSelection() {
			getValues();
			document.FormChooser.strSearchMode.value = "Page";
			document.FormChooser.isSubmitted.value = 1;
			document.FormChooser.action="TextSearchList.asp";
			document.FormChooser.submit();
		}

		function changeTextTypeSelection() {
			getValues();
			document.FormChooser.strSearchMode.value = "TextType";
			document.FormChooser.isSubmitted.value = 1;
			document.FormChooser.action="TextSearchList.asp";
			document.FormChooser.submit();
		}
		
		function changeTextExceptionsSelection() {
			getValues();
			document.FormChooser.strSearchMode.value = "Exceptions";
			document.FormChooser.isSubmitted.value = 1;
			document.FormChooser.action="TextSearchList.asp";
			document.FormChooser.submit();
		}

		function alphaSearch(val) {
			getValues();
			document.FormChooser.strAlphaCharacter.value = val;
			document.FormChooser.strSearchMode.value = "Alpha";
			document.FormChooser.isSubmitted.value = 1;
			document.FormChooser.action="TextSearchList.asp";
			document.FormChooser.submit();
		}

		function goSearchText() {
			getValues();
			document.FormChooser.strSearchMode.value = "Search";
			document.FormChooser.isSubmitted.value = 1;
			document.FormChooser.action="TextSearchList.asp";
			document.FormChooser.submit();
		}
		
		function goTranslate(val) {
			getValues();
			document.FormChooser.strSearchMode.value = "<%=strSearchMode%>";
			document.FormChooser.strAlphaCharacter.value = "<%=strAlphaCharacter%>";
			document.FormChooser.intTextID.value = val;
			document.FormChooser.action="TranslateText.asp";
			document.FormChooser.isSubmitted.value = 0;
			document.FormChooser.submit();
		}

	-->
	</script>
</head>
<body bgcolor="#ffffff">
	<div align="center">
	<span class="title">Text Translation System</span>
	<br><br>
	<form name="FormChooser" method="post">
	<input type="hidden" name="isSubmitted">
	<input type="hidden" name="intTranslationLanguageID">
	<input type="hidden" name="intTextTypeID">
	<input type="hidden" name="intTextExceptionID">
	<input type="hidden" name="strSearchMode" value="">
	<input type="hidden" name="strAlphaCharacter">
	<input type="hidden" name="strText">
	<input type="hidden" name="intPageSelectID">
	<input type="hidden" name="intTextID">

	<table class="ThinTable" width="95%" border="1" cellpadding="8" cellspacing="1">
		<tr bgcolor="#DDDDDD">
			<td colspan="2">
				<h1>Text Search Criteria</h1>
					<table bgcolor="#DDDDFF" width="500" border="1" cellpadding="6" cellspacing="1" align="center">
						<tr>
							<td bgcolor="#DDDDFF">
								<span class="step">Step 1 (Choose Language)</span>
								<br>Please Select Language for Translation:
								<select name="LanguageSelection" size="1" onChange="javascript:changeLanguage();">
<%
								If intRsLanguagesErrorCode < 1 Then
									oRsLanguages.MoveFirst
									While Not oRsLanguages.EOF
										If oRsLanguages("LanguageID") <> 1 Then
											Response.Write VbTab & "<option value=""" & oRsLanguages("LanguageID") & """"
											If CInt(oRsLanguages("LanguageID")) = CInt(intTranslationLanguageID) Then
												Response.Write " selected "
												strSelectedLanguageName = oRsLanguages("NameEnglish")
											End If
											Response.Write ">"
											Response.Write oRsLanguages("NameNative")
											Response.Write " - "
											Response.Write oRsLanguages("NameEnglish")
											Response.Write "</option>" & VbCrLf
										End If
										oRsLanguages.MoveNext
									Wend
								End If
%>
								</select>
							</td>
						</tr>	
					</table>
					<br>
					
					<table bgcolor="#DDDDFF" border="1" cellpadding="6" cellspacing="1">
						<tr>
							<td colspan="3" bgcolor="#DDDDFF">
								<span class="step">Step 2 (Locate Desired Text)</span>
							</td>
						</tr>
						<tr bgcolor="#DDDDBB" align="left">
							<td><strong>A</strong></td>
							<td><strong>Find Text By Page</strong></td>
							<td>
								<strong>Select Page to Translate:</strong>
								<select name="PageSelection" size="1" onChange="javascript:changePageSelection();">

<%
								If intRsPagesErrorCode < 1 Then
									oRsPages.MoveFirst
									While Not oRsPages.EOF
										Response.Write VbTab & "<option value=""" & oRsPages("PageID") & """"
										If CInt(oRsPages("PageID")) = CInt(intPageSelectID) Then
											Response.Write " selected "
											strPageNameSelected = oRsPages("Text")
										End If
										Response.Write ">"
										Response.Write oRsPages("Text")
										Response.Write "</option>" & VbCrLf
										oRsPages.MoveNext
									Wend
								End If
%>
								</select>
								&nbsp;
								<input type="Button" value="Go" onClick="javascript:changePageSelection();">
							</td>
						</tr>
						<tr bgcolor="#BBDDBB" align="left">
							<td><strong>B</strong></td>
							<td><strong>Find By Type of Text</strong></td>
							<td>
								<strong>Select Type of Text:</strong>
								<select name="TextTypeSelection" size="1" onChange="javascript:changeTextTypeSelection();">
<%
								If intRsTextTypesErrorCode < 1 Then
									oRsTextTypes.MoveFirst
									While Not oRsTextTypes.EOF
										Response.Write VbTab & "<option value=""" & oRsTextTypes("TextTypeID") & """"
										If CInt(oRsTextTypes("TextTypeID")) = CInt(intTextTypeID) Then
											Response.Write " selected "
											strTextTypeSelected = oRsTextTypes("Name")
										End If
										Response.Write ">"
										Response.Write oRsTextTypes("Name")
										Response.Write "</option>" & VbCrLf
										oRsTextTypes.MoveNext
									Wend
								End If
%>
								</select>
								&nbsp;
								<input type="Button" value="Go" onClick="javascript:changeTextTypeSelection();">
							</td>
						</tr>
						<tr bgcolor="#DDBBBB" align="left">
							<td><strong>C</strong></td>
							<td><strong>Find Exceptions</strong></td>
							<td>
								<strong>Select Type of Exceptions to Find:</strong>
								<select name="ExceptionSelection" size="1" onChange="javascript:changeTextExceptionsSelection();">
									<option value="1"
									<%
									If intTextExceptionID = 1 Then
										Response.Write " selected"
										strExceptionNameSelected = "All Text NOT Translated in this Language"
									End If
									%>>All Text NOT Translated in this Language</option>
									<option value="2"
									<%
									If intTextExceptionID = 2 Then
										Response.Write " selected "
										strExceptionNameSelected = "All Text Translated by Someone Other Than Me"
									End If %>>All Text Translated by Someone Other Than Me</option>
									<option value="3"
									<%
									If intTextExceptionID = 3 Then
										Response.Write " selected "
										strExceptionNameSelected = "All Text Translated by Automated Technology Only"
									End If %>>All Text Translated by Automated Technology Only</option>
								</select>
								&nbsp;
								<input type="Button" value="Go" onClick="javascript:changeTextExceptionsSelection();">
							</td>
						</tr>
						<tr bgcolor="#BBDDDD" align="left">
							<td><strong>+</strong></td>
							<td><strong>Find Text By Search</strong></td>
							<td>
								<strong>Enter Text to Find:</strong>
								<input type="text" name="SearchText" maxlength="500" size="30" value="<%=strText%>">
								<input type="button" name="searchIt" value="Find" onClick="javascript:goSearchText();">
							</td>
						</tr>
						<tr bgcolor="#DDBBDD" align="left">
							<td><strong>+</strong></td>
							<td width="80"><strong>Alphabetic Text Search</strong></td>
							<td width="600">
								<strong>Click a letter below to display all text beginning with that letter:</strong>
								<br><br>
								<input type="button" value="A" onClick="alphaSearch('A');">
								<input type="button" value="B" onClick="alphaSearch('B');">
								<input type="button" value="C" onClick="alphaSearch('C');">
								<input type="button" value="D" onClick="alphaSearch('D');">
								<input type="button" value="E" onClick="alphaSearch('E');">
								<input type="button" value="F" onClick="alphaSearch('F');">
								<input type="button" value="G" onClick="alphaSearch('G');">
								<input type="button" value="H" onClick="alphaSearch('H');">
								<input type="button" value="I" onClick="alphaSearch('I');">
								<input type="button" value="J" onClick="alphaSearch('J');">
								<input type="button" value="K" onClick="alphaSearch('K');">
								<input type="button" value="L" onClick="alphaSearch('L');">
								<input type="button" value="M" onClick="alphaSearch('M');">
								<input type="button" value="N" onClick="alphaSearch('N');">
								<input type="button" value="O" onClick="alphaSearch('O');">
								<input type="button" value="P" onClick="alphaSearch('P');">
								<input type="button" value="Q" onClick="alphaSearch('Q');">
								<input type="button" value="R" onClick="alphaSearch('R');">
								<input type="button" value="S" onClick="alphaSearch('S');">
								<input type="button" value="T" onClick="alphaSearch('T');">
								<input type="button" value="U" onClick="alphaSearch('U');">
								<input type="button" value="V" onClick="alphaSearch('V');">
								<input type="button" value="W" onClick="alphaSearch('W');">
								<input type="button" value="X" onClick="alphaSearch('X');">
								<input type="button" value="Y" onClick="alphaSearch('Y');">
								<input type="button" value="Z" onClick="alphaSearch('Z');">
								<input type="button" value="All" onClick="alphaSearch('All');">
							</td>
						</tr>
					</table>
			</td>
		</tr>
		<tr>
			<td align="center">
<%
	Response.Write "<h1>Search Results</h1>"
	If isSubmitted Then
		Response.Write "<h2><strong>" & intRsTextCount & "</strong> Pieces of Text Found</h2>"
		Select Case strSearchMode
			Case "Alpha"
				Response.Write "<strong>Displaying all Text beginning with the character '" & strAlphaCharacter & "'</strong>"
			Case "Search"
				Response.Write "<strong>Displaying all Text containing the string '" & strText & "'</strong>"
			Case "TextType"
				Response.Write "<strong>Displaying all Text of the Type '" & strTextTypeSelected & "'</strong>"
			Case "Page"
				Response.Write "<strong>Displaying all Text from the Page '" & strPageNameSelected & "'</strong>"
			Case "Exceptions"
				Response.Write "<strong>Displaying all Text of Exception Type '" & strExceptionNameSelected & "'</strong>"
			Case Else
				
		End Select
		
		If strErrorMessage <> "" Then
			Response.Write "<br><br><span class=""required"">" & strErrorMessage & "</span>"
		End If
		
		If isDebugOn Then
			Response.Write "<br>ErrorCode=" & intRsTextErrorCode
			Response.Write "<br>strAlphaCharacter = " & strAlphaCharacter
			Response.Write "<br>strText = " & strText
		End If
		
		If intRsTextErrorCode < 1 And Not oRsText.EOF Then
			Response.Write "<br><br>" & VbCrLf
			Response.Write "<table width=""95%"" border=""1"" cellpadding=""6"" cellspacing=""1"">" & VbCrLf
			Response.Write "	<tr>" & VbCrLf
			Response.Write "		<td colspan=""6"" bgcolor=""#DDDDFF"">" & VbCrLf
			Response.Write "			<span class=""step"">Step 3 (Click Text Link to Translate)</span>" & VbCrLf
			Response.Write "		</td>" & VbCrLf
			Response.Write "	</tr>" & VbCrLf
			Response.Write "	<tr bgcolor=""#DDBBBB"">" & VbCrLf
			Response.Write "		<td><strong>ID</strong></td>"
			Response.Write "		<td><strong>English</strong></td>"
			Response.Write "		<td><strong>" & strSelectedLanguageName & "</strong></td>"
			Response.Write "		<td><strong>Translation Method</strong></td>"
			Response.Write "		<td><strong>Date Entered</strong></td>"
			Response.Write "		<td><strong>Date Translated</strong></td>"
			Response.Write "	</tr>"
			oRsText.MoveFirst
			intAlt = 0
			While Not oRsText.EOF
				If intAlt = 1 Then
					intAlt = 0
					Response.Write "	<tr bgcolor=""#CCFFFF"">" & VbCrLf
				Else
					intAlt = 1
					Response.Write "	<tr bgcolor=""#CCCCFF"">" & VbCrLf
				End If
				Response.Write "		<td align=""left"">" & oRsText("TextID") & "</td>" & VbCrLf
				Response.Write "		<td align=""left"">"
				Response.Write "<a href=""javascript:goTranslate(" & oRsText("TextID") & ");"">"
				Response.Write oRsText("TextEnglish")
				Response.Write "</a> </td>" & VbCrLf
				Response.Write "		<td align=""left"">" & oRsText("TextLanguage") & "&nbsp;</td>" & VbCrLf
				Response.Write "		<td align=""left"">" & oRsText("TranslationMethod") & "&nbsp;</td>" & VbCrLf
				Response.Write "		<td align=""left"">" & oRsText("DateEntered") & "&nbsp;</td>" & VbCrLf
				Response.Write "		<td align=""left"">" & oRsText("DateTranslated") & "&nbsp;</td>" & VbCrLf

				Response.Write "	</tr>" & VbCrLf
				oRsText.MoveNext
			Wend
			Response.Write "</table>" & VbCrLf
		Else
			Response.Write "<br><br><span class=""required""><strong>No text was found that matches your criteria.</strong></span>" & VbCrLf
		End If
	Else
		Response.Write "<strong>Make your selection above to display search results</strong>" & VbCrLf
	End If
%>
		<br><br>
			</td>
		</tr>

	</table>
	</div>
	</form>
</body>
</html>
<%
' Close and Deallocate Recordsets and Objects
	oConn.Close
	Set oConn = Nothing
	Set oCmd = Nothing
	oRsPages.Close
	Set oRsPages = Nothing
	oRsLanguages.Close
	Set oRsLanguages = Nothing
	Set oRsTextTypes = Nothing
	Set oRsText = Nothing
%>
