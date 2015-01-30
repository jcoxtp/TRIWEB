<%	
	Option Explicit
	response.buffer=false 
'****************************************************
'
' Name:		uploadFile.asp
' Purpose:	page to upload images
'
'
' Author:	    Ultimate Software Designs
' Date Written:	6/24/2002
' Modified:		
'
' Changes:
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html;">    
   
 <%  
   Dim strReturnPage
   Dim intUserType
   Dim Func
   Dim BrowseServer
   Dim strPath
   Dim strBinaryDataStream
   Dim lngCount
   Dim intDataStartPosition
   Dim intDataEndPosition
   Dim strFieldValue
   Dim intNamePosition    				
   Dim strSavePath
   Dim strFileName
   Dim strFileData
   Dim ForWriting 
   Dim lngNumberUploaded
   Dim lngBytes
   Dim binData
   Dim boolFileExists
   Dim intSurveyID
   Dim intUserID
  
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfoWithoutSettingCookies(intUserID, intUserType, "","", "")
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	
	strReturnPage = Request.QueryString("returnPage")
	
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
 %>
	<%=header_htmlTop("white","")%>
    <%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
 
    
    <br />
    <span class="surveyTitle">Upload Image</span>
    <hr noshade color="#C0C0C0" size="2">
 <%
    Func = cint(Request("Func"))
    if not utility_isPositiveInteger(Func) Then
    	Func = 1
    End if
    Select Case Func
    Case 1
    'You do not need to use this form to 
    'send your files.
    BrowseServer = Request.Form("BrowseServer")
    %>
    

			

    	<table class="normal">
    	
    		
    		<FORM ENCTYPE="multipart/form-data" ACTION="uploadFile.asp?func=2&surveyID=<%=intSurveyID%>&returnPage=<%=server.URLEncode(strReturnPage)%>" METHOD=POST id=form1 name=form1>
    		<INPUT NAME=ServerPath TYPE=Hidden value='<%= SV_UPLOADED_IMAGE_FOLDER %>'>
    		<TR><TD><STRONG>Hit the [Browse] button to find the file on your computer.</STRONG><BR></TD></TR>
    		<TR><TD><INPUT NAME=File1 SIZE=30 TYPE=file src="images/button-uploadImage.gif"><BR></TD></TR>
    		<TR><TD align=left><INPUT name=submit type="hidden" value="Upload File">
    		<input type="image" alt="Upload File" src="images/button-uploadFile.gif" border="0">
    		<BR><BR></TD></TR>
    		<TR><TD>NOTE: Please be patient, you will not receive any notification until the file is completely transferred.<BR><BR></TD></TR>
    		</FORM>
    	</TABLE>

    <%
    Case 2 ' File Upload
		
		Const UTILITY_TIMEOUT = 300
		Const MAX_FILE_SIZE = 500000 'Max upload size in bytes

		
		' Allows for large file upload
		Server.ScriptTimeout = UTILITY_TIMEOUT
   	
		'Get binary data from form		
    	lngBytes = Request.TotalBytes 
    	binData = Request.BinaryRead (lngBytes)
    	
    	
    	'Get the path to save the file in
    	strSavePath = Utility_ParseForm("ServerPath", binData)
		
		' Convert the binary data stream to a string
		strBinaryDataStream = FileSystemUtility_ConvertFormDataToString(binData)
    	 
		' Get the filename out of the data stream
		strFileName = FileSystemUtility_GetFileNameFromDataStream(strBinaryDataStream)

		' TO DO: Check that the file is a jpg or a gif
 
			
    	' Get the file out of the data stream
   		strFileData = FileSystemUtility_FindFileInDataStream(strBinaryDataStream)

		
		' TO DO: You may want to set the filename on your own rather than just use whatever the user typed in

		' Check that a file was found and that it is of acceptable size		
		If strFileData <> "" and Len(strFileData) <= MAX_FILE_SIZE and strSavePath <> "" Then
			' Save the file to the disk
    		If len(trim(strFileName)) = 0 Then
%>
				<span class="message">Please specify a file.</span><a href="uploadFile.asp?surveyID=<%=intSurveyID%>&returnPage=<%=server.URLEncode(strReturnPage)%>">Choose File</a>
<%
			Else
    			FileSystemUtility_SaveDataToDisk strFileData, strSavePath, strFileName, boolFileExists
			
%>
			
<%
				If boolFileExists = False Then
%>		
					<span class="heading">1 File Uploaded:</span>
					<span class="normalBold"><%=strFileName%></span>
					<br /><a class="normalBold" href="<%=strReturnPage%>&fileUploaded=<%=strFileName%>">
						Continue
					</a>
