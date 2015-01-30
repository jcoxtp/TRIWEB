<!--<METADATA TYPE="typelib" FILE="C:\Program Files\Common Files\System\ado\msado15.dll"></METADATA>-->

<%
'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
'NOTE: The above metadata reference is for testing purposes only. In order to get
'	   classic ADO to run on MARCT42.
'TODO: Remove the above metadata reference and this section of comments
'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
'=============================== GLOBAL SETTINGS ====================================
'	Note: Normally we would reference the application variable directly but
'	this is inherited code and the global.asa was not being used when got
'	the code.  As an interim step we are resetting these variables with
'	the application variable.  Later, it would be ideal to convert the
' 	system to use the application variables directly.	MG Feb 2004
	


    	Dim strThisLocation, strVarValue 
		'strThisLocation = "production"
        'strThisLocation = "staging"
		strThisLocation = "development"
	    
		'== Site Domain ============
			If strThisLocation = "production" Then
				strDbConnString = "Provider=SQLOLEDB.1;Data Source=216.52.198.215,1433;Network Library=DBMSSOCN;Trusted_Connection=False;Initial Catalog=TeamResources;User Id=sa;Password=s3rv3r pa33word!;"
				
				Application("SiteDomain") = "www.pdiprofile.com"
				Application("strDbConnString") = strDbConnString
				Application("ActivePDF_IP") = "216.52.198.213"
				Application("PDFOut_DiskPath") = "C:\PDFReports"
				Application("PDFOut_SitePath") = "/PDFReports/"
				Application("ChartBackgroundDir") = "C:\TRIWEB\DISC_PDF_IMAGES\"
			ElseIf strThisLocation = "development" Then
			    Dim SqlUserName : SqlUserName = "sa"
			    Dim SqlPassword : SqlPassword = "s3rv3r pa33word!"
			    
				'strDbConnString = "Provider=SQLOLEDB.1;Data Source=209.155.96.7,1433;Network Library=DBMSSOCN;Trusted_Connection=False;Initial Catalog=TeamResources;User Id=sa;Password=s3rv3r pa33word!;"
				
				strDbConnString = "DRIVER={SQL Server};SERVER=216.52.198.215,1433;DATABASE=TeamResources_Test;UID=" & SqlUserName & ";PWD=" & SqlPassword
				
				Application("SiteDomain") = "localhost"
				Application("strDbConnString") = strDbConnString
				Application("ActivePDF_IP") = "209.155.96.6" '"192.0.0.7"
				Application("PDFOut_DiskPath") = "C:\PDFReports"
				Application("PDFOut_SitePath") = "/PDFReports/"
				Application("ChartBackgroundDir") = "C:\TRIWEB\DISC_PDF_IMAGES\"
            Else
				strDbConnString = "Provider=SQLOLEDB.1;Data Source=216.52.198.215,1433;Network Library=DBMSSOCN;Trusted_Connection=False;Initial Catalog=TeamResources;User Id=sa;Password=s3rv3r pa33word!;"
				
				Application("SiteDomain") = "216.52.198.216/"
				Application("strDbConnString") = strDbConnString
				Application("ActivePDF_IP") = "216.52.198.213"
				Application("PDFOut_DiskPath") = "C:\PDFReports"
				Application("PDFOut_SitePath") = "/PDFReports/"
				Application("ChartBackgroundDir") = "C:\TRIWEB\DISC_PDF_IMAGES\"
			End If

		' Get the Universal Text variables and values from the database'
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			Set oRs = CreateObject("ADODB.Recordset")
			
			With oCmd
				.CommandText = "spUniversalTextSelect"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			    ' Output parameters'
			    .Parameters.Append .CreateParameter("@intReturnCode", 5, 3, 4, 0)
			End With
			
			oConn.Open strDbConnString , SqlUserName , SqlPassword
			
			oCmd.ActiveConnection = oConn
			'oCmd.Properties("Output Encoding") = UNICODE
			
			oRs.CursorLocation = 3
			oRs.Open oCmd, , 0, 1
			intReturnCode = oCmd.Parameters("@intReturnCode").value
	ON ERROR RESUME NEXT
			If intReturnCode = 1 Then
				oRs.MoveFirst
				While Not oRs.EOF
					strVarValue = "Application(""strText" & CStr(oRs("TextName")) & CStr(oRs("LanguageCode")) & """) = """ & CStr(oRs("Text")) & """" & VbCrLf
    'Response.Write("Universal Text: " & strVarValue)
					Execute(strVarValue)
					If Err.Number <> 0 Then
					   strThisLocation = strThisLocation & "<BR>Err.Number: " & Err.Number & "<BR>Err.Description:" & Err.Description & "<BR>" & strVarValue 
					   Err.Clear
					End If
					oRs.MoveNext
				Wend
				oRs.Close
				oConn.Close
				Set oRs = Nothing
				Set oConn = Nothing
			End If

		Application("test_variables") = strThisLocation 

	Dim strActivePDFIP
	strActivePDFIP = Application("ActivePDF_IP")
'====================================================================================

' [SM] The following variables toggles the appearance of the older Next/Prev buttons.
' [SM] In case we need to put them back, it will be easier to do so.
Dim intLanguageID
Dim strLanguageCode
Dim tempLanguageID
Dim tempLanguageCode
Dim oldButtons, tableWidth
oldButtons = False
tableWidth = 650
strFirstName = Request.Cookies("FirstName")
strLastName = Request.Cookies("LastName")
strFullName = strFirstName & " " & strLastName
'[SM] used for help text
Dim pageID, help_popUpWidth, help_popUpHeight

Dim intResellerID
intResellerID = Request.Cookies("ResellerID")
If intResellerID = "" Then
	intResellerID = Request.Form("ResellerID")
End If
If intResellerID = "" Then
	intResellerID = Request.QueryString("res")
End If
If intResellerID = "" Then
	intResellerID = 1
End If
intResellerID = CInt(intResellerID)

intUserID = Request.Cookies("UserID")
If intUserID <> "" Then
	intUserID = CLng(intUserID)
	'Response.Write "intUserID = " & intUserID
Else
	intUserID = 0
	'Response.Write "intUserID = 0"
End If
If intUserID = 210 Then
	isDebugOn = False
Else
	isDebugOn = False
End If

Dim strSiteType
Select Case intResellerID
	Case 2, 10, 11
		strSiteType = "DG"
	Case 12, 13, 14, 18, 20, 21, 22, 23
		strSiteType = "Focus3"
	Case Else
		strSiteType = "TR"
End Select

Dim strResellerType
Select Case intResellerID
	Case 15
		strResellerType = "Biblical"
	Case Else
		strResellerType = "Secular"
End Select

' strDbConnString = Application("strDbConnString") 'moved to head of page -mlp 12/2/2004

' Get all ResellerIDs and PathNames
	Dim SitePathName
	Dim intTempResellerID
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRsResellers = CreateObject("ADODB.Recordset")
	'Set param = oCmd.CreateParameter ("@RETURN_VALUE", adInteger, adParamReturnValue, 0)
	
	
	With oCmd
		.CommandText = "spResellerPathNameSelect"
		.CommandType = 4
		'.Parameters.Append param
		'.CreateParameter ("@RETURN_VALUE", adInteger, adParamReturnValue, 0)
	End With
	oConn.Open strDbConnString 'Application("strDbConnString")
	oCmd.ActiveConnection = oConn
	
	oRsResellers.CursorLocation = adUseClient
	oRsResellers.Open oCmd, , 0, 1
	If Not oRsResellers.EOF Then
		oRsResellers.MoveFirst
		While Not oRsResellers.EOF
			intTempResellerID = CInt(oRsResellers("ResellerID"))
			If intResellerID = intTempResellerID Then
				SitePathName = oRsResellers("PathName")
			End If
			oRsResellers.MoveNext
		Wend
	End If

' Get intLanguageID and resolve strLanguageCode
' We only want to provide alternate languages to English on the TeamResources site for now
If intResellerID = 1 Or 1 = 1 Then
	intLanguageID = Request.QueryString("lid")
	If intLanguageID = "" Then
		intLanguageID = Request.Cookies("intLanguageID")
	End If
	If intLanguageID = "" Then
		intLanguageID = Request.Form("intLanguageID")
	End If
	If intLanguageID = "" Then
		intLanguageID = 1
	End If
	intLanguageID = CInt(intLanguageID)

	If Request.Cookies("intLanguageID") = "" Then
		Response.Cookies("intLanguageID") = intLanguageID
	End If

	Select Case CInt(intLanguageID)
		Case 2
			strLanguageCode = "DE"
		Case 3
			strLanguageCode = "FR"
		Case 4
			strLanguageCode = "ES"
		Case 5
			strLanguageCode = "RU"
		Case 6
			strLanguageCode = "ZH"
		Case 7
			strLanguageCode = "CN"
		Case 8
			strLanguageCode = "IT"
		Case 9
			strLanguageCode = "EL"
		Case 10
			strLanguageCode = "JA"
		Case 11
			strLanguageCode = "KO"
		Case 13
			strLanguageCode = "PT"
		Case 14
			strLanguageCode = "NL"
		Case 15
			strLanguageCode = "HR"
		Case 16
			strLanguageCode = "HE"
		Case 17
			strLanguageCode = "HU"
		Case 18
			strLanguageCode = "IS"
		Case 19
			strLanguageCode = "GA"
		Case 20
			strLanguageCode = "LT"
		Case 21
			strLanguageCode = "NO"
		Case 24
			strLanguageCode = "PL"
		Case 25
			strLanguageCode = "RO"
		Case 26
			strLanguageCode = "SR"
		Case 27
			strLanguageCode = "TH"
		Case 31
			strLanguageCode = "AR"
		Case 34
			strLanguageCode = "SV"
		Case 35
			strLanguageCode = "TR"
		Case 36
			strLanguageCode = "AF"
		Case 37
			strLanguageCode = "SQ"
		Case 38
			strLanguageCode = "GD"
		Case 39
			strLanguageCode = "UK"
		Case 40
			strLanguageCode = "VI"
		Case Else
			strLanguageCode = "EN"
	End Select
Else
	intLanguageID = 1
	strLanguageCode = "EN"
End If



	Sub ResetCookies
		Response.Cookies("CompanyID") = ""
		Response.Cookies("CompanyName") = ""
		Response.Cookies("FirstName") = ""
		Response.Cookies("LastName") = ""
		Response.Cookies("Login") = 0
		Response.Cookies("NoPDIPurch") = 0
		Response.Cookies("URLInfo") = ""
		Response.Cookies("fileNameInfo") = ""
		Response.Cookies("qcompleted") = 0
		Response.Cookies("UserID") = 0
		Response.Cookies("UserName") = ""
		Response.Cookies("UserType") = 0
		Response.Cookies("UserTypeID") = 0
	End Sub
	
	Function FormatSQLError(strError)
		strError = Replace(strError,"[Microsoft][ODBC SQL Server Driver][SQL Server]","")
		FormatSQLError = "<font color=red>" & strError & "</font>"
		strError = ""
	End Function
	
	Function DisplayCompanyName()
		If Request.Cookies("CompanyName") <> "" Then
			Response.Write "<strong>Company Name - " & Request.Cookies("CompanyName") & "</strong>"
			Response.Write "<br><br>"
		End If
	End Function

' Vietnamese language is not implemented for PDI Report. Set to English -- mlp 4/22/2010
If intLanguageID = 40 And Not (intPageID >= 44 And intPageID <= 47) Then
	tempLanguageID = 1
	tempLanguageCode = "EN"
Else
	tempLanguageID = intLanguageID
	tempLanguageCode = strLanguageCode
End If

' Get all static page variable names and values
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRsPageStaticText = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spPageStaticTextSelect"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue, 0)
		.Parameters.Append .CreateParameter("@intPageID", adInteger, adParamInput, 4, intPageID)
		.Parameters.Append .CreateParameter("@intLanguageID", adInteger, adParamInput, 4, tempLanguageID)
	    ' Output parameters'
	    .Parameters.Append .CreateParameter("@intReturnCode", adDouble, AdParamOutput, 4, 0)
	End With
	oConn.Open strDbConnString 'Application("strDbConnString")
	oCmd.ActiveConnection = oConn
	oCmd.Properties("Output Encoding") = UNICODE
	oRsPageStaticText.CursorLocation = adUseClient
	oRsPageStaticText.Open oCmd, , 0, 1
	intPageStaticTextReturnCode = oCmd.Parameters("@intReturnCode").value
	If intPageStaticTextReturnCode = 1 Then
		Dim strVarName
		'Dim strVarValue
		Dim strNewValue
		Dim blnUsingEnglishStatic
		blnUsingEnglishStatic = False
		If Not oRsPageStaticText.EOF Then
			oRsPageStaticText.MoveFirst
			While Not oRsPageStaticText.EOF
				If isDebugOn Then
					Response.Write "<br>strText" & CStr(oRsPageStaticText("TextName")) & " = """ & CStr(Trim(oRsPageStaticText("Text"))) & """" & VbCrLf
				End If
				strVarName = "Dim strText" & CStr(oRsPageStaticText("TextName")) & VbCrLf
            'Response.Write "Page Static Text: " & strVarName & VbCrLf
				Execute (strVarName)
				If CStr(oRsPageStaticText("Text")) = "" Then
					blnUsingEnglishStatic = True
					strVarValue = "strText" & CStr(oRsPageStaticText("TextName")) & " = """ & CStr(Trim(oRsPageStaticText("TextEnglish"))) & """" & VbCrLf
				Else
					strVarValue = "strText" & CStr(oRsPageStaticText("TextName")) & " = """ & CStr(Trim(oRsPageStaticText("Text"))) & """" & VbCrLf
				End If
				
				Execute(strVarValue)
				oRsPageStaticText.MoveNext
			Wend
			oRsPageStaticText.Close
			oConn.Close
			Set oRsPageStaticText = Nothing
			Set oConn = Nothing
		End If
	End If
%>