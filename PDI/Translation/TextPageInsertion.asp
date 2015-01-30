<%@ Language=VBScript Codepage = 65001 %>
<%
' Set initial critical page parameters
	Response.Buffer = True
'	On Error Resume Next
	intPageID = 4	' TextSearchList Page
%>
<!-- #Include virtual = "PDI/Include/Common.asp" -->
<!-- #Include virtual = "PDI/Include/ADOVBS.asp" -->
<%
' Declare Internal Variables (alphabetical)
	Dim blnFormError
	Dim intAlt
	Dim intExistingText
	Dim intExistingTextText
	Dim intExistingTextText2
	Dim intExistingTextText3
	Dim intPageSelectID
	Dim intRsLanguagesErrorCode
	Dim intRsTextCount
	Dim intRsTextErrorCode
	Dim intRsTextTypesErrorCode
	Dim intTextExceptionID
	Dim intTextTypeID
	Dim isDebugOn
	Dim blnSubmitted
	Dim oConn
	Dim oCmd
	Dim oRs
	Dim strAlpha
	Dim strAlphaCharacter
	Dim strAlternateProposedTextName
	Dim strErrorMessage
	Dim strFormErrorMessage
	Dim strSelectedLanguageName
	Dim strPageName
	Dim strPageNameSelected
	Dim strProposedTextName
	Dim strRsLanguagesErrorMessage
	Dim strRsTextErrorMessage
	Dim strRsTextTypesErrorMessage
	Dim strSearchMode
	Dim strText
	Dim strTextTypeSelected

' Set Initial Values for Internal Variables
	blnFormError = False
	isDebugOn = False
	'isDebugOn = True
	
	intPageSelectID = Request.Form("PageSelection")
	If intPageSelectID = "" Then
		blnFormError = True
		strFormErrorMessage = "Page Selection Not Available"
	Else
		intPageSelectID = CInt(intPageSelectID)
	End If
	
	intTextTypeID = Request.Form("TextTypeSelection")
	If intTextTypeID = "" Then
		blnFormError = True
		strFormErrorMessage = "Text Type was not Selected"
	Else
		intTextTypeID = CInt(intTextTypeID)
	End If
	
	strTextEnglish = Request.Form("TextEnglish")
	If strTextEnglish = "" Then
		blnFormError = True
		strFormErrorMessage = "English Text not Available"
	End If
	
	strProposedTextName = Request.Form("ProposedTextName")
	If strProposedTextName = "" Then
		blnFormError = True
		strFormErrorMessage = "Proposed Text Name Not Available"
	End If
	
	strAlternateProposedTextName = Request.Form("AlternateProposedTextName")
	If strAlternateProposedTextName = "" Then
		blnFormError = True
		strFormErrorMessage = "Alternate Proposed Text Name Not Available"
	End If
	
	intLanguage2ID = Request.Form("LanguageSelection2")
	If intLanguage2ID = "" Then
		blnFormError = True
		strFormErrorMessage = "Language Selection 2 Not Available"
	Else
		intLanguage2ID = Cint(intLanguage2ID)
	End If
	
	strText2 = Request.Form("TextLanguage2")
	
	intLanguage3ID = Request.Form("LanguageSelection3")
	If intLanguage3ID = "" Then
		blnFormError = True
		strFormErrorMessage = "Language Selection 3 Not Available"
	Else
		intLanguage3ID = CInt(intLanguage3ID)
	End If
	
	strText3 = Request.Form("TextLanguage3")
	
	blnSubmitted = Request.Form("isSubmitted")
	If blnSubmitted = "1" Or blnSubmitted = "99" Then
		blnSubmitted = True
	Else
		blnSubmitted = False
	End If
	strAlphaCharacter = Request.Form("strAlphaCharacter")
	strErrorMessage = Request.QueryString("isSuccess")
	strPageName = "TextSearchList.asp"
	strText = Request.Form("strText")
	If strText = "" Then
		strText = Request.Form("SearchText")
	End If
	strSearchMode = Request.Form("strSearchMode")

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

