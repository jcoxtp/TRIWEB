<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="EditUserPropertyGroupsDialog.aspx.cs" Inherits="ManageUsers.EditUserPropertyGroupsDialog" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<asp:Literal ID="DialogTitle" Runat="server"></asp:Literal>
		</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table style="BORDER-RIGHT: 1px solid; PADDING-RIGHT: 0px; BORDER-TOP: 1px solid; PADDING-LEFT: 0px; LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; BORDER-LEFT: 1px solid; WIDTH: 100%; PADDING-TOP: 0px; BORDER-BOTTOM: 1px solid; POSITION: absolute; TOP: 0px; HEIGHT: 100%"
				cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<iframe name="ContentFrame" src="Shared/ManageUserProperties/UserPropertiesLoadingWait.aspx?hash=<%=Request["hash"]%>" scrolling="auto" frameborder="0" marginwidth="0" marginheight="0" style="WIDTH: 100%; HEIGHT: 100%" noresize></iframe>
					</td>
				</tr>
				<tr>
					<td style="HEIGHT: 50px; TEXT-ALIGN: left">
						<input type="button" id="CloseButton" runat="server" class="stdbutton" onclick="window.close()">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
