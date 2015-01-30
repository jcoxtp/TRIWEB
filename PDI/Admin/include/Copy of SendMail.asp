<%
	Sub SendMail(strFromEmail,strFromName,strSubject,strToEmail,strCCEmail,strBody)
		Dim JMail
		Set JMail = Server.CreateObject("JMail.SMTPMail") 
		JMail.ServerAddress = "www.pdiprofile.com:25" ' change this to your mail server
		JMail.Sender = strFromEmail 
		JMail.SenderName = strFromName
		JMail.Subject = strSubject 
		JMail.AddRecipient(strToEmail)
		'Its not sending the cc  - not sure why - but this is based on old syntax
		'anyway and will need to be updated at some point so I'm hacking it 
		'for the moment to save time/money - MG 4-6-04
		'JMail.AddRecipientCC(strCCEmail)
		JMail.AddRecipient(strCCEmail)
		JMail.Body = strBody
		JMail.Priority = 3
		JMail.Execute
		Set JMail = Nothing
	End Sub 
%>