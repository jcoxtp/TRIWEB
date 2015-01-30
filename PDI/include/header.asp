<%
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRsLanguages = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spLanguagesSelectPublic"
		.CommandType = 4
	    .Parameters.Append .CreateParameter("@intErrorCode", adDouble, adParamOutput, 4, 0)
	    .Parameters.Append .CreateParameter("@strErrorMessage", adVarWChar, adParamOutput, 255, Null)
	End With
	oConn.Open Application("strDbConnString")
	oCmd.ActiveConnection = oConn
	oRsLanguages.CursorLocation = adOpenStatic
	oRsLanguages.Open oCmd, , adOpenForwardOnly, adOpenKeyset
	intRsLanguagesErrorCode = oCmd.Parameters("@intErrorCode").value
	strRsLanguagesErrorMessage = oCmd.Parameters("@strErrorMessage").value
%>
<link href="./include/header.css" rel="stylesheet" />
<div id="header" class="clearfix">
    <div class="header-top clearfix">
        <div class="header-top-wrapper">
            <div class="contact-info">
                <%= Application("strTextContactUs" & strLanguageCode) %>: (770) 956-0985 | Email: <a href="mailto:info@triaxiapartners.com">info@triaxiapartners.com</a>
            </div>
            <div id="language-chooser">
                <form name="langChooser" method="get">
                    <select name="LanguageID" onchange="javascript:changeLanguage();">
                        <!--Language Dropdown list from DB-->
                        <%
	                        If intRsLanguagesErrorCode < 1 Then
		                        oRsLanguages.MoveFirst
		                        While NOT oRsLanguages.EOF
			                        Response.Write "<option  value=""" & oRsLanguages("LanguageID") & """"
			                        If CInt(oRsLanguages("LanguageID")) = CInt(intLanguageID) Then
				                        Response.Write " selected "
			                        End If
			                        Response.Write ">"
			                        If CInt(oRsLanguages("LanguageID")) <> 1 Then
				                        Response.Write oRsLanguages("NameNative")
				                        Response.Write " - "
			                        End If
			                        Response.Write oRsLanguages("NameEnglish")
			                        Response.Write "</option>" & VbCrLf
			                        oRsLanguages.MoveNext
		                        Wend
	                        End If %>
                    </select>
                    <!-- <span id="flashit" style="color:lightgreen;font-family:comic sans ms;font-weight:normal;font-size:12pt;">&nbsp;&nbsp;&nbsp;<%= strTextNew %></span> -->
                </form>

            </div>
            <%If Request.Cookies("UserName") <> "" Then%>
            <div class="header-right languages">
                <div class="user-links">
                    <div class="user-links-wrapper">
                        <span class="welcome-user">Hello,
                                <a href="UserRegistrationInfo.asp?res=<%=intResellerID%>" class="edit-user"><%= strFullName %></a>
                        </span>
                        <a href="javascript:confirmLogout()" class="logout"><%= Application("strTextLogout" & strLanguageCode) %></a>
                    </div>
                    <div class="languages-wrapper">
                        <!--<div class="language-active clearfix">
                    <span>English</span>
                    </div>
                    <!--<div class="language-list">
                        <a href="" class="language">English</a>
                        <a href="" class="language">Espanol</a>
                    </div>-->
                    </div>
                </div>
            </div>
            <%Else%>
            <div class="login-wrapper">
                <div class="login">
                    <form method="post" action="./Login.asp?res=1">
                        <span class="login-wrapper-textinput">
                            <input type="text" name="txtUserName" value="" placeholder="Username"></span>
                        <span class="login-wrapper-textinput">
                            <input type="password" name="txtPassword" value="" placeholder="Password"></span>
                        <span class="submit">
                            <input id="add" type="submit" name="add" value="<%=Application("strtextenter" & strlanguagecode)%>">
                            <input type="hidden" name="txtSubmit" id="txtSubmit" value="1" />
                        </span>
                    </form>
                </div>
                <div class="login-help">
                    <span class="forgot"><a href="emailusernamepswd.asp?res=1">Forgot?</a></span>
                </div>
            </div>
            <%End If%>
        </div>
    </div>
    <div class="header-bottom clearfix">
        <div class="header-bottom-wrapper">
            <div id="logo">
                <a href="../default.asp" class="logo">
                    <img src="./images/PDILogo_w_<%=strLanguageCode%>.png" alt="PDI DISC Profile System" /></a>
                <span class="tagline">An Instrument for Understanding Yourself and Others<sup class="reg">&reg;</sup></span>
            </div>
            <div>
                <ul class="menu">
                    <!--<li class="menu-item">
	                    <a href="../default.asp" ><%= Application("strTextHome" & strLanguageCode) %></a>
                    </li>-->
                    <%If Request.Cookies("UserName") <> "" Then%>
                    <li class="menu-item account-home">
                        <a href="main.asp?res=1">Account Home</a>
                    </li>
                    <%Else%>
                    <li class="menu-item">
	                    <a href="../default.asp" ><%= Application("strTextHome" & strLanguageCode) %></a>
                    </li>
                    <li class="menu-item">
<!--                        <a href="UserRegistration.asp?res=1"><%=Application("strTextRegister" & strLanguageCode) %></a>-->
                            <a href="Registration.asp?res=1"><%=Application("strTextRegister" & strLanguageCode) %></a>
                    </li>
                    <%End If%>

                    <li class="menu-item">
                        <a href="Products.asp"><%= Application("strTextProducts" & strLanguageCode) %></a>
                    </li>
                    <li class="menu-item">
	                    <a href="Features.asp">Features</a>
                    </li>
                    <li class="menu-item">
                        <a href="AboutDISC.asp"><%= Application("strTextAboutDISC" & strLanguageCode) %></a>
                    </li>
                    <li class="menu-item">
                        <a href="ContactUs.asp"><%= Application("strTextContactUs" & strLanguageCode) %></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
