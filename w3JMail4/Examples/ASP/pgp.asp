<%@LANGUAGE="VBSCRIPT" %>
<HTML>
<BODY>
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

	' PGP encryption
	' The message is set up as usual...
	set msg = Server.CreateObject( "JMail.Message" )

	msg.From = "myEmail@mydomain.com"
	msg.Subject = "For your eyes only"
	msg.Body = "Top secret stuff for you."

	' Set logging to true to ease any potential debugging
	' And set silent to true as we wish to handle our errors ourself
	msg.Logging = true
	msg.silent = true

	' An encryption key can be set as the third parameter to AddRecipient.
	' This can be a comma separated string containing email addresses and
	' hexadecimal key id's if more than one key are going to be used.
	' The third parameter is optional and will default to the same value
	' as the recipients email address, which in most cases are quite sufficient.

	' msg.AddRecipient("myFriend@hisdomain.com", "A Name", "anEmail@mydomain.com, 0xFD43CD12, anotherEmail@mydomain.com" )

	msg.AddRecipient "myRecipient@hisdomain.com", "A Name"

	' With PGPEncrypt set to true the email will be encrypted upon Send()
	msg.PGPEncrypt = true
	
	' To capture any errors which might occur, we wrap the call in an IF statement
	if not msg.Send( "mail.myDomain.net" ) then
		Response.write "<pre>" & msg.log & "</pre>"
	else
		Response.write "Message sent succesfully and encrypted!"
	end if
%>
</BODY>
</HTML>