If intUserID = "" Then
	intUserID = Request.Cookies("UserID")
End If

'Response.Write "<br>UserID = '" & intUserID & "'"
'Response.Write "<br>@strProposedTextName = '" & strProposedTextName & "'"
'Response.Write "<br>@strAlternateProposedTextName = '" & strAlternateProposedTextName & "'"
'Response.Write "<br>exec spTextPageInsertion " & intUserID & ", " & intPageSelectID & ", " & intTextTypeID & ", '" & strTextEnglish & "', '" & strProposedTextName & "', '" & strAlternateProposedTextName & "', " & intLanguage2ID & ", '" & strText2 & "', " & intLanguage3ID & ", '" & strText3 & "', 'TestPageInsertion.asp', Null, 0, 0, 0, 0, 0, Null"

' Perform the search against the database
	If blnSubmitted Then
		' Remove Double Quote and replace with Single Quote (tick mark)
			strTextEnglish = Replace(strTextEnglish, chr(34), "'")
			strText2 = Replace(strText2, chr(34), "'")
			strText3 = Replace(strText3, chr(34), "'")
		' Remove Line Feed from text
			strTextEnglish = Replace(strTextEnglish, chr(10), "")
			strText2 = Replace(strText2, chr(10), "")
			strText3 = Replace(strText3, chr(10), "")
		' Remove Carriage Return from text
			strTextEnglish = Replace(strTextEnglish, chr(13), "")
			strText2 = Replace(strText2, chr(13), "")
			strText3 = Replace(strText3, chr(13), "")
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRsText = CreateObject("ADODB.Recordset")
			With oCmd
			.CommandText = "spTextPageInsertion"
			.CommandType = 4
			' Input parameters
				.Parameters.Append .CreateParameter("@intUserID", adInteger, adParamInput, 4, intUserID)
				.Parameters.Append .CreateParameter("@intPageSelectID", adInteger, adParamInput, 4, intPageSelectID)
				.Parameters.Append .CreateParameter("@intTextTypeID", adInteger, adParamInput, 4, intTextTypeID)
				.Parameters.Append .CreateParameter("@strTextEnglish", adVarWChar, adParamInput, 4000, strTextEnglish)
				.Parameters.Append .CreateParameter("@strProposedTextName", adVarWChar, adParamInput, 100, strProposedTextName)
				.Parameters.Append .CreateParameter("@strAlternateProposedTextName", adVarWChar, adParamInput, 100, strAlternateProposedTextName)
				.Parameters.Append .CreateParameter("@intLanguage2ID", adInteger, adParamInput, 4, intLanguage2ID)
				.Parameters.Append .CreateParameter("@strText2",  adVarWChar, adParamInput, 4000, strText2)
				.Parameters.Append .CreateParameter("@intLanguage3ID", adInteger, adParamInput, 4, intLanguage3ID)
				.Parameters.Append .CreateParameter("@strText3",  adVarWChar, adParamInput, 4000, strText3)
				.Parameters.Append .CreateParameter("@strCallingPageName",  adVarChar, adParamInput, 100, "TestPageInsertion.asp")
		    ' Output parameters
				.Parameters.Append .CreateParameter("@strTextName", adVarWChar, adParamOutput, 100, Null)
				.Parameters.Append .CreateParameter("@intExistingText", adInteger, adParamOutput, 4, Null)
				.Parameters.Append .CreateParameter("@intTextID", adInteger, adParamOutput, 4, Null)
				.Parameters.Append .CreateParameter("@intExistingTextText", adInteger, adParamOutput, 4, Null)
				.Parameters.Append .CreateParameter("@intTextTextID", adInteger, adParamOutput, 4, Null)
				.Parameters.Append .CreateParameter("@intExistingTextText2", adInteger, adParamOutput, 4, Null)
				.Parameters.Append .CreateParameter("@intTextText2ID", adInteger, adParamOutput, 4, Null)
				.Parameters.Append .CreateParameter("@intExistingTextText3", adInteger, adParamOutput, 4, Null)
				.Parameters.Append .CreateParameter("@intTextText3ID", adInteger, adParamOutput, 4, Null)
			    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, Null)
			    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 500, Null)
		End With
		oConn.Open Application("strDbConnString")
		oCmd.ActiveConnection = oConn
		oRsText.CursorLocation = adOpenStatic
		oRsText.Open oCmd, , adOpenForwardOnly, adOpenKeyset
		intRsTextErrorCode = oCmd.Parameters("@intErrorCode").value
		strRsTextErrorMessage = oCmd.Parameters("@strErrorMessage").value
		If intRsTextErrorCode > 0 Then
			strErrorMessage = strRsTextErrorMessage
			Response.Write "<BR><BR>" & strRsTextErrorMessage & "<BR><BR>"
		Else
			strTextName = oCmd.Parameters("@strTextName").value
			intTextID = oCmd.Parameters("@intTextID").value
			intExistingText = oCmd.Parameters("@intExistingText").value
			intTextTextID = oCmd.Parameters("@intTextTextID").value
			intExistingTextText = oCmd.Parameters("@intExistingTextText").value
			intTextTextID2 = oCmd.Parameters("@intTextText2ID").value
			intExistingTextText2 = oCmd.Parameters("@intExistingTextText2").value
			intTextTextID3 = oCmd.Parameters("@intTextText3ID").value
			intExistingTextText3 = oCmd.Parameters("@intExistingTextText3").value
			intErrorCode = oCmd.Parameters("@intErrorCode").value
			strErrorMessage = oCmd.Parameters("@strErrorMessage").value
		End If
	End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Page Text Insertion</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="Default.css" type="text/css">
	<!-- #Include virtual = "PDI/Include/HeadStuff.asp" -->

	<script language="JavaScript">
	<!--
		function TitleCase(strString) {
			// This function capitalizes the first character of every word
			// appearing in the string.
			window.status = strString;
			var htext
			var nhtext;
			var htext = strString;
			htext = htext.toLowerCase();
			// Just in case they're all caps.
			j = htext.length;
			nhtext = "";
			for(i=0; i<j; i++) {
			 	if(i == 0) {
					// To capitalize the first character.
					nhtext = nhtext + htext.substr(i,1).toUpperCase();
				}
				else if(htext.charAt(i) == " ") {
					// Checks for the appearance of the space character.
					nhtext = nhtext + htext.substr(i,1);
					// Adds that space character to the string.
					nhtext = nhtext + htext.substr(++i,1).toUpperCase();
					// Capitalizes and adds the next character to the
					// string.
				} else if(htext.charAt(i) == " ") {
					// Checks for the appearance of the newline character.
					nhtext = nhtext + htext.substr(i,1);
					// Adds the newline character to the string.
					nhtext = nhtext + htext.substr(++i,1).toUpperCase();
					// Capitalizes and adds the next character to the
					// string.
				} else {
					nhtext = nhtext + htext.substr(i,1);
					// Adds the character in a normal way.
				}
			}
			return nhtext;
		}

		function RemoveSpaces(string) {
			var temp = "";
			string = '' + string;
			splitstring = string.split(" ");
			for(i = 0; i < splitstring.length; i++)
			temp += splitstring[i];
			return temp;
		}

		function CreateProposedTextName() {
			// Get string value
			var strTempText = document.FormChooser.TextEnglish.value;
			// Convert string to Title Case
			var strTempText2 = TitleCase(strTempText);
			// Remove spaces from string
			var strTempText3 = RemoveSpaces(strTempText2);
			// Remove non-alphanumeric characters
			var strTempText4 = strTempText3.replace(/[^a-zA-Z 0-9]+/g,'');
			// Get first 100 characters for alternate proposed text name
			document.FormChooser.AlternateProposedTextName.value = strTempText4.substring(strTempText4, 100);
			// Get first 30 characters
			document.FormChooser.ProposedTextName.value = strTempText4.substring(strTempText4, 30);
		}

		function SubmitIt() {
			if (document.FormChooser.ProposedTextName.value.length < 1) {
				CreateProposedTextName();
			}
			document.FormChooser.submit();
		}

	-->
	</script>
