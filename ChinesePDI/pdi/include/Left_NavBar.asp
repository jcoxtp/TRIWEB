<%
Randomize
Pic=Int((8)*Rnd() + 1)
LastPic = Request.Cookies("LeftNavPicture")
If Pic = LastPic then
	If Pic=8 then 
		Pic =2
	Else
		Pic = Pic + 1
	End If
End If
Response.Cookies("LeftNavPicture") = Pic
%>

<div id="leftnavbar">
	<p><img src="images/LeftNav.jpg" alt="" usemap="#navbar" border="0" />
	<map name="navbar">
<% If intResellerID = 1 Then %>
<!--		<area shape="rect" alt="" coords="5,234,86,252" href="main.asp?res=<%=intResellerID%>"> -->
		<area shape="rect" alt="" coords="5,235,86,253" href="contact_us.asp?res=<%=intResellerID%>">
		<area shape="rect" alt="" coords="5,265,36,283" href="javascript:confirmLogout()">
<% Else If intResellerID = 2 Then %>
<!--		<area shape="rect" alt="" coords="5,225,86,242" href="main.asp?res=<%=intResellerID%>"> -->
		<area shape="rect" alt="" coords="5,228,86,245" href="contact_us.asp?res=<%=intResellerID%>">
		<area shape="rect" alt="" coords="5,265,36,283" href="javascript:confirmLogout()">
<% End If End If %>
	</map>
	</p>

	<%
	Dim currentURL, currentFileName
	currentURL = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
	currentFileName = mid(currentURL, InStrRev(currentURL, "/") + 1)
	Response.Cookies("URLInfo") = currentURL
	Response.Cookies("fileNameInfo") = currentFileName
	%>
</div>