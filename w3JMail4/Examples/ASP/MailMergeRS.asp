<% @LANGUAGE="VBSCRIPT" %>
<html>
<body>
<%

'*************************************************
'*                                               *
'*   Produced by Dimac                           *
'*                                               *
'*   More examples can be found at 				 *
'*   http://tech.dimac.net                       *
'*                                               *
'*   Support is available at our helpdesk        *
'*   http://support.dimac.net                    *
'*                                               *
'*   Our main website is located at              *
'*   http://www.dimac.net                        *
'*                                               *
'*************************************************

	' First we will create a message object that will serve as a 
	' template for the merge.
	' The merge fields are marked with %% in the front and in the 
	' end.
	' Note how we use merge fields even in the addRecipient method
	
	set msgTemplate = Server.CreateObject( "JMail.Message" )
	
	msgTemplate.From = "me@myDomain.com"
	msgTemplate.FromName = "Mailinglist info!"
	
	msgTemplate.AddRecipient "%%EMail%%>", "%%Name%%"
	
	msgTemplate.Subject = "Hi %%Name%%"
	msgTemplate.Body = "Hello %%Name%%,  you are my favorite website visitor!"	
	
	' There, our message template is done. Next we create the mailmerge object.
	set mMerge = Server.CreateObject( "JMail.MailMerge" )
	
	' Now, tell mailMerge to use the template we created earlier
	mMerge.MailTemplate = msgTemplate
	
	' Before we start emailing thousands of recipients, we make testrun.
	' The line below tells MailMerge to process only 10 recipients
	' and to send the emails to "myEMail@company.com" instead.
	' This way we can see if our template is as expected. When we
	' are ready to go live, just remove the line below.
	mMerge.SetDebugMode "myEMail@company.com", 10 

	
	' Okay lets do the merge. As we do an ADO resultset merge, we do not need to
	' specify each merge variable.
	' The myRS is assumed to hold a ADO recordset.
	
	' If we didn't have to many recipients, we wouldn't have to enque the emails,
	' instead we would have to specify the mailserver like this
	' MailMerge.BulkMerge( myRS, false, "mail.myDomain.com" )'
	' However, we will now enque it and therefore sets the second parameter to
	' true and instead of supplying the mailserver address, we specify where
	' our MS pickup directory is (if you run windows 2000 this is optional).
	
	' The BulkMerge() method automatically sends/enques our emails, so we
	' do not need to use the send() method.
	
	mMerge.BulkMerge myRS, true, "c:\inetpub\mailroot\pickup"
	
	' Thats it! One template, a workload of emails.
%>
Mailmerge complete!
</body>
</html>