<%
Class MultifileCheckInDialog
	Private m_oMFS
	
	Private Sub Class_Initialize()
		Set m_oMFS = New MultifileSelection
	End Sub
	
	Private Sub Class_Terminate()
		Set m_oMFS = Nothing
	End Sub
	
	' String
	Public Property Let XMLData(value)
		m_oMFS.SetXML value
	End Property
	Public Property Get XMLData
		XMLData = m_oMFS.GetXML()
	End Property
	
	' String
	Public Property Let Language(value)
		m_oMFS.SetLanguage value
	End Property
	
	' String
	Public Property Let ProjectName(value)
		m_oMFS.SetProjectName value
	End Property
	Public Property Get ProjectName
		m_oMFS.GetProjectName()
	End Property
	
	' Bool
	Public Property Let ShowUnlockProject(value)
		m_oMFS.SetOptionAttribute "unlockproject", "show", LCase(Cstr(value))
	End Property
	
	' Bool
	Public Property Let UnlockProject(value)
		m_oMFS.SetOptionAttribute "unlockproject", "selected", LCase(Cstr(value))
	End Property
	Public Property Get UnlockProject
		UnlockProject = CBool(m_oMFS.GetOptionAttribute("unlockproject", "selected"))
	End Property
	
	' String : 
	Public Property Let CopyOption(value)
		Call m_oMFS.SetOptionValue( "copyoption", value )
	End Property
	
	Public Sub SetFileMaskAttributes(strName, strCopyOption)
		Call m_oMFS.SetFileMaskAttributes2(strName, "false", strCopyOption, "project", "false")
	End Sub
	
	Public Sub SetFileMaskAttributes2(strName, strCopyOption, strLocation, strAllowNew)
		Call m_oMFS.SetFileMaskAttributes2(strName, "false", strCopyOption, strLocation, strAllowNew)
	End Sub
	
	Public Function SetFileMaskAttribute(strName, strAttr, strValue)
		SetFileMaskAttribute = m_oMFS.SetFileMaskAttribute(strName, strAttr, strValue)
	End Function

	
	Public Sub SetClientData( strName, strValue )
		Call m_oMFS.SetClientData(strName, strValue)
	End Sub
	
	' String
	Public Function GetClientData( strName )
		GetClientData = m_oMFS.GetClientData(strName)
	End Function

	' String "ok" / "cancel"
	Public Property Get ReturnValue
		ReturnValue = m_oMFS.GetReturnValue()
	End Property
	
	' String : "userworkspace" / "masterworkspace"
	Public Property Get SelectedChoise
		SelectedChoise = m_oMFS.GetChoiceSelected()
	End Property
End Class

