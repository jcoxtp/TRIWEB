<%@language = "vbscript"%>
<%
Option Explicit
Response.Expires = 0
Response.Buffer = True	
%>
<!--#INCLUDE FILE="helpMenu.asp"-->
<span class="heading">Manage Conditions</span><br />
<span class="normal">This page is used to edit conditions for an item/page in a survey.
</span><br /><br />
<span class="normalBold">Options:</span>
<br /><br />
<span class="normalBold">Create new condition</span><span class="normal">- 
This allows you to create a new condition by selecting from available questions, an operator, 
and a value for the question response. You may add this condition to an existing 
or new condition group. If you choose 'Answered 
Question' or 'Did Not Answer Question' the value will not be evaluated. The 
condition will simply check to see if the user did or did not answer the 
question.<br>
&nbsp;</span><br />

<span class="normalBold">Add existing condition</span><span class="normal">- 
This allows you to use a condition that was already created 
at a previous time. You may still select whether to add this to 
an existing group or to a new group.<br>
&nbsp;</span><br />