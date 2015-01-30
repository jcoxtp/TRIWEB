<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="upload.asp" -->
<!-- #include file="pfs.asp" -->
<!-- #include file="fmutil.asp" -->
<!-- #include file="MrMyUser_Constants.asp" -->
<html>
	<%Session.CodePage=1252
	' NOTE - YOU MUST HAVE VBSCRIPT v5.0 INSTALLED ON YOUR WEB SERVER
	'	   FOR THIS LIBRARY TO FUNCTION CORRECTLY. YOU CAN OBTAIN IT
	'	   FREE FROM MICROSOFT WHEN YOU INSTALL INTERNET EXPLORER 5.0
	'	   OR LATER.
	Call doAction
	
	Sub doAction()	
		' Force VS to save as UTF ÆØÅ with this comment
		Dim oPFS
		Set oPFS = New ProjectfileSelection
		oPFS.SetXML unescape(Session.Value("PFSData"))

		' Create user object used for getting the users project folder
		Dim strDocumentName, strErrorMessage
		Dim oAgent, oFileMgt, strProjectFolder
		
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
		
		strProjectFolder = oFileMgt.GetFolder( oAgent, oPFS.GetProjectName(), FT_USER_PROJECT_ROOT, FAT_DEFAULT, FCO_CREATEIFNOTEXIST )
		
		Set oFileMgt = Nothing
		On Error Resume Next
			oAgent.Logoff
		On Error Goto 0
		Set oAgent = Nothing
		
		' Create the FileUploader
		Dim Uploader, File
		Set Uploader = New FileUploader

		' This starts the upload process
		Uploader.Upload()
		' Check if many files were uploaded
		If Uploader.Files.Count = 0 Then
			strDocumentName = Server.MapPath( "res/literals" )
			strErrorMessage = GetLanguageLiteral( "pfs_upload_no_file_uploaded", strDocumentName, oPFS.GetLanguage() )
			%>
			<script language="javascript">
				alert('<%=strErrorMessage%>');
				if ( top.frames[1].unlockGUI != null ) {
					top.frames[1].unlockGUI();
				}
			</script>
			<%
		Else
			' Save the file
			On Error Resume Next
			Dim strErrorLabel, strErrorDescriptionLabel
			Dim f
			f = Uploader.Files.Items
			Set File = f(0)
			File.FileName = oPFS.GetFileName()
			File.SaveToDisk strProjectFolder
			If Err.number <> 0 Then
				' There was a problem saving the file
				strDocumentName = Server.MapPath( "res/literals" )
				strErrorLabel = GetLanguageLiteral( "error_errorlabel", strDocumentName, oPFS.GetLanguage() )
				strErrorDescriptionLabel = GetLanguageLiteral( "error_descriptionlevel", strDocumentName, oPFS.GetLanguage() )
				strErrorMessage = GetLanguageLiteral( "error_upload_savefile_failed", strDocumentName, oPFS.GetLanguage() )
				Select Case Err.number
					Case 70
						strErrorMessage = strErrorMessage & "\n\n" & strErrorLabel & Err.Number & "\n" & strErrorDescriptionLabel & GetLanguageLiteral( "error_permission_denied", strDocumentName, oPFS.GetLanguage() )
					Case Else
						'strErrorMessage = strErrorMessage & "\n\n" & strErrorLabel & Err.Number & "\n" & strErrorDescriptionLabel & Err.Description
				End Select
				%>
			<script language="javascript">
					alert('<%=strErrorMessage%>');
					if ( top.frames[1].unlockGUI != null ) {
						top.frames[1].unlockGUI();
					}
					this.location='pfs_action.asp'
			</script>
			<%
				Err.Clear
			Else
				%>
			<script language="javascript">
					if ( top.frames[1].unlockGUI != null ) {
						top.frames[1].unlockGUI();
					}
					if ( top.frames[1].submitSelection != null ) {
						top.frames[1].submitSelection();
					}
			</script>
			<%
			End If
			On Error Goto 0
		End If
	End Sub
	Session.CodePage=65001
	%>
</html>
