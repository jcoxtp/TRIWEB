<%
'****************************************************
'
' Name:		Utility_inc.asp Server-Side Include
' Purpose:		Provides general functions for use throughout the application
'
' Author:	      Ultimate Software Designs
' Date Written:	6/18/2002
' Modified:		
'
' Changes:
'****************************************************

'*****************************************************************************************
'Name:		utility_setCookieExpiration
'
'Purpose:	extend the expiration of a cookie value
'
'Inputs:	strCookieName - name of cookie to extend the expiration of
'			intExtension - number of specified interval to extend cookie by
'			strInterval - the interval (minutes, days, months, years) to extend the cookie
'******************************************************************************************
Function utility_setCookieExpiration(strCookieName,intExtension, strInterval)
	Response.Cookies(strCookieName).Expires = DateAdd(strInterval,intExtension,now())
End Function
'*****************************************************************************************
' Name:     utility_SQLEncode
'				
' Purpose:      Given a text value which is going to be passed into a SQL statement 
'		(i.e. TheText), we will encode it by adding single quotes before and 
'		after, plus replacing any single quotes which appear in the text with 
' 		two single quotes, for each occurrence.  That will prevent any single 
'		quotes which the user may have provided us from confusing the database
'		application when parsing our SQL statement.
'				
' Arguments:    strTheText - The text that is to be encoded before being inserted into the 
'				database
'
' Return Value: The encoded string
'	
'*****************************************************************************************
Function utility_SQLEncode(strTheText, boolDefaultNull)
	If Len(trim(strTheText)) > 0 or boolDefaultNull = False Then
		If Len(trim(strTheText)) > 0 Then
			utility_SQLEncode = "'" & Replace (strTheText, "'", "''" ) & "'"
		Else 
			utility_SQLEncode = "''"
		End If
	Else
		utility_SQLEncode = "NULL"
	End If
End Function

'*****************************************************************************************
' Name:         utility_ConvertSQL
'				
' Purpose:      This function takes a string of SQL in SQL Server format, and then checks to
'				see if the application is being run against SQL Server or Access.  If SQL
'				Server, then the function returns the original SQL string.  If Access, the
'				function converts the string to MS Access-compliant SQL.
'				
' Arguments:    strSQL -- the SQL, in SQL Server format, to be (possibly) converted
'
' Return Value: strConvertedSQL -- the SQL string, in the appropriate syntax for either
'								   SQL Server or Access
'	
'*****************************************************************************************
Function utility_ConvertSQL(strSQL)

	Dim strConvertedSQL
	If DATABASE_TYPE = "SQLServer" Then
		'If the database is SQL Server, the SQL is already in the correct format, so just pass
		'it through
		strConvertedSQL = strSQL
	Else
		strConvertedSQL = Replace(strSQL, "GETDATE", "NOW")
	End If
	utility_ConvertSQL = strConvertedSQL
End Function

'*****************************************************************************************
' Name:         utility_executeCommand
'				
' Purpose:      This function takes a string of SQL and executes it
'				
' Arguments:    strSQL -- the SQL to be executed
'
' Return Value: 
'
' Dependencies: PowerBannerConnection_inc.asp
'**************************************************************************************
Function utility_executeCommand(strSQL)
	
	On Error Resume Next
	
		Dim conDB
		Dim strErrorDescription
	
	
		Set conDB = Server.CreateObject("ADODB.Connection")
		conDB.Open DB_CONNECTION
		conDB.Execute utility_convertSQL(strSQL), ,adCmdText
		conDB.Close	
		Set conDB = Nothing
'response.Write strSQL & "<br /><br />"

	 ' Trap standard errors		
	 If Err.number <> 0 then
    
		strErrorDescription = Err.Description
   	
   		If DATABASE_TYPE = "MSAccess" Then
   		
   			If InStr(strErrorDescription , "Operation must use an updateable query") > 1 or _
   				InStr(strErrorDescription , "Unable to open registry key") > 1 Then
	   			Call utility_displayError("Cannot write to your Access database. Please set write permissions on the Access database.", strErrorDescription & "<br>" & strSQL)	
	   		Else
	   			Call utility_displayError("Error querying your Access database. Please confirm that read and write permissions have been set on your Access database and see if the error persists.", strErrorDescription & "<br><br>" & "SQL=" & strSQL)	
	   		End If
	   			   		
		Else
	   		Call utility_displayError("Error executing query.", strErrorDescription & "<br><br>" & "SQL=" & strSQL)	
	    End If
	    
    End If
		
	
