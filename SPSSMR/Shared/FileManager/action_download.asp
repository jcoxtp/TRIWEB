<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="fm.asp" -->
<%
' Load Filemanager Object
Dim oFM
Set oFM = New FileManager
oFM.SetXML unescape(Session.Value("FMData"))

Dim strRootPath, strRelpath, strFileSelection
strRootPath = oFM.GetDirectoryFromAlias(Request.QueryString("alias"))
strRelpath = unescape(Request.QueryString("relpath"))
strFileSelection = Request.QueryString("filesel")

Response.Buffer = True
Response.Clear
Response.AddHeader "content-disposition","attachment;filename=""" & strFileSelection & """"
Response.ContentType="application/octet-stream"
Response.BinaryWrite getBinaryFile
Response.End

Function getBinaryFile()
	Dim adTypeBinary
	Dim oStream
	
	adTypeBinary = 1
	Set oStream = Server.CreateObject("ADODB.Stream")
	oStream.Open
	oStream.Type = adTypeBinary
	oStream.LoadFromFile strRootPath & "\" & strRelPath & unescape(strFileSelection)
	getBinaryFile = oStream.Read
	Set oStream = Nothing
End Function
%>
