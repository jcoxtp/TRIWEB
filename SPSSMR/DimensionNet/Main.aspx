<%@ Page language="c#" Codebehind="main.aspx.cs" Inherits="Launcher.MainClass" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>SPSS DimensionNet</title>
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
  </HEAD>
	<body>
		<form id="main" method="post" runat="server">
			<table height="100%" width="100%">
  				<tr vAlign="middle" align="center">
					<td>
						<table id="table1" cellSpacing="0" cellPadding="0" border="0" background="images/dimensionnet.gif" height="300">
        					<tr><td colspan="2" vAlign="top" width="450" height="90"></td></tr>
							<tr><td width="15"></td>
								<td vAlign="top" width="*">
									<table id="table2" cellSpacing="0" width="430" border="0" cellpadding="0">
										<tr><td><font face="Verdana" color="#c41e3a" size="3"><b><div runat="server" id="divDimensionNetHeader">DimensionNet Home Page</div></b></font></td><td></td></tr>
										<tr>
											<td>
												<table cellSpacing="0" width="360" height="25" border="0" cellpadding="0">
													<tr>
														<td><font size="1"><b><asp:label id="lblIntroToStart" Runat="server"></asp:label></b></font></td>
													</tr>
												</table>
											</td>
										</tr>											
										<tr>
											<td>
												<table cellSpacing="0" width="290" height="30" border="0" cellpadding="0">
													<tr>
														<td><font size="1"><asp:label id="lblIntroToStartText" Runat="server"></asp:label></font></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table cellSpacing="0" width="220" height="25" border="0" cellpadding="0">
													<tr>
														<td><font size="1"><b><asp:label id="lblIntroOr" Runat="server"></asp:label></b></font></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table cellSpacing="0" width="220" border="0" cellpadding="0">
													<tr>
														<td><font size="1"><asp:label id="lblIntroOrText" Runat="server"></asp:label></font></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom">
								<td colspan="2">&nbsp;&nbsp;<asp:HyperLink Target="_blank" CssClass="spsshomepagelink" ID="hlSpssHomePage" name="hlSpssHomePage" Runat="server"></asp:HyperLink></td>
							</tr>
							<tr><td colspan="2" height="5px"></td></tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
