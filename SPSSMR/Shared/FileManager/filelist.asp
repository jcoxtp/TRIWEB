<%@ Language=VBScript%>
<%Option Explicit%>
<!-- #include file="fm.asp" -->
<!-- #include file="fmutil.asp" -->
<html>
	<head>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<script language="javascript" src="filelist.js"></script>
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
	</head>
<%
	Dim strParamPath
	Dim strParamAlias
	
	strParamPath  = unescape(Request.QueryString("path"))
	strParamAlias = unescape(Request.QueryString("alias"))

	' Load Filemanager Object
	Dim oFM
	Set oFM = New FileManager
	oFM.SetXML unescape(Session.Value("FMData"))
	
	' Now create output XML
	Dim objOutputXML, objElementApplication, objElementFiles, objElementFile, rootPath 
	Set objOutputXML = server.createobject("MSXML2.DOMDocument.3.0")
	objOutputXML.loadXML(oFM.GetXML)
	
	Set objElementApplication = objOutputXML.getElementsByTagName("application").item(0)
	Set objElementFiles = objOutputXML.createElement("files")
	rootPath = oFM.GetDirectory(strParamAlias)
	objElementFiles.SetAttribute "alias", strParamAlias
	objElementFiles.SetAttribute "path", strParamPath
	objElementFiles.SetAttribute "wildcard", oFM.GetElementAttribute("options", "wildcard")
	objElementApplication.appendChild objElementFiles
	
	' change LCID to get date formats right
	Dim oldLCID
	oldLCID = SetLCIDByName(CStr(oFM.GetLanguage()))
	
	Dim path
	path = rootPath & "\" & strParamPath
	Dim objFSO, objFolder, objFiles, objFile
	' get files and populate xml
	If Not rootPath = "" Then
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
		Set objFolder = objFSO.GetFolder(path)
		Set objFiles = objFolder.Files
		Dim wc
		wc = oFM.GetElementAttribute("options", "wildcard")
		For Each objFile In objFiles
			If IsLike(objFile.Name, wc) Then
				Set objElementFile = objOutputXML.createElement("file")
				objElementFile.SetAttribute "name", objFile.Name
				objElementFile.SetAttribute "type", objFile.Type
				objElementFile.SetAttribute "date", CStr(objFile.DateLastModified)
				objElementFiles.appendChild objElementFile
			End If
		Next
	End If	
	
	Call SetLCID(oldLCID)
	
	Dim objStylesheet
	Dim retHTML
	Set objStylesheet = server.createobject("MSXML2.DOMDocument.3.0")
	objStylesheet.async = False
	objStylesheet.Load Server.MapPath( "filelist.xslt" )
	
	retHTML = objOutputXML.transformNode(objStylesheet)	
	
%>
	<body topmargin="0" leftmargin="0" style="background-color:white">
		<%=retHTML%>
	</body>
</html>
<%
' Destroy server objects
Set objFile = Nothing
Set objFiles = Nothing
Set objFolder = Nothing
Set objFSO = Nothing

Set objElementFile = Nothing
Set objElementFiles = Nothing
Set objElementApplication = Nothing	
Set objOutputXML = Nothing

Set oFM = Nothing
%>