</head>
<body bgcolor="#ffffff">
<%
If isDebugOn Then
	Response.Write "<br>@strTextName = " & strTextName
	Response.Write "<br>@intTextID = " & intTextID
	Response.Write "<br>@intTextTextID = " & intTextTextID
	Response.Write "<br>@intTextTextID2 = " & intTextTextID2
	Response.Write "<br>@intTextTextID3 = " & intTextTextID3
	Response.Write "<br>@intErrorCode = " & intErrorCode
	Response.Write "<br>@strErrorMessage = " & strErrorMessage
	Response.Write "<br><br><br>"

	Response.Write "<br>Declare @strTextName NVarChar(100)"
	Response.Write "<br>Declare @intTextID Int"
	Response.Write "<br>Declare @intTextTextID Int"
	Response.Write "<br>Declare @intTextText2ID Int"
	Response.Write "<br>Declare @intTextText3ID Int"
	Response.Write "<br>Declare @intErrorCode Real"
	Response.Write "<br>Declare @strErrorMessage VarChar(500)"
	Response.Write "<br>Set @strTextName = Null"
	Response.Write "<br>Set @intTextID = Null"
	Response.Write "<br>Set @intTextTextID = Null"
	Response.Write "<br>Set @intTextText2ID = Null"
	Response.Write "<br>Set @intTextText3ID = Null"
	Response.Write "<br>Set @intErrorCode = Null"
	Response.Write "<br>Set @strErrorMessage = Null"
	Response.Write "<br>exec spTextPageInsertion " & intUserID & ", " & intPageSelectID & ", " & intTextTypeID & ", '" & strTextEnglish & "', '" & strProposedTextName & "', '" & strAlternateProposedTextName & "', " & intLanguage2ID & ", '" & strText2 & "', " & intLanguage3ID & ", '" & strText3 & "', '" & strCallingPageName & "', @strTextName output, @intTextID output, @intTextTextID output, @intTextText2ID output, @intTextText3ID output, @intErrorCode output, @strErrorMessage output"
	Response.Write "<br>Select @strTextName , @intTextID, @intTextTextID, @intTextText2ID, @intTextText3ID, @intErrorCode, @strErrorMessage"
