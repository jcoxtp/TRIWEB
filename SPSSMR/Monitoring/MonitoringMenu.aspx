<%@ Page language="c#" Codebehind="MonitoringMenu.aspx.cs" Inherits="SPSSMR.Management.Monitoring.Web.MonitoringMenu" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>Menu</title>
        <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
        <meta name="CODE_LANGUAGE" Content="C#">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <!-- SPSS Launcher applications stylesheet -->
        <link href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
        <!-- Tab  stylesheet and javascript file -->
        <link href="Shared/tabs/spsstabs.css" type="text/css" rel="stylesheet">
        <script src="Shared/tabs/tabctrl.js" type="text/javascript"></script>
        <!-- Menu stylesheet and javascript files -->
        <link href="Shared/coolmenu/spssmenu.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="Shared/coolmenu/coolmenus4.js"></script>
        
        <!-- DIALOG LIB -->
		<script src="../Shared/Dialog/dialog.js" type="text/javascript"></script>
		<!-- STANDARD SPSS TAB SETTINGS -->
		<script type="text/javascript" src="../shared/tabs/tabctrl.js"></script>
		<link rel="stylesheet" type="text/css" href="../shared/tabs/spsstabs.css">
		<!-- STANDARD SPSS MENU SETTINGS -->
		<script type="text/javascript" src="../shared/coolmenu/coolmenus4.js"></script>
		<link rel="stylesheet" type="text/css" href="../shared/coolmenu/spssmenu.css">
		<!-- JAVASCRIPT FUNCTIONS USED ONLY FROM THIS PAGE -->
		
		<script type="text/javascript" src="MonitoringMail.js"></script>
		
		<script src="menu.js" type="text/javascript"></script>
		<link type="text/css" rel="stylesheet" href="../shared/spssmrNet.css">
		<!-- PROJECT EDITOR STYLESHEET SETTINGS -->
		<link rel="stylesheet" type="text/css" href="css/projecteditor.css">
        
        <!-- doInitTabs() is a function that will be generated by the code behind if tabs are in use, 
  if tabs are in use. If tabs are not required this action can be removed.
  -->
        <script language="javascript">
			function doCloseApp() 
			{
				var exitURL = '<%=GetExitUrl()%>';
				
				if (exitURL == '')
				{
					window.close();
				}
				else
				{
					top.location.replace (exitURL);
				}
			}	
			function showMailOption(hash)
            {
	            var url = "MailOptions.aspx?hash=" + hash;
	            if (window.showModalDialog) 
		            window.showModalDialog(url, "", "dialogHeight:400px;dialogWidth:370px;status:no;help:no;resizeable:yes;scroll:no;edge:sunken;unadorned:yes;");
	            else 
		            window.open(url,"","height=400,width=370,toolbar=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,modal=yes");
            }  
            
            
            
            var oTabCtrl = new spssTabCtrl();
			
			// function that actually creates and displays the tabs...
			function doInitTabs() {
				oTabCtrl.SetImagePath('shared/tabs/images');
				oTabCtrl.InitTab('TabsDiv');
				oTabCtrl.AutoSelectTabs = false;
				oTabCtrl.selectedIdx = 0;

				oTabCtrl.AddTab("<%=Server.HtmlEncode(I18N.GetResourceString("menu_tabtext_license"))%>", 'tabSelected(0);' );
				oTabCtrl.AddTab("<%=Server.HtmlEncode(I18N.GetResourceString("menu_tabtext_counter"))%>", 'tabSelected(1);' );
				


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
    <body class="Menu" MS_POSITIONING="GridLayout">
        <body class="Menu" onload="doInitTabs()">
			<div id="TabsDiv" style="position:absolute; top: 47px; left: 0px; Z-INDEX: 10; display:<%=usageReportVisibility%>" >
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
														<%=Server.HtmlEncode(I18N.GetResourceString("menu_tabtext_license"))%>
													</a>
			
												</div>
											</TD>
											
											<TD style="PADDING: 0px" width="16" background="shared/tabs/images/tab.on.off.gif" height="32">
												<DIV style="WIDTH: 16px" />
											</TD>
											<TD onclick="tabSelected(1)" class="tabArea" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap" align="left" width="60" background="shared/tabs/images/tabmain.off.gif" height="32">
												<div style="width:60px;">
													<a href="javascript:void(0);" class="tabText" style="vertical-align:middle; white-space:nowrap; text-decoration:none;">
														<%=Server.HtmlEncode(I18N.GetResourceString("menu_tabtext_counter"))%>
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
    </body>
</HTML>