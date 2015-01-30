<%@ Page Language="vb" CodeBehind="srctree.aspx.vb" AutoEventWireup="false" Inherits="mrWebExplorer.Internal.Page.srctree" %>
<%@ OutputCache Location="none" %>
<html>
	<head>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="mrWebExplorer.css">
		<!-- Infrastructure code for the tree -->
		<script language="javascript" src="ftiens4.js"></script>
	</head>
	<body topmargin="0" leftmargin="0" style="background-color:white">
		<table width="100%">
			<tr>
				<td>
					<input type="button" id="foldersButton" runat="server" class="headerbutton" value="folders" >
				</td>
			</tr>
		</table>
		<!-- Execution of the code that actually builds the specific tree -->
		<%
			Call GenerateJScriptForFolderAliases()
		%>
	</body>
</html>
