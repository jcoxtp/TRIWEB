<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="upload.asp" -->
<!-- #include file="mfs.asp" -->
<!-- #include file="mfsutil.asp" -->
<!-- #include file="fmutil.asp" -->
<!-- #include file="MrMyUser_Constants.asp" -->
<html>
<%
	Session.CodePage=1252
	' NOTE - YOU MUST HAVE VBSCRIPT v5.0 INSTALLED ON YOUR WEB SERVER
	'	   FOR THIS LIBRARY TO FUNCTION CORRECTLY. YOU CAN OBTAIN IT
	'	   FREE FROM MICROSOFT WHEN YOU INSTALL INTERNET EXPLORER 5.0
	'	   OR LATER.

	Dim oMFS
	Set oMFS = New MultifileSelection
	oMFS.SetXML unescape(Session.Value("MFSData"))

	Call doInitUpload()
	
	Sub doInitUpload()
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
		
		strProjectFolder = oFileMgt.GetFolder( oAgent, oMFS.GetProjectName(), FT_USER_PROJECT_ROOT, FAT_DEFAULT, FCO_CREATEIFNOTEXIST )
		
		Set oFileMgt = Nothing
		On Error Resume Next
			oAgent.Logoff
		On Error Goto 0
		Set oAgent = Nothing

		Dim strDestinationFileName
		strDestinationFileName = Request.QueryString("destinationfilename")
		If ( strDestinationFileName = "" ) Then
			%>
			<script language="javascript">
				alert('no destination filename received'); // TODO : language
				if ( top.frames[1].unlockGUI != null ) {
					top.frames[1].unlockGUI();
				}
				this.location='mfs_action.asp'
			</script>
			<%
			Exit Sub
		End If

		' Create the FileUploader
		Dim Uploader, File
		Set Uploader = New FileUploader

		' This starts the upload process
		Uploader.Upload()

		' Check if many files were uploaded
		If Uploader.Files.Count = 0 Then
			strDocumentName = Server.MapPath( "res/literals" )
			strErrorMessage = GetLanguageLiteral( "pfs_upload_no_file_uploaded", strDocumentName, oMFS.GetLanguage() )
			' strErrorMessage = strErrorMessage & "\nError : " & Err.Number & "\nDescription : " & Err.Description
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
			Dim f
			f = Uploader.Files.Items
			Set File = f(0)
			File.FileName = strDestinationFileName
			File.SaveToDisk strProjectFolder
			If Err.number <> 0 Then
				' There was a problem saving the file
				strDocumentName = Server.MapPath( "res/literals" )
				strErrorMessage = GetLanguageLiteral( "error_upload_savefile_failed", strDocumentName, oMFS.GetLanguage() )
				'strErrorMessage = strErrorMessage & "\nError : " & Err.Number & "\nDescription : " & Err.Description
				%>
				<script language="javascript">
					alert('<%=strErrorMessage%>');
					if ( top.frames[1].unlockGUI != null ) {
						top.frames[1].unlockGUI();
					}
					this.location='mfs_action.asp';
				</script>
				<%
				Err.Clear
			Else
				Dim oMFSUtil
				Set oMFSUtil = new MFSUtil
				
				' Search for files and add to XML
				If Not oMFSUtil.GenerateFileList( oMFS ) Then
				End If
				Session.Value("MFSData") = escape(oMFS.GetXML())
				%>
				<script language="javascript">
					if ( top.frames[1].unlockGUI != null ) {
						top.frames[1].unlockGUI();
					}
					this.location='mfs_action.asp';
					top.frames[1].location = 'mfs_gui.asp';
					//top.frames[1].location = 'about:blank';
				</script>
				<%
			End If
			On Error Goto 0
		End If
	End Sub

	Session.CodePage=65001
%>
</html>
