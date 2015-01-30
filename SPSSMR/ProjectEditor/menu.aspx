<%@ Page language="c#" Codebehind="menu.aspx.cs" Inherits="ProjectEditor.menu" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<!-- DIALOG LIB -->
		<script src="../Shared/Dialog/dialog.js" type="text/javascript"></script>
		<!-- STANDARD SPSS TAB SETTINGS -->
		<script type="text/javascript" src="../shared/tabs/tabctrl.js"></script>
		<link rel="stylesheet" type="text/css" href="../shared/tabs/spsstabs.css">
		<!-- STANDARD SPSS MENU SETTINGS -->
		<script type="text/javascript" src="../shared/coolmenu/coolmenus4.js"></script>
		<link rel="stylesheet" type="text/css" href="../shared/coolmenu/spssmenu.css">
		<!-- JAVASCRIPT FUNCTIONS USED ONLY FROM THIS PAGE -->
		<script src="menu.js" type="text/javascript"></script>
		<link type="text/css" rel="stylesheet" href="../shared/spssmrNet.css">
		<!-- PROJECT EDITOR STYLESHEET SETTINGS -->
		<link rel="stylesheet" type="text/css" href="css/projecteditor.css">
		<script type="text/javascript">
			var oTabCtrl = new spssTabCtrl();
			
			// function that actually creates and displays the tabs...
			function doInitTabs() {
				oTabCtrl.SetImagePath('shared/tabs/images');
				oTabCtrl.InitTab('TabsDiv');
				oTabCtrl.AutoSelectTabs = false;
				oTabCtrl.selectedIdx = 0;
				
				oTabCtrl.AddTab("<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("menu_tabtext_projectinfo"))%>", 'tabSelected(0);' );
				oTabCtrl.AddTab("<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("menu_tabtext_permissions"))%>", 'tabSelected(1);' );
				oTabCtrl.AddTab("<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("menu_tabtext_connection"))%>", 'tabSelected(2);' );
				oTabCtrl.AddTab("<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("menu_tabtext_properties"))%>", 'tabSelected(4);' );
				
				//oTabCtrl.Draw();
				//oTabCtrl.Select(0);
			}
			
			function tabSelected(tabselected)
			{
				//0:Project Info 1:Roles 2:Connection 3:Properties
				if(document.frames[1].showTab)
				{
				    document.frames[1].showTab(tabselected);
				}
			}
		</script>
	</HEAD>
	<body class="Menu" onload="doInitTabs()">
			<div id="TabsDiv" style="position:absolute; top: 47px; left: 0px; Z-INDEX: 10">
				<TABLE style="PADDING: 0px; DISPLAY: inline" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TBODY>
						<TR>
							<TD style="PADDING: 0px;">
								<TABLE id="TabsDivTabsDivSPSS" style="PADDING: 0px; DISPLAY: inline" cellSpacing="0" cellPadding="0" border="0">
									<TBODY>
										<TR>
											<TD class="tabBorderLight" style="PADDING: 0px;" width="1" height="32">&nbsp;</TD>
											
											<TD style="PADDING: 0px" width="15" background="shared/tabs/images/tabfirst.on.gif" height="32">
												<DIV style="WIDTH: 15px" />
											</TD>
											<TD onclick="tabSelected(0)" class="tabArea" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap" align="left" width="60" background="shared/tabs/images/tabmain.on.gif" height="32">
												<div style="width:60px;">
													<a href="javascript:void(0);" class="tabText" style="vertical-align:middle; white-space:nowrap; text-decoration:none;">
														<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("menu_tabtext_projectinfo"))%>
													</a>
												</div>
											</TD>
											
											<TD style="PADDING: 0px" width="16" background="shared/tabs/images/tab.on.off.gif" height="32">
												<DIV style="WIDTH: 16px" />
											</TD>
											<TD onclick="tabSelected(1)" class="tabArea" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap" align="left" width="60" background="shared/tabs/images/tabmain.off.gif" height="32">
												<div style="width:60px;">
													<a href="javascript:void(0);" class="tabText" style="vertical-align:middle; white-space:nowrap; text-decoration:none;">
														<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("menu_tabtext_permissions"))%>
													</a>
												</div>
											</TD>
											
											<TD style="PADDING: 0px" width="16" background="shared/tabs/images/tab.off.off.gif" height="32">
												<DIV style="WIDTH: 16px" />
											</TD>
											<TD onclick="tabSelected(2)" class="tabArea" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap" align="left" width="60" background="shared/tabs/images/tabmain.off.gif" height="32">
												<div style="width:60px;">
													<a href="javascript:void(0);" class="tabText" style="vertical-align:middle; white-space:nowrap; text-decoration:none;">
														<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("menu_tabtext_connection"))%>
													</a>
												</div>
											</TD>
											
											<TD style="PADDING: 0px" width="16" background="shared/tabs/images/tab.off.off.gif" height="32">
												<DIV style="WIDTH: 16px" />
											</TD>
											<TD onclick="tabSelected(3)" class="tabArea" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap" align="left" width="60" background="shared/tabs/images/tabmain.off.gif" height="32">
												<div style="width:60px;">
													<a href="javascript:void(0);" class="tabText" style="vertical-align:middle; white-space:nowrap; text-decoration:none;">
														<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("menu_tabtext_properties"))%>
													</a>
												</div>
											</TD>
											
											<TD style="PADDING: 0px" width="13" background="shared/tabs/images/tabend.off.gif" height="32">
												<DIV style="WIDTH: 13px" />
											</TD>
										</TR>
									</TBODY>
								</TABLE>
							</TD>
						</TR>
					</TBODY>
				</TABLE>
			</div>
		<form id="menu" method="post" runat="server">
		</form>
	</body>
</HTML>
