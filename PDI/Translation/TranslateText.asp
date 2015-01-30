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
	Dim intCurrentTextID
	Dim intNextTextID
	Dim intPageSelectID
	Dim	intPreviousTextID
	Dim intRowCountEnglish
	Dim intRowCountLanguage
	Dim intRsLanguagesErrorCode
	Dim intRsTextCount
	Dim intRsTextErrorCode
	Dim intRsTextTypesErrorCode
	Dim intTextExceptionID
	Dim intTextTypeID
	Dim intTranslationStorageErrorCode
	Dim isDebugOn
	Dim isSubmitted
	Dim oConn
	Dim oCmd
	Dim oRs
	Dim strAlpha
	Dim strAlphaCharacter
	Dim strErrorMessage
	Dim strExceptionNameSelected
	Dim strPageName
	Dim strPageNameSelected
	Dim strRsLanguagesErrorMessage
	Dim strRsTextErrorMessage
	Dim strRsTextTypesErrorMessage
	Dim strSearchMode
	Dim strSelectedLanguageName
	Dim strText
	Dim strTextLanguage
	Dim strTextTypeSelected
	Dim strTranslatedText
	Dim strTranslationStorageErrorMessage

' Set Initial Values for Internal Variables
	' Get LanguageID Value
		If intTranslationLanguageID = "" Then
			intTranslationLanguageID = Request.Form("intTranslationLanguageID")
		End If
		If intTranslationLanguageID = "" Then
			intTranslationLanguageID = 1
		Else
			intTranslationLanguageID = CInt(intTranslationLanguageID)
		End If
	' Get TextExceptionID Value
		intTextExceptionID = Request.Form("intTextExceptionID")
	' Get PageSelectID Value
		intPageSelectID = Request.form("intPageSelectID")
		If intPageSelectID = "" Then
			intPageSelectID = Request.Form("intPageSelectID")
		End If
		If intPageSelectID = "" Then
			intPageSelectID = 1
		Else
			intPageSelectID = CInt(intPageSelectID)
		End If
	' Get TextID Value
		intTextID = Request.Form("intTextID")
	' Get TextTypeID Value
		intTextTypeID = Request.Form("intTextTypeID")
		If intTextTypeID = "" Then
			intTextTypeID = 1
		Else
			intTextTypeID = CInt(intTextTypeID)
		End If
	' Get TextExceptionID Value
		intTextExceptionID = Request.Form("intTextExceptionID")
		If intTextExceptionID = "" Then
			intTextExceptionID = 1
		Else
			intTextExceptionID = CInt(intTextExceptionID)
		End If
	' Get UserID Value
		intUserID = Request.Cookies("UserID")
		If intUserID <> "" Then
			intUserID = CLng(intUserID)
		Else
			intUserID = 1
		End If
	' Get Submitted Value
		isSubmitted = Request.Form("isSubmitted")
		If isSubmitted = "1" Then
			isSubmitted = True
		Else
			isSubmitted = False
		End If
	' Get strAlphaCharacter Value
		strAlphaCharacter = Request.Form("strAlphaCharacter")
		If strAlphaCharacter = "" Then
			strAlphaCharacter = Request.Form("strAlphaCharacter")
		End If
	' Get ErrorMsssage Value

		strErrorMessage = Request.QueryString("isSuccess")
	' Get PageName Value
		strPageName = "TextSearchList.asp"
	' Get Text Value
		strText = Request.Form("strText")
		If strText = "" Then
			strText = Request.Form("SearchText")
		End If

	' Get strSearchMode Value
		strSearchMode = Request.Form("strSearchMode")
		If strSearchMode = "" Then
			strSearchMode = Request.Form("strSearchMode")
		End If

