<%Session.CodePage=1252
'***************************************
' File:	  Upload.asp
' Author: Jacob "Beezle" Gilley
' Email:  avis7@airmail.net
' Date:   12/07/2000
' Comments: The code for the Upload, CByteString, 
'			CWideString	subroutines was originally 
'			written by Philippe Collignon...or so 
'			he claims. Also, I am not responsible
'			for any ill effects this script may
'			cause and provide this script "AS IS".
'			Enjoy!
'****************************************

Class FileUploader
	Public  Files
	Private mcolFormElem

	Private Sub Class_Initialize()
		Set Files = Server.CreateObject("Scripting.Dictionary")
		Set mcolFormElem = Server.CreateObject("Scripting.Dictionary")
	End Sub
	
	Private Sub Class_Terminate()
		If IsObject(Files) Then
			Files.RemoveAll()
			Set Files = Nothing
		End If
		If IsObject(mcolFormElem) Then
			mcolFormElem.RemoveAll()
			Set mcolFormElem = Nothing
		End If
	End Sub

	Public Property Get Form(sIndex)
		Form = ""
		If mcolFormElem.Exists(LCase(sIndex)) Then Form = mcolFormElem.Item(LCase(sIndex))
	End Property

	Public Default Sub Upload()
		Dim biData, sInputName
		Dim nPosBegin, nPosEnd, nPos, vDataBounds, nDataBoundPos
		Dim nPosFile, nPosBound

		biData = Request.BinaryRead(Request.TotalBytes)
		nPosBegin = 1
		nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(13)))
		
		If (nPosEnd-nPosBegin) <= 0 Then Exit Sub
		 
		vDataBounds = MidB(biData, nPosBegin, nPosEnd-nPosBegin)
		nDataBoundPos = InstrB(1, biData, vDataBounds)
		
		Do Until nDataBoundPos = InstrB(biData, vDataBounds & CByteString("--"))
			
			nPos = InstrB(nDataBoundPos, biData, CByteString("Content-Disposition"))
			nPos = InstrB(nPos, biData, CByteString("name="))
			nPosBegin = nPos + 6
			nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(34)))
			sInputName = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
			nPosFile = InstrB(nDataBoundPos, biData, CByteString("filename="))
			nPosBound = InstrB(nPosEnd, biData, vDataBounds)
			
			If nPosFile <> 0 And  nPosFile < nPosBound Then
				Dim oUploadFile, sFileName
				Set oUploadFile = New UploadedFile
				
				nPosBegin = nPosFile + 10
				nPosEnd =  InstrB(nPosBegin, biData, CByteString(Chr(34)))
				sFileName = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
				oUploadFile.FileName = Right(sFileName, Len(sFileName)-InStrRev(sFileName, "\"))

				nPos = InstrB(nPosEnd, biData, CByteString("Content-Type:"))
				nPosBegin = nPos + 14
				nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(13)))
				
				oUploadFile.ContentType = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
				
				nPosBegin = nPosEnd+4
				nPosEnd = InstrB(nPosBegin, biData, vDataBounds) - 2
				oUploadFile.FileData = MidB(biData, nPosBegin, nPosEnd-nPosBegin)
				
				If oUploadFile.FileSize > 0 Then Files.Add LCase(sInputName), oUploadFile
			Else
				nPos = InstrB(nPos, biData, CByteString(Chr(13)))
				nPosBegin = nPos + 4
				nPosEnd = InstrB(nPosBegin, biData, vDataBounds) - 2
				If Not mcolFormElem.Exists(LCase(sInputName)) Then mcolFormElem.Add LCase(sInputName), CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
			End If

			nDataBoundPos = InstrB(nDataBoundPos + LenB(vDataBounds), biData, vDataBounds)
		Loop
	End Sub

	'String to byte string conversion
	Private Function CByteString(sString)
		Dim nIndex
		For nIndex = 1 to Len(sString)
		   CByteString = CByteString & ChrB(AscB(Mid(sString,nIndex,1)))
		Next
	End Function

	'Byte string to string conversion
	Private Function CWideString(bsString)
		Dim nIndex
		CWideString =""
		For nIndex = 1 to LenB(bsString)
		   CWideString = CWideString & Chr(AscB(MidB(bsString,nIndex,1))) 
		Next
	End Function
