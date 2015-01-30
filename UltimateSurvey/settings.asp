<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'************************************************************************************
'
' Name:		settings.asp
'
' Purpose:	allows administrator to change system settings
'************************************************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim strError
	Dim strSQL
	Dim rsResults
	Dim intUserType
	Dim strTopColor
	Dim strMenuColor
	Dim strTitleColor
	Dim strSiteName
	Dim strRootPath
	Dim strUploadedImageFolder
	Dim strUploadedImageURL
	Dim strIndexPageHeader
	Dim strIndexPageText
	Dim intEmailObjectType
	Dim strSMTPMailHost
	Dim strMainEmail
	Dim strEmailFromAddress
	Dim intDefaultUserType
	Dim boolAllowPublicRegistration
	Dim boolNonLoggedInNavLinks
	Dim intSessionTimeout
	Dim intResultsPerPage
	Dim boolEmailRequired
	Dim strDropdownDefault
	Dim intDefaultReportType
	Dim strCustomUserField1
	Dim strCustomUserField2
	Dim strCustomUserField3
	Dim intSecurityType
	Dim intSecurityTypeOld
	Dim intUserID
	Dim boolPreventConcurrentLogin
	Dim strCookieName
	
	Call user_loginNetworkUser()

	
	If Request.Form("submit") = "submit" Then
		'Call user_getSessionInfo(intUserID, intUserType, strUserName, intLoginType, boolOverRideNetwork,True)
		
		strTopColor = request.Form("topColor")
		strMenuColor = request.Form("menuColor")
		strTitleColor = Request.Form("titleColor")
		strSiteName = request.Form("siteName")
		strRootPath = request.Form("rootPath")
		strUploadedImageFolder = request.Form("uploadedImageFolder")
		strUploadedImageURL = request.Form("uploadedImageURL")
		strIndexPageHeader = request.Form("indexPageHeader")
		strIndexPageText = request.Form("indexPageText")
		intEmailObjectType = Request.Form("emailObjectType") 
		strSMTPMailHost = request.Form("smtpMailHost")
		strMainEmail = request.Form("mainEmail")
		strEmailFromAddress = request.Form("emailFromAddress")
		intDefaultUserType = request.Form("defaultUserType")
		If request.Form("allowPublicRegistration") = "on" Then
			boolAllowPublicRegistration = True
		Else
			boolAllowPublicRegistration = False
		End If
		If request.Form("nonLoggedInNavLinks") = "on" Then
			boolNonLoggedInNavLinks = True
		Else
			boolNonLoggedInNavLinks = False
		End If
		intSessionTimeout = request.Form("sessionTimeout")
		intResultsPerPage = request.Form("resultsPerPage")
		If request.Form("emailRequired") = "on" Then
			boolEmailRequired = True
		Else
			boolEmailRequired = False
		End If
		strDropdownDefault = request.Form("dropdownDefault")
		intDefaultReportType = Request.form("defaultReportType")
 
		strCustomUserField1 = Request.Form("customUserField1")
		strCustomUserField2 = Request.Form("customUserField2")
		strCustomUserField3 = Request.Form("customUserField3")
		
		intSecurityTypeOld = Request.Form("securityTypeOld")
		intSecurityType= Request.Form("securityType")

		If Request.Form("preventConcurrentLogin") = "on" Then
			boolPreventConcurrentLogin = True
		Else
			boolPreventConcurrentLogin = False
		End If
		
		strCookieName = Request.Form("cookieName")
		
		If Cint(intSecurityTypeOld) <> Cint(intSecurityType) Then

			Dim strUserName
			Dim intLoginType
			Dim boolOverRideNetwork

			
		End If 

 
 
		strSQL = "UPDATE usd_surveySettings SET " &_
				 "topColor = " & utility_SQLEncode(strTopColor, True) & "," &_
				 "menuColor = " & utility_SQLEncode(strMenuColor, True) & "," &_
				 "titleColor = " & utility_SQLEncode(strTitleColor, True) & "," &_
				 "siteName = " & utility_SQLEncode(strSiteName, True) & "," &_
				 "rootPath = " & utility_SQLEncode(strRootPath, True) & "," &_
				 "uploadedImageFolder = " & utility_SQLEncode(strUploadedImageFolder, True) & "," &_ 
				 "uploadedImageURL = " & utility_SQLEncode(strUploadedImageURL, True) & "," &_
				 "indexPageHeader = " & utility_SQLEncode(strIndexPageHeader, True) & "," &_
				 "indexPageText = " & utility_SQLEncode(strIndexPageText, True) & "," &_
				 "EmailObjectType = " & cint(intEmailObjectType) & "," &_
				 "smtpMailHost = " & utility_SQLEncode(strSMTPMailHost, True) & "," &_
				 "mainEmail = " & utility_SQLEncode(strMainEmail, True) & "," &_
				 "emailFromAddress = " & utility_SQLEncode(strEmailFromAddress, True) & "," &_
				 "defaultUserType = " & intDefaultUserType & "," &_
				 "allowPublicRegistration = " & cint(boolAllowPublicRegistration) & "," &_
				 "nonLoggedInNavLinks = " & cint(boolNonLoggedInNavLinks) & "," &_
				 "sessionTimeout = " & intSessionTimeout & "," &_
				 "resultsPerPage = " & intResultsPerPage & "," &_
				 "emailRequired = " & cint(boolEmailRequired) & "," &_
				 "dropdownDefault = " & utility_SQLEncode(strDropdownDefault, True) & "," &_
				 "defaultReportType = " & intDefaultReportType & "," &_
				 "customUserField1 = " & utility_SQLEncode(strCustomUserField1, True) & "," &_
				 "customUserField2 = " & utility_SQLEncode(strCustomUserField2, True) & "," &_
				 "customUserField3 = " & utility_SQLEncode(strCustomUserField3, True) & "," &_
				 "securityType = " & utility_SQLEncode(intsecurityType, True) & "," &_
				 "preventConcurrentLogin = " & abs(cint(boolPreventConcurrentLogin)) & "," &_
				 "cookieName = " & utility_SQLEncode(strCookieName,True)

		Call utility_executeCommand(strSQL)
		
		If Cint(intSecurityTypeOld) <> Cint(intSecurityType) Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_SECURITY_SETTINGS_CHANGED)
		End If 
		
	End If
	
	strSQL = "SELECT topColor, menuColor, titleColor, siteName, rootPath, uploadedImageFolder, uploadedImageURL, " &_
			 "indexPageHeader, indexPageText, emailObjectType, smtpMailHost, mainEmail, " &_
			 "emailFromAddress, defaultUserType, allowPublicRegistration, nonLoggedInNavLinks, " &_
			 "sessionTimeout, resultsPerPage, emailRequired, dropdownDefault, defaultReportType, customUserField1, customUserField2, customUserField3, securitytype, " &_
			 "preventConcurrentLogin, cookieName " &_
			 "FROM usd_surveySettings"
	
	Set rsResults = utility_getRecordset(strSQL)

	strTopColor = rsResults("topColor")
	strMenuColor = rsResults("menuColor")
	strTitleColor = rsResults("titleColor")
	strSiteName = rsResults("siteName")
	strRootPath = rsResults("rootPath")
	strUploadedImageFolder = rsResults("uploadedImageFolder")
	strUploadedImageURL = rsResults("uploadedImageURL")
	strIndexPageHeader = rsResults("indexPageHeader")
	strIndexPageText = rsResults("indexPageText")
	intEmailObjectType = cint(rsResults("emailObjectType"))
	strSMTPMailHost = rsResults("smtpMailHost")
	strMainEmail = rsResults("mainEmail")
	strEmailFromAddress = rsResults("emailFromAddress")
	intDefaultUserType = rsResults("defaultUserType")
	boolAllowPublicRegistration = cbool(rsResults("allowPublicRegistration"))
	boolNonLoggedInNavLinks = cbool(rsResults("nonLoggedInNavLinks"))
	intSessionTimeout = rsResults("sessionTimeout")
	intResultsPerPage = rsResults("resultsPerPage")
	boolEmailRequired = cbool(rsResults("emailRequired"))
	strDropdownDefault = rsResults("dropdownDefault")
	intDefaultReportType = rsResults("defaultReportType")
	strCustomUserField1 = rsResults("customUserField1")
	strCustomUserField2 = rsResults("customUserField2")
	strCustomUserField3 = rsResults("customUserField3")
	intSecurityType = rsResults("securityType")
	boolPreventConcurrentLogin = cbool(rsResults("preventConcurrentLogin"))
	strCookieName = rsResults("cookieName")
	
	rsResults.Close
	Set rsResults = NOTHING
