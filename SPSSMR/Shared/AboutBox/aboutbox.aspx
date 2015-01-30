<%@ Page language="c#" Codebehind="aboutbox.aspx.cs" AutoEventWireup="true" Inherits="AboutBox.AboutBoxPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>      
			<%=Server.HtmlEncode(AboutBox.I18N.GetResourceString("IDS_INFO_TITLE"))%>
  	</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<style type="text/css">
			.Details { FONT-SIZE: 8pt;FONT-FAMILY: verdana;COLOR: black; }
			.Header { FONT-SIZE: 10pt;FONT-FAMILY: verdana;COLOR: #d42c50; }
			.Link { FONT-SIZE: 8pt;FONT-FAMILY: verdana;COLOR: black; }
			.Scroll { text-align : left;  width : 100%;  height : 100%;  overflow: auto; cursor: pointer;}
		</style>
	</HEAD>
	<body style="margin: 0 0 0 0">
		<form id="Form1" method="post" runat="server">
			<table width="100%" height="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td align="right"><img src="images/banner.gif" width="400px"></td>
				</tr >
				<tr valign="middle" height="100%">
				<td>
				<table width="100%" height="100%" cellpadding="5px" cellspacing="5px">
					<tr valign="top" height="20px">
						<td><asp:Label cssclass="Header" id="lblAboutHeader" runat="server"></asp:Label></td>
					</tr>
					<tr valign="middle" height="100%">
						<td width="100%">
							<div runat="server" class="Scroll" id="divCopyToClipboard" title="click to copy to clipboard" onclick="javascript:copyToClipboard();">
								<asp:Label CssClass="Details" id="lblAboutDetails" runat="server"></asp:Label>
							</div>
						</td>
					</tr>
					<tr valign="top" height="20px">
						<td><a class="Link" href="" target="_blank" id="linkSupportHomePage" name="linkSupportHomePage" runat="server"></a></td>
					</tr>
				</table>
				</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
