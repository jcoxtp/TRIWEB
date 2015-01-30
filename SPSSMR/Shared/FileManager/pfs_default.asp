<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="pfs.asp" -->
<!-- #include file="fmutil.asp" -->
<!-- #include file="MrMyUser_Constants.asp" -->
<html>
<%
	' Force VS to save as UTF ÆØÅ with this comment
	Dim oPFS
	Set oPFS = New ProjectfileSelection
	oPFS.SetXML unescape(Session.Value("PFSData"))
	
	InitDialog()
	
	Sub InitDialog()
		On Error Resume Next
		
		Dim strResourceFileName
		strResourceFileName = Server.MapPath( "res/literals" )
		
		' Check if resource file exists for selected language
		If Not ResourceFileExists( strResourceFileName, oPFS.GetLanguage() ) Then
			If ResourceFileExists( strResourceFileName, "en-us" ) Then
				oPFS.SetLanguage "en-us"
				Session.Value("PFSData") = escape(oPFS.GetXML())
			Else
				' WE HAVE NO RESOURCE FILE AT ALL
				' user should check installation or contact support
				
				' Display an error in english
				Call launchResourceErrorStartPage(oPFS.GetLanguage())
				Exit Sub
			End If
		End If
		
		Dim strCommand, strXSLTDoc
		strCommand = Request.QueryString("cmd")
		
		' Check that project exists
		If oPFS.GetProjectName() = "" Then
			Call launchProjectErrorStartPage(strProjectName)
		Else
			' TODO - Check that project exists in DPMError handling
			' (add function to MrMyUser)
		End If
		
		' Check that filename is set
		If oPFS.GetFileName() = "" Then
			' TODO - Error handling
		End If
		
		Dim oAgent, oFileMgt, oFSO, oFile
		
		'On Error Resume Next (already enabled)
			Set oAgent = CreateObject("mrAgent.Agent")
			If Err.number <> 0 And Not IsObject(oAgent) Then
				Response.Write( "<script language='javascript'>" )
				Response.Write("alert('" & EncodeForJavaScript(Replace( GetLanguageLiteral("error_could_not_com_object", strLiterals, strLanguage), "{0}", "mrAgent")) & "');")
				Response.Write( "</script>" )
				Exit Sub
			End If
			
			oAgent.LogonEx
			If Err.number <> 0 Then
				Response.Write( "<script language='javascript'>" )
				Response.Write("alert('" & EncodeForJavaScript( "Unable to logon to DPM" ) & "');")
				Response.Write( "</script>" )
				Exit Sub
			End If
			
			Set oFileMgt = CreateObject("MRFileMgt.FMAdmin")
			If Err.number <> 0 And Not IsObject(oFileMgt) Then
				Response.Write( "<script language='javascript'>" )
				Response.Write("alert('" & EncodeForJavaScript(Replace( GetLanguageLiteral("error_could_not_com_object", strLiterals, strLanguage), "{0}", "MrFileMgt")) & "');")
				Response.Write( "</script>" )
				Exit Sub
			End If
		' On Error Goto 0 (don't disable here)
		
		
		'**************************************************************
		' Register if Master and / or User file exists
		Set oFSO = Server.CreateObject( "Scripting.FileSystemObject" )
		
		Dim oldLCID
		oldLCID = SetLCIDByName(CStr(oPFS.GetLanguage()))
		
		Dim bFileExists
		bFileExists = oFileMgt.DoesFileExist( oAgent, oPFS.GetProjectName(), FT_SHARED_PROJECT_ROOT, oPFS.GetFileName() )
		If Err.number = 0 And bFileExists Then
			Set oFile = oFSO.GetFile( oFileMgt.GetFolder(oAgent, oPFS.GetProjectName(), FT_SHARED_PROJECT_ROOT, FAT_DEFAULT, FCO_CREATEIFNOTEXIST) & "\" & oPFS.GetFileName() )
			Call oPFS.SetWorkspaceAttribute("masterworkspace", "filedate", CStr(oFile.DateLastModified))
			Call oPFS.SetWorkspaceAttribute("masterworkspace", "fileexists", "true")
		Else
			Err.Clear
			Call oPFS.SetWorkspaceAttribute("masterworkspace", "fileexists", "false")
		End If
		
		bFileExists = oFileMgt.DoesFileExist( oAgent, oPFS.GetProjectName(), FT_USER_PROJECT_ROOT, oPFS.GetFileName() )
		If Err.number = 0 And bFileExists Then
			Set oFile = oFSO.GetFile( oFileMgt.GetFolder(oAgent, oPFS.GetProjectName(), FT_USER_PROJECT_ROOT, FAT_DEFAULT, FCO_CREATEIFNOTEXIST) & "\" & oPFS.GetFileName() )
			Call oPFS.SetWorkspaceAttribute("userworkspace", "filedate", CStr(oFile.DateLastModified))
			Call oPFS.SetWorkspaceAttribute("userworkspace", "fileexists", "true")
		Else
			Err.Clear
			Call oPFS.SetWorkspaceAttribute("userworkspace", "fileexists", "false")
		End If
		
		Call SetLCID(oldLCID)
		
		If strCommand = "checkin" Then
			strXSLTDoc = "pfs_checkin_default.xslt"
		Else
			strXSLTDoc = "pfs_default.xslt"
			
			'**************************************************************
			' masterworkspace
			If oPFS.GetChoiceAllowed("masterworkspace") = "true" Then
				' check if file exists in master workspace
				If oPFS.GetWorkspaceAttribute("masterworkspace", "fileexists") = "true" Then
					Call oPFS.SetChoiceDisplayed("masterworkspace", "true")
				Else
					Call oPFS.SetChoiceDisplayed("masterworkspace", "false")
				End If
			Else
				Call oPFS.SetChoiceDisplayed("masterworkspace", "false")
			End If
			
			
			'**************************************************************
			' userworkspace
			If oPFS.GetChoiceAllowed("userworkspace") = "true" Then
				' check if file exists in master workspace
				If oPFS.GetWorkspaceAttribute("userworkspace", "fileexists") = "true" Then
					Call oPFS.SetChoiceDisplayed("userworkspace", "true")
				Else
					Call oPFS.SetChoiceDisplayed("userworkspace", "false")
				End If
			Else
				Call oPFS.SetChoiceDisplayed("userworkspace", "false")
			End If
			
			
			'**************************************************************
			' newfile
			If oPFS.GetChoiceAllowed("newfile") = "true" Then
				Call oPFS.SetChoiceDisplayed("newfile", "true")
			Else
				Call oPFS.SetChoiceDisplayed("newfile", "false")
			End If
			
			
			'**************************************************************
			' uploadfile
			If oPFS.GetChoiceAllowed("uploadfile") = "true" Then
				Call oPFS.SetChoiceDisplayed("uploadfile", "true")
			Else
				Call oPFS.SetChoiceDisplayed("uploadfile", "false")
			End If
		End If
		
		
		'**************************************************************
		' saving changed values in PFSData to 'initialize' GUI
		Session.Value("PFSData") = escape(oPFS.GetXML())
		
		Response.Write( oPFS.Transform(strXSLTDoc) )
		Set oPFS = Nothing
		Set oFile = Nothing
		Set oFSO = Nothing
		Set oFileMgt = Nothing
		oAgent.Logoff
		Set oAgent = Nothing
		
		On Error GoTo 0
	End Sub

	''''''''''''''''
	' Function : launchResourceErrorStartPage()
	'
	' This function will create the HTML that displays an error message telling
	' that the resourcefile for the selected language is not available.
	Sub launchResourceErrorStartPage(strSelectedLanguage)
	%>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<script type="text/javascript" src="dialog.js"></script>
		<script type="text/javascript">
		<!--
			function initDlg() {
				dlgSetSizeXY(600,400);
			}
			window.onload = initDlg;
		-->
		</script>
<!--		<link rel="stylesheet" type="text/css" href="filemgr.css" />-->
	</head>
	<body style="margin: 10px">
		<h2>The application was unable to find resources for the selected language.</h2>
		<p>The selected language is : "<%=strSelectedLanguage%>"</p>
		<p>You should check that the resource file is available or contact SPSS support for help.</p>
	</body>
	<%
	End Sub


	''''''''''''''''
	' Function : launchProjectErrorStartPage()
	'
	' This function will create the HTML that displays an error message telling
	' that the project could not be found in DPM.
	Sub launchProjectErrorStartPage( strProjectName )
	%>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<script type="text/javascript" src="dialog.js"></script>
		<script type="text/javascript">
		<!--
			function initDlg() {
				dlgSetSizeXY(600,400);
			}
			window.onload = initDlg;
		-->
		</script>
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
	</head>
	<body style="margin: 10px">
		<h2>Could not find the project in DPM.</h2>
		<%
			' TODO - resources
		%>
		<%If strProjectName = "" Then%>
			<p>No Project Selected.</p>
		<%Else%>
			<p>Selected project : strProjectName</p>
		<%End If%>
	</body>
	<%
	End Sub
%>
</html>