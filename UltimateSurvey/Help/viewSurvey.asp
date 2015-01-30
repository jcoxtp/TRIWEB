<%@language = "vbscript"%>
<%
Option Explicit
Response.Expires = 0
Response.Buffer = True	
%>
<!--#INCLUDE FILE="helpMenu.asp"-->
<span class="heading">Edit Survey</td></tr></tr>
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="normal">
<tr><td valign="top" class="normalBold" width="150">View Reports</td>
	<td valign="top"> View reports on responses to this survey.</td></tr>
<tr><td valign="top" class="normalBold" width="150">Edit Survey</td>
	<td valign="top"> Edit basic survey information, such as start and end dates and permission levels.</td></tr>
<tr><td valign="top" class="normalBold" width="150">Clear Data</td>
	<td valign="top"> Deletes all responses to the survey.</td></tr>
<tr><td valign="top" class="normalBold" width="150">Delete Survey</td>
	<td valign="top"> Delete entire survey and all reporting information.</td></tr>
<tr><td valign="top" class="normalBold" width="150">Invite Users</td>
	<td valign="top"> Select who may take the survey and promote public surveys via email.</td></tr>
<tr><td valign="top" class="normalBold" width="150">Activate/Deactivate</td>
	<td valign="top"> Change active status of survey.  You can still view reports on inactive surveys.</td>
</tr>
<tr><td valign="top" class="normalBold" width="150">Move Page</td>
	<td valign="top">Move an entire page of items within the survey.</td>
</tr>


<tr><td valign="top" class="normalBold" width="150">Items:</td>
<td>

Edit - Lets you edit item, including changing the item type.<br />
Delete - Deletes Specified Item Permanently.<br />
Conditions - Manage conditions for the specific item.<br />
Up/Down Arrows - Change order of items within page.<br />
Move To Page - Move the item to another page or to a new page. 
</td>
</tr>
</table>