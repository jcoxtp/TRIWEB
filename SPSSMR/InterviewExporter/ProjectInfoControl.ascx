<%@ Control ClassName="ProjectInfoControl" Language="c#" AutoEventWireup="false" Codebehind="ProjectInfoControl.ascx.cs" Inherits="SPSS.Dimensions.Web.UI.CommonControls.ProjectInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table class="RoundedTable" cellPadding="0" width="100%">
	<tr>
		<td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topleft.gif" width="10"></td>
		<td class="RoundedTableOuterBorder" colSpan="2" height="1"></td>
		<td colspan="2" rowspan="2"><img src="shared/images/RoundedTableControl/dark_topright.gif" height="30" width="10" alt=""></td>
	</tr>
	<tr>
		<td width="100%" colspan="2" class="RoundedTableDarkHeader">
			<table width="100%">
				<tr width="100%">
					<td><asp:Label class="ProjectInfoControlDarkHeader" id="lblHeader" runat="server">&lt;TitleText&gt;</asp:Label></td>
					<td align="right">
						<asp:LinkButton id="lbtnMinMax" runat="server" OnClick="lbtnMinMax_OnClick">
							<asp:Image id="imgMinMax" height="20" width="20" runat="server" ImageUrl="~/shared/images/roundedtablecontrol/collapse.gif"></asp:Image>
						</asp:LinkButton>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<asp:Panel ID="panelMinMax" Runat="server">
		<TR>
			<TD class="RoundedTableOuterBorder" width="1"></TD>
			<TD class="RoundedTableLightInfo" width="9"></TD>
			<TD class="RoundedTableLightInfo" width="25%">
				<asp:Label id="lblProjectIdLabel" runat="server" cssclass="RoundedTableLabel">&lt;ProjectIdLabel&gt;</asp:Label></TD>
			<TD class="RoundedTableLightInfo" width="75%">
				<asp:Label id="lblProjectIdValue" runat="server" cssclass="RoundedTableText">&lt;ProjectIdValue&gt;</asp:Label></TD>
			<TD class="RoundedTableLightInfo" width="9"></TD>
			<TD class="RoundedTableOuterBorder" width="1"></TD>
		</TR>
		<TR>
			<TD class="RoundedTableOuterBorder" width="1"></TD>
			<TD class="RoundedTableLightInfo" width="9"></TD>
			<TD class="RoundedTableLightInfo" width="25%">
				<asp:Label id="lblProjectNameLabel" runat="server" cssclass="RoundedTableLabel">&lt;ProjectIdLabel&gt;</asp:Label></TD>
			<TD class="RoundedTableLightInfo" width="75%">
				<asp:Label id="lblProjectNameValue" runat="server" cssclass="RoundedTableText">&lt;ProjectIdValue&gt;</asp:Label></TD>
			<TD class="RoundedTableLightInfo" width="9"></TD>
			<TD class="RoundedTableOuterBorder" width="1"></TD>
		</TR>
		<TR>
			<TD class="RoundedTableOuterBorder" width="1"></TD>
			<TD class="RoundedTableLightInfo" width="9"></TD>
			<TD class="RoundedTableLightInfo" width="25%">
				<asp:Label id="lblProjectDescriptionLabel" runat="server" cssclass="RoundedTableLabel">&lt;ProjectIdLabel&gt;</asp:Label></TD>
			<TD class="RoundedTableLightInfo" width="75%">
				<asp:Label id="lblProjectDescriptionValue" runat="server" cssclass="RoundedTableText">&lt;ProjectIdValue&gt;</asp:Label></TD>
			<TD class="RoundedTableLightInfo" width="9"></TD>
			<TD class="RoundedTableOuterBorder" width="1"></TD>
		</TR>
		<TR>
			<TD class="RoundedTableOuterBorder" width="1"></TD>
			<TD class="RoundedTableDarkInfo" width="9"></TD>
			<TD class="RoundedTableDarkInfo" width="100%" colSpan="2"><BR>
				<asp:Label id="lblAdviceValue" runat="server" cssclass="RoundedTableText">&lt;Advice&gt;</asp:Label></TD>
			<TD class="RoundedTableDarkInfo" width="9"></TD>
			<TD class="RoundedTableOuterBorder" width="1"></TD>
		</TR>
	</asp:Panel>
	<tr>
		<td colspan="2" rowspan="2" class="RoundedTableDarkInfo"><img src="shared/images/RoundedTableControl/light_bottomleft.gif" height="10" width="10"></td>
		<td height="9" class="RoundedTableDarkInfo" colspan="2"></td>
		<td colspan="2" rowspan="2" class="RoundedTableDarkInfo"><img src="shared/images/RoundedTableControl/light_bottomright.gif" height="10" width="10"></td>
	</tr>
	<tr>
		<td height="1" colspan="2" class="RoundedTableOuterBorder"></td>
	</tr>
</table>
