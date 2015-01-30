<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="Run.aspx.cs" AutoEventWireup="false" Inherits="InterviewExporter.Run" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Exporting...</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta id="metaRefresh" runat="server"></meta>
		<base target="_self">
		<!-- STANDARD SPSS STYLESHEET SETTINGS -->
		<link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			function doCloseAndDownload()
			{
				window.returnValue = true; 
				window.close();
			}

			function doCloseDialog()
			{
				window.returnValue = false; 
				window.close();
			}
		</script>
	</HEAD>
	<body id="body" runat="server">
		<form id="Run" method="post" runat="server">
			<span id="dialogSize" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; WIDTH: 400px; PADDING-TOP: 0px">
				<asp:Panel Visible="True" ID="pnlRunning" Runat="server">
					<DIV class="DarkBlueBackground" align="center"><IMG src="../Shared/images/molecules.gif">
					</DIV>
					<BR>
					<DIV align="left">&nbsp;&nbsp;<LABEL id="lblStatus"><%=I18N.GetResourceString("exporting_wait")%></LABEL></DIV>
					<BR>
					<BR>
				</asp:Panel>
				<asp:Panel Visible="false" ID="pnlError" Runat="server"><BR>
					<DIV align="left">
						&nbsp;&nbsp;<LABEL id="lblError"><%=I18N.GetResourceString("exporting_error")%></LABEL>
					</DIV>
					<BR>&nbsp;&nbsp;<BUTTON id="btnViewLog" style="WIDTH: 6em" type="button" runat="server" onserverclick="btnViewLog_ServerClick">
						<%=I18N.GetResourceString("exporting_viewlog")%>
					</BUTTON> 
					<BR>
					<asp:Panel id="pnlLog" Runat="server" Visible="false">
						<div align="center">
							<asp:TextBox ID="tbLog" Runat="server" TextMode="MultiLine" Height="100px" CssClass="InnerTableMainDataCtrl"
								style="BORDER-RIGHT: 1px inset; BORDER-TOP: 1px inset; OVERFLOW: auto; BORDER-LEFT: 1px inset; BORDER-BOTTOM: 1px inset"
								Width="98%" ReadOnly="True"></asp:TextBox>
							<BR>
						</div>						
					</asp:Panel>
					<BR>
				</asp:Panel>
				<div align="center">
					<button id="btnCancel" runat="server" style="WIDTH: 6em" type="button" onserverclick="btnCancel_ServerClick">
						<%=I18N.GetResourceString("run_cancel")%>
					</button>
				</div>
			</span>
		</form>
		<iframe style="DISPLAY: none; WIDTH: 0px; HEIGHT: 0px" src="shared/sessionkeepalive.aspx">
		</iframe>
	</body>
</HTML>
