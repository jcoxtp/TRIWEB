<%@ Page language="c#" Codebehind="dlgNewProject.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.dlgNewProject" %>
<%@ OutputCache Location="none" %>
<%@ Register tagprefix="SPSS" Tagname="OkCancel" src="ctrlOkCancel.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProject_title"))%>
		</title>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script type="text/javascript" src="general.js"></script>
		<script type="text/javascript" src="Shared/Dialog/dialog.js"></script>
		<script type="text/javascript" src="dlgNewProject.js"></script>
		<link type="text/css" rel="stylesheet" href="Shared/spssmrNet.css">
	</HEAD>
	<body tabIndex="-1" MS_POSITIONING="GridLayout" onkeydown="keyWasPressed()">
		<form id="errorMessageForm" style="DISPLAY: none" name="errorMessageForm" method="post">
			<input id="ProjectNameTooLong" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProject_err_tolong")%>">
			<input id="ProjectNameInvalid" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProject_err_invalid")%>">
			<input id="ProjectNameReserved" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProject_err_reserved")%>">
			<input id="LabelInvalid" type="hidden" value="<%=ProjectEditor.Utilities.I18N.GetResourceString("dlgNewProject_err_label_invalid")%>">
		</form>
		<table>
			<tr>
				<td>
					<table class="OuterTable">
						<tr>
							<td>
								<form id="dlgNewProject" method="post" runat="server">
									<input id="doResizeWindow" type="hidden" value="1" name="doResizeWindow" runat="server">
									<asp:Button id="btnCreateProject" runat="server" style="DISPLAY: none" Text="" OnClick="btnCreateProject_Click"></asp:Button>
									<input id="hProjectID" type="hidden" name="hProjectID" runat="server">
									<input id="hProjectFolder" type="hidden" name="hProjectFolder" runat="server">
									<input id="hAssignedRoles" type="hidden" name="hAssignedRoles" runat="server">
									<table class="InnerTable" cellSpacing="2">
										<tr>
											<td class="InnerTableMainDataDark" style="WIDTH: 1%">
												<DIV id="lblApplication" style="DISPLAY: inline; WIDTH: 70px; HEIGHT: 15px" noWrap runat="server" ms_positioning="FlowLayout">Application:</DIV>
											</td>
											<td class="InnerTableMainDataDark">
												<select class="InnerTableMainDataCtrl" id="cbApplication" style="WIDTH: 344px" name="cbApplication" runat="server">
													<option value="[spss:standard]" selected>(Standard)</option>
												</select>
											</td>
										</tr>
										<tr>
											<td class="InnerTableMainDataDark" style="WIDTH: 1%">
												<DIV id="lblLabel" style="DISPLAY: inline; WIDTH: 70px; HEIGHT: 15px" noWrap runat="server" ms_positioning="FlowLayout">Name:</DIV>
											</td>
											<td class="InnerTableMainDataDark" style="WHITE-SPACE: nowrap">
												<INPUT class="InnerTableMainDataCtrl" id="tbLabel" style="WIDTH: 344px; HEIGHT: 20px" type="text" size="52" name="tbLabel" runat="server" onserverchange="tbLabelOnChange">
											</td>
										</tr>
										<tr>
											<td class="InnerTableMainDataDark" style="WIDTH: 1%">
												<DIV id="lblDescription" style="DISPLAY: inline; WIDTH: 70px; HEIGHT: 15px" noWrap runat="server" ms_positioning="FlowLayout">Description:</DIV>
											</td>
											<td class="InnerTableMainDataDark">
												<TEXTAREA class="InnerTableMainDataCtrl" id="tbDescription" style="WIDTH: 344px; HEIGHT: 38px" rows="2" cols="40" runat="server" onfocus="this.select()"></TEXTAREA>
											</td>
										</tr>
									</table>
								</form>
							</td>
						</tr>
					</table>
					<table style="WIDTH: 100%" border="0">
						<tr>
							<td>
								&nbsp;<input id="btnAdvanced" onclick="btnAdvanced_ClickedClient()" type="button" value="Advanced..." runat="server" NAME="btnAdvanced">
							</td>
							<td style="TEXT-ALIGN: right">
								<div style="OVERFLOW: visible; WHITE-SPACE: nowrap">
									<input id="btnOK" onclick="javascript:btnOK_ClickedClient()" type="button" class="stdbutton" value=" OK " runat="server" NAME="btnOK">
									&nbsp;<input id="btnCancel" onclick="javascript:btnCancel_ClickedClient()" type="button" class="stdbutton" value="Cancel" runat="server" NAME="btnCancel">
									&nbsp;
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div id="EventFormDiv" runat="server" style="DISPLAY: none"></div>
		<IFRAME id="KeepAliveFrame" runat="server" style="DISPLAY: none; WIDTH: 0px; HEIGHT: 0px" src="shared/sessionkeepalive.aspx">
		</IFRAME>
	</body>
</HTML>
