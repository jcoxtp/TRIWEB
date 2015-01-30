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

	' Key information
	' To validate a key we need a Message object, even if we
	' do not intend to actually send an email.
	set jmail = Server.CreateObject( "JMail.Message" )

	' Key identifiers supplied in a comma separated string.
	' Valid identifiers are emailaddresses and hexadecimal key id's
	' in the format 0xAABBCCDD as seen below
	' No special order is needed.

	keyString = "kirne@dimac.net"

	' Verifykeys returns true if all the supplied keys could be matched with a key in the local keyring.
 	if jmail.VerifyKeys( keyString ) THEN
	
		' KeyInformation return a PGPKeys collection with information for all the supplied keys.
	  	set keys = jmail.KeyInformation( keyString )
		Response.Write("Found keys for " & keyString & "<br>")
		Response.Write( "--------------------------------------------------------<br>")
		
		' Iterate the PGPKeys collection
		For i = 0 To keys.Count-1
			Response.Write( "Key ID: " & keys.Item( i ).KeyID & " <br> " )
			Response.Write( "Username: " & keys.Item( i ).KeyUser & " <br> " )
			Response.Write( "Key created: " & keys.Item( i ).KeyCreationDate & " <br> " )
			Response.Write( "--------------------------------------------------------<br>")
		Next

	ELSE
		' Verifykeys returnEd false, some unknown keys where supplied.
		Response.write("One or more invalid key(s):" & keyString )
	END IF

%>
</BODY>
</HTML>