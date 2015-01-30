<%
Class FileManager
	Dim xd
	Dim xdElementApplication
	Dim xdElementDirectories
	Dim xdElementOptions
	Dim xdElementClientData
	Dim xdElementReturnValue

	Private Sub Class_Initialize()
		Dim N
		
		Set xd = server.createobject("MSXML2.DOMDocument.3.0")
		Set N = xd.createProcessingInstruction("xml", "version=""1.0"" encoding=""UTF-8""")
		xd.appendChild N
	
		Set xdElementApplication = xd.createElement("application")
		xdElementApplication.SetAttribute "name", "filemanager"
		Set xdElementDirectories = xd.createElement("directories")
		xdElementApplication.appendChild xdElementDirectories
		Set xdElementOptions = xd.createElement("options")
		xdElementApplication.appendChild xdElementOptions
		Set xdElementClientData = xd.createElement("clientdata")
		xdElementApplication.appendChild xdElementClientData
		Set xdElementReturnValue = xd.createElement("returnvalue")
		xdElementApplication.appendChild xdElementReturnValue
		
		xdElementApplication.SetAttribute "selection", ""
		xdElementApplication.SetAttribute "lang", "en-us"
		
		xd.appendChild xdElementApplication
	End Sub
	
	Private Sub Class_Terminate()
		Set xdElementReturnValue = Nothing
		Set xdElementClientData = Nothing
		Set xdElementOptions = Nothing
		Set xdElementDirectories = Nothing
		Set xdElementApplication = Nothing
		Set xd = Nothing
	End Sub
	
	Public Function GetElementAttribute(elementName, AttrName)
		Dim objNodeList
		Set objNodeList = xd.getElementsByTagName(elementName)
		
		Dim i
		For i = 0 To (objNodeList.length - 1)
			GetElementAttribute = objNodeList.item(0).attributes.getNamedItem(AttrName).Text
			Exit Function
		Next
	End Function 
	
	Public Function GetDirectoryFromAlias(Alias)
		Dim objNodeList
		Set objNodeList = xd.getElementsByTagName("directory")
		Dim i
		For i = 0 To (objNodeList.length - 1)
			if( objNodeList.item(i).attributes.getNamedItem("name").Text = Alias ) Then
				GetDirectoryFromAlias = objNodeList.item(i).Text
				Exit Function
			End If
		Next
		
		GetDirectoryFromAlias = ""
	End Function 
	
	Public Function GetElementList(elementName)
		Set GetElementList = xd.getElementsByTagName(elementName)
	End Function
		
	Public Sub SetOptionsAttribute(attr, value)
		xdElementOptions.SetAttribute attr, value
	End Sub
	
	Public Function GetOptionsAttribute(attr)
		GetOptionsAttribute = xdElementOptions.GetAttribute(attr)
	End Function
	
	Public Sub AddDirectory(strDescription, strDirectory)
		Dim xdElementDirectory
		Dim objChildNode
		Set xdElementDirectory = xd.createElement("directory")
		xdElementDirectory.SetAttribute "name", strDescription
		Set objChildNode = xd.createTextNode(strDirectory)
		xdElementDirectory.appendChild objChildNode
		xdElementDirectories.appendChild xdElementDirectory
		Set objChildNode = Nothing
		Set xdElementDirectory = Nothing
	End Sub
	
	Public Sub SetDirectoriesAttribute(attr, value)
		xdElementDirectories.SetAttribute attr, value
	End Sub	
	
	Public Sub AddOption(name, value)
		Dim xdElementOption
		Dim objChildNode
		
		Set xdElementOption = xd.createElement("option")
		xdElementOption.SetAttribute "name", name
		Set objChildNode = xd.createTextNode(value)
		
		xdElementOption.appendChild objChildNode
		xdElementOptions.appendChild xdElementOption
	End Sub
	
	Public Function GetOption(name)
		Dim objNodeList
		Dim i
		
		Set objNodeList = xd.getElementsByTagName("options")
		For i = 0 To objNodeList.Length-1 
			if( objNodeList.item(i).attributes.getNamedItem("name").Text = name ) Then
				GetOption = objNodeList.item(i).attributes.getNamedItem("name").Value
				Exit For
			End if
		Next
	End Function
	
	Public Function GetDirectory(name)
		Dim objNodeList
		Dim i
		
		Set objNodeList = xd.getElementsByTagName("directory")
		For i = 0 To objNodeList.Length-1 
			if( objNodeList.item(i).attributes.getNamedItem("name").Text = name ) Then
				GetDirectory = objNodeList.item(i).Text
				Exit For
			End if
		Next
	End Function
	
	Public Sub SetReturnValue(strReturnValue)
		xdElementReturnValue.Text = strReturnValue
	End Sub
	
	Public Function GetReturnValue()
		GetReturnValue = xdElementReturnValue.Text
	End Function
	
	Public Sub SetLanguage(strLanguage)
		xdElementApplication.SetAttribute "lang", strLanguage
	End Sub
	
	Public Function GetLanguage()
		GetLanguage = xdElementApplication.attributes.getNamedItem("lang").Text
	End Function
	
	Public Sub SetSelection(strSelection)
		xdElementApplication.SetAttribute "selection", strSelection
	End Sub
	
	Public Function GetSelection()
		GetSelection = xdElementApplication.attributes.getNamedItem("selection").Text
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
	
	Public Sub Dump(strDirFN)
		xd.save(strDirFN)
	End Sub
	
	Public Function GetXML()
		GetXML = xd.xml
	End Function
	
	Public Sub SetXML(xmldata)
		Dim objNodeList
		
		xd.loadXML(xmldata)
		
		Set objNodeList = xd.getElementsByTagName("application")
		Set xdElementApplication = objNodeList.item(0)
		Set objNodeList = xd.getElementsByTagName("directories")
		Set xdElementDirectories = objNodeList.item(0)
		Set objNodeList = xd.getElementsByTagName("options")
		Set xdElementOptions = objNodeList.item(0)
		Set objNodeList = xd.getElementsByTagName("clientdata")
		Set xdElementClientData = objNodeList.item(0)
		Set objNodeList = xd.getElementsByTagName("returnvalue")
		Set xdElementReturnValue = objNodeList.item(0)
	End Sub
	
	Public Function Transform(strxsltdoc)
		Dim objStylesheet
		Dim retHTML
		on error resume next
		Set objStylesheet = server.createobject("MSXML2.DOMDocument.3.0")
		objStylesheet.async = False
		objStylesheet.Load Server.MapPath( strxsltdoc )
		retHTML = xd.transformNode(objStylesheet)
		Set objStylesheet = Nothing
		on error goto 0
		Transform = retHTML
	End Function
	
End Class
%>