<%
' [SM] We are trying to avoid having scrollbars in the help window, so we are testing for
' [SM] those pages that have a relatively large amount of help text
' [SM] One problem is that if you view the help text on a typical page, then, without closing
' [SM] the popup window, visit the Main page and click the Help button, the popup window
' [SM] will *not* honor the new height setting, resulting in the need to scroll.

help_popUpWidth = 325

Select Case pageID
	Case "home"
		help_popUpHeight = 350
	Case "enterTestCode"
		help_popUpHeight = 300
	Case "editUser"
		help_popUpHeight = 250
	Case "purchaseTest"
		help_popUpHeight = 250
	Case "question1"
		help_popUpHeight = 300
	Case "question2"
		help_popUpHeight = 300
	Case "question3"
		help_popUpHeight = 300
	Case "question4"
		help_popUpHeight = 300
	Case "quit"
		help_popUpHeight = 400
	Case "repProfile2"
		help_popUpHeight = 500
	Case "profileDesc"
		help_popUpHeight = 250
	Case "profileResults"
		help_popUpHeight = 200
	Case "behavioralChar1"
		help_popUpHeight = 250
	Case "behavioralChar2"
		help_popUpHeight = 250
	Case Else
		help_popUpHeight = 200
End Select
%>
<% If strSiteType = "DG" Then %>
<style>
    #maincontent {
        position: absolute;
        top: 101px;
        left: 106px;
        width: 660px;
        padding-left: 20px;
        padding-top: 20px;
    }

    #maincontent_tab {
        position: absolute;
        top: 180px;
        left: 101px;
        width: 660px;
        padding-left: 25px;
        padding-top: 20px;
        margin: 1em auto;
    }
</style>
<div class="header">
    <img src="/RS/<%=SitePathName%>/TopBanner<%=strLanguageCode%>.jpg" alt="" width="791" height="89" usemap="#banner" />
    <map name="banner">
        <area shape="rect" alt="" coords="690,59,769,80" href="javascript:openAnyWindow('help.asp?pageID=<%=pageID%>','Help',<%=help_popUpWidth%>,<%=help_popUpHeight%>,'left=425','top=200')">
    </map>
</div>
<!-- #Include File = "LeftNavBar.asp" -->

<% ElseIf strSiteType = "TR" Then%>
<!-- #Include File = "header.asp" -->

<% Else %>
<style>
    #maincontent {
        position: absolute;
        top: 101px;
        left: 106px;
        width: 660px;
        padding-left: 20px;
        padding-top: 20px;
    }

    #maincontent_tab {
        position: absolute;
        top: 180px;
        left: 101px;
        width: 660px;
        padding-left: 25px;
        padding-top: 20px;
        margin: 1em auto;
    }
</style>
<div class="header">
    <img src="/RS/<%=SitePathName%>/TopBanner<%=strLanguageCode%>.gif" border="0" alt="" width="791" height="89" usemap="#banner" style="display: block;" />
    <map name="banner">
        <area shape="rect" alt="" coords="690,59,769,80" href="javascript:openAnyWindow('help.asp?pageID=<%=pageID%>','Help',<%=help_popUpWidth%>,<%=help_popUpHeight%>,'left=425','top=200')">
    </map>
</div>
<!-- #Include File = "LeftNavBar.asp" -->
<% End If %>

<%
	currentURL = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
	currentFileName = mid(currentURL, InStrRev(currentURL, "/") + 1)
	Response.Cookies("URLInfo") = currentURL
	Response.Cookies("fileNameInfo") = currentFileName
%>

