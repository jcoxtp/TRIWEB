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

    ' Create the POP 3 object
    Set pop = Server.CreateObject("JMail.POP3")

    ' Connect to the mailserver using an username and a password.
    pop.Connect "MyUserName", "MyPassword", "somemailserver.somedomain.com", 110

    ' Fetch the most recent message from the pop3 server
    Set msg = pop.Messages.Item( pop.Count )

    ' Set the passphrase we're going to use when decrypting
    msg.PGPPassPhrase = "MyPassphrase"

    ' Decode the message.
    ' The second parameter tells jmail to decode
    ' all the attachments ( if any ) in the message
    Set decodeResult = msg.PGPDecode( true,true )

    ' Was the message body decoded successfully ?

    ' Was the message encrypted ?
    if decodeResult.body.EncryptionUsed then
        Response.Write("<br>Messsage was encrypted<br>")
    else
        Response.Write("<br>Message was not encrypted<br>")
    end if

    ' Was it signed ?
    if  decodeResult.body.SigningUsed then
        ' Did the signature verify ?
        if decodeResult.body.SignatureGood then
            Response.Write("Signing good<br>")
        else
            Response.Write("Signing bad<br>")
        end if
    else
        Response.Write("<br>Message was not signed<br>")
    end if


    if  decodeResult.body.Success then
        ' Just print the decoded body
        Response.Write("<h4>Message</h4><br>")
        Response.Write( msg.Body & "<br>" )
    else
        ' An error occured
        Response.Write("<br>Message did not decrypt properly.<br>")
        Response.Write("<br>" & decodeResult.body.PGPErrorCode & "<br>" )
        Response.Write("<br>" & decodeResult.body.PGPErrorMsg & "<br>" )
    end if


%>
</BODY>
</HTML>