' Display Debug Information, if applicable
	If isDebugOn Then
		Response.Write "<br>Exec spLanguagesSelectActive " & intResellerID & ", NULL, NULL"
		Response.Write "<br>Exec spTextTranslateAlphaSearch " & intUserID & ", " & intTranslationLanguageID & ", '" & strAlphaCharacter & "', '" & strPageName & "', 0, Null"
		Response.Write "<br>intTranslationLanguageID = " & intTranslationLanguageID
		Response.Write "<br>intTextExceptionID = " & intTextExceptionID
		Response.Write "<br>intPageSelectID = " & intPageSelectID
		Response.Write "<br>intTextID = " & intTextID
		Response.Write "<br>intTextTypeID = " & intTextTypeID
		Response.Write "<br>intTextExceptionID = " & intTextExceptionID
		Response.Write "<br>intUserID = " & intUserID
		Response.Write "<br>isSubmitted = " & isSubmitted
		Response.Write "<br>strAlphaCharacter = " & strAlphaCharacter
		Response.Write "<br>strErrorMessage = " & strErrorMessage
		Response.Write "<br>strPageName = " & strPageName
		Response.Write "<br>strText = " & strText
		Response.Write "<br>strSearchMode = " & strSearchMode
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
		Response.Write "<br>Exec spTextTranslationAlphaSearch " & intUserID & ", " & intTranslationLanguageID & ", '" & strAlphaCharacter & "', '" & strPageName & "', 0, Null"
	End If

' Perform the search against the database
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
					.Parameters.Append .CreateParameter("@intLanguageID", adInteger, adParamInput, 4, intTranslationLanguageID)
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
			.CommandText = "spTextTranslationPageSearch"
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