%>
	<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<%
	'Get the user info
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
		
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If


		
%>
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType,SV_PAGE_TYPE_SETTINGS)%>
	<span class="surveyTitle">Edit System Settings</span>
	<hr noshade color="#C0C0C0" size="2">
	<span class="message"><%=strError%></span>
	<form method="post" action="settings.asp" name="settings">
		<table class="normal" cellpadding="0" cellspacing="0">
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Folder/Path Settings
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/rootPath.asp",SV_SMALL_HELP_IMAGE)%>Root Path
				</td>
				<td valign="top">
					<input type="text" name="rootPath" value="<%=strRootPath%>" size="70">
					<input type="hidden" name="oldPath" value="<%=strRootPath%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/uploadedImageURL.asp",SV_SMALL_HELP_IMAGE)%>Uploaded Image URL
				</td>
				<td valign="top">
					<input type="text" name="uploadedImageURL" value="<%=strUploadedImageURL%>" size="70">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/uploadedImageFolder.asp",SV_SMALL_HELP_IMAGE)%>Uploaded Image Folder
				</td>
				<td valign="top">
					<input type="text" name="uploadedImageFolder" value="<%=strUploadedImageFolder%>" size="70">
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table class="normal" cellpadding="0" cellspacing="0">
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Appearance Settings
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/topColor.asp",SV_SMALL_HELP_IMAGE)%>Top Color
				</td>
				<td>
					<input type="text" name="topColor" value="<%=strTopColor%>" size="10">
					<a href="#" onclick="javascript:popup('chooseColor.asp?formName=settings&formField=topColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/menuColor.asp",SV_SMALL_HELP_IMAGE)%>Menu Color
				</td>
				<td>
					<input type="text" name="menuColor" value="<%=strMenuColor%>" size="10">
					<a href="#" onclick="javascript:popup('chooseColor.asp?formName=settings&formField=menuColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/titleColor.asp",SV_SMALL_HELP_IMAGE)%>Title Color
				</td>
				<td>
					<input type="text" name="titleColor" value="<%=strTitleColor%>" size="10">
					<a href="#" onclick="javascript:popup('chooseColor.asp?formName=settings&formField=titleColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/siteName.asp",SV_SMALL_HELP_IMAGE)%>Site Name
				</td>
				<td>
					<input type="text" name="siteName" value="<%=strsiteName%>" size="30">
				</td>
			</tr>
	
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold">
					<%=common_helpLink("settings/dropdownMenuText.asp",SV_SMALL_HELP_IMAGE)%>Dropdown Menu Text&nbsp;&nbsp;
				</td>
				<td>
					<input type="text" name="dropdownDefault" value="<%=strDropdownDefault%>">
				</td>
			<tr>
				<td>
					&nbsp;
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/homePageHeader.asp",SV_SMALL_HELP_IMAGE)%>Home Page Header
				</td>
				<td class="normal">
					<textarea name="indexPageHeader" rows="3" cols="55"><%=strIndexPageHeader%></textarea>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/homePageText.asp",SV_SMALL_HELP_IMAGE)%>Home Page Text
				</td>
				<td>
					<textarea name="indexPageText" rows="3" cols="55"><%=strIndexPageText%></textarea>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td colspan="2" class="normalBold">
					<input type="checkbox" name="nonLoggedInNavLinks" 
