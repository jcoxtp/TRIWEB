<%@ Page language="c#" Codebehind="WebForm1.aspx.cs" AutoEventWireup="false" Inherits="apptestcenter.WebForm1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Rep Pattern Selections</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="1">
				<TR>
					<TD></TD>
					<TD><asp:dropdownlist id="ddlQueries" runat="server" Width="206px"></asp:dropdownlist></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD><asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False">
							<Columns>
								<asp:TemplateColumn HeaderText="Representative&amp;nbsp;Pattern">
									<ItemStyle VerticalAlign="Top"></ItemStyle>
									<ItemTemplate>
										<img width="90px" height="219px" src='ViewImageFromDb.aspx?img=<%# DataBinder.Eval(Container.DataItem, "img_ID") %>' />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="PatternHighFactor" HeaderText="Pattern High Factor">
									<ItemStyle VerticalAlign="Top"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="ReferenceName" HeaderText="Pattern Selected">
									<ItemStyle VerticalAlign="Top"></ItemStyle>
								</asp:BoundColumn>
								<asp:TemplateColumn HeaderText="Suggested Patterns">
									<ItemStyle VerticalAlign="Top"></ItemStyle>
									<ItemTemplate>
										<%# GetPatternSuggestions( (string)DataBinder.Eval(Container.DataItem, "TestCode") ) %>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="User Chart">
									<ItemStyle VerticalAlign="Top"></ItemStyle>
									<ItemTemplate>
										<img width="90px" height="218px" src='http://www.pdiprofile.com/pdi/DiscCompositeSmall.asp?nD1=<%# DataBinder.Eval(Container.DataItem, "C_NumberD") %>&amp;nD2=<%# DataBinder.Eval(Container.DataItem, "C_NumberI") %>&amp;nD3=<%# DataBinder.Eval(Container.DataItem, "C_NumberS") %>&amp;nD4=<%# DataBinder.Eval(Container.DataItem, "C_NumberC") %>&amp;res=1' />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="UserHighFactor" HeaderText="User High Factor">
									<ItemStyle VerticalAlign="Top"></ItemStyle>
								</asp:BoundColumn>
							</Columns>
						</asp:datagrid></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD><asp:button id="Button1" runat="server" Text="Query"></asp:button></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
