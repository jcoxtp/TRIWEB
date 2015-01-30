<%
'*************************************************
'*                                               *
'*   Copyright (C) Dimac AB 2000                 *
'*   All rights reserved.                        *
'*                                               *
'*   http://www.dimac.net                        *
'*                                               *
'*************************************************




'-------------------------------------------------------------------------'
' This function iterates through the Recipients Object
' and formats the message's recipients
ReTo = ""
ReCC = ""

Sub getRecipients( )

  Set Recipients = msg.Recipients
  seperator = ", "

  For i = 0 To Recipients.Count - 1

	 If i = Recipients.Count - 1 Then
		seperator = ""
	 End If

	 Set re = Recipients.item(i)
	 If re.ReType = 0 Then
	 	ReTo = ReTo & re.Name & "&nbsp;(<a href=""mailto:"& re.EMail &""">" & re.EMail & "</a>)" & seperator
	 else
		ReCC = ReTo & re.Name & "&nbsp;(<a href=""mailto:"& re.EMail &""">" & re.EMail & "</a>)" & seperator
	 End If

  Next

End Sub


'-------------------------------------------------------------------------'
' This function iterates through the Attachments object,
' and saves the attachment to the server's disk.
' It also returns a nicely formated string with a
' link to the attachment.
Function getAttachments( )

  Set Attachments = msg.Attachments
  seperator = ", "

  For i = 0 To Attachments.Count - 1

	 If i = Attachments.Count - 1 Then
		seperator = ""
	 End If

	 Set at = Attachments.Item(0)
	 at.SaveToFile( "c:\EMail\attachments\" & at.Name )
	 getAttachments =	getAttachments & "<a href=""/EMail/attachments/" & at.Name &""">" &_
				at.Name & "(" & at.Size  & " bytes)" & "</a>" & seperator
  Next

End Function


%>