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


	' Example on how to use queueing
	
	' The message is set up as usual..
	set Message = Server.CreateObject( "JMail.Message" )

	Message.From = "myEmail@mydomain.com"
	Message.Subject = "Testing"
	Message.Body = "This is a test mail"
	Message.AddRecipient "myRecipient@hisdomain.com","A Name"

	' Instead of using the Send() method, we use nq 
	' The email will be placed in the mail queue and sent 
	' as soon as the mailservice picks it up.
	' We do not need to specify a mailserver, as the
	' mailservice does all that for us.
	
	' What we do need to do is to specify where the MS pickup
	' directory is. If you are running w3 JMail on a 
	' Windows 2000 server, this is not neccessary, otherwise
	
	' Unless you are running windows 2000 on your webserver,
	' you will need to specify where the MS pickup directory
	' is (c:\inetpub\mailroot\pickup\).
	
	Message.MSPickupDirectory = "c:\inetpub\mailroot\pickup\"
	Message.nq
%>
</BODY>
</HTML>