' Once the Translator presses submit, we need to save the changes in the database
If isSubmitted Then
	' Get submitted values for processing
		strTranslatedText = Request.Form("TranslatedText")
		' Remove Double Quote and replace with Single Quote (tick mark)
			strTranslatedText = Replace(strTranslatedText, chr(34), "'")
		' Remove Line Feed from text
			strTranslatedText = Replace(strTranslatedText, chr(10), "")
		' Remove Carriage Return from text
			strTranslatedText = Replace(strTranslatedText, chr(13), "")
		intPageSelectID = Request.Form("intPageSelectID")
		intPreviousTextID = Request.Form("intPreviousTextID")
		intCurrentTextID = Request.Form("intCurrentTextID")
		intNextTextID = Request.Form("intNextTextID")
		strSaveMode = Request.Form("strSaveMode")
		
	' Store data in database
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "spTextTranslationUpdateInsertion"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@intUserID", adInteger, adParamInput, 4, intUserID)
			.Parameters.Append .CreateParameter("@intLanguageID", adInteger, adParamInput, 4, intTranslationLanguageID)
			.Parameters.Append .CreateParameter("@intTextID", adInteger, adParamInput, 4, intCurrentTextID)
			.Parameters.Append .CreateParameter("@strTranslatedText", adVarWChar, adParamInput, 4000, strTranslatedText)
			.Parameters.Append .CreateParameter("@strCallingPageName", adVarChar, adParamInput, 50, strPageName)
			.Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
			.Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 255, Null)
		End With
		oConn.Open Application("strDbConnString")
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		intTranslationStorageErrorCode = oCmd.Parameters("@intErrorCode").value
		strTranslationStorageErrorMessage = oCmd.Parameters("@strErrorMessage").value
		If intTranslationStorageErrorCode = 0 Then
			' We successfully stored the translated text into the database, now what
			If strSaveMode = "List" Then
				' The user wants to return to the Search Results Listing page, so send them there via post form
				Response.Write "<html><body>" & VbCrLf
				Response.Write "<form name=""FormChooser"" method=""post"" action=""TextSearchList.asp"">" & VbCrLf
				Response.Write "<input type=""hidden"" name=""isSubmitted"" value=""99"">" & VbCrLf
				Response.Write "<input type=""hidden"" name=""intTranslationLanguageID"" value=""" & intTranslationLanguageID  & """>" & VbCrLf
				Response.Write "<input type=""hidden"" name=""intTextTypeID"" value=""" & intTextTypeID & """>" & VbCrLf
				Response.Write "<input type=""hidden"" name=""intTextExceptionID"" value=""" & intTextExceptionID & """>" & VbCrLf
				Response.Write "<input type=""hidden"" name=""strSearchMode"" value=""" & strSearchMode & """>" & VbCrLf
				Response.Write "<input type=""hidden"" name=""strAlphaCharacter"" value=""" & strAlphaCharacter & """>" & VbCrLf
				Response.Write "<input type=""hidden"" name=""strText"" value=""" & strText & """>" & VbCrLf
				Response.Write "<input type=""hidden"" name=""intPageSelectID"" value=""" & intPageSelectID & """>" & VbCrLf
				Response.Write "<input type=""hidden"" name=""strSuccessMessage"" value=""Your translation was successfully stored in the database. Thank you."">" & VbCrLf
				Response.Write "</form>" & VbCrLf
				Response.Write "<script language=""JavaScript"">" & VbCrLf
				Response.Write "document.FormChooser.submit();" & VbCrLf
				Response.Write "</script>" & VbCrLf
				Response.Write "</body></html>" & VbCrLf
			Else
				' Otherwise, go ahead and continue processing this page
				' We need to switch the current TextID value to the previous or next one depending upon the User's selection
				If strSaveMode = "Previous" Then
					' Go to the previous record in the Search Results recordset from the previous page
					intTextID = intPreviousTextID
				Else
					' Go to the next record in the Search Results recordset from the previous page
					intTextID = intNextTextID
				End If
			End If
		End If
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Text Translation Alphabetical List</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="Default.css" type="text/css">
	<!--#Include virtual="/pdi/include/HeadStuff.asp" -->

	<script language="JavaScript">
	<!--
		function getValues () {
			' Get all of the dropdown values with any change so that those values are always preserved '
			' Get Language Selection Values '
				val = document.FormChooser.LanguageSelection.options[document.FormChooser.LanguageSelection.selectedIndex].value;
				var expDate = new Date();
				expDate.setDate(expDate.getDate( ) + 365);
				document.cookie = 'LanguageID=' + val + '; expires=' + expDate.toGMTString( ) + ';';
				document.FormChooser.intTranslationLanguageID.value = val;
			' Get Page Selection Values '
				val = document.FormChooser.PageSelection.options[document.FormChooser.PageSelection.selectedIndex].value;
				document.FormChooser.intPageSelectID.value = val;
			' Get TextType Selection Values '
				val = document.FormChooser.TextTypeSelection.options[document.FormChooser.TextTypeSelection.selectedIndex].value;
				document.FormChooser.intTextTypeID.value = val;
			' Get Exceptions Selection Values '
				val = document.FormChooser.ExceptionSelection.options[document.FormChooser.ExceptionSelection.selectedIndex].value;
				document.FormChooser.intTextExceptionID.value = val;
			' Get Search Text Values '
				document.FormChooser.strText.value = document.FormChooser.SearchText.value;
			' Get SearchMode '
				document.FormChooser.strSearchMode.value = "<%=strSearchMode%>";
			' Get AlphaCharacter '
				document.FormChooser.strAlphaCharacter.value = "<%=strAlphaCharacter%>";
			' Get Text '
				document.FormChooser.strText.value = "<%=strText%>";
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

		function goPrevious (currentTextID, previousTextID) {
			getValues();
			document.FormChooser.strSaveMode.value = "Previous";
			document.FormChooser.intPreviousTextID.value = previousTextID;
			document.FormChooser.intCurrentTextID.value = currentTextID;
			document.FormChooser.isSubmitted.value = 1;
			document.FormChooser.action = "TranslateText.asp"
			document.FormChooser.submit();
		}

		function goList (currentTextID) {
			getValues();
			document.FormChooser.strSaveMode.value = "List";
			document.FormChooser.intCurrentTextID.value = currentTextID;
			document.FormChooser.isSubmitted.value = 1;
			document.FormChooser.action = "TranslateText.asp"
			document.FormChooser.submit();
		}

		function goNext (currentTextID, nextTextID) {
			getValues();
			document.FormChooser.strSaveMode.value = "Next";
			document.FormChooser.intCurrentTextID.value = currentTextID;
			document.FormChooser.intNextTextID.value = nextTextID;
			document.FormChooser.isSubmitted.value = 1;
			document.FormChooser.action = "TranslateText.asp"
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
	<input type="hidden" name="strSearchMode">
	<input type="hidden" name="strAlphaCharacter">
	<input type="hidden" name="strText">
	<input type="hidden" name="intPageSelectID">
	<input type="hidden" name="intPreviousTextID">
	<input type="hidden" name="intCurrentTextID">
	<input type="hidden" name="intNextTextID">
	<input type="hidden" name="strSaveMode">
	
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
' Itterate through the recordset until we find the requested TextID record
' We also need to get the previous and next record IDs
	If Not oRsText.EOF Then
		oRsText.MoveFirst
		intPreviousTextID = 0
		intCount = 1
		Do While Not oRsText.EOF And (CInt(oRsText("TextID")) <> CInt(intTextID))
			intCount = intCount + 1
			intPreviousTextID = CInt(oRsText("TextID"))
			oRsText.MoveNext
		Loop
		If intCount = 1 Then
			' This was the first record in the recordset, so there was no previous one
			intPreviousTextID = 0
		End If
		intCurrentTextID = CInt(oRsText("TextID"))
		If intRsTextCount = intCount Then
			' The user selected the end record in the recordset
			intNextTextID = 0
		Else
			oRsText.MoveNext
			intNextTextID = CInt(oRsText("TextID"))
			oRsText.MovePrevious
		End If
	End If
	
	Response.Write "<h1>Please translate the English text into " & strSelectedLanguageName & " in the box below</h1>" & VbCrLf
	Response.Write "<h2><strong>Editing Text #" & intCount & " of " & intRsTextCount & "</strong> from Search Results</h2>" & VbCrLf
	Response.Write "<br><strong>English" & "</strong>" & VbCrLf
	Response.Write "<br><textarea cols=""80"" rows="""
	intRowCountEnglish = CInt(len(oRsText("TextEnglish")) / 60)
	Response.Write intRowCountEnglish + 1
	Response.Write """ name=""TextEnglish"">" & oRsText("TextEnglish") & "</textarea>" & VbCrLf
	Response.Write "<br><br>" & VbCrLf
	Response.Write "<br><strong>" & strSelectedLanguageName & "</strong>" & VbCrLf
	Response.Write "<br><textarea name=""TranslatedText"" cols=""80"" rows="""
	intRowCountLanguage = CInt(len(oRsText("TextLanguage")) / 60)
	If intRowCountLanguage = 0 Then
		intRowCountLanguage = intRowCountEnglish
	End If
	Response.Write intRowCountLanguage + 1
	Response.Write """ name=""TextLanguage"">" & oRsText("TextLanguage") & "</textarea>" & VbCrLf
	' Show Navigation Buttons
	Response.Write "<br><br>" & VbCrLf
		If intPreviousTextID > 0 Then
			Response.Write "<input type=""button"" name=""PreviousButton"" value=""Save & Go Previous""  onClick=""javascript:goPrevious("  & intCurrentTextID & "," & intPreviousTextID & ");"" onMouseOver=""javascript:window.status='Click to save this translation and go to the previous text in the results list';return true"" onMouseOut=""javascript:window.status='';return true"">" & VbCrLf
		End If
		Response.Write "<input type=""button"" name=""SaveButton"" value=""Save & Go List""  onClick=""javascript:goList("  & intCurrentTextID & ");"" onMouseOver=""javascript:window.status='Click to save this translation and return to the results listing';return true"" onMouseOut=""javascript:window.status='';return true"">" & VbCrLf
		If intNextTextID > 0 Then
			Response.Write "<input type=""button"" name=""NextButton"" value=""Save & Go Next""  onClick=""javascript:goNext("  & intCurrentTextID & "," & intNextTextID & ");"" onMouseOver=""javascript:window.status='Click to save this translation and go to the next text in the results list';return true"" onMouseOut=""javascript:window.status='';return true"">" & VbCrLf
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
	oRsLanguages.Close
	oRsPages.Close
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRsPages = Nothing
	Set oRsLanguages = Nothing
	Set oRsTextTypes = Nothing
	Set oRsText = Nothing
%>
