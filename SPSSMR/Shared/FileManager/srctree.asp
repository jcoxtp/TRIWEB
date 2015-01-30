<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="fm.asp" -->
<!-- #include file="fmutil.asp" -->
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<!-- Infrastructure code for the tree -->
		<script language="javascript" src="ftiens4.js"></script>
<%
server.ScriptTimeout = 300000

Dim ErrorMsgArray ' Array of messages to display to user, when page is loaded
ErrorMsgArray = Array()

Dim strLiterals
strLiterals = Server.MapPath( "res/literals" )

' get input values and initialize and FM object
Dim oFM
Set oFM = New FileManager
oFM.SetXML unescape(Session.Value("FMData"))

Dim strLanguage
strLanguage = oFM.GetLanguage()

' create XML tree based on folder (recursive)
Function createTree(parentElement, rootPathLen, alias, parentPhysicalPath)
	Dim oFSO, oFolder, oSubFolder
	Dim xNewLevel
	Dim newRefPath
	
	Set oFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set xNewLevel = server.createobject("MSXML2.DOMDocument.3.0")
	
	On Error Resume Next
		Set oFolder = oFSO.GetFolder(parentPhysicalPath)
		If Err.number <> 0 Then
			' Add errormessage to display to user, when page is loaded
			ReDim Preserve ErrorMsgArray(UBound(ErrorMsgArray)+1)
			ErrorMsgArray(UBound(ErrorMsgArray)) = Replace(GetLanguageLiteral( "srctree_folder_not_found", strLiterals, strLanguage ), "{0}", alias )
			Err.Clear
			Set createTree = Nothing
			Exit Function
		End If
	On Error Goto 0
		
	For Each oSubFolder In oFolder.SubFolders
		Set xNewLevel = xdtree.createElement("Level")
		xNewLevel.SetAttribute "Name", oSubFolder.Name
		
		newRefPath = Right(parentPhysicalPath+"\"+oSubFolder.Name, Len(parentPhysicalPath+"\"+oSubFolder.Name)-rootPathLen-1)
		xNewLevel.SetAttribute "hreference", newRefPath
		
		
		xNewLevel.SetAttribute "alias", alias
		If( LCase(selectedDirectory) = LCase(parentPhysicalPath + "\" + oSubFolder.Name)) Then
			xNewLevel.SetAttribute "selected", "true"
		Else
			xNewLevel.SetAttribute "selected", "false"
		End IF
		parentElement.appendChild xNewLevel
		
		createTree xNewLevel, rootPathLen, alias, parentPhysicalPath+"\"+oSubFolder.Name
	Next
	Set createTree = xNewLevel
End Function

' Write javascript code to show tree based on tree xml
Sub GetNodeList(Element, depth)
	Dim xnode
	for each xnode in element
		if xnode.nodetype = 3 then 'NODE_TEXT
			Response.Write( "insDoc(aux" & depth - 2 & ",gLnk(0,""" & xnode.text & """,""" & xnode.parentnode.attributes(0).text & """));" )
		else
			if xnode.attributes.length > 0 and xnode.nodename <> "Item" then
				if depth = 1 then
					Response.Write( "aux1=insFld(foldersTree,gFld(""" & xnode.attributes(0).text & """,""" & escape(xnode.attributes(1).text) & """,""" & xnode.attributes(2).text & """," & xnode.attributes(3).text & "),"""");" )
				else
					Response.Write( "aux" & depth & "=insFld(aux" & depth - 1 & ",gFld(""" & xnode.attributes(0).text & """,""" & escape(xnode.attributes(1).text) & "\\"",""" & xnode.attributes(2).text & """," & xnode.attributes(3).text &"),"""");" )
				end if
			end if
		end if
		if xnode.hasChildnodes then
			call GetNodeList(xnode.ChildNodes, depth + 1)
		end if
	next
end sub

'***********************************************************************************************
Dim xdtree, RootElement, DirectoryElement, root, N
set xdtree = server.createobject("MSXML2.DOMDocument.3.0")
Set RootElement = server.createobject("MSXML2.DOMDocument.3.0")
Set DirectoryElement = server.createobject("MSXML2.DOMDocument.3.0")
Set root = server.createobject("MSXML2.DOMDocument.3.0")

xdtree.async = false
''''
Set N = xdtree.createProcessingInstruction("xml", "version=""1.0"" encoding=""UTF-8""")
xdtree.appendChild N
Set RootElement = xdtree.createElement("Level")
RootElement.SetAttribute "Name", "root"

Dim objNodeList, selectedDirectory, selectedAlias
selectedAlias = oFM.GetElementAttribute("directories", "dirselected")
selectedDirectory = oFM.GetDirectoryFromAlias(selectedAlias)
Set objNodeList = oFM.GetElementList("directory")

' create tree xml based on input directory values
Dim i
For i = 0 To (objNodeList.length - 1)
	Dim physicalDirPath
	Set DirectoryElement = xdtree.createElement("Level")
	physicalDirPath = objNodeList.item(i).Text
	DirectoryElement.SetAttribute "Name", objNodeList.item(i).attributes.getNamedItem("name").Text
	DirectoryElement.SetAttribute "hreference", ""
	DirectoryElement.SetAttribute "alias", objNodeList.item(i).attributes.getNamedItem("name").Text
	If( LCase(selectedDirectory) = LCase(physicalDirPath) ) Then
		DirectoryElement.SetAttribute "selected", "true"
	Else
		DirectoryElement.SetAttribute "selected", "false"
	End If
	
	If Not createTree(DirectoryElement, Len(physicalDirPath), objNodeList.item(i).attributes.getNamedItem("name").Text, physicalDirPath) Is Nothing Then
		RootElement.appendChild DirectoryElement
	End If
Next

Set oFM = Nothing

xdtree.appendChild RootElement
Set root = xdtree.documentelement

%>
	</head>
	<body topmargin="0" leftmargin="0" style="background-color:white">
		<table width="100%">
			<tr>
				<td>
					<input type="button" class="headerbutton" value="<%=GetLanguageLiteral("folders", strLiterals, strLanguage)%>" />
				</td>
			</tr>
		</table>
		<!-- Execution of the code that actually builds the specific tree -->
		<script>
			USETEXTLINKS = 1
			foldersTree = gFld("<%=root.attributes(0).text%>", "", "", false)
			<%Call GetNodeList(root.childnodes, 1)%>
			initializeDocument();
			
			<%
				Dim nErrorMsg
				For nErrorMsg = 0 To UBound(ErrorMsgArray)
					Response.Write("alert('" & ErrorMsgArray(nErrorMsg) & "');")
				Next
			%>
		</script>
	</body>
</html>
