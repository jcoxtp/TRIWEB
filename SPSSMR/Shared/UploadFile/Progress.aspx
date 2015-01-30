<%@ Page language="c#" Codebehind="Progress.aspx.cs" AutoEventWireup="false" Inherits="SPSSMR.Web.UI.UploadFile.Progress" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title></title>
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../spssmrNet.css" type="text/css" rel="stylesheet">
		<style>
			.progressBarOuter { border: #006000 1px solid; padding: 0; border-top: #006000 1px solid;  width: 100%; height: 15px }
			.progressBarInner {	height: 100%; background-color: #eff7ff; }
		</style>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:panel id="panelProgress" runat="server" visible="True">
				<TABLE width="100%">
					<TR>
						<TD id="tdUploadingLabel" runat="server">Uploading:</TD>
					</TR>
					<TR>
						<TD>
							<DIV class="progressBarOuter"><SPAN class="progressBarInner" id="progressBar" runat="server"></SPAN></DIV>
						</TD>
					</TR>
					<TR>
						<TD>
							<asp:label id="lblSize" runat="server"></asp:label></TD>
					</TR>
				</TABLE>
			</asp:panel><asp:label id="lblError" runat="server"></asp:label></form>
	</body>
</HTML>
