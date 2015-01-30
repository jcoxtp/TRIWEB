<%@ Page language="c#" Codebehind="dlgSelectProjectGroup.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.dlgSelectProjectGroup" %>
<%@ OutputCache Location="none" %>
<%@ Register tagprefix="SPSS" Tagname="OkCancel" src="ctrlOkCancel.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgSelectProjectGroup_title"))%>
		</title>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<!-- STANDARD FUNCTIONS FOR THIS APP -->
		<script type="text/javascript" src="general.js"></script>
		<!-- DIALOG LIB -->
		<script type="text/javascript" src="../Shared/Dialog/dialog.js"></script>
		<!-- JAVASCRIPT FUNCTIONS USED ONLY FROM THIS PAGE -->
		<script type="text/javascript" src="dlgSelectProjectGroup.js"></script>
		<link type="text/css" rel="stylesheet" href="../shared/spssmrNet.css">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="dlgSelectProjectGroup" method="post" runat="server">
			<table>
				<tr>
					<td>
						<table class="OuterTable" style="WIDTH : 400px">
							<tr>
								<td>
									<table class="InnerTable" cellspacing="2">
										<tr>
											<td class="InnerTableMainDataDark">
												<asp:label id="projectGroupLabel" runat="server">Group Name:</asp:label>
											</td>
											<td class="InnerTableMainDataDark">&nbsp;
												<asp:DropDownList id="projectGroupList" runat="server"></asp:DropDownList>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<SPSS:OkCancel runat="server" ID="Okcancel1" NAME="Okcancel1" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