<%
				Else
%>
					<span class="message">File Already Exists.</span><br />
					<a class="normalBold" href="uploadFile.asp?surveyID=<%=intSurveyID%>&returnPage=<%=server.URLEncode(strReturnPage)%>">Choose Another File</a>				
<%
				End If
			End If
	   	Else
%>
	   		<span class="message">Invalid Path.</span><br />
<%
	   	End If    	
    	    	
    	Case 3
    	
    		'get prev path if any
    		path = SV_UPLOADED_IMAGE_FOLDER
    		'if Not assign one
    		if path = "" or isempty(path) Then
    			path = server.MapPath(".")
    		End if
    		'create filesystemobject
    		Set fso = CreateObject("Scripting.FileSystemObject")
    		'get a folder object
    		Set f = fso.GetFolder(path)
    		path = f.path
    		
		
    		Response.Write "<H2>Server Browse Form.</H2>"	
    		Response.Write "<FORM ACTION='uploadFile.asp?func=1&returnPage=" & server.URLEncode(strReturnPage) & "' METHOD=POST>"
    		Response.Write "<TABLE width=400 border=1 cellpadding=0 cellspacing=1>" & vbcrlf
    		Response.Write "<TR><TH colspan=2>" & path & "</TH></TR>"
    		Response.Write "<TR><TD colspan=2 align=left><A href='uploadFile.asp?func=3&retrunPage=" & server.URLEncode(strReturnPage) & "&path=" & path & "\..'><STRONG>Parent ..</STRONG></A></TD></TR>" & vbcrlf
    		
    		'get subfolders collection
    		Set fc = f.subfolders
    		
    		'enum subfolders 
    		For Each folder In fc
    			Response.Write "<TR><TD align=left><INPUT NAME=BrowseServer TYPE=CheckBox Value='" & folder.path & "'></TD><TD style='padding-left: 20px;' align=left><A href='uploadFile.asp?func=3&advertiserID=" & intAdvertiserID & "&path=" & folder.path & "'>" & folder.name & "</A></TD></TR>" & vbcrlf
    		Next
    		
    		'if there is a folder display the Select folder button
    			if fc.count > 0 Then
    				Response.Write "<TR><TD align=left colspan=2><BR><INPUT name=submit type='submit' value='Select Folder'></TD></TR>"
    			End if
    		
    			Response.Write"<TR><TD colspan=2><INPUT name=cancel type='Button' value='Cancel' onclick=document.location='uploadFile.asp?func=1&advertiserID=" & intAdvertiserID & "'></TD></TR>"
    		
    		Response.Write "</TABLE>" & vbcrlf
    		Response.Write "</FORM>"
    End Select
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->
<%    

Function FileSystemUtility_ConvertFormDataToString(binDataIn)

		Dim rsBinaryData
		Dim intBinaryStreamLen
		
		' Convery the binary data to a string
    	Set rsBinaryData = CreateObject("ADODB.Recordset")
    	intBinaryStreamLen = LenB(binDataIn)    	
    	
    	' Check the length of the binary stream and convert it to a string
    	If intBinaryStreamLen > 0 Then
    		rsBinaryData.Fields.Append "BinaryStream", 201, intBinaryStreamLen
    		rsBinaryData.Open
    		rsBinaryData.AddNew
    		rsBinaryData("BinaryStream").AppendChunk binDataIn
    		rsBinaryData.Update
    		FileSystemUtility_ConvertFormDataToString = rsBinaryData("BinaryStream")
    	Else
    	
    		FileSystemUtility_ConvertFormDataToString = ""
    	
    	End If
    	    

End Function


Function FileSystemUtility_FindFileInDataStream(strDataStreamIn)

		Dim intCharacterCount
		Dim intDataStartPosition
		Dim intDataEndPosition
		Dim intDataLength

		' Find the beginning of the file in the data stream
		intCharacterCount = instr(1,strDataStreamIn,"Content-Type:")
					
		if intCharacterCount > 0 Then
	    	intDataStartPosition = instr(intCharacterCount,strDataStreamIn,chr(13) & chr(10)) + 4
			
			'Get the ending position of the file 'data sent.
    		intDataEndPosition = len(strDataStreamIn) 
			
			'Calculate the file size.
			intDataLength = (intDataEndPosition - intDataStartPosition) -1
				
			'Get the file data	
    		FileSystemUtility_FindFileInDataStream = mid(strDataStreamIn,intDataStartPosition,intDataLength)			
    	
		Else
    		FileSystemUtility_FindFileInDataStream = ""
    	End if


