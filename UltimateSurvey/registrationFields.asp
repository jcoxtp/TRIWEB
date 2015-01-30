<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Server.ScriptTimeout = 6000
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/inviteUsers_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Call user_loginNetworkUser()
	
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
%>
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>

<span class="normalBold-Big">Bulk User Registration</span>
<hr noshade color="#C0C0C0" size="2">
<span class="normal">Please choose which fields you would like to specify for each user.  On the next screen, you will enter all of the fields for each user
in a comma separated list.  <br /><br />You must specify a username or email address for each user.  If you do not choose to specify a username, the user's username will be 
his or her email address.  <br /><br />
On the next page, you will be able to choose whether the user will login based on NT authentication or based on a Username/Password combination.  
If you plan on using NT authentication, do not choose to specify a password.</span>
<hr noshade color="#C0C0C0" size="2">
<form method="post" action="bulkRegistration.asp" name="frmFields">
<table cellpadding="0" cellspacing="2" border="0" class="normal">
	<tr>
		<td class="normalBold" width="60">
			Field 1
		</td>
		<td>
			<%=fieldDropdown("field1",0)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 2
		</td>
		<td>
			<%=fieldDropdown("field2",1)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 3
		</td>
		<td>
			<%=fieldDropdown("field3",2)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 4
		</td>
		<td>
			<%=fieldDropdown("field4",3)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 5
		</td>
		<td>
			<%=fieldDropdown("field5",4)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 6
		</td>
		<td>
			<%=fieldDropdown("field6",5)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 7
		</td>
		<td>
			<%=fieldDropdown("field7",6)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 8
		</td>
		<td>
			<%=fieldDropdown("field8",7)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 9
		</td>
		<td>
			<%=fieldDropdown("field9",8)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 10
		</td>
		<td>
			<%=fieldDropdown("field10",9)%>
		</td>
	</tr>
	<tr>
		<td class="normalBold" width="60">
			Field 11
		</td>
		<td>
			<%=fieldDropdown("field11",10)%>

		</td>
	</tr>
</table>
<hr noshade color="#C0C0C0" size="2">
<table>
	<tr>
		<td width="60">
			&nbsp;
		</td>
		<td>
			<input type="hidden" name="numberFields" value="11">
			<input type="image" src="images/button-submit.gif" alt="Submit" border="0" onclick="javascript:return validateForm();">
		</td>
	</tr>
</table>
</form>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->
<%
	Function fieldDropdown(strFieldName,intIndex)
%>
		<select name="<%=strFieldName%>" onchange="javascript:blockDuplicates(document.frmFields.<%=strFieldName%>.value,<%=intIndex%>);">
			<option value=""></option>
			<option value="User Name">Username</option>
			<option value="Password">Password</option>
			<option value="First Name">First Name</option>
			<option value="Last Name">Last Name</option>
			<option value="Email Address">Email Address</option>
			<option value="Title">Title</option>
			<option value="Company">Company</option>
			<option value="Location">Location</option>
<%
			If len(SV_CUSTOM_USER_FIELD_1) > 0 Then
%>
				<option value="customUserField1"><%=SV_CUSTOM_USER_FIELD_1%></option>
<%
			End If
			
			If len(SV_CUSTOM_USER_FIELD_2) > 0 Then
%>			
				<option value="customUserField2"><%=SV_CUSTOM_USER_FIELD_2%></option>
<%
			End If
			
			If len(SV_CUSTOM_USER_FIELD_3) > 0 Then			
%>			
				<option value="customUserField3"><%=SV_CUSTOM_USER_FIELD_3%></option>
<%
			End If
%>			
		</select>

<%
	End Function
%>
<script language="javascript">
	function blockDuplicates(formValue, intIndex)
	{
		var i;
		var dropValue;
		var continueOn;
		for (i=0; i < 12;) 
		{
			dropValue = document.frmFields[i].value;
			
			if (dropValue != '')
			{		
			if (dropValue == formValue)
			{
				if (intIndex != i)
				{
					alert('You may not select the same field twice.');	
					document.frmFields[intIndex].selectedIndex = 0;
				}
			}
			}
			i++;
		}
		
	}
	
	
	function validateForm()
	{
		var i;
		var dropValue;
		var continueOn;
		for (i=0; i < 12;) 
		{
			dropValue = document.frmFields[i].value;
					
			if (dropValue == 'User Name')
			{
				continueOn = 'Yes';		
			}
			else
			{
				if (dropValue == 'Email Address')
				{
					continueOn = 'Yes'
				}
				
			}
			i++;
		}
		
		if (continueOn == 'Yes')
		{
			return true;
		}
		else
		{
			alert('You must specify either an email address or username');
			return false;
		}
	
	}
</script>

