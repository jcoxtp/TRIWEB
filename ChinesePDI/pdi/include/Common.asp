<%

	'=== GLOBAL SETTINGS =============================================
	'	Note: Normally we would reference the application variable directly but 
	'	this is inherited code and the global.asa was not being used when got 
	'	the code.  As an interim step we are resetting these variables with 
	'	the application variable.  Later, it would be ideal to convert the 
	' 	system to use the application variables directly.	MG Feb 2004
		
		Dim strDBaseConnString
		strDBaseConnString = Application("strDbConnString")
	
		Dim strActivePDFIP
		strActivePDFIP = Application("ActivePDF_IP")
		
	'=================================================================

	' [SM] The following variables toggles the appearance of the older Next/Prev buttons.
	' [SM] In case we need to put them back, it will be easier to do so.
	
	Dim oldButtons, tableWidth
	oldButtons = false
	tableWidth = 650
	
	'[SM] used for help text
	Dim pageID, help_popUpWidth, help_popUpHeight
	
	
	Dim intResellerID
	intResellerID = Request.Form("ResellerID")
	If intResellerID = "" Then
		intResellerID = Request.QueryString("res")
	End If
	If intResellerID = "" Then
		intResellerID = 1
	End If
	
	Dim SitePathName
	Select Case intResellerID
		Case 1
			SitePathName = "TeamResources"
		Case 2
			SitePathName = "TheDreamGiver"
		Case 3
			SitePathName = "CoolSprings"
		Case 4
			SitePathName = "LMAC"
		Case 5
			SitePathName = "TrueNorth"
		Case 6
			SitePathName = "Cinnabon"
		Case 7
			SitePathName = "Havertys"
		Case 8
			SitePathName = "VisionWorks"
		Case 9
			SitePathName = "disctr1"
	End Select
	
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
	
	function FormatSQLError(strError)
		strError = Replace(strError,"[Microsoft][ODBC SQL Server Driver][SQL Server]","")
		FormatSQLError = "<font color=red>" & strError & "</font>"
		strError = ""
	end function
	
	function DisplayCompanyName()
		if Request.Cookies("CompanyName") <> "" then
			Response.Write "<strong>Company Name - " & Request.Cookies("CompanyName") & "</strong>"
			Response.Write "<br><br>"
		end if
	end function
%>