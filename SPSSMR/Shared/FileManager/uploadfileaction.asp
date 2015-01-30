<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="upload.asp" -->
<!-- #include file="fm.asp" -->
<!-- #include file="fmutil.asp" -->
<html>
<%Session.CodePage=1252
	' NOTE - YOU MUST HAVE VBSCRIPT v5.0 INSTALLED ON YOUR WEB SERVER
	'	   FOR THIS LIBRARY TO FUNCTION CORRECTLY. YOU CAN OBTAIN IT
	'	   FREE FROM MICROSOFT WHEN YOU INSTALL INTERNET EXPLORER 5.0
	'	   OR LATER.
	' Force VS to save as UTF with this comment - ÆØÅ
	
	Dim confirmParameter
	confirmParameter = Request.QueryString("confirm")
	If ( Len(confirmParameter) > 0 ) Then
		Call SaveUploadedFile( True, CBool(confirmParameter) )
	Else
		Call SaveUploadedFile( False, False )
	End If

	Sub SaveUploadedFile( bConfirmed, bOverwrite )
		' Load Filemanager Object
		Dim oFM
		Set oFM = New FileManager
		oFM.SetXML unescape(Session.Value("FMData"))
		
		Dim strRootPath, strRelPath, strAlias
		strRelPath = unescape(Request.QueryString("uploadPath"))
		strAlias = unescape(Request.QueryString("alias"))
		strRootPath = oFM.GetDirectoryFromAlias(strAlias)
		
		Dim strDocumentName, strErrorMessage, strLanguage
		strLanguage = oFM.GetLanguage()
		strDocumentName = Server.MapPath( "res/literals" )
		
		' Create the FileUploader
		Dim Uploader, File

		' This starts the upload process
		If bConfirmed = True Then
			If bOverwrite = True Then
				Set File = New UploadedFile
				
				File.ContentType = Session("FileManagerContentType")
				File.FileName = Session("FileManagerFileName")
				File.FileData = Session("FileManagerFileData")
			Else
				Session("FileManagerContentType") = ""
				Session("FileManagerFileName") = ""
				Session("FileManagerFileData") = ""
			End If
		Else
			Set Uploader = New FileUploader
			Uploader.Upload()
			If Uploader.Files.Count = 0 Then
				' TODO : render a script to display an alert (error message)
			Else
				Dim files
				files = Uploader.Files.Items
				Set File = files(0)
			End If
		End If
		
		If IsObject(File) Then
			' Loop through the uploaded files
			' For Each File In Uploader.Files.Items
			' Save the file
			On Error Resume Next
			If ( (bConfirmed = False) And File.ExistsInFolder(strRootPath & "\" & strRelPath) )Then
				Session("FileManagerContentType") = File.ContentType
				Session("FileManagerFileName") = File.FileName
				Session("FileManagerFileData") = File.FileData
				
				%>
				<script language="javascript">
					if ( confirm('<%=GetLanguageLiteral( "confirm_upload_overwrite", strDocumentName, strLanguage )%>') ) {
						this.location += '&confirm=true';
					}
					else {
						this.location += '&confirm=false';
					}
				</script>
				<%
				Exit Sub
			End If
			
			File.SaveToDisk strRootPath & "\" & strRelPath
			If Err.number <> 0 Then
				' There was a problem saving the file
				strErrorMessage = GetLanguageLiteral( "error_upload_savefile_failed", strDocumentName, strLanguage )
				'strErrorMessage = strErrorMessage & "\nError : " & Err.Number & "\nDescription : " & Err.Description
				%>
				<script language="javascript">
					alert('<%=strErrorMessage%>');
				</script>
				<%
				Err.Clear
			End If
			On Error Goto 0
			'Next
		End If
		
		Dim bCloseDialog
		bCloseDialog = CBool(Request.QueryString("closedialog"))
		' Close the dialog or update filelist
		If bCloseDialog Then
			%>
			<script language="javascript" src="dialog.js"></script>
			<script language="javascript">
				closeDialog('ok');
			</script>
			<%
		Else
			Dim strFileListUrl
			strFileListUrl = "filelist.asp?path=" & Request.QueryString("uploadPath") & "&alias=" & Request.QueryString("alias")
			%>
			<script language="javascript">
				top.frames[2].frames[1].location = '<%=strFileListUrl%>';
				this.location="action.asp";
			</script>
			<%
		End If
	End Sub

Session.CodePage=65001%>
</html>
