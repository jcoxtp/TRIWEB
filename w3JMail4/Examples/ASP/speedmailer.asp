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

  set JMail = Server.CreateObject( "JMail.Speedmailer" )

	' Send a simple email in a single method call.
	' You can add multiple recipients by separating them with a ","

  JMail.SendMail "me@myDomain.com", "to@otherDomain.com, to2@otherDomain.com", "subject", "Body", "mail.dimac.net"


%>
<html>
Mail sent..
</html>