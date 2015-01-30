<%@language = "vbscript"%>
<%
Option Explicit
Response.Expires = 0
Response.Buffer = True	
%>
<!--#INCLUDE FILE="helpMenu.asp"-->
<span class="heading">Invite Users</span><br />
<span class="normal">This page is used to control which users have access to restricted surveys*
and to send email invites to those people that you'd wish to survey.
<br /><br />
If you are selecting existing users, you may check the box next to their username / email and they will be
granted access to the restricted surveys*, or emailed about non-restricted surveys.
<br /><br />
If you want to invite non-registered users, you may enter their email addresses, separated by a semicolon, into the
large text area. If it is a restricted survey* or a registered-users only survey, any email address that does not already have
a user associated with it will have a username automatically added to the database.
</span><br /><br />
<span class="normalBold">Options:</span>
<br /><br />
<span class="normalBold">Send email to these users</span><span class="normal">- Checking this option will send an email invited
to the users selected above.</span><br />
<span class="normalBold">Email Subject</span>
	<span class="normal">Specifies the subject of the email that they receive.</span><br />
<span class="normalBold">Email Body Header</span>
	<span class="normal">- A blob of text that gets displayed at the top of the email.</span><br />
<span class="normalBold">Email Body URL</span>
	<span class="normal">- Automatically generated. This is the URL to take the survey.<br />
	</span><br />
<span class="normal">*RESTRICTED SURVEY - a survey that only users specified through the "Invite Users" interface can take</span>