<%
					If boolNonLoggedInNavLinks = True Then
%>
						checked
<%
					End If
%>
					 >
					Show navigation links when not logged in<%=common_helpLink("settings/showNavLinks.asp",SV_SMALL_HELP_IMAGE)%>
				</td>
				
			</tr>				
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table class="normal" cellpadding="0" cellspacing="0">
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Registration Settings
 				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/allowPublicRegistration.asp",SV_SMALL_HELP_IMAGE)%>Allow Public Registration
				</td>
				<td>
					<input type="checkbox" name="allowPublicRegistration"
<%
					If boolAllowPublicRegistration = True Then
%>
						checked
<%
					End If
%>
					 >
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
 				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/emailRequired.asp",SV_SMALL_HELP_IMAGE)%>Email Required
				</td>
				<td>
					<input type="checkbox" name="emailRequired"
<%
					If boolEmailRequired = True Then
%>
						checked
<%
					End If
%>
					 >
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
 				</td>
				<td valign="top" class="normalBold">
					<%=common_helpLink("settings/defaultUserType.asp",SV_SMALL_HELP_IMAGE)%>Default User Type
				</td>
				<td>
					<select name="defaultUserType">
						<option value="<%=SV_USER_TYPE_ADMINISTRATOR%>"
<%
						If intDefaultUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
							selected
