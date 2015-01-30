<%@ Page language="c#" Codebehind="dlgNewProjectConfigure.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.dlgNewProjectConfigure" %>
<%@ OutputCache Location="none" %>
<%@ Register tagprefix="SPSS" Tagname="OkCancel" src="ctrlOkCancel.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProjectConfigure_title"))%>
		</title>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script src="general.js" type="text/javascript"></script>
		<script src="shared/Dialog/dialog.js" type="text/javascript"></script>
		<!-- STANDARD SPSS TABS --><LINK href="shared/tabs/spsstabs.css" type="text/css" rel="stylesheet">
		<script src="shared/tabs/tabctrl.js" type="text/javascript"></script>
		<style>.menuBgColor { BACKGROUND-COLOR: #31569c }
		</style>
		<script src="dlgNewProjectConfigure.js" type="text/javascript"></script>
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onkeydown="keyWasPressed()" scroll="no" tabIndex="-1" MS_POSITIONING="GridLayout">
		<form id="errorMessageForm" style="DISPLAY: none" name="errorMessageForm" method="post">
			<input id="ProjectNameTooLong" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProjectConfigure_err_tolong")%>">
			<input id="ProjectNameInvalid" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProjectConfigure_err_invalid")%>">
			<input id="ProjectNameReserved" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProjectConfigure_err_reserved")%>">
			<input id="GroupNameInvalidRequired" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProjectConfigure_err_groupname_invalid_required")%>">
			<input id="GroupNameInvalid" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProjectConfigure_err_groupname_invalid")%>">
			<input id="MustSelectValidGroupName" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("projectinfo_err_must_select_groupname")%>">
		</form>
		<form id="dlgNewProjectConfigure" method="post" encType="multipart/form-data" runat="server">
			<input id="doResizeWindow" type="hidden" value="1" name="doResizeWindow" runat="server">
			<input id="hReservedProjectNames" type="hidden" name="hReservedProjectNames" runat="server">
			<input id="hSelectedTab" type="hidden" value="0" name="hSelectedTab" runat="server">
			<input id="hProjectLabel" type="hidden" name="hProjectLabel" runat="server">
			<input id="hProjectType" type="hidden" name="hProjectType" runat="server">
			<input id="hAssignedRoles" type="hidden" name="hAssignedRoles" runat="server">
			<INPUT id="newGroupName" type="hidden" runat="server"> 
			<asp:button id="btnInitPage" style="DISPLAY: none" onclick="btnInitPage_Clicked" Runat="server"></asp:button>
			<asp:Button id="btnCheckProjectId" runat="server" style="DISPLAY: none" Text="" OnClick="btnCheckProjectId_Click"></asp:Button>
			<div id="InitDiv" runat="server"></div>
			<table id="ContentTable" height="100%" cellSpacing="0" cellPadding="0" width="100%" runat="server"
				style="DISPLAY: none">
				<tr class="menuBgColor" vAlign="bottom" height="50">
					<td>
						<div id="divTabsLocation">
							<TABLE style="PADDING-RIGHT: 0px; DISPLAY: inline; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px"
								cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TBODY>
									<TR>
										<TD style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px">
											<TABLE id="divTabsLocationdivTabsLocationSPSS" style="PADDING-RIGHT: 0px; DISPLAY: inline; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px"
												cellSpacing="0" cellPadding="0" border="0">
												<TBODY>
													<TR>
														<TD class="tabBorderLight" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px"
															width="1" height="32">&nbsp;</TD>
														<TD id="TabSeperator_0" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px"
															width="15" background="shared/tabs/images/tabfirst.off.gif" height="32" runat="server">
															<DIV style="WIDTH: 15px"></DIV>
														</TD>
														<TD class="tabArea" id="TabMain_0" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap"
															onclick="oTabCtrl.Click(0)" align="left" width="60" background="shared/tabs/images/tabmain.off.gif"
															height="32" runat="server">
															<div style="width:60px;">
																<a id="TabMain_0_anchor" href="javascript:void(0);" class="tabText" style="vertical-align:middle; white-space:nowrap; text-decoration:none;">
																	<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProjectConfigure_project_link"))%>
																</a>
															</div>
														</TD>
														<TD id="TabSeperator_1" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px"
															width="16" background="shared/tabs/images/tab.off.off.gif" height="32" runat="server">
															<DIV style="WIDTH: 16px"></DIV>
														</TD>
														<TD class="tabArea" id="TabMain_1" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; VERTICAL-ALIGN: middle; PADDING-TOP: 0px; WHITE-SPACE: nowrap"
															onclick="oTabCtrl.Click(1)" align="left" width="60" background="shared/tabs/images/tabmain.off.gif"
															height="32" runat="server">
															<div style="width:60px;">
																<a id="TabMain_1_anchor" href="javascript:void(0);" class="tabText" style="vertical-align:middle; white-space:nowrap; text-decoration:none;">
																	<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProjectConfigure_permissions_link"))%>
																</a>
															</div>
														</TD>
														<TD id="TabSeperator_2" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px"
															width="13" background="shared/tabs/images/tabend.off.gif" height="32" runat="server">
															<DIV style="WIDTH: 13px"></DIV>
														</TD>
													</TR>
												</TBODY>
											</TABLE>
										</TD>
										<TD class="tabBorderLight" width="100%">&nbsp;</TD>
									</TR>
								</TBODY>
							</TABLE>
						</div>
					</td>
				</tr>
				<tr>
					<td style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px">
						<table class="OuterTable" cellSpacing="1" cellPadding="1">
							<tr>
								<td>
									<!-- Start 1st Tab Content -->
									<TABLE id="ProjectTabTable" style="WIDTH: 510px; HEIGHT: 155px" cellSpacing="0" cellPadding="0"
										runat="server">
										<tr>
											<td style="WHITE-SPACE: nowrap" vAlign="top">
												<TABLE class="InnerTable" style="DISPLAY: inline; WIDTH: 510px" cellSpacing="2">
													<TR>
														<TD class="InnerTableMainDataDark" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; WIDTH: 120px; PADDING-TOP: 3px; HEIGHT: 20px"
															vAlign="middle">
															<DIV id="lblProjectId" style="DISPLAY: inline; WIDTH: 70px" noWrap runat="server" ms_positioning="FlowLayout">Project 
																ID:</DIV>
														</TD>
														<TD class="InnerTableMainDataDark" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px; WHITE-SPACE: nowrap; HEIGHT: 20px">
															<div>
																<INPUT class="InnerTableMainDataCtrl" id="tbProjectId" style="WIDTH: 344px; HEIGHT: 20px"
																	type="text" size="52" name="tbProjectId" runat="server"> <a id="ancCheckProjectId" runat="server" class="darklinks" href="javascript:checkProjectIdClicked()">
																	Check</a>
															</div>
														</TD>
													</TR>
													<TR>
														<TD class="InnerTableMainDataDark" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; WIDTH: 120px; PADDING-TOP: 3px; HEIGHT: 20px">
															<DIV id="lblProjectFolder" style="DISPLAY: inline; WIDTH: 70px" noWrap runat="server"
																ms_positioning="FlowLayout">Project Folder:</DIV>
														</TD>
														<TD class="InnerTableMainDataDark" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; PADDING-TOP: 3px; WHITE-SPACE: nowrap; HEIGHT: 20px">
															<asp:DropDownList id="projectGroupList" onchange="groupSelected();" runat="server" AutoPostBack="True"></asp:DropDownList>
														</TD>
													</TR>
												</TABLE>
											</td>
										</tr>
									</TABLE>
									<!-- End 1st Tab Content -->
									<!-- Start 2nd Tab Content -->
									<TABLE class="InnerTable" id="RolesTabTable" style="TABLE-LAYOUT: fixed; WIDTH: 510px; HEIGHT: 155px"
										cellSpacing="2" runat="server">
										<TR>
											<TD class="InnerTableMainDataDark" style="VERTICAL-ALIGN: top; WIDTH: 130px"><DIV id="lblRoles" style="DISPLAY: inline; WIDTH: 70px; HEIGHT: 15px" noWrap runat="server"
													ms_positioning="FlowLayout">Groups:</DIV>
											</TD>
											<TD class="InnerTableMainDataDark" style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px; PADDING-BOTTOM: 2px; VERTICAL-ALIGN: top; PADDING-TOP: 2px; WHITE-SPACE: nowrap">
												<DIV style="BORDER-RIGHT: 1px inset; BORDER-TOP: 1px inset; OVERFLOW: auto; BORDER-LEFT: 1px inset; WIDTH: 100%; BORDER-BOTTOM: 1px inset; HEIGHT: 146px; BACKGROUND-COLOR: white">
													<TABLE id="RolesList" style="WIDTH: 88%" runat="server">
														<tr>
															<td style="WIDTH: 10px"><IMG src="images/users.png">
															</td>
															<td style="WIDTH: 10px"><input type="checkbox">
															</td>
															<td>Developers
															</td>
														</tr>
													</TABLE>
												</DIV>
											</TD>
										</TR>
									</TABLE>
									<!-- End 2nd Tab Content -->
								</td>
							</tr>
						</table>
						<SPSS:OKCANCEL id="Okcancel" runat="server" NAME="Okcancel"></SPSS:OKCANCEL></td>
				</tr>
			</table>
		</form>
		<iframe style="DISPLAY: none; WIDTH: 0px; HEIGHT: 0px" src="shared/sessionkeepalive.aspx">
		</iframe>
	</body>
</HTML>