Class MultifileSelection
	Dim xd
	Dim xdElementApplication
	Dim xdElementProject
	Dim xdElementOptions
	Dim xdElementFileMasks
	Dim xdElementClientData
	Dim xdElementReturnValue
	Dim xdElementFileList

	'**************************************************************
	Private Sub Class_Initialize()
		Dim N, xdChoice, xdWorkspace, xdOption, xtText
		
		Set xd = server.createobject("MSXML2.DOMDocument.3.0")
		Set N = xd.createProcessingInstruction("xml", "version=""1.0"" encoding=""UTF-8""")
		xd.appendChild N
	
		
		Set xdElementApplication = xd.createElement("application")
		xdElementApplication.SetAttribute "name", "multifileselection"
		xdElementApplication.SetAttribute "lang", "en-us"
		
		
		Set xdElementProject = xd.createElement("project")
		xdElementProject.SetAttribute "name", ""
		xdElementProject.SetAttribute "path", ""
		xdElementApplication.appendChild xdElementProject
		
		
		Set xdElementOptions = xd.createElement("options")
			
			Set xdOption = xd.createElement("option")
			xdOption.SetAttribute "name", "showerrordlg"
			Set xtText = xd.createTextNode("true")
			xdOption.appendChild xtText
			xdElementOptions.appendChild xdOption
			
			Set xdOption = xd.createElement("option")
			xdOption.SetAttribute "name", "includeupload"
			Set xtText = xd.createTextNode("true")
			xdOption.appendChild xtText
			xdElementOptions.appendChild xdOption
			
		xdElementApplication.appendChild xdElementOptions
		
		
		Set xdElementFileMasks = xd.createElement("filemasks")
		xdElementApplication.appendChild xdElementFileMasks
		
		Set xdElementClientData = xd.createElement("clientdata")
		xdElementApplication.appendChild xdElementClientData
		
		Set xdElementReturnValue = xd.createElement("returnvalue")
		xdElementApplication.appendChild xdElementReturnValue
		
		Set xdElementFileList = xd.createElement("filelist")
		xdElementApplication.appendChild xdElementFileList
		
		xd.appendChild xdElementApplication
	End Sub
	
	'**************************************************************
	Private Sub Class_Terminate()
		Set xdElementFileList = Nothing
		Set xdElementReturnValue = Nothing
		Set xdElementClientData = Nothing
		Set xdElementFileMasks = Nothing
		Set xdElementOptions = Nothing
		Set xdElementProject = Nothing
		Set xdElementApplication = Nothing
		Set xd = Nothing
	End Sub
	
	'**************************************************************
	Public Sub SetLanguage(strLanguage)
		xdElementApplication.SetAttribute "lang", strLanguage
	End Sub
	
	'**************************************************************
	Public Function GetLanguage()
		GetLanguage = xdElementApplication.attributes.getNamedItem("lang").Text
	End Function
	
	'**************************************************************
	Public Sub SetProjectName(strProjectName)
		xdElementProject.SetAttribute "name", strProjectName
	End Sub
	
	'**************************************************************
	Public Function GetProjectName()
		GetProjectName = xdElementProject.attributes.getNamedItem("name").Text
	End Function
	
	'**************************************************************
	Public Sub SetPath(strPath)
		xdElementProject.SetAttribute "path", strPath
	End Sub
	
	'**************************************************************
	Public Function GetPath()
		GetPath = xdElementProject.attributes.getNamedItem("path").Text
	End Function
	
	'**************************************************************
	' FILEMASKS
	'**************************************************************
	Public Function GetFileMaskCount()
		GetFileMaskCount = xdElementFileMasks.childNodes.Length
	End Function
	
	'**************************************************************
	Public Function GetFileMaskAttribute(index, strAttrName)
		Dim objNodeList
		Set objNodeList = xdElementFileMasks.childNodes
		
		If index < 0 Or index >= objNodeList.Length Then
			GetFileMaskAttribute = Nothing
			Exit Function
		End If
		
		On Error Resume Next
		GetFileMaskAttribute = objNodeList.item(index).attributes.getNamedItem(strAttrName).Text
		On Error GoTo 0
	End Function
	
	'**************************************************************
	Public Sub SetFileMaskAttributes(strName, strRequired, strCopyOption)
		Call SetFileMaskAttributes2(strName, strRequired, strCopyOption, "project", "false")
	End Sub
	
	Public Sub SetFileMaskAttributes2(strName, strRequired, strCopyOption, strLocation, strAllowNew)
		Dim objNodeList, objNode, i
		
		Set objNodeList = xdElementFileMasks.childNodes
		For i = 0 To objNodeList.Length-1
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strName ) Then
				Set objNode = objNodeList.item(i)
				Exit For
			End If
		Next
		
		If Not IsObject(objNode) Then
			Set objNode = xd.createElement("filemask")
			xdElementFileMasks.appendChild objNode
		End If
		
		objNode.SetAttribute "name", strName
		objNode.SetAttribute "required", strRequired
		objNode.SetAttribute "copyoption", strCopyOption
		objNode.SetAttribute "location", LCase(strLocation)
		objNode.SetAttribute "allownew", strAllowNew
	End Sub
	
	'**************************************************************
	Public Function SetFileMaskAttribute(strName, strAttr, strValue)
		SetFileMaskAttribute = False
		Dim objNodeList, objNode, i
		
		Set objNodeList = xdElementFileMasks.childNodes
		For i = 0 To objNodeList.Length-1
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strName ) Then
				Set objNode = objNodeList.item(i)
				objNode.SetAttribute strAttr, strValue
				SetFileMaskAttribute = True
				Exit Function
			End If
		Next
	End Function
	
	'**************************************************************
	' FILELIST
	'**************************************************************
	Public Function GetFileListCount()
		GetFileListCount = xdElementFileList.childNodes.Length
	End Function
	
	'**************************************************************
	Public Function GetFileAttribute(index, strAttrName)
		Dim objNodeList
		Set objNodeList = xdElementFileList.childNodes
		
		If index < 0 Or index >= objNodeList.Length Then
			GetFileAttribute = Nothing
			Exit Function
		End If
		
		On Error Resume Next
		GetFileAttribute = objNodeList.item(index).attributes.getNamedItem(strAttrName).Text
		On Error GoTo 0
	End Function
	
	'**************************************************************
	Public Sub SetUserFileAttributes(strFileName, strFileSize, strFileDate, strRequired, strDependency, strCopyOption, strLocation, strAllowNew)
		Dim objNodeList, objNode, i
		Set objNodeList = xdElementFileList.childNodes
		For i = 0 To objNodeList.Length-1
			If( UCase(objNodeList.item(i).attributes.getNamedItem("name").Text) = UCase(strFileName) ) Then
				Set objNode = objNodeList.item(i)
				Exit For
			End If
		Next
		
		If Not IsObject(objNode) Then
			Set objNode = xd.createElement("file")
			xdElementFileList.appendChild objNode
			objNode.SetAttribute "master", "false"
			objNode.SetAttribute "masterdate", ""
			objNode.SetAttribute "mastersize", ""
		End If
		
		objNode.SetAttribute "name", strFileName
		objNode.SetAttribute "user", "true"
		objNode.SetAttribute "userdate", strFileDate
		objNode.SetAttribute "usersize", strFileSize
		objNode.SetAttribute "required", strRequired
		objNode.SetAttribute "dependency", strDependency
		objNode.SetAttribute "copyoption", strCopyOption
		objNode.SetAttribute "location", LCase(strLocation)
		objNode.SetAttribute "allownew", strAllowNew
	End Sub
	
	'**************************************************************
	Public Sub SetMasterFileAttributes(strFileName, strFileSize, strFileDate, strRequired, strDependency, strCopyOption, strLocation, strAllowNew)
		Dim objNodeList, objNode, i
		Set objNodeList = xdElementFileList.childNodes
		For i = 0 To objNodeList.Length-1
			If( UCase(objNodeList.item(i).attributes.getNamedItem("name").Text) = UCase(strFileName) ) Then
				Set objNode = objNodeList.item(i)
				Exit For
			End If
		Next
		
		If Not IsObject(objNode) Then
			Set objNode = xd.createElement("file")
			xdElementFileList.appendChild objNode
			objNode.SetAttribute "user", "false"
			objNode.SetAttribute "userdate", ""
			objNode.SetAttribute "usersize", ""
		End If
		
		objNode.SetAttribute "name", strFileName
		objNode.SetAttribute "master", "true"
		objNode.SetAttribute "masterdate", strFileDate
		objNode.SetAttribute "mastersize", strFileSize
		objNode.SetAttribute "required", strRequired
		objNode.SetAttribute "dependency", strDependency
		objNode.SetAttribute "copyoption", strCopyOption
		objNode.SetAttribute "location", LCase(strLocation)
		objNode.SetAttribute "allownew", strAllowNew
	End Sub
	
	'**************************************************************
	Public Sub SetFileAttribute(strFileName, strAttributeName, strValue)
		Dim objNodeList, objNode, i
		Set objNodeList = xdElementFileList.childNodes
		For i = 0 To objNodeList.Length-1
			If( UCase(objNodeList.item(i).attributes.getNamedItem("name").Text) = UCase(strFileName) ) Then
				Set objNode = objNodeList.item(i)
				objNode.SetAttribute strAttributeName, strValue
				Exit Sub
			End If
		Next
	End Sub
	
	'**************************************************************
	' OPTION
	'**************************************************************
	Public Sub SetOptionValue(strOptionName, strValue)
		Dim objNodeList, i
		Set objNodeList = xdElementOptions.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strOptionName ) Then
				objNodeList.item(i).childNodes(0).nodeValue = strValue
				Exit For
			End If
		Next
	End Sub
	
	'**************************************************************
	Public Function GetOptionValue(strOptionName)
		Dim objNodeList, i
		Set objNodeList = xdElementOptions.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strOptionName ) Then
				GetOptionValue = objNodeList.item(i).childNodes(0).nodeValue
				Exit For
			End If
		Next
	End Function
	
	'**************************************************************
	Public Sub SetOptionAttribute(strOptionName, strAttributeName, strValue)
		Dim xdOption
		Dim objNodeList, i
		
		Set xdOption = Nothing
		Set objNodeList = xdElementOptions.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strOptionName ) Then
				Set xdOption = objNodeList.item(i)
				Exit For
			End If
		Next
		If xdOption Is Nothing Then
			Set xdOption = xd.createElement("option")
			xdOption.SetAttribute "name", strOptionName
			xdElementOptions.appendChild xdOption
		End If
		
		xdOption.SetAttribute strAttributeName, strValue
	End Sub
	
	'**************************************************************
	Public Function GetOptionAttribute(strOptionName, strAttributeName)
		Dim objNodeList, i
		Set objNodeList = xdElementOptions.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strOptionName ) Then
				GetOptionAttribute = objNodeList.item(i).GetAttribute(strAttributeName)
				Exit For
			End If
		Next
	End Function
	
	'**************************************************************
	' CLIENT DATA
	'**************************************************************
	Public Sub SetClientData(strName, strValue)
		Dim objNodeList, i, xdData, xtText
		Set objNodeList = xdElementClientData.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strName ) Then
				objNodeList.item(i).SetAttribute strAttrName, strValue
				Exit Sub
			End If
		Next
		
		' If we get here, there is no data with name = strName, so we add it
		Set xdData = xd.createElement("data")
		xdData.SetAttribute "name", strName
		Set xtText = xd.createTextNode(strValue)
		xdData.appendChild xtText
		xdElementClientData.appendChild xdData
	End Sub
	
	'**************************************************************
	Public Function GetClientData(strName)
		Dim objNodeList, i
		Set objNodeList = xdElementClientData.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strName) Then
				GetClientData = objNodeList.item(i).childNodes(0).nodeValue
				Exit For
			End If
		Next
	End Function
	
	'**************************************************************
	' RETURN VALUE
	'**************************************************************
	Public Sub SetReturnValue(strReturnValue)
		Dim xtText
		Set xtText = xd.createTextNode(strReturnValue)
		
		While ( xdElementReturnValue.hasChildNodes() )
			xdElementReturnValue.removeChild(xdElementReturnValue.childNodes.Item(0))
		WEnd
		
		xdElementReturnValue.appendChild xtText
	End Sub
	
	'**************************************************************
	Public Function GetReturnValue()
		If xdElementReturnValue.childNodes.length > 0 Then
			GetReturnValue = xdElementReturnValue.childNodes(0).nodeValue
		Else
			GetReturnValue = ""
		End If
	End Function
	
	'**************************************************************
	' MISC
	'**************************************************************
	Public Sub Dump(strDirFN)
		xd.save(strDirFN)
	End Sub
	
	'**************************************************************
	Public Function GetXML()
		GetXML = xd.xml
	End Function
	
	'**************************************************************
	Public Sub SetXML(xmldata)
		xd.loadXML(xmldata)
		
		Set xdElementApplication = xd.getElementsByTagName("application").item(0)
		Set xdElementProject = xd.getElementsByTagName("project").item(0)
		Set xdElementOptions = xd.getElementsByTagName("options").item(0)
		Set xdElementFileMasks = xd.getElementsByTagName("filemasks").item(0)
		Set xdElementClientData = xd.getElementsByTagName("clientdata").item(0)
		Set xdElementReturnValue = xd.getElementsByTagName("returnvalue").item(0)
		
		Set xdElementFileList = xd.getElementsByTagName("filelist").item(0)
	End Sub
	
	'**************************************************************
	Public Function Transform(strxsltdoc)
		Dim objStylesheet
		Dim retHTML

		Set objStylesheet = server.createobject("MSXML2.DOMDocument.3.0")
		objStylesheet.async = False
		objStylesheet.Load Server.MapPath( strxsltdoc )
		retHTML = xd.transformNode(objStylesheet)
		Set objStylesheet = Nothing
		
		Transform = retHTML
	End Function
	
End Class
%>