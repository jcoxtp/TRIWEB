<%@language = "vbscript"%>
<%
Option Explicit
Response.Expires = 0
Response.Buffer = True	
%>
<!--#INCLUDE FILE="helpMenu.asp"-->
<span class="heading">Create/Edit Survey</span>
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="normal">
	<tr width="150px">
		<td valign="top"  class="normalBold" width="150px">
			Survey Title
		</td>
		<td valign="top" width="400">
			Main title of a survey.  Displayed on all pages in survey.  Must be unique.
		</td></tr>
		<tr><td valign="top"  class="normalBold" width="150px">Description</td>
			<td valign="top" width="400">(Optional) - Description of survey.  Displayed on all pages in survey.</td></tr>
		<tr width="150px"><td valign="top"  class="normalBold" width="150px">Allow Users to Resume</td>
			<td valign="top" width="400"> Choose this to allow users to stop taking a survey, then come back later and resume
									where he/she left off.</td></tr>
		<tr><td valign="top"  class="normalBold" width="150px">Show Survey Progress</td>
			<td valign="top" width="400"> Choose this to show the user what page they are on relative to the end of the survey  
			(for example: Page 3 of 6).  Note:  This may not be accurate for surveys with items or pages shown conditionally.</td></tr>
		<tr width="150px"><td valign="top"  class="normalBold" width="150px">Scored Survey</td>
			<td valign="top" width="400"> Choose this to allow points to be assigned to preset answers.  You will be able to see user's scores in reports
			and search based on score ranges.</td></tr>
<tr><td valign="top"  class="normalBold" width="150px">Survey Type</td>
	<td valign="top" width="400">
	Public - Anonymous users can take survey.<br />
	Registered Users Only - Only logged in users can take survey.<br />
	Restricted - Only users specified by survey creator can take survey.<br />
	</td>
</tr>
<tr width="150px"><td valign="top"  class="normalBold" width="150px">Start Date</td>
	<td valign="top" width="400">(Optional) - Date for survey to become available.  Survey must also be activated.</td></tr>
<tr><td valign="top"  class="normalBold" width="150px">End Date</td>
	<td valign="top" width="400">(Optional) - Last date this survey is available.</td></tr>
<tr width="150px"><td valign="top"  class="normalBold" width="150px">Max Respondants</td>
	<td valign="top" width="400">(Optional) - Maximum responses to this survey.</td></tr>
<tr><td valign="top"  class="normalBold" width="150px">Privacy Level</td>
	<td valign="top" width="400">
	All Results Private - Only survey creator and administrators can view survey response information.<br />
	Summary Results Public - Public can view only results totals, not individual responses.<br />
	Detailed Results Public - All response information is public.
	</td></tr>
<tr width="150px"><td valign="top"  class="normalBold" width="150px">Responses Per User:</td>
	<td valign="top" width="400"> Maximum times each user can take survey.  Leave blank for unlimited.</td></tr>
<tr><td valign="top"  class="normalBold" width="150px">Completion Action</td>
	<td valign="top" width="400">(Optional) - Behavior When Survey is Completed<br />
	&nbsp;&nbsp;&nbsp;&nbsp;- Display Message - Displays this text when user completes survey.<br /> 
	&nbsp;&nbsp;&nbsp;&nbsp;- Redirect to URL - Brings user to this URL.  Overrides 'Display Message'<br />
	</td></tr>
<tr width="150px"><td valign="top"  class="normalBold" width="150px">Email Responses to:</td>
	<td valign="top" width="400">(optional) - Details of each response will be sent to this email address.</td></tr>
</table>