<%@ Page CodeBehind="FrameManager.aspx.cs" Language="c#" AutoEventWireup="false" Inherits="ProgressDialog.FrameManager" %>
<HTML>
	<head>
	<title id=title runat=server></title>
	</head>
	<frameset rows="156,*" frameborder="0">
		<frame name="frmImage" src="molecules.htm" frameborder=0></frame>
		<frame name="frmAction" id="frmAction" runat="server" frameborder=0></frame>
	</frameset>
</HTML>
