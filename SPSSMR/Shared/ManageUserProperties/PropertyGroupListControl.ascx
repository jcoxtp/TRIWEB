<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PropertyGroupListControl.ascx.cs" Inherits="ManageUserProperties.PropertyGroupListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE cellSpacing="0" width="100%" align="left" border="0">
    <tr>
        <td vAlign="top" width="100%" colSpan="2" bordercolor="White">
            <asp:datagrid id="PropertyGroupsGrid" Width="100%" Enabled="True" ShowFooter="true" AutoGenerateColumns="False" AllowSorting="true"
                BorderStyle="None" BackColor="White" CellPadding="5" GridLines="None" runat="server"
                BorderColor="White">
                <FooterStyle ForeColor="Black" VerticalAlign="Top" BackColor="White"></FooterStyle>
                <SelectedItemStyle Font-Bold="True" ForeColor="#000066" BackColor="#BBBBBB"></SelectedItemStyle>
                <AlternatingItemStyle ForeColor="#000066" BackColor="#EFF7FF"></AlternatingItemStyle>
                <ItemStyle ForeColor="#000066" BackColor="White"></ItemStyle>
                <HeaderStyle Font-Bold="True" CssClass="RoundedTableLightHeader"></HeaderStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="25%"></HeaderStyle>
                        <ItemTemplate>
                            <asp:LinkButton CommandName="Select" style="text-decoration:none" ForeColor="Black" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' Runat="server"/>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:LinkButton Runat="server" ID="AddLnkBtn" CommandName="Add" OnClick="PropertyGroupsGrid_Add"
                                style="text-decoration:none" ForeColor="Black" BorderStyle="Dashed" BorderWidth="1" />
                        </FooterTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="40%"></HeaderStyle>
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "Description") %>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="35%"></HeaderStyle>
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "Properties") %>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
                <PagerStyle HorizontalAlign="Center" ForeColor="Black" BackColor="#999999" Mode="NumericPages"></PagerStyle>
            </asp:datagrid></td>
    </tr>
</TABLE>
