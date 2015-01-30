<%
Randomize
Pic = Int((8)*Rnd() + 1)
LastPic = Request.Cookies("LeftNavPicture")
If Pic = LastPic then
	If Pic = 8 then 
		Pic = 2
	Else
		Pic = Pic + 1
	End If
End If
Response.Cookies("LeftNavPicture") = Pic
%>

<div id="leftnavbar">
<% If intResellerID = 1 Then %>
    <div>
	    <img src="images/TRLeftNav<%=strLanguageCode & Pic%>.jpg" border="0" alt="" usemap="#navbar" />
	    <map name="navbar">
		    <area shape="rect" alt="" coords="5,234,86,252" href="main.asp?res=<%=intResellerID%>">
		    <area shape="rect" alt="" coords="5,255,86,273" href="ContactUs.asp?res=<%=intResellerID%>&lid=<%=intLanguageID%>">
		    <area shape="rect" alt="" coords="5,278,86,296" href="javascript:confirmLogout()">
    	</map>
    </div>
<% Else %>
	<div>
        <img src="/RS/<%=SitePathName%>/LeftNavImage.jpg" alt="" usemap="#navbar" />
	    <map name="navbar">
		    <area shape="rect" alt="" coords="5,235,86,252" href="main.asp?res=<%=intResellerID%>">
            <area shape="rect" alt="" coords="5,277,86,298" href="javascript:confirmLogout()">
        </map>
    </div>
<% End If %>

<%
	'Dim currentURL, currentFileName
	currentURL = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
	currentFileName = mid(currentURL, InStrRev(currentURL, "/") + 1)
	Response.Cookies("URLInfo") = currentURL
	Response.Cookies("fileNameInfo") = currentFileName
%>
</div>