<%@ Page language="c#" Codebehind="welcome.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.welcome" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Welcome</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<%= getHTML("welcome.inc") %>
			<div id="welcomeBeginButton"><asp:button id="btnBegin" runat="server" CssClass="standard-textbox" Text="Begin" CausesValidation="False"></asp:button></div>
		</form>
	</body>
</HTML>
