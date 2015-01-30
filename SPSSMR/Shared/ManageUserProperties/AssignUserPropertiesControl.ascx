<%@ Control Language="c#" AutoEventWireup="false" Codebehind="AssignUserPropertiesControl.ascx.cs" Inherits="ManageUserProperties.AssignUserPropertiesControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<table cellSpacing="0" width="100%">
    <tr>
        <td vAlign="top" width="100%" colSpan="2"><asp:datagrid id="AssignPropertiesTbl" GridLines="None" ShowFooter="False" ShowHeader="True"
                AutoGenerateColumns="False" Runat="server" BorderStyle="None">
                <AlternatingItemStyle ForeColor="#00066" BackColor="#EFF7FF"></AlternatingItemStyle>
                <ItemStyle ForeColor="#00066" BackColor="White"></ItemStyle>
                <HeaderStyle Font-Bold="True" CssClass="RoundedTableLightHeader"></HeaderStyle>
                <Columns>
                    <asp:TemplateColumn ItemStyle-HorizontalAlign="Center">
                        <HeaderStyle Width="15%" />
                        <ItemTemplate>
                            <asp:CheckBox Runat="server" AutoPostBack="True" ID="ApplyChkBtn" OnCheckedChanged="AssignPropertiesTbl_ApplyCheckChanged" checked='<%# DataBinder.Eval(Container.DataItem, "Apply") %>'/>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="20%" />
                        <ItemTemplate>
                            <asp:Label Runat="server" ID="PropertyName" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:BoundColumn DataField="Description" ReadOnly="True" ItemStyle-Width="35%" />
                    <asp:TemplateColumn>
                        <HeaderStyle Width="30%" />
                        <ItemTemplate>
                            <asp:ListBox Runat="server" ID="lbOptions" AutoPostBack="True" Visible="False" SelectionMode="Multiple" />
                            <asp:DropDownList Runat="server" ID="ddlOptions" AutoPostBack="True" Visible="False" />
                            <asp:RadioButtonList Runat="server" ID="rblOptions" AutoPostBack="True" Visible="False" RepeatDirection="Vertical" />
                            <asp:CheckBox Runat="server" ID="cbOptions" AutoPostBack="True" Visible="False" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:datagrid></td>
    </tr>
</table>
