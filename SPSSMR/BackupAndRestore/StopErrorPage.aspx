<%@ Page language="c#" Codebehind="StopErrorPage.aspx.cs" AutoEventWireup="false" Inherits="Brad.Delete.StopErrorPage" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD runat=server>
		<title>
		<%=SetDocumentTitle()%>
		</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script src="../Shared/Dialog/dialog.js" type="text/javascript"></script>
		<link type="text/css" rel="stylesheet" href="../shared/spssmrNet.css">
	  </HEAD>
	<body MS_POSITIONING="GridLayout" style="MARGIN: 5px">
		<form id="StopErrorPage" method="post" runat="server">
				<table class="OuterTable" style="WIDTH : 100%;">
					<tr>
						<td style="PADDING: 5px; height: 58px;">
							<font style="FONT-WEIGHT: bold; FONT-SIZE: larger">
								<nobr>
									<asp:Label id="lblHeading" runat="server"></asp:Label>
								</nobr>
							</font>
							<P>
								<asp:Label id="lblDescription" runat="server"></asp:Label>
							</P>
						</td>
					</tr>
				</table>
				<table style="WIDTH: 100%" border="0">
					<tr>
						<td style="TEXT-ALIGN: center">
							<div style="OVERFLOW: visible; WHITE-SPACE: nowrap">
								<input type="button" class="stdbutton" id="btnFinish" runat="server" value="F" NAME="btnFinish">
								&nbsp;
							</div>
						</td>
					</tr>
				</table>
			</form>
	</body>
</HTML>
