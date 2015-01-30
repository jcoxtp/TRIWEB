<%@ Page language="c#" Codebehind="Progress.aspx.cs" Inherits="ManageUsers.Progress" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>Progress</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta id="metaRefresh" runat="server"/>
		<link href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</head>
	<body ms_positioning="GridLayout">
		<form id="ProgressForm" method="post" target="_self" runat="server">
			<table width="100%" height="100%">
				<tr align="left" valign="top" height="100%">
					<td><asp:label id="progressLabel" runat="server"></asp:label></td>
				</tr>
				<tr>
					<td align="center"><asp:button id="AbortButton" runat="server"></asp:button></td>
				</tr>
			</table>
		</form>
	</body>
</html>
