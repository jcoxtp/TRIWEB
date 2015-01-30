<%@ Control ClassName="ProjectInfoControl" Language="c#" AutoEventWireup="false" Codebehind="ProjectInfoControl.ascx.cs" Inherits="SPSS.Dimensions.Web.UI.CommonControls.ProjectInfoControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table id="tblTable" class="RoundedTable" cellPadding="0" width="100%" runat="server">
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
    <tr class="MinMax">
        <td class="RoundedTableOuterBorder" width="1">
        </td>
        <td class="RoundedTableLightInfo" width="9">
        </td>
        <td class="RoundedTableLightInfo" width="25%">
            <asp:Label ID="lblProjectIdLabel" runat="server" CssClass="RoundedTableLabel">&lt;ProjectIdLabel&gt;</asp:Label></td>
        <td class="RoundedTableLightInfo" width="75%">
            <asp:Label ID="lblProjectIdValue" runat="server" CssClass="RoundedTableText">&lt;ProjectIdValue&gt;</asp:Label></td>
        <td class="RoundedTableLightInfo" width="9">
        </td>
        <td class="RoundedTableOuterBorder" width="1">
        </td>
    </tr>
    <tr class="MinMax">
        <td class="RoundedTableOuterBorder" width="1">
        </td>
        <td class="RoundedTableLightInfo" width="9">
        </td>
        <td class="RoundedTableLightInfo" width="25%">
            <asp:Label ID="lblProjectNameLabel" runat="server" CssClass="RoundedTableLabel">&lt;ProjectIdLabel&gt;</asp:Label></td>
        <td class="RoundedTableLightInfo" width="75%">
            <asp:Label ID="lblProjectNameValue" runat="server" CssClass="RoundedTableText">&lt;ProjectIdValue&gt;</asp:Label></td>
        <td class="RoundedTableLightInfo" width="9">
        </td>
        <td class="RoundedTableOuterBorder" width="1">
        </td>
    </tr>
    <tr class="MinMax">
        <td class="RoundedTableOuterBorder" width="1">
        </td>
        <td class="RoundedTableLightInfo" width="9">
        </td>
        <td class="RoundedTableLightInfo" width="25%">
            <asp:Label ID="lblProjectDescriptionLabel" runat="server" CssClass="RoundedTableLabel">&lt;ProjectIdLabel&gt;</asp:Label></td>
        <td class="RoundedTableLightInfo" width="75%">
            <asp:Label ID="lblProjectDescriptionValue" runat="server" CssClass="RoundedTableText">&lt;ProjectIdValue&gt;</asp:Label></td>
        <td class="RoundedTableLightInfo" width="9">
        </td>
        <td class="RoundedTableOuterBorder" width="1">
        </td>
    </tr>
    <tr class="MinMax">
        <td class="RoundedTableOuterBorder" width="1">
        </td>
        <td class="RoundedTableDarkInfo" width="9">
        </td>
        <td class="RoundedTableDarkInfo" width="100%" colspan="2">
            <br>
            <asp:Label ID="lblAdviceValue" runat="server" CssClass="RoundedTableText">&lt;Advice&gt;</asp:Label></td>
        <td class="RoundedTableDarkInfo" width="9">
        </td>
        <td class="RoundedTableOuterBorder" width="1">
        </td>
    </tr>
    <tr>
		<td colspan="2" rowspan="2" class="RoundedTableDarkInfo"><img src="shared/images/RoundedTableControl/light_bottomleft.gif" height="10" width="10"></td>
		<td height="9" class="RoundedTableDarkInfo" colspan="2"></td>
		<td colspan="2" rowspan="2" class="RoundedTableDarkInfo"><img src="shared/images/RoundedTableControl/light_bottomright.gif" height="10" width="10"></td>
	</tr>
	<tr>
		<td height="1" colspan="2" class="RoundedTableOuterBorder"></td>
	</tr>
</table>