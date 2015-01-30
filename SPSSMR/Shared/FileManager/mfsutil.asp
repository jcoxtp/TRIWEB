<%
' when using this class, "fmutil.asp" and "MrMyUser_Constants.asp" should also be included.
Class MFSUtil
	Dim oAgent, oFileMgt, oFSO
	
	Private Sub Class_Initialize()
		On Error Resume Next
			Set oAgent = CreateObject("mrAgent.Agent")
			If Err.number <> 0 And Not IsObject(oAgent) Then
				Response.Write( "<script language='javascript'>" )
				Response.Write("alert('" & EncodeForJavaScript(Replace( GetLanguageLiteral("error_could_not_com_object", strLiterals, strLanguage), "{0}", "mrAgent")) & "');")
				Response.Write( "</script>" )
			End If
			
			oAgent.LogonEx
			If Err.number <> 0 Then
				Response.Write( "<script language='javascript'>" )
				Response.Write("alert('" & EncodeForJavaScript( "Unable to logon to DPM" ) & "');")
				Response.Write( "</script>" )
			End If

			Set oFileMgt = CreateObject("MRFileMgt.FMAdmin")
			If Err.number <> 0 And Not IsObject(oFileMgt) Then
				Response.Write( "<script language='javascript'>" )
				Response.Write("alert('" & EncodeForJavaScript(Replace( GetLanguageLiteral("error_could_not_com_object", strLiterals, strLanguage), "{0}", "MrFileMgt")) & "');")
				Response.Write( "</script>" )
			End If
		On Error Goto 0
		Set oFSO = Server.CreateObject( "Scripting.FileSystemObject" )
	End Sub
	
	Private Sub Class_Terminate()
		Set oFSO = Nothing
		Set oFileMgt = Nothing
		On Error Resume Next
			oAgent.Logoff
		On Error Goto 0
		Set oAgent = Nothing
	End Sub
	
	'*************************************************
	' oMFS must be an instance of MultifileSelection
	Function GenerateFileList( oMFS )
		GenerateFileList = False
		
		Dim strFileMask, strRequired, strCopyOption, strDependency, strLocation, strAllowNew
		
		
		Dim i
		For i=0 To oMFS.GetFileMaskCount()
			strFileMask = oMFS.GetFileMaskAttribute(i, "name")
			strRequired = oMFS.GetFileMaskAttribute( i, "required" )
			strDependency = oMFS.GetFileMaskAttribute( i, "dependency" )
			strCopyOption = oMFS.GetFileMaskAttribute( i, "copyoption" )
			strLocation = oMFS.GetFileMaskAttribute( i, "location" )
			strAllowNew = oMFS.GetFileMaskAttribute( i, "allownew" )
			Call AddFilesInfoToXML( oMFS, strFileMask, strRequired, strDependency, strCopyOption, strLocation, strAllowNew )
		Next
		
		GenerateFileList = True
	End Function

	'*************************************************
	' oMFS must be an instance of MultifileSelection
	Function AddFilesInfoToXML( oMFS, strFileMask, strRequired, strDependency, strCopyOption, strLocation, strAllowNew )
		Dim strMasterFolder, strUserFolder
		
		If Instr(1, strFileMask, "*", vbTextCompare) = 0 Then
			Call oMFS.SetMasterFileAttributes( strFileMask, "", "", strRequired, strDependency, strCopyOption, strLocation, strAllowNew )
			Call oMFS.SetUserFileAttributes( strFileMask, "", "", strRequired, strDependency, strCopyOption, strLocation, strAllowNew )
			Call oMFS.SetFileAttribute( strFileMask, "master", "false" )
			Call oMFS.SetFileAttribute( strFileMask, "user", "false" )
		End If
		
		Select Case strLocation
			Case "project"
				strMasterFolder = oFileMgt.GetFolder( oAgent, oMFS.GetProjectName(), FT_SHARED_PROJECT_ROOT, FAT_DEFAULT, FCO_CREATEIFNOTEXIST )
				strUserFolder = oFileMgt.GetFolder( oAgent, oMFS.GetProjectName(), FT_USER_PROJECT_ROOT, FAT_DEFAULT, FCO_CREATEIFNOTEXIST )
			Case "media"
				strMasterFolder = oFileMgt.GetFolder( oAgent, oMFS.GetProjectName(), FT_SHARED_PROJECT_MEDIA, FAT_DEFAULT, FCO_CREATEIFNOTEXIST )
				strUserFolder = oFileMgt.GetFolder( oAgent, oMFS.GetProjectName(), FT_USER_PROJECT_MEDIA, FAT_DEFAULT, FCO_CREATEIFNOTEXIST )
			Case "template"
				strMasterFolder = oFileMgt.GetFolder( oAgent, oMFS.GetProjectName(), FT_SHARED_PROJECT_TEMPLATES, FAT_DEFAULT, FCO_CREATEIFNOTEXIST )
				strUserFolder = oFileMgt.GetFolder( oAgent, oMFS.GetProjectName(), FT_USER_PROJECT_MEDIA, FAT_DEFAULT, FCO_CREATEIFNOTEXIST )
			Case Else
				AddFilesInfoToXML = False
				Exit Function
		End Select
		
		'fmutil.asp
		Dim objFSO, objFolder, objFiles, objFile
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
		
		' get userworkspace files and populate xml
		If Not strUserFolder = "" Then
			Set objFolder = objFSO.GetFolder(strUserFolder)
			Set objFiles = objFolder.Files
			For Each objFile In objFiles
				If IsLike(objFile.Name, strFileMask) Then
					Call oMFS.SetUserFileAttributes( objFile.Name, GetFormattedSize(objFile.Size), CStr(objFile.DateLastModified), strRequired, strDependency, strCopyOption, strLocation, strAllowNew )
				End If
			Next
		End If	
		
		' get masterworkspace files and populate xml
		If Not strMasterFolder = "" Then
			Set objFolder = objFSO.GetFolder(strMasterFolder)
			Set objFiles = objFolder.Files
			For Each objFile In objFiles
				If IsLike(objFile.Name, strFileMask) Then
					Call oMFS.SetMasterFileAttributes( objFile.Name, GetFormattedSize(objFile.Size), CStr(objFile.DateLastModified), strRequired, strDependency, strCopyOption, strLocation, strAllowNew )
				End If
			Next
		End If	
		
		AddFilesInfoToXML = True
	End Function
	
	Private Function GetFormattedSize( FileSize )
		On Error Resume Next
		If FileSize > 1048576 Then ' 1024 * 1024
			GetFormattedSize = CInt(10*(FileSize/1048576))/10 & " MB"
		ElseIf FileSize > 1024 Then
			GetFormattedSize = CInt(FileSize/1024) & " KB"
		Else
			GetFormattedSize = FileSize & " B"
		End If
		On Error Goto 0
	End Function
End Class
%>