<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="mfs.asp" -->
<!-- #include file="MrMyUser_Constants.asp" -->
<!-- #include file="mfsutil.asp" -->
<!-- #include file="fmutil.asp" -->
<html>
<%
	InitDialog()
	
	Function InitDialog()
		On Error Resume Next
		
		Dim oMFS
		Set oMFS = New MultifileSelection
		oMFS.SetXML unescape(Session.Value("MFSData"))
		
		InitDialog = False
		
		Dim strResourceFileName
		strResourceFileName = Server.MapPath( "res/literals" )
		
		' Check if resource file exists for selected language
		If Not ResourceFileExists( strResourceFileName, oMFS.GetLanguage() ) Then
			If ResourceFileExists( strResourceFileName, "en-us" ) Then
				oMFS.SetLanguage "en-us"
				Session.Value("MFSData") = escape(oMFS.GetXML())
			Else
				' WE HAVE NO RESOURCE FILE AT ALL
				' user should check installation or contact support
				
				' Display an error in english
				Call launchResourceErrorStartPage(oMFS.GetLanguage())
				Exit Function
			End If
		End If
		
		Dim strCommand, strXSLTDoc
		strCommand = Request.QueryString("cmd")
		
		' Check that project exists
		If oMFS.GetProjectName() = "" Then
			Call launchProjectErrorStartPage( strProjectName )
		Else
			' TODO - Check that project exists in DPM Error handling
			' (add function to MrMyUser)
		End If
		
		Dim oldLCID
		oldLCID = SetLCIDByName(CStr(oMFS.GetLanguage()))
		
		Dim oMFSUtil
		Set oMFSUtil = new MFSUtil
		
		' Search for files and add to XML
		If Not oMFSUtil.GenerateFileList( oMFS ) Then
			Call SetLCID(oldLCID)
		End If
		
		Call SetLCID(oldLCID)
		
		If strCommand = "checkin" Then
			strXSLTDoc = "mfs_checkin_default.xslt"
		Else
			strXSLTDoc = "mfs_default.xslt"
		End If
		
		'**************************************************************
		' saving changed values in MFSData to 'initialize' GUI
		Session.Value("MFSData") = escape(oMFS.GetXML())
		
		'Response.Write( Server.HTMLEncode( oMFS.GetXML() ) )
		
		Response.Write( oMFS.Transform(strXSLTDoc) )
		
		Set oMFS = Nothing
		
		InitDialog = True
		
		On Error GoTo 0
	End Function

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