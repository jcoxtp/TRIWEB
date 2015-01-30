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
	
	msgTemplate.AddRecipient "%%EMail%%", "%%Name%%"
	
	msgTemplate.Subject = "Hi %%Name%%"
	msgTemplate.Body = "Hello %%Name%%,  you are my favorite website visitor!"
	
	
	
	' There, our message template is done. Next we create the mailmerge object.
	set mMerge = Server.CreateObject( "JMail.MailMerge" )
	
	' Now, tell mailMerge to use the template we created earlier
	mMerge.MailTemplate = msgTemplate
	
	
	' Now we have a few options on how to merge.
	' We can do it manually or by specifying an ADO Recordset. 
	
	' This is the manual way to do it.
	' We specify each merge variable and give it a value.
	' You will remember the mergeFields below from the template previously.
	mMerge.Item( "Name" ) = "Elvis Presley"
	mMerge.Item( "EMail" ) = "the.king@graceland.com"
	
	' When the merge variables are finished, we replace all mergeFields
	' in our template with the merge variables, using the expand() method.
	' expand() returns a Message object.
	set msg = mMerge.Expand
	
	' As usual we turn on logging and silent mode to handle possible errors.
	msg.Logging = true
	msg.silent = true
	
	if not msg.Send( "mail.myDomain.net" ) then
		Response.write "<pre>" & msg.log & "</pre>"
	else
		Response.write "Mailmerge successful and email sent succesfully!"
	end if  

	' Ok, thats one email sent, however to understand the purpose
	' of mailmerge, lets send another one.
	
	' Set some new values in the merge variables
	mMerge.Item( "Name" ) = "Frank Sinatra"
	mMerge.Item( "EMail" ) = "old.blue.eyes@twinpalms.com"
	
	' Now create us a new Message object with the new variables
	' but use the same template. Let's reuse the msg variable as
	' we no longer need the last email.
	set msg = mMerge.Expand
	
	' As usual we turn on logging and silent mode to handle possible errors.
	msg.Logging = true
	msg.silent = true
	
	if not msg.Send( "mail.myDomain.net" ) then
		Response.write "<pre>" & msg.log & "</pre>"
	else
		Response.write "Mailmerge successful again and email sent succesfully!"
	end if 
	
	' Thats it! One template, 2 emails.
%>
</body>
</html>