<%
						End If
%>
						>Administrator</option>
						<option value="<%=SV_USER_TYPE_CREATOR%>"
<%
						If intDefaultUserType = SV_USER_TYPE_CREATOR Then
%>
							selected
<%
						End If
%>
						>Take/Create</option>
						<option value="<%=SV_USER_TYPE_TAKE_ONLY%>"
<%
						If intDefaultUserType = SV_USER_TYPE_TAKE_ONLY Then
%>
							selected
<%
						End If
%>
						>Take Only</option>
					</select>
				</td>
			</tr>
		</table>
				<hr noshade color="#C0C0C0" size="2">
		<table class="normalBold" cellpadding="0" cellspacing="0">
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Custom User Fields
 				</td>
				<td valign="middle" class="normalBold">
					<%=common_helpLink("settings/customUserFields.asp",SV_SMALL_HELP_IMAGE)%>
				</td>
				<td>
					1. <input type="text" name="customUserField1" value="<%=strCustomUserField1%>" size="30">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
 				</td>
				<td valign="top" class="normalBold">
					&nbsp;
				</td>
				<td>
					2. <input type="text" name="customUserField2" value="<%=strCustomUserField2%>" size="30">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
 				</td>
				<td valign="top" class="normalBold">
					&nbsp;
				</td>
				<td>
					3. <input type="text" name="customUserField3" value="<%=strCustomUserField3%>" size="30">
				</td>
			</tr>		
		</table>

		
		<hr noshade color="#C0C0C0" size="2">
		<table class="normal" cellpadding="0" cellspacing="0">
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Email Settings
 				</td>
 				<td width="150" class="normalBold">
 					<%=common_helpLink("settings/emailObject.asp",SV_SMALL_HELP_IMAGE)%>Email Object
 				</td>
 				<td>
 					<select name="emailObjectType">
 					
 						<option value="<%=SV_EMAIL_NO_EMAIL%>" 
<%
						If Cint(intEmailObjectType) = SV_EMAIL_NO_EMAIL Then
%>
							selected
<%
						End If
%>
						>Email Disabled</option>
 					
 						<option value="<%=SV_EMAIL_CDONTS%>" 
<%
						If Cint(intEmailObjectType) = SV_EMAIL_CDONTS Then
%>
							selected
<%
						End If
%>
						>CDONTS</option>
						
						<option value="<%=SV_EMAIL_CDOSYS%>" 
<%
						If Cint(intEmailObjectType) = SV_EMAIL_CDOSYS Then
%>
							selected
<%
						End If
%>
						>CDOSYS</option>
						
						<option value="<%=SV_EMAIL_ASPMAIL%>" 
<%
						If Cint(intEmailObjectType) = SV_EMAIL_ASPMAIL Then
%>
							selected
<%
						End If
%>
						>ASPMail</option>
						<option value="<%=SV_EMAIL_JMAIL%>" 
<%
						If Cint(intEmailObjectType) = SV_EMAIL_JMAIL Then
%>
							selected
<%
						End If
%>
						>JMail</option>
						</select> <a href="emailTester.asp">(Test Email Settings)</a>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold">
						<%=common_helpLink("settings/smtpMailHost.asp",SV_SMALL_HELP_IMAGE)%>SMTP Mail Host<br />(not used with CDONTS)
					</td>
					<td>
						<input type="text" name="smtpMailHost" value="<%=strSMTPMailHost%>" size="40">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold">
						<%=common_helpLink("settings/inviteUsersFrom.asp",SV_SMALL_HELP_IMAGE)%>Invite Users "From" Address<br />
					</td>
					<td>
						<input type="text" name="mainEmail" value="<%=strMainEmail%>" size="40">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold">
						<%=common_helpLink("settings/surveyResultsFrom.asp",SV_SMALL_HELP_IMAGE)%>Survey Results "From" Address<br />
					</td>
					<td>
						<input type="text" name="emailFromAddress" value="<%=strEmailFromAddress%>" size="40">
					</td>
				</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table class="normal" cellpadding="0" cellspacing="0" border="0">
		
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Security Settings
 				</td>
				<td class="normalBold">
					<%=common_helpLink("settings/preventConcurrentLogin.asp",SV_SMALL_HELP_IMAGE)%>
					Prevent Concurrent Login? 
				</td>
				<td>
					<input type="checkbox" name="preventConcurrentLogin" 
