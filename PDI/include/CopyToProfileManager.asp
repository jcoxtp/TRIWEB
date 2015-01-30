<%
	Sub CopyProfileManager(intUserID, TestCodeID, strPDFFileName)
		Dim JMail
		Dim strSubject, strToEmail, strBody
		Dim strUsername, bytIsProfileMgr, bytWantsCopy
		
		Dim oConn
		Dim oCmd

		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "sel_ProfileManagerCopyInfo"
			.CommandType = 4
			
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@userID", 3, 1, 4, intUserID)
			.Parameters.Append .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
			.Parameters.Append .CreateParameter("@UserName", 200, 3, 201, CStr(strUsername))
			.Parameters.Append .CreateParameter("@PmEmail", 200, 3, 50, CStr(strToEmail))
			.Parameters.Append .CreateParameter("@IsProfileMgr", 16, 3, , CByte(bytIsProfileMgr))
			.Parameters.Append .CreateParameter("@WantsCopyOfReport", 16, 3, , CByte(bytWantsCopy))
		End With
		
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		strUsername = oCmd.Parameters("@UserName").value
		strToEmail = oCmd.Parameters("@PmEmail").value
		bytIsProfileMgr = oCmd.Parameters("@IsProfileMgr").Value
		bytWantsCopy = oCmd.Parameters("@WantsCopyOfReport").Value
		
		If bytWantsCopy = 1 Then
			strSubject = strUsername & "'s PDI Assessment is Complete"
			strBody = strUsername & " has completed the DISC Inventory." & Chr(13) & _
						"The report can be viewed at " & Chr(13) & _
						"http://" & Application("SiteDomain") & Application("PDFOut_SitePath") & strPDFFileName
			
			Set JMail = Server.CreateObject("JMail.SMTPMail") 
			JMail.ServerAddress = "www.pdiprofile.com:25" ' change this to your mail server
			JMail.Sender = "info@teamresources.com" 
			JMail.SenderName = "PDI Survey Center"
			JMail.Subject = strSubject 
			JMail.AddRecipient(strToEmail)
			
			JMail.Body = strBody
			JMail.Priority = 3
			JMail.Execute
			Set JMail = Nothing
		End If
	End Sub 
%>