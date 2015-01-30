<%@ Page language="c#" Codebehind="Help.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.Help" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<!-- 
	* Warning: this computer program is protected by
	* copyright law and international treaties.
	* Unauthorized reproduction or distribution of this
	* program, or any portion of it, may result in severe
	* civil and criminal penalties, and will be prosecuted 
	* to the maximum extent of the law. 
	*  
	* Copyright © 2003 SPSS Ltd. All rights reserved.
	-->
	<head>
		<title>
			<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("help_dialog_title"))%>
		</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Help" method="post" runat="server">
		</form>
	</body>
</html>
