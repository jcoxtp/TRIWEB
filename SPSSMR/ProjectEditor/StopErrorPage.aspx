<%@ Page language="c#" Codebehind="StopErrorPage.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.StopErrorPage" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=BrowserTitle()%>
		</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script src="../Shared/Dialog/dialog.js" type="text/javascript"></script>
		<script type="text/javascript">
		<!--
		-->
		</script>
		<link type="text/css" rel="stylesheet" href="../shared/spssmrNet.css">
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="MARGIN: 5px">
			<form id="StopErrorPage" method="post" runat="server">
			<table style="width:100%;height:100%;">
            <tr>
            <td>
				<table class="OuterTable" style="WIDTH : 500px;" align="center">
					<tr>
						<td style="PADDING: 5px">
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
				<table style="WIDTH: 500px" border="0" align="center">
					<tr>
						<td style="TEXT-ALIGN: center">
							<div style="OVERFLOW: visible; WHITE-SPACE: nowrap">
								<input type="button" class="stdbutton" id="btnFinish" runat="server" value="F" NAME="btnFinish">
								&nbsp;
							</div>
						</td>
					</tr>
				</table>
				</td></tr></table>
			</form>
	</body>
</HTML>
