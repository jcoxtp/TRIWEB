<%@ Language=VBScript %>
<!-- #include file="mfs.asp" -->
<!-- #include file="fmutil.asp" -->
<!-- #include file="MrMyUser_Constants.asp" -->
<html>
	<head>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<script language="javascript" src="dialog.js"></script>
		<script language='javascript'>
		<!--
			function noFocus() {
				top.frames[1].focus();
			}
			window.onfocus = noFocus;
		-->
		</script>
	</head>
	<body tabindex="-1">
		<%
		' Force VS to save as UTF ÆØÅ with this comment
		Call doAction
		
		Sub doAction()
			Dim ErrorMsgArray ' Array of messages to display to user, when page is loaded
			ErrorMsgArray = Array()
			
			Dim returnvalue
			returnvalue = unescape(Request.QueryString("returnvalue"))
			
			Dim oMFS
			Set oMFS = New MultifileSelection
			oMFS.SetXML unescape(Session.Value("MFSData"))
			
			If returnvalue = "ok" Then
				oMFS.SetReturnValue returnvalue
				
				On Error Resume Next
					Dim oAgent, oFileMgt
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
				On Error Goto 0
				
				Dim iFile, nFiles
				Dim strFileName, strCopyOption, strDependency
				Dim strSelection, strLocation
				Dim nSrcFolder, nDstFolder, nCopyOption
				
				nFiles = oMFS.GetFileListCount()
				For iFile=0 To nFiles-1
					strFileName = oMFS.GetFileAttribute(iFile, "name")
					strCopyOption = oMFS.GetFileAttribute(iFile, "copyoption")
					strDependency = oMFS.GetFileAttribute(iFile, "dependency")
					strLocation = oMFS.GetFileAttribute(iFile, "location")
					
					Select Case strLocation
						Case "project"
							nSrcFolder = FT_SHARED_PROJECT_ROOT
							nDstFolder = FT_USER_PROJECT_ROOT
						Case "media"
							nSrcFolder = FT_SHARED_PROJECT_MEDIA
							nDstFolder = FT_USER_PROJECT_MEDIA
						Case "template"
							nSrcFolder = FT_SHARED_PROJECT_TEMPLATES
							nDstFolder = FT_USER_PROJECT_TEMPLATES
						Case Else
							' TODO - Log - display error
							nSrcFolder = Empty
							nDstFolder = Empty
					End Select
					
					Select Case UCase(strCopyOption)
						Case "MRFS_NONE"
							nCopyOption = FCPY_COPYFILE
						Case "MRFS_COPY_FILE_FAIL_IF_EXISTS"
							nCopyOption = FCPY_FAILIFDESTFILEEXISTS
						Case "MRFS_BACKUP_FILE_IF_EXISTS"
							nCopyOption = FCPY_BACKUPDESTFILEIFEXISTS
						Case"MRFS_MERGE_MDM_FILE_IF_EXISTS"
							nCopyOption = FCPY_MERGEMDM
					End Select
					
					If Not IsEmpty(nSrcFolder) And Not IsEmpty(nDstFolder) Then
						Dim strItm
						If ( strDependency = "" ) Then
							strItm = CStr("radioname" & strFileName)
							strSelection = Request.Form.Item(strItm)
						Else
							' File is dependent of another option and should inherit options from "parent"
							strItm = CStr("radioname" & strDependency)
							strSelection = Request.Form.Item(strItm)
						End If
						
						' Copy file from master to user workspace if selection is master
						If ( strSelection = "master" ) Then
							On Error Resume Next
							Call oFileMgt.CopyFile( oAgent, oMFS.GetProjectName(), nSrcFolder, nDstFolder, strFileName, nCopyOption )
							If Err.number <> 0 Then
								ReDim Preserve ErrorMsgArray(UBound(ErrorMsgArray)+1)
								ErrorMsgArray(UBound(ErrorMsgArray)) = EncodeForJavaScript(Replace( GetLanguageLiteral("mfs_err_copy_failed", strLiterals, strLanguage), "{0}", strFileName))
								Err.Clear
							End If
							On Error Goto 0
						End If
					End If
				Next
				
				' TODO : set return values ( path + selection )
				Call oMFS.SetPath(oFileMgt.GetFolder( oAgent, oMFS.GetProjectName(), FT_USER_PROJECT_ROOT, FAT_DEFAULT, FCO_CREATEIFNOTEXIST) )
				' close dialog
				Response.Write( "<script language='javascript'>closeDialog('" & escape(oMFS.GetPath()) & "');</script>" )

				Set oFileMgt = Nothing
				On Error Resume Next
					oAgent.Logoff
				On Error Goto 0
				Set oAgent = Nothing
				
				Session.Value("MFSData") = escape(oMFS.GetXML())
				
				Set oMFS = Nothing
			ElseIf returnvalue = "cancel" Then
				oMFS.SetReturnValue returnvalue
				
				Response.Write( "<script language='javascript'>closeDialog('');</script>" )
				
				Session.Value("MFSData") = escape(oMFS.GetXML())
				
				Set oMFS = Nothing
			End If
		End Sub
		%>
		<form name="mfs_upload_form" method="post" enctype="multipart/form-data" ID="mfs_upload_form">
			<input type="FILE" size="1" name="File1" ID="File1" />
		</form>
	</body>
</html>