<%
					If boolPreventConcurrentLogin = True Then
%>
						checked
<%
					End If
%>					
					>				
 					
 				</td>
 			</tr>
			<tr>
				<td class="normalBold-Big" width="200" valign="top">&nbsp;</td>
 				<td class="normalBold">
 					<%=common_helpLink("settings/securitytype.asp",SV_SMALL_HELP_IMAGE)%> Session Type
 				</td>
 				<td>
 					<input type="radio" name="securitytype" value="<%=SV_SECURITY_TYPE_COOKIES%>" <% If Cint(intSecurityType) = SV_SECURITY_TYPE_COOKIES Then %> checked <% End If %> > Cookies
 					<input type="radio" name="securitytype" value="<%=SV_SECURITY_TYPE_SESSION%>" <% If Cint(intSecurityType) = SV_SECURITY_TYPE_SESSION Then %> checked <% End If %> ID="Radio1"> Session
 					<input type="hidden" name="securitytypeold" value="<%=intSecurityType%>">
 					&nbsp;<%=common_helpLinkText("settings/securitytype.asp","(Which type should I use?)")%>
 				</td>
 			</tr>
		
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					&nbsp;
 				</td>
 				<td class="normalBold">
 					<%=common_helpLink("settings/sessionTimeout.asp",SV_SMALL_HELP_IMAGE)%>Session Timeout 
 				</td>
 				<td>
 					&nbsp;<input type="text" name="sessionTimeout" value="<%=intSessionTimeout%>" size="4">
 				</td>
 			</tr>

 			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					&nbsp;
 				</td>
 				<td class="normalBold">
 					<%=common_helpLink("settings/cookieName.asp",SV_SMALL_HELP_IMAGE)%>Cookie Name 
 				</td>
 				<td>
 					&nbsp;<input type="text" name="cookieName" value="<%=strCookieName%>" size="20">
 				</td>
 			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table class="normal" cellpadding="0" cellspacing="0">
		
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Other Settings
 				</td>
 				<td class="normalBold">
 					<%=common_helpLink("settings/resultsPerPage.asp",SV_SMALL_HELP_IMAGE)%>Results Per Page&nbsp;&nbsp;
 				</td>
 				<td>
 					<input type="text" name="resultsPerPage" value="<%=intResultsPerPage%>" size="4">
 				</td>
 			</tr>
 			<tr>
				<td>
					&nbsp;
 				</td>
				<td valign="top" class="normalBold">
					Default Report Type
				</td>
				<td>
					<select name="defaultReportType">
						<option value="<%=SV_REPORT_TYPE_TABLE%>"
<%
						If intDefaultReportType = SV_REPORT_TYPE_TABLE Then
%>
							selected
<%
						End If
%>
						>Table Format</option>
						<option value="<%=SV_REPORT_TYPE_GRAPHS%>"
<%
						If intDefaultReportType = SV_REPORT_TYPE_GRAPHS Then
%>
							selected
<%
						End If
%>
						>3D Graphs</option>
					</select>
				</td>
			</tr>
		</table>
 		<hr noshade color="#C0C0C0" size="2">
 		<table cellpadding="0" cellspacing="0">
 			<tr>
 				<td width="200">
 					&nbsp;
 				</td>
 				<td>
 					<input type="hidden" name="submit" value="submit">
 					<input type="image" src="images/button-submitChanges.gif" alt="Submit Changes" border="0"
 					onclick="javascript:return confirmAction('Are you sure you want to change the settings?');"
 					>
 				</td>
 			</tr>
 		</table>
	</form>
<%
		If strRootPath <> Request.Form("oldPath") Then
%>
			<img src="http://www.razza.com/support/recordInstall.asp?URL=<%=strRootPath%>" width="1" height="1">
<%
		
		End If
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

	
	