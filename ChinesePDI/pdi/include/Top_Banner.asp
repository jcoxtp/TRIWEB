<img src="images/BannerTop.gif" alt="" width="791" height="89" usemap="#banner" border="0" />

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

<map name="banner">
<% If intResellerID = 1 Then %>
	<area shape="rect" alt="" coords="711,59,761,84" href="javascript:openAnyWindow('help.asp?pageID=<%=pageID%>','Help',<%=help_popUpWidth%>,<%=help_popUpHeight%>,'left=425','top=200')">
<% Else If intResellerID = 2 Then %>
	<area shape="rect" alt="" coords="690,59,769,80" href="javascript:openAnyWindow('help.asp?pageID=<%=pageID%>','Help',<%=help_popUpWidth%>,<%=help_popUpHeight%>,'left=425','top=200')">
<% End If End If %>
</map>
