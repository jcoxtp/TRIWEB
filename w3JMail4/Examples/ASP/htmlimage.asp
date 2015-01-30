<%@LANGUAGE="VBSCRIPT" %>
<HTML>
<BODY>
<%

'*************************************************
'*                                               *
'*   Produced by Dimac                           *
'*                                               *
'*   More examples can be found at 		 *
'*   http://tech.dimac.net                       *
'*                                               *
'*   Support is available at our helpdesk        *
'*   http://support.dimac.net                    *
'*                                               *
'*   Our main website is located at              *
'*   http://www.dimac.net                        *
'*                                               *
'*************************************************

	Set jmail = Server.CreateObject("JMail.Message")

	jmail.AddRecipient "myRecipient@hisdomain.com", "Mr.Example"
	jmail.From = "me@mydomain.com"
	
	jmail.Subject = "Here's some graphics!"
	jmail.Body = "A nice picture if you can read HTML-mail."

	' The return value of AddAttachment is used as a
	' reference to the image in the HTMLBody.
	contentId = jmail.AddAttachment("c:\myCoolPicture.gif",true)

	' As only HTML formatted emails can contain inline images
	' we use HTMLBody and appendHTML
	jmail.HTMLBody = "<html><body><font color=""red"">Hi, here is a nice picture:</font><br>"
	jmail.appendHTML "<img src=""cid:" & contentId & """>"
	jmail.appendHTML "<br><br> good one huh?</body></html>"
	
	' But as not all mailreaders are capable of showing HTML emails
	' we will also add a standard text body
	jmail.Body = "Too bad you can't read HTML-mail."
	jmail.appendText " There would have been a nice picture for you"
	
	jmail.Send( "mailserver.mydomain.com" )
%>
</BODY>
</HTML>