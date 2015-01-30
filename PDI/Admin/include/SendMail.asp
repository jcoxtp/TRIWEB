<%
	Sub SendMail(strFromEmail,strFromName,strSubject,strToEmail,strCCEmail,strBody)
		Dim JMail
		Set JMail = Server.CreateObject("JMail.Message") 
		JMail.Logging = true
		JMail.Silent = true
		
		JMail.From = strFromEmail 
		JMail.FromName = strFromName
		JMail.MailServerUserName = "DISC"
		JMail.MailServerPassword = "s3rv3r pa33word!"
		
		JMail.Subject = strSubject 
		JMail.AddRecipient strToEmail
		'Its not sending the cc  - not sure why - but this is based on old syntax
		'anyway and will need to be updated at some point so I'm hacking it 
		'for the moment to save time/money - MG 4-6-04
		'UPDATE: Using JMail Upgrade. Set back to AddRecipientCC from AddRecipient -- MP 1-16-06
		JMail.AddRecipientCC strCCEmail
		JMail.Body = strBody

		JMail.Send("www.pdiprofile.com:25")

		Set JMail = Nothing
	End Sub 
	
	Sub SendSimpleMail(strFromEmail,strFromName,strSubject,strToEmail,strBody)
		Dim JMail
		Set JMail = Server.CreateObject("JMail.Message") 
		JMail.Logging = true
		JMail.Silent = true
		
		JMail.From = strFromEmail 
		JMail.FromName = strFromName
		JMail.MailServerUserName = "DISC"
		JMail.MailServerPassword = "s3rv3r pa33word!"

		JMail.Subject = strSubject 
		JMail.AddRecipient strToEmail
		JMail.Body = strBody
		
		JMail.Send("www.pdiprofile.com:25")

		Set JMail = Nothing
	End Sub 
%>