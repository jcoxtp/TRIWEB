<%
Class ProjectfileCheckInDialog
	Private m_oPFS
	
	Private Sub Class_Initialize()
		Set m_oPFS = New ProjectfileSelection
	End Sub
	
	Private Sub Class_Terminate()
		Set m_oPFS = Nothing
	End Sub
	
	' String
	Public Property Let XMLData(value)
		m_oPFS.SetXML value
	End Property
	Public Property Get XMLData
		XMLData = m_oPFS.GetXML()
	End Property
	
	' String
	Public Property Let Language(value)
		m_oPFS.SetLanguage value
	End Property
	
	' String
	Public Property Let ProjectName(value)
		m_oPFS.SetProjectName value
	End Property
	Public Property Get ProjectName
		m_oPFS.GetProjectName()
	End Property
	
	' String
	Public Property Let FileName(value)
		m_oPFS.SetFileName value
	End Property
	Public Property Get FileName
		m_oPFS.GetFileName()
	End Property
	
	' Bool
	Public Property Let ShowUnlockProject(value)
		m_oPFS.SetOptionAttribute "unlockproject", "show", LCase(Cstr(value))
	End Property
	
	' Bool
	Public Property Let UnlockProject(value)
		m_oPFS.SetOptionAttribute "unlockproject", "selected", LCase(Cstr(value))
	End Property
	Public Property Get UnlockProject
		UnlockProject = CBool(m_oPFS.GetOptionAttribute("unlockproject", "selected"))
	End Property
	
	' String : 
	Public Property Let CopyOption(value)
		Call m_oPFS.SetOptionValue( "copyoption", value )
	End Property
	
	
	Public Sub SetClientData( strName, strValue )
		Call m_oPFS.SetClientData(strName, strValue)
	End Sub

	' String
	Public Function GetClientData( strName )
		GetClientData = m_oPFS.GetClientData(strName)
	End Function

	' String "ok" / "cancel"
	Public Property Get ReturnValue
		ReturnValue = m_oPFS.GetReturnValue()
	End Property
	
	' String : "userworkspace" / "masterworkspace"
	Public Property Get SelectedChoise
		SelectedChoise = m_oPFS.GetChoiceSelected()
	End Property
End Class



