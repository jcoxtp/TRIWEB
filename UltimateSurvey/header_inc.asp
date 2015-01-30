<%
'****************************************************
'
' Name:		header_inc.asp 
'
' Purpose:	create HTML common to all pages 
'****************************************************
Function header_htmlTop(strBackgroundColor, strBodyTagAppend)
%>
<html>
	

<head>
<title><%=SV_SITENAME%></title>
<script language="javascript">
		function popup(URL,name,toolbar,scrollbars,location,statusbar,menubar,resizable,width,height,left,top)
		{	
			var popwin;
			var params = 'toolbar=' + toolbar + 
						 ',scrollbars=' + scrollbars + 
						 ',location=' + location + 
						 ',statusbar=' + statusbar + 
						 ',menubar=' + menubar + 
						 ',resizable=' + resizable + 
						 ',width=' + width + 
						 ',height=' + height + 
						 ',left=' + left + 
						 ',top=' + top;
			popwin = window.open(URL, name, params);
			popwin.focus();
		}
		function confirmAction(message)
		{
			if (confirm(message) == true)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		function toggle(target)
		{
		   obj=(document.all) ? document.all[target] : document.getElementById(target);
		   obj.style.display=(obj.style.display=='none') ? 'inline' : 'none';
		}

		var allChecked = 'false';

		function checkAll(array, checkedAll)
		{
			
			
			size = array.length;
		
			for (var j=0; j<size; j++)
			{
			if (checkedAll.value == '0') 
			{
			array[j].checked = 'true';
			}
			
			else
			{
			array[j].checked = false;
			}
			}
			
			if (checkedAll.value == '0') 
			{
			checkedAll.value = '1';
			}
			else
			{
			checkedAll.value = '0';
			}
			
		}

	
	var array;
	
	function deleteElement(array,delindex) {
	
		size = array.length;
		
		validNo = (delindex != "NaN");
		inRange = ( (delindex >= 0) && (delindex <= array.length) );

		if (validNo && inRange) {
		
		for (var j=delindex-1; j<size-1; j++)
		if (j != size) array[j].value = array[j+1].value;
		array.length = size-1;
		
		}
		
	}

	function deleteCheckbox(array,delindex) {
	
		size = array.length;
		
		validNo = (delindex != "NaN");
		inRange = ( (delindex >= 0) && (delindex <= array.length) );

		if (validNo && inRange) {
		
		for (var j=delindex-1; j<size-1; j++)
		if (j != size) array[j].checked = array[j+1].checked;
		array.length = size-1;
		
		}
		
	}


	function swTextBox(text1, text2)
	{
		var text1Value = text1.value;
		var text2Value = text2.value;
		text2.value = text1Value;
		text1.value = text2Value;
	}
	function swCheckBox(check1, check2)
	{
		var check1Value = check1.checked;
		var check2Value = check2.checked;
		check2.checked = check1Value;
		check1.checked = check2Value;
	}

	function oneChecked(array, checkedIndex)
		{
			
			size = array.length;
			for (var j=0; j<size; j++)
			{
			if (checkedIndex == j) 
			{
			array[j].checked == 'true';
			}
			
			else
			{
			array[j].checked = false;
			}
			}
			
		}

</script>

		
</head>
<BODY bgColor="<%=strBackgroundColor%>" leftMargin=0 <%=strBodyTagAppend%> topMargin="0" marginheight="0" marginwidth="0" link="#0000FF" vlink="#0000FF" alink="#0000FF">
<style>
<!--
.nav-white   { font-family: Verdana; font-size: 9pt; color: #FFFFFF;}
-->
</style>
<link rel="stylesheet" href="Include/Stylesheets/ultimateAppsStyles.css" type="text/css" />
<%
End Function

Function header_writeHeader(intUserType, intPageType)

	Select Case intUserType
		Case SV_USER_TYPE_ADMINISTRATOR
			Call header_administratorHeader(intPageType)
		Case SV_USER_TYPE_CREATOR 
			Call header_creatorHeader(intPageType)
		Case SV_USER_TYPE_TAKE_ONLY
			Call header_takeOnlyHeader(intPageType)
		Case Else
			Call header_notLoggedInHeader(intPageType)
	End Select

End Function

Function header_administratorHeader(intPageType)
	Dim strUsername
	
	'Get the user info
	Call user_getSessionInfo("", "", strUserName,"", "",True)

	
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%" bgcolor="<%=SV_TOP_COLOR%>">
    <img src="images/spacer.gif" height="30" width="1">&nbsp;
    <span style="font-size: 24px; font-family: Arial; font-weight: bold; color: <%=SV_TITLE_COLOR%>">
    <%=SV_SITENAME%>
    </span>
    </td>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
  </tr>
  <tr>
	<TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%">
      
      <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
      
        <TR>
          <TD width="15"><IMG height="26" src="images/navbar_bg.jpg" width=15></TD>
<%
		If not utility_isPositiveInteger(intPageType) Then
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-home-on.gif" alt="Home" border="0" width="75" height="26"></TD>
		    <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
		  <TD width="75"><a href="index.asp"><IMG src="images/nav-home-off.gif" alt="Home" border="0" width="75" height="26"></a></TD>
		  <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If
		
		If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>          
          <TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-surveys-on.gif" alt="Surveys" border="0" width="75" height="26"></TD>
		  <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
		  <TD width="75"><a href="manageSurveys.asp"><IMG src="images/nav-surveys-off.gif" alt="Surveys" border="0" width="75" height="26"></a></TD>
		  <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If

		If intPageType = SV_PAGE_TYPE_REPORTS Then	
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-reports-on.gif" alt="Reports" border="0" width="75" height="26"></TD>
			 <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%		
		Else
%>  		
			 <TD width="75"><a href="chooseReport.asp"><IMG src="images/nav-reports-off.gif" alt="Reports" border="0" width="75" height="26"></a></TD>
			 <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If

		If intPageType = SV_PAGE_TYPE_USERS Then
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-users-on.gif" alt="Users" border="0" width="75" height="26"></TD>
			<TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
			<td width="75"><A href="manageUsers.asp"><IMG src="images/nav-users-off.gif" alt="Users" border="0" width="75" height="26"></A></TD>
			<TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>
<%
		End If

		' JT - added the following condition to prevent CNI survey users from seeing this menu link...
		If intSurveyID = 1 Then
			If intPageType = SV_PAGE_TYPE_MYINFO Then
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-myinfo-on.gif" alt="My Info" border="0" width="75" height="26"></TD>
				<TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
			Else
%>
			<td width="75"><A href="changeLoginInfo.asp"><IMG src="images/nav-myinfo-off.gif" alt="My Info" border="0" width="75" height="26"></A></TD>
			<TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
			End If
		End If

		If intPageType = SV_PAGE_TYPE_SETTINGS Then
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-settings-on.gif" alt="Settings" border="0" width="75" height="26"></td>
			<TD width="100%" background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" ><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
			<TD width="75"><A href="settings.asp"><IMG src="images/nav-settings-off.gif" alt="Settings" border="0" width="75" height="26"></A></TD>
			<TD width="2" background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" ><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		End If
%>
		<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" width="100%" align="left" valign="top"><IMG src="images/spacer.gif" width="100%" height="26"></TD>
		<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" width="100%" align="right" valign="top" colspan="2"><a href="login.asp"><img src="images/nav-logout.gif" alt="Logout" border="0" width="75" height="26" /></a></TD>
          
		</TR>
   		<TR>
			<TD width="15" height="2"><IMG height="2" src="images/nav-shadow.gif" width="15"></TD>
<%

			If not utility_isPositiveInteger(intPageType) Then
%>          
			 <TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2"><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If          

			If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>          
			 <TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2"><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If

			If intPageType = SV_PAGE_TYPE_REPORTS Then	
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2" ><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%		
			Else
%>  		
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If
			
			If intPageType = SV_PAGE_TYPE_USERS Then
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2" ><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If   
			If intPageType = SV_PAGE_TYPE_MYINFO Then
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2" ><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If

			If intPageType = SV_PAGE_TYPE_SETTINGS Then
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2" ><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If
%>
			 <TD background="images/nav-shadow.gif" width="100%" height="2" colspan="5"><IMG width="1" height="2" src="images/spacer.gif"><TD>
         
           
			 </TR>

  
			 </TABLE>
	
		</td>
      
    <TD bgColor=#666666 width="1"><IMG width="1" height="1" src="images/spacer.gif"></TD>
  </tr>
  <tr>
  
    <TD bgColor=#666666 width="1"><IMG width="1" height="15" src="images/spacer.gif"></TD>
    <td width="100%">
  
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0 height="0" style="border-collapse: collapse" bordercolor="#111111">
        <TBODY>

        <TR>
		  <TD align="left" bgColor="<%=SV_MENU_COLOR%>" height="0" valign="middle" class="navLinks">
			<img src="images/spacer.gif" height="22" width="5">
		  </TD>
		  <TD align="left" bgColor="<%=SV_MENU_COLOR%>" height="0" valign="middle" class="navLinks">
<%
		 If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>
			<a href="chooseSurvey.asp">Take Survey</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="manageSurveys.asp">Manage Surveys</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="manageCategories.asp">Question Libraries</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="styleTemplates.asp">Style Templates</a>
			
<%
		 ElseIf intPageType = SV_PAGE_TYPE_REPORTS Then
%>
			<a href="chooseReport.asp">Reports Home</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="searchReports.asp">Search Results</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="chooseExport.asp">Export Results</a>&nbsp;&nbsp;
			
<%
		 ElseIf intPageType = SV_PAGE_TYPE_USERS Then
%>
			<a href="manageUsers.asp">Manage Users</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="manageGroups.asp">User Groups</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="registrationFields.asp">Bulk User Registration</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="manageLists.asp">Email Lists</a>&nbsp;&nbsp;

<%
		 End If
%>
		  </TD>
          <TD align="right" bgColor="<%=SV_MENU_COLOR%>" colSpan="2" height="0" valign="middle">
<%
	If utility_isPositiveInteger(intUserType) Then
%>        
          <span class="navLinks">user:</span>
          <span class="navlinks"><a href="changeLoginInfo.asp"><%=strUsername%></a></span>
<%
	Else
%>
		&nbsp;
<%
	End If
%>
          <IMG width="1" height="3" src="images/spacer.gif"></TD>
          </TR></TBODY></TABLE>
      </td>
      
    <TD bgColor=#666666 width="1"><IMG height="15" src="images/spacer.gif" width="1"></TD>
  </tr>
   

</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">

  
  <tr>

    <TD bgColor="#666666" width="1" rowspan="1">
    <IMG width="1" height="25" src="images/spacer.gif"></TD>

    <td width="100%"><IMG width="100%" height="2" src="images/spacer.gif"></p>
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top" width="10">
					&nbsp;
				</td>
				<td valign="top">

<%
End Function

Function header_creatorHeader(intPageType)
	Dim strUsername
	
	'Get the user info
	Call user_getSessionInfo("", "", strUserName,"", "",True)
	
	
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%" bgcolor="<%=SV_TOP_COLOR%>">
    <img src="images/spacer.gif" height="40" width="1">&nbsp;
    <span style="font-size: 24px; font-family: Arial; font-weight: bold; color: white">
    <%=SV_SITENAME%>
    </span>
    </td>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
  </tr>
  <tr>

    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%">
      
      <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
      
        <TR>
          <TD width="15"><IMG height="26" src="images/navbar_bg.jpg" width=15></TD>
<%
		If not utility_isPositiveInteger(intPageType) Then
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-home-on.gif" alt="Home" border="0" width="75" height="26"></TD>
		    <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
		  <TD width="75"><a href="index.asp"><IMG src="images/nav-home-off.gif" alt="Home" border="0" width="75" height="26"></a></TD>
		  <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If
		
		If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>          
          <TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-surveys-on.gif" alt="Surveys" border="0" width="75" height="26"></TD>
		  <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
		  <TD width="75"><a href="manageSurveys.asp"><IMG src="images/nav-surveys-off.gif" alt="Surveys" border="0" width="75" height="26"></a></TD>
		  <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If

		If intPageType = SV_PAGE_TYPE_REPORTS Then	
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-reports-on.gif" alt="Reports" border="0" width="75" height="26"></TD>
			 <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%		
		Else
%>  		
			 <TD width="75"><a href="chooseReport.asp"><IMG src="images/nav-reports-off.gif" alt="Reports" border="0" width="75" height="26"></a></TD>
			 <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If

		' JT - added the following condition to prevent CNI survey users from seeing this menu link...
		If intSurveyID = 1 Then
			If intPageType = SV_PAGE_TYPE_MYINFO Then
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-myinfo-on.gif" alt="My Info" border="0" width="75" height="26"></td>
			<TD width="100%" background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" ><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
			<TD width="75"><A href="changeLoginInfo.asp"><IMG src="images/nav-myinfo-off.gif" alt="My Info" border="0" width="75" height="26"></A></TD>
			<TD width="2" background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" ><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
			End If
		End If
%>
		<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" colspan="2" width="100%" align="left" valign="top"><IMG src="images/spacer.gif" width="100%" height="26"></TD>
<%
		If utility_isPositiveInteger(intUserType) Then
%>
			<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" width="100%" align="right" valign="top"><a href="login.asp"><img src="images/nav-logout.gif" alt="Logout" border="0" width="75" height="26" /></a></TD>
<%
		Else
%>
			<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" width="100%" align="right" valign="top" colspan="2"><a href="login.asp"><img src="images/nav-login.gif" alt="Login" border="0" width="75" height="26" /></a></TD>
<%
		End If
%>
          
		</TR>
   		<TR>
			<TD width="15" height="2"><IMG height="2" src="images/nav-shadow.gif" width="15"></TD>
<%

			If not utility_isPositiveInteger(intPageType) Then
%>          
			 <TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2"><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If          

			If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>          
			 <TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2"><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If

			If intPageType = SV_PAGE_TYPE_REPORTS Then	
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2" ><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%		
			Else
%>  		
			<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If
%>
			 <TD background="images/nav-shadow.gif" width="100%" height="2" colspan="6"><IMG width="1" height="2" src="images/spacer.gif"><TD>
         
           
			 </TR>

  
			 </TABLE>
	
		</td>
      
    <TD bgColor=#666666 width="1"><IMG width="1" height="1" src="images/spacer.gif"></TD>
  </tr>
  <tr>
  
    <TD bgColor=#666666 width="1"><IMG width="1" height="15" src="images/spacer.gif"></TD>
    <td width="100%">
  
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0 height="0" style="border-collapse: collapse" bordercolor="#111111">
        <TBODY>

        <TR>
		  <TD align="left" bgColor="<%=SV_MENU_COLOR%>" height="0" valign="middle" class="navLinks">
			<img src="images/spacer.gif" height="22" width="5">
		  </TD>
		  <TD align="left" bgColor="<%=SV_MENU_COLOR%>" height="0" valign="middle" class="navLinks">
<%
		 If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>
			<a href="chooseSurvey.asp">Take Survey</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="manageSurveys.asp">Manage Surveys</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp; 
			<a href="manageCategories.asp">Question Libraries</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="styleTemplates.asp">Style Templates</a>
<%
		 ElseIf intPageType = SV_PAGE_TYPE_REPORTS Then
%>
			<a href="chooseReport.asp">Reports Home</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="searchReports.asp">Search Results</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="chooseExport.asp">Export Results</a>&nbsp;&nbsp;
<%
		 End If
%>
		  </TD>
          <TD align="right" bgColor="<%=SV_MENU_COLOR%>" colSpan="2" height="0" valign="middle">
<%
	If utility_isPositiveInteger(intUserType) Then
%>        
          <span class="navLinks">user:</span>
          <span class="navlinks"><a href="changeLoginInfo.asp"><%=strUsername%></a></span>
<%
	Else
%>
		&nbsp;
<%
	End If
%>
          <IMG width="1" height="3" src="images/spacer.gif"></TD>
          </TR></TBODY></TABLE>
      </td>
      
    <TD bgColor=#666666 width="1"><IMG height="15" src="images/spacer.gif" width="1"></TD>
  </tr>
   

</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

  
  <tr>

    <TD bgColor="#666666" width="1" rowspan="1">
    <IMG width="1" height="25" src="images/spacer.gif"></TD>

    <td width="100%"><IMG width="100%" height="2" src="images/spacer.gif"></p>
		<table width="100%" cellpadding="10" cellspacing="0">
			<tr>
				<td>
			
<%
End Function

Function header_takeOnlyHeader(intPageType)
	Dim strUsername
	
	'Get the user info
	Call user_getSessionInfo("", "", strUserName,"", "",True)
	
	
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%" bgcolor="<%=SV_TOP_COLOR%>">
    <img src="images/spacer.gif" height="40" width="1">&nbsp;
    <span style="font-size: 24px; font-family: Arial; font-weight: bold; color: white">
    <%=SV_SITENAME%>
    </span>
    </td>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
  </tr>
  <tr>

    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%">
      
      <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
      
        <TR>
          <TD width="15"><IMG height="26" src="images/navbar_bg.jpg" width=15></TD>
<%
		If not utility_isPositiveInteger(intPageType) Then
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-home-on.gif" alt="Home" border="0" width="75" height="26"></TD>
		    <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
		  <TD width="75"><a href="index.asp"><IMG src="images/nav-home-off.gif" alt="Home" border="0" width="75" height="26"></a></TD>
		  <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If
		
		If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>          
          <TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-surveys-on.gif" alt="Surveys" border="0" width="75" height="26"></TD>
		  <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
		  <TD width="75"><a href="chooseSurvey.asp"><IMG src="images/nav-surveys-off.gif" alt="Surveys" border="0" width="75" height="26"></a></TD>
		  <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If

		If intPageType = SV_PAGE_TYPE_REPORTS Then	
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-reports-on.gif" alt="Reports" border="0" width="75" height="26"></TD>
			 <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%		
		Else
%>  		
			 <TD width="75"><a href="chooseReport.asp"><IMG src="images/nav-reports-off.gif" alt="Reports" border="0" width="75" height="26"></a></TD>
			 <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If

		' JT - added the following condition to prevent CNI survey users from seeing this menu link...
		If intSurveyID = 1 Then
			If intPageType = SV_PAGE_TYPE_MYINFO Then
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-myinfo-on.gif" alt="My Info" border="0" width="75" height="26"></td>
			<TD width="100%" background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" ><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
			Else
%>
			<TD width="75"><A href="changeLoginInfo.asp"><IMG src="images/nav-myinfo-off.gif" alt="My Info" border="0" width="75" height="26"></A></TD>
			<TD width="2" background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" ><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
			End If
		End If
%>
		<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" colspan="2" width="100%" align="left" valign="top"><IMG src="images/spacer.gif" width="100%" height="26"></TD>
<%
		If utility_isPositiveInteger(intUserType) Then
%>
			<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" width="100%" align="right" valign="top"><a href="login.asp"><img src="images/nav-logout.gif" alt="Login" border="0" width="75" height="26" /></a></TD>
<%
		Else
%>
			<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" width="100%" align="right" valign="top" colspan="2"><a href="login.asp"><img src="images/nav-login.gif" alt="Login" border="0" width="75" height="26" /></a></TD>
<%
		End If
%>
          
		</TR>
   		<TR>
			<TD width="15" height="2"><IMG height="2" src="images/nav-shadow.gif" width="15"></TD>
<%

			If not utility_isPositiveInteger(intPageType) Then
%>          
			 <TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2"><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If          

			If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>          
			 <TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2"><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If

			If intPageType = SV_PAGE_TYPE_REPORTS Then	
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2" ><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%		
			Else
%>  		
			<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If

			If intPageType = SV_PAGE_TYPE_MYINFO Then	
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2" ><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%		
			Else
%>  		
			<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If

%>
			 <TD background="images/nav-shadow.gif" width="100%" height="2" colspan="6"><IMG width="1" height="2" src="images/spacer.gif"><TD>
         
           
			 </TR>

  
			 </TABLE>
	
		</td>
      
    <TD bgColor=#666666 width="1"><IMG width="1" height="1" src="images/spacer.gif"></TD>
  </tr>
  <tr>
  
    <TD bgColor=#666666 width="1"><IMG width="1" height="15" src="images/spacer.gif"></TD>
    <td width="100%">
  
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0 height="0" style="border-collapse: collapse" bordercolor="#111111">
        <TBODY>

        <TR>
		  <TD align="left" bgColor="<%=SV_MENU_COLOR%>" height="0" valign="middle" class="navLinks">
			<img src="images/spacer.gif" height="22" width="5">
		  </TD>
		  <TD align="left" bgColor="<%=SV_MENU_COLOR%>" height="0" valign="middle" class="navLinks">
<%
		 If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>
		&nbsp;
<%
		 ElseIf intPageType = SV_PAGE_TYPE_REPORTS Then
%>
			<a href="chooseReport.asp">Reports Home</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="searchReports.asp">Search Results</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="chooseExport.asp">Export Results</a>&nbsp;&nbsp;
<%
		 End If
%>
		  </TD>
          <TD align="right" bgColor="<%=SV_MENU_COLOR%>" colSpan="2" height="0" valign="middle">
<%
	If utility_isPositiveInteger(intUserType) Then
%>        
          <span class="navLinks">user:</span>
          <span class="navlinks"><a href="changeLoginInfo.asp"><%=strUsername%></a></span>
<%
	Else
%>
		&nbsp;
<%
	End If
%>
          <IMG width="1" height="3" src="images/spacer.gif"></TD>
          </TR></TBODY></TABLE>
      </td>
      
    <TD bgColor=#666666 width="1"><IMG height="15" src="images/spacer.gif" width="1"></TD>
  </tr>
   

</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

  
  <tr>

    <TD bgColor="#666666" width="1" rowspan="1">
    <IMG width="1" height="25" src="images/spacer.gif"></TD>

    <td width="100%"><IMG width="100%" height="2" src="images/spacer.gif"></p>
		<table width="100%" cellpadding="10" cellspacing="0">
			<tr>
				<td>
			
<%
End Function


Function header_notLoggedInHeader(intPageType)
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%" bgcolor="<%=SV_TOP_COLOR%>">
    <img src="images/spacer.gif" height="40" width="1">&nbsp;
    <span style="font-size: 24px; font-family: Arial; font-weight: bold; color: white">
    <%=SV_SITENAME%>
    </span>
    </td>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
  </tr>
</table>
<%
If SV_NON_LOGGED_IN_NAV_LINKS = True Then
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>

    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%">
      
      <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
      
        <TR>
          <TD width="15"><IMG height="26" src="images/navbar_bg.jpg" width=15></TD>
<%
		If not utility_isPositiveInteger(intPageType) Then
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-home-on.gif" alt="Home" border="0" width="75" height="26"></TD>
		    <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
		  <TD width="75"><a href="index.asp"><IMG src="images/nav-home-off.gif" alt="Home" border="0" width="75" height="26"></a></TD>
		  <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If
		
		If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>          
          <TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-surveys-on.gif" alt="Surveys" border="0" width="75" height="26"></TD>
		  <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%
		Else
%>
		  <TD width="75"><a href="chooseSurvey.asp"><IMG src="images/nav-surveys-off.gif" alt="Surveys" border="0" width="75" height="26"></a></TD>
		  <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If

		If intPageType = SV_PAGE_TYPE_REPORTS Then	
%>
			<TD width="75" bgcolor="<%=SV_MENU_COLOR%>"><IMG src="images/nav-reports-on.gif" alt="Reports" border="0" width="75" height="26"></TD>
			 <TD width="2"><IMG src="images/spacer.gif" width="2" height="26"></TD>
<%		
		Else
%>  		
			 <TD width="75"><a href="chooseReport.asp"><IMG src="images/nav-reports-off.gif" alt="Reports" border="0" width="75" height="26"></a></TD>
			 <TD width="2"><IMG src="images/navbar_divider.gif" width="2" height="26"></TD>	
<%
		End If
%>
		<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" colspan="2" width="100%" align="left" valign="top"><IMG src="images/spacer.gif" width="100%" height="26"></TD>
			<TD background="images/navbar_bg.jpg" src="images/navbar_bg.jpg" width="100%" align="right" valign="top" colspan="3"><a href="login.asp"><img src="images/nav-login.gif" alt="Login" border="0" width="75" height="26" /></a></TD>
     	</TR>
   		<TR>
			<TD width="15" height="2"><IMG height="2" src="images/nav-shadow.gif" width="15"></TD>
<%

			If not utility_isPositiveInteger(intPageType) Then
%>          
			 <TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2"><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If          

			If intPageType = SV_PAGE_TYPE_SURVEYS Then
%>          
			 <TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2"><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%
			Else
%>
				<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If

			If intPageType = SV_PAGE_TYPE_REPORTS Then	
%>
				<TD width="75" bgcolor="<%=SV_MENU_COLOR%>" height="2" ><IMG src="images/nav-shadowcorner.gif" width="2" height="2"><IMG height="2" src="images/spacer.gif" width="71"></TD>
<%		
			Else
%>  		
			<TD colspan="2" height="2" background="images/nav-shadow.gif" width="75"><IMG height="2" src="images/nav-shadow.gif" width="2"></TD>
<%
			End If
%>			
			 <TD background="images/nav-shadow.gif" width="100%" height="2" colspan="6"><IMG width="1" height="2" src="images/spacer.gif"><TD>
         
           
			 </TR>

  
			 </TABLE>
	
		</td>
      
    <TD bgColor=#666666 width="1"><IMG width="1" height="1" src="images/spacer.gif"></TD>
  </tr>
  <tr>
  
    <TD bgColor=#666666 width="1"><IMG width="1" height="15" src="images/spacer.gif"></TD>
    <td width="100%">
  
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0 height="0" style="border-collapse: collapse" bordercolor="#111111">
        <TBODY>

        <TR>
          <TD align="left" bgColor="<%=SV_MENU_COLOR%>" height="0" valign="middle" class="navLinks">
			<img src="images/spacer.gif" height="22" width="5">
		  </TD>
		  <TD align="left" bgColor="<%=SV_MENU_COLOR%>" height="0" valign="middle" class="navLinks">
		
<%
		If intPageType = "" Then
%>		  
		  	<a href="login.asp">Login</a>&nbsp;&nbsp;
		  
<%
			If SV_ALLOW_PUBLIC_REGISTRATION = True Then
%>			
					<span class="separator"> | </span>&nbsp;&nbsp;
					<a href="register.asp">Register</a>&nbsp;&nbsp;
				
<%
			Else
%>
				<img src="images/spacer.gif" width="88" height="5" border="0">
<%
			End If
%>
				
<%
		ElseIf intPageType = SV_PAGE_TYPE_REPORTS Then
%>

			<a href="chooseReport.asp">Reports Home</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="searchReports.asp">Search Results</a>&nbsp;&nbsp;
			<span class="separator"> | </span>&nbsp;&nbsp;
			<a href="chooseExport.asp">Export Results</a>&nbsp;&nbsp;
<%
		Else
%>
			&nbsp;
<%
		End If
%>
		  </TD>
		  <TD align="right" bgColor="<%=SV_MENU_COLOR%>" colSpan="4" height="0" valign="middle">
          <IMG width="1" height="3" src="images/spacer.gif">&nbsp;</TD>
          </TR></TBODY></TABLE>
      </td>
      
    <TD bgColor=#666666 width="1"><IMG height="15" src="images/spacer.gif" width="1"></TD>
  </tr>
   

</table>
<%
End If
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">

  
  <tr>

    <TD bgColor="#666666" width="1" rowspan="1">
    <IMG width="1" height="25" src="images/spacer.gif"></TD>

    <td width="100%"><IMG width="100%" height="2" src="images/spacer.gif"></p>
		<table width="100%" cellpadding="10" cellspacing="0">
			<tr>
				<td>

<%
End Function

Function header_padding()
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">

  
  <tr>

    <TD width="1" rowspan="1">
    <IMG width="1" height="25" src="images/spacer.gif"></TD>

    <td width="100%"><IMG width="100%" height="2" src="images/spacer.gif"></p>
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top" width="10">
					&nbsp;
				</td>
				<td valign="top">

<%
End Function

Function header_bottomPadding()
%>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</td>
<td width="10">
	&nbsp;
</td>
</tr>
</table>
</td>
    
    <TD width="1" rowspan="1">
    <IMG width="1" height="25" src="images/spacer.gif"></TD>
    
    </tr>
  
     <TR>
         <TD width="1" rowspan="1"><IMG src="images/spacer.gif" width="1" height="1"></TD>
    <TD colSpan="1"><IMG src="images/spacer.gif" width="1" height="1"></TD>
    
    <TD width="1" rowspan="1"><IMG src="images/spacer.gif" width="1" height="1"></TD>
    </TR>
        
</table>

<%
End Function

Function header_errorPage()
%>
<html>
<head>
<title>SYSTEM ERROR</title>
</head>
<BODY bgColor="white" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0" link="#0000FF" vlink="#0000FF" alink="#0000FF">
<style>
<!--
.nav-white   { font-family: Verdana; font-size: 9pt; color: #FFFFFF;}
-->
</style>
<link rel="stylesheet" href="Include/Stylesheets/ultimateAppsStyles.css" type="text/css" />

<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table1">
  <tr>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
    
    <td width="100%" bgcolor="<%=SV_TOP_COLOR%>">
    <img src="images/spacer.gif" height="40" width="1">&nbsp;
    <span style="font-size: 24px; font-family: Arial; font-weight: bold; color: white">
    <%=SV_SITENAME%>: Error
    </span>
    </td>
    
    <TD bgColor=#666666 width="1"><IMG width="1" height="18" src="images/spacer.gif"></TD>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table5">
  <tr>
    <TD bgColor="#666666" width="1" rowspan="1">
    <IMG width="1" height="25" src="images/spacer.gif"></TD>
    <td width="100%"><IMG width="100%" height="2" src="images/spacer.gif"></p>
		<table width="100%" cellpadding="10" cellspacing="0" ID="Table6">
			<tr>
				<td>
<% End Function %>