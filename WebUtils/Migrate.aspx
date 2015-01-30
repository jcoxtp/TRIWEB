<%@ Page language="c#" Codebehind="Migrate.aspx.cs" AutoEventWireup="false" Inherits="TRIWebUtils.Migrate" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Migrate</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="frmMigrate" method="post" runat="server">
			<asp:TextBox id="txtConnection" style="Z-INDEX: 100; LEFT: 184px; POSITION: absolute; TOP: 40px"
				runat="server" Width="568px"></asp:TextBox>
			<asp:RadioButtonList id="rblExportType" style="Z-INDEX: 123; LEFT: 456px; POSITION: absolute; TOP: 168px"
				runat="server" Width="288px">
				<asp:ListItem Value="Variables" Selected="True">Export Single Language</asp:ListItem>
				<asp:ListItem Value="AddLanguage">Export English + Foreign Language</asp:ListItem>
			</asp:RadioButtonList>
			<asp:Label id="lblExecResult" style="Z-INDEX: 119; LEFT: 288px; POSITION: absolute; TOP: 248px"
				runat="server" Width="488px"></asp:Label>
			<asp:CompareValidator id="CompareValidator2" style="Z-INDEX: 114; LEFT: 344px; POSITION: absolute; TOP: 200px"
				runat="server" ErrorMessage="Invalid date" ControlToValidate="txtDateTo" Type="Date" Operator="DataTypeCheck"
				Display="Dynamic"></asp:CompareValidator>
			<asp:Label id="Label6" style="Z-INDEX: 112; LEFT: 184px; POSITION: absolute; TOP: 176px" runat="server">To:</asp:Label>
			<asp:TextBox id="txtDateTo" style="Z-INDEX: 109; LEFT: 184px; POSITION: absolute; TOP: 200px"
				runat="server"></asp:TextBox>
			<asp:Label id="Label5" style="Z-INDEX: 111; LEFT: 184px; POSITION: absolute; TOP: 128px" runat="server">From:</asp:Label>
			<asp:Label id="Label4" style="Z-INDEX: 110; LEFT: 96px; POSITION: absolute; TOP: 152px" runat="server">Date Range:</asp:Label>
			<asp:Label id="Label3" style="Z-INDEX: 107; LEFT: 136px; POSITION: absolute; TOP: 104px" runat="server">Page:</asp:Label>
			<asp:Label id="Label1" style="Z-INDEX: 101; LEFT: 64px; POSITION: absolute; TOP: 40px" runat="server">Connection String:</asp:Label>
			<asp:Button id="btnTestConnection" style="Z-INDEX: 102; LEFT: 752px; POSITION: absolute; TOP: 40px"
				runat="server" Text="Test" CausesValidation="False"></asp:Button>
			<asp:Label id="lblTestConnResult" style="Z-INDEX: 103; LEFT: 808px; POSITION: absolute; TOP: 40px"
				runat="server"></asp:Label>
			<asp:DropDownList id="ddlLanguage" style="Z-INDEX: 104; LEFT: 184px; POSITION: absolute; TOP: 72px"
				runat="server" Width="256px"></asp:DropDownList>
			<asp:Label id="Label2" style="Z-INDEX: 105; LEFT: 112px; POSITION: absolute; TOP: 72px" runat="server">Language:</asp:Label>
			<asp:DropDownList id="ddlPage" style="Z-INDEX: 106; LEFT: 184px; POSITION: absolute; TOP: 104px" runat="server"
				Width="256px"></asp:DropDownList>
			<asp:TextBox id="txtDateFrom" style="Z-INDEX: 108; LEFT: 184px; POSITION: absolute; TOP: 152px"
				runat="server"></asp:TextBox>
			<asp:CompareValidator id="CompareValidator1" style="Z-INDEX: 113; LEFT: 344px; POSITION: absolute; TOP: 152px"
				runat="server" ErrorMessage="Invalid date" ControlToValidate="txtDateFrom" Type="Date" Operator="DataTypeCheck"
				Display="Dynamic"></asp:CompareValidator>
			<asp:RadioButtonList id="rblImportExport" style="Z-INDEX: 115; LEFT: 456px; POSITION: absolute; TOP: 72px"
				runat="server" AutoPostBack="True">
				<asp:ListItem Value="Export" Selected="True">Export</asp:ListItem>
				<asp:ListItem Value="Import">Import</asp:ListItem>
			</asp:RadioButtonList>
			<asp:ListBox id="lstFiles" style="Z-INDEX: 116; LEFT: 536px; POSITION: absolute; TOP: 72px" runat="server"
				Width="256px" Visible="False"></asp:ListBox>
			<asp:Button id="btnExecute" style="Z-INDEX: 117; LEFT: 184px; POSITION: absolute; TOP: 248px"
				runat="server" Text="Execute"></asp:Button>
			<asp:DataGrid id="dtgLogs" style="Z-INDEX: 118; LEFT: 184px; POSITION: absolute; TOP: 304px" runat="server"
				BorderColor="#999999" BorderStyle="None" BorderWidth="1px" BackColor="White" CellPadding="3"
				GridLines="Vertical">
				<FooterStyle ForeColor="Black" BackColor="#CCCCCC"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#008A8C"></SelectedItemStyle>
				<AlternatingItemStyle BackColor="#DCDCDC"></AlternatingItemStyle>
				<ItemStyle ForeColor="Black" BackColor="#EEEEEE"></ItemStyle>
				<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#000084"></HeaderStyle>
				<PagerStyle HorizontalAlign="Center" ForeColor="Black" BackColor="#999999" Mode="NumericPages"></PagerStyle>
			</asp:DataGrid>
			<asp:RadioButtonList id="rblImportType" style="Z-INDEX: 121; LEFT: 456px; POSITION: absolute; TOP: 152px"
				runat="server" Width="288px" Visible="False">
				<asp:ListItem Value="Variables" Selected="True">Import Language Variable and English Text</asp:ListItem>
				<asp:ListItem Value="AddLanguage">Import an Additional Language</asp:ListItem>
				<asp:ListItem Value="English + Foreign Language">English + Foreign Language</asp:ListItem>
			</asp:RadioButtonList>
			<asp:LinkButton id="lnkViewData" style="Z-INDEX: 122; LEFT: 808px; POSITION: absolute; TOP: 80px"
				runat="server" Visible="False">View Data</asp:LinkButton>
		</form>
	</body>
</HTML>
