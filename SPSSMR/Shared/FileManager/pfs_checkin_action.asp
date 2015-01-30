<%@ Language=VBScript %>
<!-- #include file="pfs.asp" -->
<!-- #include file="fmutil.asp" -->
<!-- #include file="MrMyUser_Constants.asp" -->
<html>
	<head>
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
	<body>
		<%
		' Force VS to save as UTF with this comment Æ Ø Å
		Call doCheckIn
		
		Sub doCheckIn()
			Dim returnvalue
			returnvalue = unescape(Request.QueryString("returnvalue"))
			
			Dim oPFS
			
			Set oPFS = New ProjectfileSelection
			oPFS.SetXML unescape(Session.Value("PFSData"))
			
			If returnvalue = "ok" Then
				Dim strLiterals
				strLiterals = Server.MapPath( "res/literals" )
				
				oPFS.SetReturnValue returnvalue
				
				If returnvalue = "ok" Then
					Dim oAgent, oFileMgt
					
					On Error Resume Next
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
					
					Dim strApplyOption, strKeepFile
					strApplyOption		= Request.Form("applyoption")
					strKeepFile			= Request.Form("keepfile")
					strKeepProjectLock	= Request.Form("keepprojectlock")
					
					Dim nCopyOption
					Select Case UCase(oPFS.GetOptionValue("copyoption"))
						Case "MRFS_NONE"
							nCopyOption = FCPY_COPYFILE
						Case "MRFS_COPY_FILE_FAIL_IF_EXISTS"
							nCopyOption = FCPY_FAILIFDESTFILEEXISTS
						Case "MRFS_BACKUP_FILE_IF_EXISTS"
							nCopyOption = FCPY_BACKUPDESTFILEIFEXISTS
						Case"MRFS_MERGE_MDM_FILE_IF_EXISTS"
							nCopyOption = FCPY_MERGEMDM
					End Select
					
					Select Case strApplyOption
						Case "masterworkspace"
							' When we get here - we asume that the user have confirmed potential overwrites
							On Error Resume Next
							Call oFileMgt.CopyFile( oAgent, oPFS.GetProjectName(), FT_USER_PROJECT_ROOT, FT_SHARED_PROJECT_ROOT, oPFS.GetFileName(), nCopyOption )
							If Err.number <> 0 Then
								Response.Write( "<script language='javascript'>alert('" & GetLanguageLiteral( "pfs_checkin_action_update_masterworkspace_failed", strLiterals, oPFS.GetLanguage() ) & "');</script>" )
								Err.Clear
								Exit Sub
							End If
							On Error Goto 0
							Call oPFS.SetChoiceSelected( strApplyOption )
							
						Case "userworkspace"
							' When we get here - we asume that the user have confirmed potential overwrite
							Call oPFS.SetChoiceSelected( strApplyOption )
					End Select
					
					If Not strKeepFile = "on" Then
						' Delete the file if user will not keep changes
						On Error Resume Next
						Call oFileMgt.DeleteFile( oAgent, oPFS.GetProjectName(), FT_USER_PROJECT_ROOT, oPFS.GetFileName() )
						If Err.number <> 0 Then
							Dim strErrorMessage
							strErrorMessage = GetLanguageLiteral( "pfs_checkin_action_delete_in_userworkspace_failed", strLiterals, oPFS.GetLanguage() )
							%>
							<script language="javascript">
								alert('<%=strErrorMessage%>');
								if ( top.frames[1].unlockGUI != null ) {
									top.frames[1].unlockGUI();
								}
							</script>
							<%
							Err.Clear
							Exit Sub
						End If
						On Error Goto 0
					End If
					
					If Not strKeepProjectLock = "on" Then
						Call oPFS.SetOptionAttribute("unlockproject", "selected", "true")
					Else
						Call oPFS.SetOptionAttribute("unlockproject", "selected", "false")
					End If
					
					Response.Write( "<script language='javascript'>closeDialog('" & strApplyOption & "');</script>" )
					
					Set oFileMgt = Nothing
					On Error Resume Next
						oAgent.Logoff
					On Error Goto 0
					Set oAgent = Nothing
				End If
				
				Session.Value("PFSData") = escape(oPFS.GetXML())
				
				Set oPFS = Nothing
			ElseIf returnvalue = "cancel" Then
				oPFS.SetReturnValue returnvalue
				
				Response.Write( "<script language='javascript'>closeDialog('');</script>" )
				
				Session.Value("PFSData") = escape(oPFS.GetXML())
				
				Set oPFS = Nothing
			End If
		End Sub
		%>
	</body>
</html>
