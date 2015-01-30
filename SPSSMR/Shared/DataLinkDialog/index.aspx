<%@ Page CodeBehind="index.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="VB.index" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ OutputCache Location="none" %>
<HTML>
	<HEAD>
		<title><asp:Literal id="DialogTitle" runat="server" /></title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="tabctrl.js"></script>
		<script type="text/javascript" src="datalinkdialog.js"></script>
		<script type="text/javascript" src="index.js"></script>
		<link rel="stylesheet" type="text/css" href="spsstabs.css">
		<link rel="stylesheet" type="text/css" href="spssmrNet.css">
		<style> 
			.TopLevelTable { 
				POSITION: absolute; 
				TOP: 0px; 
				LEFT: 0px; 
				WIDTH: 100%; 
				HEIGHT: 100%; 
				MARGIN: 0px; 
				PADDING: 0px; 
			}
		</style>
	</HEAD>
	<body onload="doInitTabs()" class="ApplicationHeader" style="MARGIN: 0px">
		<form id="indexForm" runat="server">
			<table class="TopLevelTable" cellpadding="0" cellspacing="0">
				<TBODY>
					<tr>
						<td class='ApplicationLogoField' style="HEIGHT: 50px">
							<div id="TabClientDiv" style="LEFT: 0px; POSITION: absolute; TOP: 18px">
								<TABLE style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TBODY>
										<TR>
											<TD style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px"-->
												<!-- Tabs Table (begin) -->
												<TABLE id="TabClientDivTabClientDivSPSS" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" cellSpacing="0" cellPadding="0" width="333" border="0">
													<TBODY>
														<TR>
															<TD class="tabBorderLight" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" width="1" height="32">
																&nbsp;
															</TD>
															<TD background="images/tabfirst.on.gif" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" width="15" height="32">
																<DIV style="TABLE-LAYOUT: fixed; WIDTH: 15px" />
															</TD>
															
															<TD background="images/tabmain.on.gif" onclick="selectTab(cConnection)" class="tabArea" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap" align="left" width="60" height="32">
																<A class="tabText" style="VERTICAL-ALIGN: middle; WHITE-SPACE: nowrap">
																	<%=Server.HtmlEncode(VB.Utilities.I18N.GetLanguageLiteral("tab_connection", Request.QueryString("langres")))%>
																</A>
															</TD>
															<TD background="images/tab.on.off.gif" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" width="16" height="32">
																<DIV style="TABLE-LAYOUT: fixed; WIDTH: 16px" />
															</TD>
															<TD background="images/tabmain.off.gif" onclick="selectTab(cAdvanced)" class="tabArea" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap" align="left" width="60" height="32">
																<A class="tabText" style="VERTICAL-ALIGN: middle; WHITE-SPACE: nowrap">
																	<%=Server.HtmlEncode(VB.Utilities.I18N.GetLanguageLiteral("tab_advanced", Request.QueryString("langres")))%>
																</A>
															</TD>
															<TD background="images/tab.off.off.gif" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" width="16" height="32">
																<DIV style="TABLE-LAYOUT: fixed; WIDTH: 16px" />
															</TD>
															<TD background="images/tabmain.off.gif" onclick="selectTab(cAll)" class="tabArea" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap" align="left" width="60" height="32">
																<A class="tabText" style="VERTICAL-ALIGN: middle; WHITE-SPACE: nowrap">
																	<%=Server.HtmlEncode(VB.Utilities.I18N.GetLanguageLiteral("tab_all", Request.QueryString("langres")))%>
																</A>
															</TD>
															<TD background="images/tabend.off.gif" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" width="13" height="32">
																<DIV style="TABLE-LAYOUT: fixed; WIDTH: 13px" />
															</TD>
															<TD class="tabBorderLight">
																&nbsp;
															</TD>
														</TR>
													</TBODY>
												</TABLE>
												<!-- Tabs Table (end) -->
											</TD>
											<TD class="tabBorderLight" width="100%">
												&nbsp;
											</TD>
										</TR>
									</TBODY>
								</TABLE>
							</div>
						</td>
					</tr>
					<tr>
						<td style='PADDING-LEFT:30px'>
							<iframe name="ws_frame" src="<%=IFrameSource%>" scrolling="auto" frameborder="0" marginwidth="0" marginheight="0" style="WIDTH: 100%; HEIGHT: 100%" noresize />
						</td>
					</tr>
				</TBODY>
			</table>
		</form>
	</body>
</HTML>
