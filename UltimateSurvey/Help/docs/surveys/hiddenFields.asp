
<html>

<head>
<title>Hidden Fields</title>
<link rel="stylesheet" href="../../includes/stylesheet.css" type="text/css" />
</head>

<body topmargin="20" leftmargin="5" class="help-body">

<p class="help-title">Hidden Fields</p>
<hr color="#000000" size="1">
<p class="help-body"><SPAN class=normal>Hidden fields allow you to record information pertaining to 
the survey response without directly asking the user. This information can come 
from the query string, cookies, or the session.</SPAN><BR></p>


<span class="help-bodyBold">Question:</span> 
<span class="help-body">The question that the hidden field answers.  This will appear in all reports as would any regular question in 
the survey.  This question is also available in the conditions for subsequent pages and items.</span><br /><br />
<span class="help-bodyBold">Hidden Field Type: </span>Where you want to get the value for the hidden field from.</span>
<table class="help-body">
<tr><td>
&nbsp;&nbsp;&nbsp;</td>
<td><u>Querystring</u></td><td>value is passed in the URL to take the survey.</td> 
</tr>
<tr><td>
&nbsp;&nbsp;&nbsp;</td>
<td><u>Cookie</u></td><td>value will be retrieved from a cookie value that you have set.</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;</td><td><u>Session</u></td><td> value will be retrieved from a session value that you have set.</td> </tr>
</table>
<br />
<span class="help-bodyBold">Variable Name</span>
<span class="help-body">Name of variable in hidden field.  For example, if you set Session("userTitle") = "President", 
the variable name is "userTitle"</span>
</body>

</html>