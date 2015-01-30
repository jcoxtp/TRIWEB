<%
Option Explicit
%>
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<html>
<head>
<title><%=SV_SITENAME%> Help</title>
</head>
<!-- <sx-description>Xtreeme SiteXpert-generated Site Map file</sx-description> -->
<%
Dim strDoc
Dim strTree
Dim intUserType
intUserType = Request.QueryString("userType")
If utility_isPositiveInteger(intUserType) Then
	intUserType = cint(intUserType)
End If

strDoc = Request.QueryString("doc")

If intUserType = SV_USER_TYPE_ADMINISTRATOR Then
	strTree = "help/index_map.asp"
ElseIf intUserType = SV_USER_TYPE_CREATOR Then
	strTree = "help/indexcreate_map.asp" 
Else
	strTree = "help/basic_map.asp"
End If
%>
<frameset border="0" rows="44,*">
	<frame name="header" src="helpHeader.asp" scrolling="no">
	<frameset border="1" frameborder="yes" framespacing="0" cols="175,*">
	<frame name="tree" src="<%=strTree%>">
	<frame name="content" src="help/docs/<%=strDoc%>">
	</frameset>	
	
</frameset>
</html>