End Function

'*****************************************************************************************
' Name:         utility_createGUID
'				
' Purpose:      This function returns a globally unique identifier
'
' Return Value: globally unique identifier 
'
'*************************************************************************************
Function utility_createGUID()
	Dim strGUID
	strGUID = server.createobject("scriptlet.typelib").guid
	strGUID = Replace(strGUID, "{","") 
	strGUID = Replace(strGUID, "}","")
	strGUID = left(strGUID,len(strGUID)-2)
	utility_createGUID = strGUID
End Function

'*****************************************************************************************
' Name:         utility_sendMail
'				
' Purpose:      This function sends an email using globally specified method
'
'*************************************************************************************
Function utility_sendMail(strFrom, strTo, strSubject, strBody)
   On Error Resume Next
    
    If SV_EMAIL_OBJECT_TYPE = SV_EMAIL_CDONTS Then
		Dim objCDONTSMail
		
		 
		Set objCDONTSMail = Server.CreateObject("CDONTS.NewMail")
				
		objCDONTSMail.From= strFrom
		objCDONTSMail.To= strTo
		objCDONTSMail.Subject= strSubject
		objCDONTSMail.Body = strBody
		objCDONTSMail.Send
		set objCDONTSMail=nothing
		
    ElseIf SV_EMAIL_OBJECT_TYPE = SV_EMAIL_CDOSYS Then
		
		Dim objCDOSYSMail 
		Dim objCDOSYSCon 
		
		Set objCDOSYSMail = Server.CreateObject("CDO.Message")
		Set objCDOSYSCon = Server.CreateObject ("CDO.Configuration")
		
		objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = SV_SMTPMAIL_HOST
		objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport")  = 25  
		objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
		objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60 	
		objCDOSYSCon.Fields.Update 

		'Update the CDOSYS Configuration
		Set objCDOSYSMail.Configuration = objCDOSYSCon

		objCDOSYSMail.From= strFrom
		objCDOSYSMail.To= strTo
		objCDOSYSMail.Subject= strSubject
		objCDOSYSMail.TextBody = strBody
		objCDOSYSMail.Send
		
		set objCDOSYSMail = nothing
		set objCDOSYSCon  = nothing 
		
	ElseIf SV_EMAIL_OBJECT_TYPE = SV_EMAIL_JMAIL Then
		Dim objJMail
		
		Set objJMail = Server.CreateObject("Jmail.SMTPMail")
		
	    objJMail.ServerAddress    = SV_SMTPMAIL_HOST
		objJMail.Sender = strFrom
		objJMail.AddRecipient strTo
		objJMail.Subject    =  strSubject
		objJMail.Body = strBody

		IF NOT objJMail.execute THEN
			
			Call utility_displayError("JMail Mail send failure.", objJMail.ErrorMessage & "<BR>" & objJMail.ErrorSource)
			
		END IF

		Set objJMail= Nothing
	ElseIf SV_EMAIL_OBJECT_TYPE = SV_EMAIL_ASPMAIL Then
		Dim objMailer
		
		Set objMailer = Server.CreateObject("SMTPsvg.Mailer")

		objMailer.FromName   = strFrom
		objMailer.FromAddress = strFrom
		objMailer.RemoteHost = SV_SMTPMAIL_HOST
		objMailer.AddRecipient strTo, strTo
		objMailer.Subject    = strSubject
		objMailer.BodyText   = strBody
		if objMailer.SendMail then
	 	else
			Call utility_displayError("ASPMail Object Mail send failure.", objMailer.Response)
		end if
		Set objMailer = NOTHING
	Else
		Call utility_displayError("Email Send Failure", "No email object is currently selected. Please check the ""settings"" section and try again.")
	End If
	


	
	If Err.number <> 0 then
	
				
	
		Call utility_displayError("Email object not properly configured. Please check the ""Settings"" section and make sure the email object is properly selected and that it is properly configured on your server. Otherwise, contact your system administrator.", Err.Description)
			
		Response.End
	End If
	