End If
%>

	<div align="center">
	<span class="title">Add Text to a Page</span>
	<br><br>
	<form name="FormChooser" method="post">
	<input type="hidden" name="isSubmitted" value="1">
	<input type="hidden" name="intTranslationLanguageID">
	<input type="hidden" name="intTextTypeID">
	<input type="hidden" name="intPageSelectID">
	<input type="hidden" name="intTextID">
	<input type="hidden" name="AlternateProposedTextName">
	<table class="ThinTable" width="95%" border="0" cellpadding="5" cellspacing="1">
		<tr>
			<td align="right">
				<strong>Select Page to which to Add Text:</strong>
			</td>
			<td align="left">
				<select name="PageSelection" size="1">
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
						Response.Write oRsPages("Text") & " (" & oRsPages("PageID") & ")"
						Response.Write "</option>" & VbCrLf
						oRsPages.MoveNext
					Wend
				End If
%>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">
				<strong>Select Type of Text:</strong>
			</td>
			<td align="left">
				<select name="TextTypeSelection" size="1">
<%
				If intRsTextTypesErrorCode < 1 Then
					oRsTextTypes.MoveFirst
					While Not oRsTextTypes.EOF
						Response.Write VbTab & "<option value=""" & oRsTextTypes("TextTypeID") & """"
						If oRsTextTypes("Name") = "Static Text" Then
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
			</td>
		</tr>
		<tr>
			<td align="right">
				<strong>Enter Text in English</strong>
			</td>
			<td align="left">
				<textarea cols="65" rows="6" name="TextEnglish" id="TextEnglish" onBlur="CreateProposedTextName()"></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">
				<strong>Proposed Name for Text:</strong>
			</td>
			<td align="left">
				<input type="text" name="ProposedTextName" id="TextName" size="65" maxlength="100">
			</td>
		</tr>
		<tr>
			<td align="right">
				<strong>Select Language for Translation:</strong>
				<select name="LanguageSelection2" size="1">
<%
				If intRsLanguagesErrorCode < 1 Then
					oRsLanguages.MoveFirst
					While Not oRsLanguages.EOF
						If oRsLanguages("LanguageID") <> 1 Then
							Response.Write VbTab & "<option value=""" & oRsLanguages("LanguageID") & """"
							If CInt(oRsLanguages("LanguageID")) = CInt(intLanguage2ID) Then
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
			<td>
				<textarea cols="65" rows="6" name="TextLanguage2" id="TextLanguage2"></textarea>
			<td align="left">
		</tr>	
		<tr>
			<td align="right">
				<strong>Select Language for Translation:</strong>
				<select name="LanguageSelection3" size="1">
<%
				If intRsLanguagesErrorCode < 1 Then
					oRsLanguages.MoveFirst
					While Not oRsLanguages.EOF
						If oRsLanguages("LanguageID") <> 1 Then
							Response.Write VbTab & "<option value=""" & oRsLanguages("LanguageID") & """"
							If CInt(oRsLanguages("LanguageID")) = CInt(intLanguage3ID) Then
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
			<td>
				<textarea cols="65" rows="6" name="TextLanguage3" id="TextLanguage3"></textarea>
			<td align="left">
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="Submit" onClick="javascript:SubmitIt();">
			</td>
		</tr>
	</table>
	<table class="ThinTable" width="95%" border="0" cellpadding="5" cellspacing="1">
		<tr>
			<td>
<%
	Response.Write "<p align = ""left""><h1>Previous Results</h1></p>"
	If blnSubmitted Then
		If strErrorMessage <> "" Then
			Response.Write "<p align = ""left""><span class=""required"">" & strErrorMessage & "</span></p>" & VbCrLf
		Else
			If intExistingText = 0 Then
				Response.Write "<p align = ""left"">The text was inserted as: " & strTextName & "</p>" & VbCrLf
			Else
				Response.Write "<p align = ""left""><i>Text was already in database as: " & strTextName & "</i></p>" & VbCrLf
			End If
			If intExistingText = 0 Then
				Response.Write "<p align = ""left"">Your text was assigned TextID: " & intTextID & "</p>" & VbCrLf
			Else
				Response.Write "<p align = ""left"">The Text you entered was already in the database as TextID: " & intTextID & ".</p>" & VbCrLf
			End If
			If intExistingTextText = 0 Then
				Response.Write "<p align = ""left"">The English Text you entered was assigned TextTextID: " & intTextTextID & "</p>" & VbCrLf
			Else
				Response.Write "<p align = ""left"">The English Text you entered was already in the database as TextTextID: " & intTextTextID & ".</p>" & VbCrLf
			End If
			If Len(strText2) > 0 Then
				If intExistingTextText2 = 0 Then
					Response.Write "<p align = ""left"">The second language Text you entered was TextTextID2: " & intTextTextID2 & "</p>" & VbCrLf
				Else
					Response.Write "<p align = ""left"">The Second Language Text you entered was already in the database as TextTextID: " & intTextTextID2 & ".</p>" & VbCrLf
				End If
			Else
				Response.Write "<p align = ""left"">You did not enter text for the second language</p>" & VbCrLf
			End If
			If Len(strText3) > 0 Then
				If intExistingTextText3 = 0 Then
					Response.Write "<p align = ""left"">The third language text you entered was assigned TextTextID: " & intTextTextID3 & "</p>" & VbCrLf
				Else
					Response.Write "<p align = ""left"">The Third Language Text you entered was already in the database as TextTextID: " & intTextTextID3 & ".</p>" & VbCrLf
				End If
			Else
				Response.Write "<p align = ""left"">You did not enter text for the third language</p>" & VbCrLf
			End If
		End If
	End If
%>
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
