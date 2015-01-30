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


	' PGP signing
	' Create the Message as usual
	set msg = Server.CreateObject( "JMail.Message" )

	msg.From = "anakin@tatooine.com"
	msg.Subject = "Hi!"
	msg.Body = "Hello dark forces!"


	msg.AddRecipient "emperor@coruscant.com", "palpatine"

	' To sign an email, we set PGPsign to true
	msg.PGPSign = true

	' We must choose a PGP key to sign with
	' The key must reside in the local keyring.
	msg.PGPSignKey = "thechosenone@jedi.org"
	
	' A passphrase is always needed to access a private key.
	' It is NOT adviced to leave your key like this, anyone
	' who have access to your ASP-files can read your key,
	' however, to make this example we need to type it out.
	msg.PGPPassPhrase = "yoda"

	msg.Send "mymailserver.mydomain.com"
%>
</BODY>
</HTML>