End Class

Class UploadedFile
	Public ContentType
	Public FileName
	Public FileData
	
	Public Property Get FileSize()
		FileSize = LenB(FileData)
	End Property

	Public Sub SaveToDisk(sPath)
		Dim oFS, oFile
		Dim nIndex
	
		If sPath = "" Or FileName = "" Then Exit Sub
		If Mid(sPath, Len(sPath)) <> "\" Then sPath = sPath & "\"
	
		Set oFS = Server.CreateObject("Scripting.FileSystemObject")
		If Not oFS.FolderExists(sPath) Then Exit Sub
		
		Set oFile = oFS.CreateTextFile(sPath & FileName, True)
		
		If IsADODBInstalled() Then
			oFile.Write RSBinaryToString(FileData)
		Else
			' (kklausen) : THIS LOOP IS A VERY SLOW :(
			For nIndex = 1 to LenB(FileData)
				oFile.Write Chr(AscB(MidB(FileData,nIndex,1)))
			Next
		End If
		
		oFile.Close
	End Sub
	
	Public Function ExistsInFolder(sPath)
		Dim oFS
		Set oFS = Server.CreateObject("Scripting.FileSystemObject")
		ExistsInFolder = oFS.FileExists(sPath & FileName)
		Set oFS = Nothing
	End Function
	
	
	Public Sub SaveToDatabase(ByRef oField)
		If LenB(FileData) = 0 Then Exit Sub
		
		If IsObject(oField) Then
			oField.AppendChunk FileData
		End If
	End Sub
	
	
	' Functions for convertion bytearray to a string
	' Uses ADODB.Recordset so this must exist on the server
	Function IsADODBInstalled()
		On Error Resume Next
			Dim RS
			Set RS = CreateObject("ADODB.Recordset")
			If Err.number <> 0 Then
				IsADODBInstalled = False
			Else
				IsADODBInstalled = True
			End If
		On Error Goto 0
	End Function
	
	Function RSBinaryToString(xBinary)
		'Antonin Foller, http://www.pstruh.cz
		'RSBinaryToString converts binary data (VT_UI1 | VT_ARRAY Or MultiByte string)
		'to a string (BSTR) using ADO recordset

		Dim Binary
		'MultiByte data must be converted To VT_UI1 | VT_ARRAY first.
		If vartype(xBinary)=8 Then Binary = MultiByteToBinary(xBinary) Else Binary = xBinary
		  
		Dim RS, LBinary
		Const adLongVarChar = 201
		Set RS = CreateObject("ADODB.Recordset")
		LBinary = LenB(Binary)
		  
		If LBinary>0 Then
			RS.Fields.Append "mBinary", adLongVarChar, LBinary
			RS.Open
			RS.AddNew
			RS("mBinary").AppendChunk Binary 
			RS.Update
			RSBinaryToString = RS("mBinary")
		Else
			RSBinaryToString = ""
		End If
	End Function
	
	Function MultiByteToBinary(MultiByte)
		'© 2000 Antonin Foller, http://www.pstruh.cz
		' MultiByteToBinary converts multibyte string To real binary data (VT_UI1 | VT_ARRAY)
		' Using recordset
		Dim RS, LMultiByte, Binary
		Const adLongVarBinary = 205
		Set RS = CreateObject("ADODB.Recordset")
		LMultiByte = LenB(MultiByte)
		If LMultiByte>0 Then
			RS.Fields.Append "mBinary", adLongVarBinary, LMultiByte
			RS.Open
			RS.AddNew
			RS("mBinary").AppendChunk MultiByte & ChrB(0)
			RS.Update
			Binary = RS("mBinary").GetChunk(LMultiByte)
		End If
		MultiByteToBinary = Binary
	End Function
End Class
Session.CodePage=65001%>