Class ProjectfileSelection
	Dim xd
	Dim xdElementApplication
	Dim xdElementProject
	Dim xdElementWorkspaces
	Dim xdElementOptions
	Dim xdElementChoices
	Dim xdElementClientData
	Dim xdElementReturnValue

	'**************************************************************
	Private Sub Class_Initialize()
		Dim N, xdChoice, xdWorkspace, xdOption, xtText
		
		Set xd = server.createobject("MSXML2.DOMDocument.3.0")
		Set N = xd.createProcessingInstruction("xml", "version=""1.0"" encoding=""UTF-8""")
		xd.appendChild N
	
		
		Set xdElementApplication = xd.createElement("application")
		xdElementApplication.SetAttribute "name", "projectfileselection"
		xdElementApplication.SetAttribute "lang", "en-us"
		
		
		Set xdElementProject = xd.createElement("project")
		xdElementProject.SetAttribute "name", ""
		xdElementProject.SetAttribute "path", ""
		xdElementApplication.appendChild xdElementProject
		
		
		Set xdElementWorkspaces = xd.createElement("workspaces")
			
			Set xdWorkspace = xd.createElement("workspace")
			xdWorkspace.SetAttribute "name", "masterworkspace"
			xdWorkspace.SetAttribute "fileexists", ""
			xdWorkspace.SetAttribute "filedate", ""
			xdElementWorkspaces.appendChild xdWorkspace
			
			Set xdWorkspace = xd.createElement("workspace")
			xdWorkspace.SetAttribute "name", "userworkspace"
			xdWorkspace.SetAttribute "fileexists", ""
			xdWorkspace.SetAttribute "filedate", ""
			xdElementWorkspaces.appendChild xdWorkspace
		
		xdElementApplication.appendChild xdElementWorkspaces
		
		
		Set xdElementOptions = xd.createElement("options")
			
			Set xdOption = xd.createElement("option")
			xdOption.SetAttribute "name", "copyoption"
			Set xtText = xd.createTextNode("MRFS_BACKUP_FILE_IF_EXISTS")
			xdOption.appendChild xtText
			xdElementOptions.appendChild xdOption
			
			Set xdOption = xd.createElement("option")
			xdOption.SetAttribute "name", "unlockproject"
			xdOption.SetAttribute "show", "false"
			xdOption.SetAttribute "selected", "false"
			xdElementOptions.appendChild xdOption
			
		xdElementApplication.appendChild xdElementOptions
		
		
		Set xdElementChoices = xd.createElement("choices")
		xdElementChoices.SetAttribute "selected", ""
		
			Set xdChoice = xd.createElement("choice")
			xdChoice.SetAttribute "name", "masterworkspace"
			xdChoice.SetAttribute "allow", "true"
			Set xtText = xd.createTextNode("false")
			xdChoice.appendChild xtText
			xdElementChoices.appendChild xdChoice
			
			Set xdChoice = xd.createElement("choice")
			xdChoice.SetAttribute "name", "userworkspace"
			xdChoice.SetAttribute "allow", "true"
			Set xtText = xd.createTextNode("false")
			xdChoice.appendChild xtText
			xdElementChoices.appendChild xdChoice
			
			Set xdChoice = xd.createElement("choice")
			xdChoice.SetAttribute "name", "newfile"
			xdChoice.SetAttribute "allow", "true"
			Set xtText = xd.createTextNode("false")
			xdChoice.appendChild xtText
			xdElementChoices.appendChild xdChoice
			
			Set xdChoice = xd.createElement("choice")
			xdChoice.SetAttribute "name", "uploadfile"
			xdChoice.SetAttribute "allow", "true"
			Set xtText = xd.createTextNode("false")
			xdChoice.appendChild xtText
			xdElementChoices.appendChild xdChoice
		
		xdElementApplication.appendChild xdElementChoices
		
		Set xdElementClientData = xd.createElement("clientdata")
		xdElementApplication.appendChild xdElementClientData
		
		Set xdElementReturnValue = xd.createElement("returnvalue")
		xdElementApplication.appendChild xdElementReturnValue
		
		xd.appendChild xdElementApplication
	End Sub
	
	'**************************************************************
	Private Sub Class_Terminate()
		Set xdElementReturnValue = Nothing
		Set xdElementClientData = Nothing
		Set xdElementChoices = Nothing
		Set xdElementOptions = Nothing
		Set xdElementWorkspaces = Nothing
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
	Public Sub SetFileName(strFileName)
		xdElementProject.SetAttribute "filename", strFileName
	End Sub
	
	'**************************************************************
	Public Function GetFileName()
		GetFileName = xdElementProject.attributes.getNamedItem("filename").Text
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
	' WORKSPACE
	'**************************************************************
	Public Sub SetWorkspaceAttribute(strWorkspaceName, strAttrName, strValue)
		Dim objNodeList, i
		Set objNodeList = xdElementWorkspaces.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strWorkspaceName ) Then
				objNodeList.item(i).SetAttribute strAttrName, strValue
				Exit For
			End If
		Next
	End Sub
	
	'**************************************************************
	Public Function GetWorkspaceAttribute(strWorkspaceName, strAttrName)
		Dim objNodeList, i
		Set objNodeList = xdElementWorkspaces.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strWorkspaceName ) Then
				GetWorkspaceAttribute = objNodeList.item(i).attributes.getNamedItem(strAttrName).Text
				Exit For
			End If
		Next
	End Function
	
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
	' CHOICE
	'**************************************************************
	Public Sub SetChoiceSelected(value)
		xdElementChoices.SetAttribute "selected", value
	End Sub
	
	'**************************************************************
	Public Function GetChoiceSelected()
		GetChoiceSelected = xdElementChoices.attributes.getNamedItem("selected").Value
	End Function
	
	'**************************************************************
	Public Sub SetChoiceAllowed(strChoiceName, strAllowed)
		Dim objNodeList, i
		Set objNodeList = xdElementChoices.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strChoiceName ) Then
				objNodeList.item(i).SetAttribute "allow", strAllowed
				Exit For
			End If
		Next
	End Sub
	
	'**************************************************************
	Public Function GetChoiceAllowed(strChoiceName)
		Dim objNodeList, i
		Set objNodeList = xdElementChoices.childNodes
		For i = 0 To objNodeList.Length-1 
			If( objNodeList.item(i).attributes.getNamedItem("name").Text = strChoiceName ) Then
				GetChoiceAllowed = objNodeList.item(i).attributes.getNamedItem("allow").Text
				Exit For
			End If
		Next
	End Function
	
	'**************************************************************
	Public Sub SetChoiceDisplayed(strChoiceName, strDisplay)
		Dim objNodeList, curNode, i
		
		Set objNodeList = xdElementChoices.childNodes
		For i = 0 To objNodeList.Length-1 
			Set curNode = objNodeList.item(i)
			If( curNode.attributes.getNamedItem("name").Text = strChoiceName ) Then
				curNode.childNodes(0).nodeValue = strDisplay
				Exit For
			End If
		Next
	End Sub
	
	'**************************************************************
	Public Function GetChoiceDisplayed(strChoiceName)
		Dim objNodeList, curNode, i
		
		Set objNodeList = xdElementChoices.childNodes
		For i = 0 To objNodeList.Length-1 
			Set curNode = objNodeList.item(i)
			If( curNode.attributes.getNamedItem("name").Text = strChoiceName ) Then
				GetChoiceDisplayed = curNode.childNodes(o).nodeValue
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
		Set xdElementWorkspaces = xd.getElementsByTagName("workspaces").item(0)
		Set xdElementOptions = xd.getElementsByTagName("options").item(0)
		Set xdElementChoices = xd.getElementsByTagName("choices").item(0)
		Set xdElementClientData = xd.getElementsByTagName("clientdata").item(0)
		Set xdElementReturnValue = xd.getElementsByTagName("returnvalue").item(0)
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