End Function

Function FileSystemUtility_GetFileNameFromDataStream(strDataStream) 
    
		Dim intFileStartPosition
		Dim intFileEndPosition
		Dim strFullFileName
		Dim intCurrentCharacter
		Dim intPreviousCharacter
    				
		'Get the full path of the current file.
   		intFileStartPosition = instr(1,strDataStream,"filename=") + 10
   		intFileEndPosition = instr(intFileStartPosition,strDataStream,chr(34)) 
    		
   		if intFileStartPosition = intFileEndPosition Then
    		
   			' Error -- no filename found
   			FileSystemUtility_GetFileNameFromDataStream = ""
		Else
    		
    		' Get the filename out of the data stream
    		strFullFilename = mid(strDataStream,intFileStartPosition,intFileEndPosition - intFileStartPosition)
    	
    	
    		' Parse out the folders that are in the filepath to get the filename
    		intCurrentCharacter = instr(1,strFullFilename,"\")
    		Do While intCurrentCharacter > 0
    			intPreviousCharacter = intCurrentCharacter
    			intCurrentCharacter = instr(intPreviousCharacter + 1,strFullFilename,"\")
    		Loop    		
    	
	    	' Get the filename in between the boundaries
	    	strFileName = right(strFullFilename,len(strFullFileName) - intPreviousCharacter)
	    	
			' Return the name of the file
	    	FileSystemUtility_GetFileNameFromDataStream = strFileName
	    
	    End If

End Function    		


Function FileSystemUtility_SaveDataToDisk (strFileData, strPath, strFileName, boolFileExists)

    		Dim objFSO
    		Dim objFile
    		Dim strFullFilePath
    		strFullFilePath = strPath & "\" & strFileName
    		'Create the file.	
			Set objFSO = CreateObject("Scripting.FileSystemObject")
    		Response.Write strPath
    		If objFSO.FolderExists(strPath) = False Then
    			objFSO.CreateFolder(strPath)
    		End If
    		If objFSO.FileExists(strFullFilePath) = True Then
				boolFileExists = True
    		Else
    			Set objFile = objFSO.OpenTextFile(strFullFilePath, 2, True)
    			objFile.Write strFileData
    			boolFileExists = False
    			
    		End If
    	
    		
    		Set objFile = nothing
    		Set objFSO = nothing
 	

End Function
    			
   

Function Utility_ParseForm(strFieldName, binDataIn)
    	
		Dim rsBinaryData
		Dim intBinaryStreamLen
		Dim strBoundary
		Dim intBoundaryPosition
		Dim intNamePosition
		Dim intDataStartPosition
		Dim intDataEndPosition
		
		' Convert the binary data to a string
    	Set rsBinaryData = CreateObject("ADODB.Recordset")
    	intBinaryStreamLen = LenB(binDataIn)
    	
    	'get the Boundary indicator
    	strBoundary = Request.ServerVariables ("HTTP_CONTENT_TYPE")
    	intBoundaryPosition = instr(1,strBoundary,"boundary=") + 8 
    	strBoundary = "--" & right(strBoundary,len(strBoundary)-intBoundaryPosition)
    		

    	' Check the length of the binary stream
    	If intBinaryStreamLen > 0 Then
    		rsBinaryData.Fields.Append "BinaryStream", 201, intBinaryStreamLen
    		rsBinaryData.Open
    		rsBinaryData.AddNew
    		rsBinaryData("BinaryStream").AppendChunk BinDataIn
    		rsBinaryData.Update
    		strBinaryDataStream = rsBinaryData("BinaryStream")
    	End if
    	
    	' Try To find the Field in the binary stream
    	intNamePosition = instr(1,strBinaryDataStream,"name=" & chr(34) & strFieldName & chr(34))
  
		' Check to see if the field was found
		If intNamePosition > 0 Then 
   			lngCount = lngCount + 1
   			intDataStartPosition = instr(intNamePosition,strBinaryDataStream,vbcrlf & vbcrlf)+4
   			intDataEndPosition = instr(intDataStartPosition,strBinaryDataStream,strBoundary)-2
   			strFieldValue =  mid(strBinaryDataStream,intDataStartPosition,intDataEndPosition-intDataStartPosition)
   			intNamePosition = instr(intDataEndPosition,strBinaryDataStream,"name=" & chr(34) & strFieldName & chr(34))    				
    	End If
    	
    	' Send back the field's value
    	Utility_ParseForm = strFieldValue
End function
    	
    %>
 