End Function


'*****************************************************************************************
' Name:         utility_checkForRecords
'				
' Purpose:      This function takes in a SQL string and returns true if the SQL string
'			    returns records
'
'*************************************************************************************
Function utility_checkForRecords(strSQL)
	If strSQL = "" Then
		utility_checkForRecords = False
	Else
		Dim rsResults
		Set rsResults = utility_GetRecordset(strSQL)
		
		If rsResults.EOF Then
			utility_checkForRecords = False
		Else
			utility_checkForRecords = True
		End If
		
		Set rsResults = Nothing
	End If
End Function

'*****************************************************************************************
' Name:         utility_isValidEmail
'				
' Purpose:      This function returns a boolean of whether or not the specified string is 
'				a valid email address
'
' Inputs:		strEmail - string to check if it's a valid email address 
'
'*************************************************************************************
Function utility_isValidEmail(strEMail)
   
    Dim strInvalidChars
    Dim i 
    Dim strTemp
    Dim boolTemp
    
    If isNull(strEmail) Then
		utility_isValidEmail = False
		exit function
    ElseIf len(trim(strEmail)) = 0 Then
		utility_isValidEmail = False
		exit function
	End If
    
    boolTemp = False
    ' Disallowed characters
    strInvalidChars = "!#$%^&*()=+{}[]|\;:'/?>,< "
	'Instantiate value
	utility_isValidEmail = True
    ' Check that there is at least one '@'
    ' Check that there are no two consecutive dots
    ' Check that there is at least one '.'
    ' Check that the length is at least six (a@a.ca)
    If InStr(strEmail, "@") <= 0 _ 
    Or InStr(strEmail, ".") <= 0 _
    Or Len(strEmail) < 6 _
    Or InStr(strEmail, "..") > 0 _
    Then
		utility_isValidEmail = False
	End If
        
    ' Check that there is only one '@'
    ' Check that there is no '@' after a space
    ' Check that there is one dot AFTER '@'
    ' Check if there's a quote (")
    i = InStr(strEmail, "@")
    strTemp = Mid(strEmail, i + 1)
    If InStr(strTemp, "@") > 0 _
    Or InStr(strTemp, " ") > 0 _
    Or InStr(strTemp, ".") = 0 _
    Or InStr(strEmail, Chr(34)) > 0 _ 
    Then
		utility_isValidEmail = False
	End If
               
    ' Check if there's any other disallowed chars
    ' optimize a little if strEmail longer than strInvalidChars
    ' check the other way around
    i = 0
    If Len(strEmail) > Len(strInvalidChars) Then
        Do until i = Len(strInvalidChars) or utility_isValidEmail = False
            i = i + 1
            If InStr(strEmail, Mid(strInvalidChars, i, 1)) > 0 Then 
				general_IsInvalidEmail = False
			End If
            
        Loop
    Else
        Do until i = Len(strEmail) or utility_isValidEmail = False
            i = i + 1
            If InStr(strInvalidChars, Mid(strEmail, i, 1)) > 0 Then 
				utility_isValidEmail = False
            End If
        Loop
    End If
End Function

'*****************************************************************************************
' Name:         utility_getMonthText
'				
' Purpose:      This function returns the name of the month specified
'
' Inputs:		intMonth - number of month in year (e.g. 1 = January)
'
'*************************************************************************************
Function utility_getMonthText(intMonth)
	Select Case intMonth
		Case 1
			utility_getMonthText = "January"
		Case 2 
			utility_getMonthText = "February"
		Case 3 
			utility_getMonthText = "March"
		Case 4 
			utility_getMonthText = "April"
		Case 5 
			utility_getMonthText = "May"
		Case 6 
			utility_getMonthText = "June"
		Case 7 
			utility_getMonthText = "July"
		Case 8 
			utility_getMonthText = "August"
		Case 9 
			utility_getMonthText = "September"
		Case 10 
			utility_getMonthText = "October"
		Case 11 
			utility_getMonthText = "November"
		Case 12 
			utility_getMonthText = "December"
	End Select
End Function

'*****************************************************************************************
' Name:         utility_checkDefault
'				
' Purpose:      This function takes in two integer values, and if they match, outputs 
'				'selected'
'
' Inputs:		intValue1 - first integer to be checked
'			    intValue2 - second integer to be checked 
'
'*************************************************************************************
Function utility_checkDefault(intValue1, intValue2)
	If Cint(intValue1) = Cint(intValue2) Then
%>
		selected
<%
	End If
End Function

'************************************************************************************
'Name:			utility_SQLDateEncode
'
'Purpose:       format date properly depending on type of database used
'
'Inputs:	    dtmDate - date to be formatted
'
'************************************************************************************
Function utility_SQLDateEncode(dtmDate)
	If dtmDate = "" Then
		utility_SQLDateEncode = "NULL"
	ElseIf DATABASE_TYPE = "SQLServer" Then
		utility_SQLDateEncode = "'" & dtmDate & "'"
	Else
		utility_SQLDateEncode = "#" & dtmDate & "#"
	End If
End Function

'************************************************************************************
'Name:			utility_isPositiveInteger
'
'Purpose:		determine if a number is a positive integer
'
'Inputs:		intNumber - number to check
'************************************************************************************
Function utility_isPositiveInteger(intNumber)
	If not isNumeric(intNumber) Then
		utility_isPositiveInteger = False
	ElseIf intNumber < 1 Then
		utility_isPositiveInteger = False
	ElseIf instr(1, intNumber, ".") > 0 Then
		utility_isPositiveInteger = False
	Else
		utility_isPositiveInteger = True
	End If

End Function

'**************************************************************************************
'Name:			utility_isMoney
'
'Purpose:		determine if a value is in money format
'
'Inputs:		strValue - value to check 
'**************************************************************************************
Function utility_isMoney(strValue)
	Dim intDecimalLocation
	intDecimalLocation = instr(1,strValue,".")
	If strValue = "" Then
		utility_isMoney = False
	ElseIf not isNumeric(strValue) Then
		utility_isMoney = False
	ElseIf intDecimalLocation = 0 Then
		utility_isMoney = False
	ElseIf len(right(strValue, len(strValue) - intDecimalLocation)) <> 2 Then
		utility_isMoney = False
	Else
		utility_isMoney = True
	End If
End Function

'**************************************************************************************
'Name:			utility_getPercentage
'
'Purpose:		get percentage
'
'Inputs:		intDividend - first value
'				intDivisor - value to divide by 
'**************************************************************************************
Function utility_getPercentage(intDividend, intDivisor)
	If intDividend = intDivisor Then
		utility_getPercentage = 100
	ElseIf intDivisor <> 0 Then
		utility_getPercentage = formatNumber((CDbl(CDbl(intDividend / intDivisor))) * 100,2)
		If len(trim(utility_getPercentage)) > 5 Then
			If instr(1,cstr(utility_getPercentage),"E") <> 0 Then
				utility_getPercentage = Replace(utility_getPercentage,right(utility_getPercentage, len(utility_getPercentage) - 5),"")	
				utility_getPercentage = formatNumber(utility_getPercentage / 100,2)
			End If
			utility_getPercentage = formatNumber(Replace(utility_getPercentage,right(utility_getPercentage, len(utility_getPercentage) - 5),""),2)	
		End If
	Else
		utility_getPercentage = 0 
	End If

End Function


'**************************************************************************************
'Name:			utility_GetRandomizedSequencerArray
'
'Purpose:		get randomly ordered array of numbers
'
'Inputs:		iArraySize - integer size of array 
'**************************************************************************************
Function utility_GetRandomizedSequencerArray(iArraySize)
	Dim arrTemp()
	Dim I
	Dim iLowerBound, iUpperBound
	Dim iRndNumber
	Dim iTemp
		
	' Set array size
	ReDim arrTemp(iArraySize - 1)

	' Init randomizer
	Randomize

	' Get bounds into local vars for speed
	iLowerBound = LBound(arrTemp)
	iUpperBound = UBound(arrTemp)
		
	' Insert initial values
	For I = iLowerBound To iUpperBound
		arrTemp(I) = I
	Next

	' Loop through the array once, swapping each value
	' with another in a random location within the array.
	For I = iLowerBound to iUpperBound
		' Generate random # in range
		iRndNumber = Int(Rnd * (iUpperBound - iLowerBound + 1))

		' Swap Ith element with iRndNumberth element
		iTemp = arrTemp(I)
		arrTemp(I) = arrTemp(iRndNumber)
		arrTemp(iRndNumber) = iTemp
	Next 'I

	' Return our array
	utility_GetRandomizedSequencerArray = arrTemp
End Function

Function utility_GetRecordset(strSQL)
  'this function returns a disconnected recordset

   Dim objConn
   Dim objRecordset
   Dim strErrorDescription 

   'Open a connection
   On Error Resume Next
		Set objConn = Server.CreateObject("ADODB.Connection")
		objConn.Open DB_CONNECTION
   
   If Err.number <> 0 then
    
		strErrorDescription = Err.Description
   	
   		If InStr(strErrorDescription , "SQL Server does not exist or access denied") > 1 Then
	   		Call utility_displayError("Cannot connect to SQL Server. Please check your connection string and try again.", strErrorDescription)	
		Else
	   		Call utility_displayError("Cannot establish connection to your database. Please check your connection string and try again.", strErrorDescription)	
	    End If
	    
    End If
   
   On Error Resume Next
		'Create the Recordset object
		Set objRecordset = Server.CreateObject("ADODB.Recordset")
		objRecordset.CursorLocation = adUseClient

		'Populate the Recordset object with a SQL query
		objRecordset.Open utility_convertSQL(strSQL), objConn, adOpenStatic, adLockBatchOptimistic

		'Disconnect the Recordset
		Set objRecordset.ActiveConnection = Nothing

		'Return the Recordset
		Set utility_getRecordset = objRecordset

		'Clean up...
		objConn.Close
		Set objConn = Nothing
	 
	 If Err.number <> 0 then
   		
		strErrorDescription = Err.Description
   	
   		Call utility_displayError("Error executing query.", strErrorDescription & "<br><br>" & strSQL)	
	
	    
    End If
   

	
End Function

Function utility_formEncode(strString)
	If len(trim(strString)) > 0 Then
		utility_formEncode = replace(strString, """","&quot;")
	End If
End Function

Function utility_javascriptEncode(strString)
	Dim strOutputString
	If len(trim(strString)) > 0 Then
		strOutputString = replace(strString, "&quot;","\""")
		strOutputString = replace(strOutputString, "'","\'")
		strOutputString = replace(strOutputString, "\","\\")
		strOutputString = replace(strOutputString, """","\""")
	End If
	utility_javascriptEncode = strOutputString
End Function


Function utility_getNetworkUsername()
	Dim strNetworkUsername
	strNetworkUsername = Request.ServerVariables("AUTH_USER")
	utility_getNetworkUsername = strNetworkUsername
End Function

Function utility_XMLEncode(strString)
	Dim strEncoded
	strEncoded = replace(strString,"'","&apos;")
	strEncoded = replace(strEncoded,"""","&quot;")
	strEncoded = replace(strEncoded,"/","//")
	strEncoded = replace(strEncoded,">","&gt;")
	strEncoded = replace(strEncoded,"<","&lt;")

	utility_XMLEncode = strEncoded
End Function


Function utility_displayError(strErrorMessage, strErrorDescription)

%>	

<html>
<head>
<title>Ultimate Survey: System Error</title>
</head>
<BODY bgColor="white" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0" link="#0000FF" vlink="#0000FF" alink="#0000FF">

<body topmargin="0" leftmargin="0">

<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr>
    <td bgcolor="#000000" style="font-family: Arial, Helvetica; font-size:18px; font-weight: bold; color: white">
    Ultimate Survey: System Error</td>
  </tr>
  <tr>
    <td style="font-family: Arial, Helvetica; font-size:11px">
    <br>
    <p align="left">
    <span style="font-size: 16px; font-weight: bold">Error Description:</span><br>
    <%=strErrorMessage%><br>
    <br>
    <% If strErrorDescription <> "" Then %>
    <span style="font-size: 16px; font-weight: bold">Full Message:</span><br>
    <%=strErrorDescription%>
    <% End If %>
	<br><br>
	<span style="font-size: 11px; font-weight: bold">If this error persists, please contact the administrator of this system with the full details of the error message.
&nbsp;</td>
  </tr>
</table>

</body>
<%
	Response.End
End Function
%>


