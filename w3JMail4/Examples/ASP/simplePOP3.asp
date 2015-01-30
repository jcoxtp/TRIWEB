<% @LANGUAGE=VBSCRIPT %>
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




  Set pop3 = Server.CreateObject( "JMail.POP3" )

  pop3.Connect "username", "password", "mail.mydomain.com"

  Response.Write( "You have " & pop3.count & " mails in your mailbox!<br><br>" )

  if pop3.count > 0 then
	Set msg = pop3.Messages.item(1) 	' Note the first element of this array is 1
										' since the POP3 server starts counting at 1
	ReTo = ""
	ReCC = ""
	
	Set Recipients = msg.Recipients
	separator = ", "
	
	' We now need to get all the recipients,
	' both normal and Carbon Copy (CC) recipients
	' and store them in a variabel
	
	For i = 0 To Recipients.Count - 1
		If i = Recipients.Count - 1 Then
			separator = ""
		End If
	
		Set re = Recipients.item(i)
		If re.ReType = 0 Then
			ReTo = ReTo & re.Name & "&nbsp;(<a href=""mailto:"& re.EMail &""">" & re.EMail & "</a>)" & separator
		else
			ReCC = ReTo & re.Name & "&nbsp;(<a href=""mailto:"& re.EMail &""">" & re.EMail & "</a>)" & separator
		End If
	Next
	
	' This function iterates through the Attachments object,
	' and saves the attachment to the server's disk.
	' It also returns a nicely formatted string with a
	' link to the attachment.
	Function getAttachments()
	  	Set Attachments = msg.Attachments
	  	separator = ", "
	
	  	For i = 0 To Attachments.Count - 1
			If i = Attachments.Count - 1 Then
				separator = ""
		 	End If
	
		 	Set at = Attachments(i)
		 	at.SaveToFile( "c:\EMail\attachments\" & at.Name )
		 	getAttachments = getAttachments & "<a href=""/EMail/attachments/" & at.Name &""">" &_
		 						at.Name & "(" & at.Size  & " bytes)" & "</a>" & separator
	  	Next
	End Function
	  
	%>	
	<html>
	  <body>
		<TABLE>
		  <tr>
			<td>Subject</td>
			<td><%= msg.Subject %></td>
		  </tr>
		  <tr>
			<td>From</td>
			<td><%= msg.FromName %></td>
		  </tr>
		  <tr>
			<td>Recipients To</td>
			<td><%= ReTO %></td>
		  </tr>
		  <tr>
			<td>Recipients CC</td>
			<td><%= ReCC %></td>
		  </tr>
		  <tr>
			<td>Attachments</td>
			<td><%= getAttachments %></td>
		  </tr>
		  <tr>
			<td>Body</td>
			<td><pre><%= msg.Body %></pre></td>
		  </tr>		
		</TABLE>
	  </body>
	</html>
	<%

  end if

  pop3.Disconnect

%>
