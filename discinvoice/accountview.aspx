<%@ Page Language="C#" MasterPageFile="~/InvoiceMaster.master" AutoEventWireup="true" CodeFile="accountview.aspx.cs" Inherits="accountview" Title="Corporate ePDI Open Account Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
    <asp:LinkButton ID="returnLink" runat="server" onclick="returnLink_Click">Return to Open Account List</asp:LinkButton>
    <br />
    <br />
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="accountID" 
        DataSourceID="sqldsAccountView">
        <EditItemTemplate>
            AccountName:
            <asp:TextBox ID="AccountNameTextBox" runat="server" 
                Text='<%# Bind("AccountName") %>' />
            <br />
            <br />
            SiteUrl:
            <asp:TextBox ID="SiteUrlTextBox" runat="server" Text='<%# Bind("SiteUrl") %>' />
            <br />
            <br />
            Active:
            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                Checked='<%# Bind("Active") %>' />
            <br />
            <asp:Label ID="accountIDLabel1" runat="server" Text='<%# Eval("accountID") %>' 
                Visible="False" />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            AccountName:
            <asp:TextBox ID="AccountNameTextBox" runat="server" 
                Text='<%# Bind("AccountName") %>' />
            <br />
            Manager:
            <asp:TextBox ID="ManagerTextBox" runat="server" Text='<%# Bind("Manager") %>' />
            <br />
            SetupDate:
            <asp:TextBox ID="SetupDateTextBox" runat="server" 
                Text='<%# Bind("SetupDate") %>' />
            <br />
            SiteUrl:
            <asp:TextBox ID="SiteUrlTextBox" runat="server" Text='<%# Bind("SiteUrl") %>' />
            <br />
            PurchaseType:
            <asp:TextBox ID="PurchaseTypeTextBox" runat="server" 
                Text='<%# Bind("PurchaseType") %>' />
            <br />
            Active:
            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                Checked='<%# Bind("Active") %>' />
            <br />
            accountID:
            <asp:TextBox ID="accountIDTextBox" runat="server" 
                Text='<%# Bind("accountID") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            AccountName:
            <asp:Label ID="AccountNameLabel" runat="server" CssClass="form-data" 
                Text='<%# Bind("AccountName") %>' />
            <br />
            Manager:
            <asp:Label ID="ManagerLabel" runat="server" CssClass="form-data" 
                Text='<%# Bind("Manager") %>' />
            <br />
            SetupDate:
            <asp:Label ID="SetupDateLabel" runat="server" CssClass="form-data" 
                Text='<%# Bind("SetupDate") %>' />
            <br />
            SiteUrl:
            <asp:Label ID="SiteUrlLabel" runat="server" CssClass="form-data" 
                Text='<%# Bind("SiteUrl") %>' />
            <br />
            PurchaseType:
            <asp:Label ID="PurchaseTypeLabel" runat="server" CssClass="form-data" 
                Text='<%# Bind("PurchaseType") %>' />
            <br />
            Active:
            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                Checked='<%# Bind("Active") %>' Enabled="false" />
            <br />
            <asp:Label ID="accountIDLabel" runat="server" Text='<%# Eval("accountID") %>' 
                Visible="False" />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                CommandName="Edit" Text="Edit" />
        </ItemTemplate>
    </asp:FormView>
<hr />
    <asp:Button ID="export1btn" runat="server" Text="Export This Grid to Excel" 
        onclick="ExportToExcel_Click" />&nbsp;&nbsp;&nbsp;
    <asp:Button ToolTip="This action cannot be undone. Mark only when invoice is prepared."
        ID="InvoiceThis" runat="server"
        Text="Mark These Assessments 'Invoiced'" onclick="InvoiceThis_Click"
        OnClientClick="return confirm('This action cannot be undone. Are you sure you want to mark these PDI codes complete?');" 
        ForeColor="#FF3300" /><br />
        <br />
    <asp:Label ID="DetailCountLabel" runat="server" Text="" CssClass="form-data"></asp:Label><br />
    <br />
    <asp:GridView ID="gvwPurchaseDetails" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" DataSourceID="sqldsPurchaseDetails" AllowPaging="False">
        <Columns>
            <asp:BoundField DataField="AccountName" HeaderText="Account" 
                SortExpression="AccountName" />
            <asp:BoundField DataField="Manager" HeaderText="Manager" ReadOnly="True" 
                SortExpression="Manager" />
            <asp:BoundField DataField="TestCompleteDate" HeaderText="Completed On" 
                SortExpression="TestCompleteDate" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" 
                SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" 
                SortExpression="LastName" />
            <asp:BoundField DataField="EmailAddress" HeaderText="Email" 
                SortExpression="EmailAddress" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:Button ID="export2btn" runat="server" Text="Export This Grid to Excel" 
        onclick="ExportToExcel_Click" />
    <br />
    <asp:SqlDataSource ID="sqldsAccountView" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ePDIConnectionString %>" SelectCommand="SELECT ca.AccountName, mgr.FirstName + ' ' + mgr.LastName [Manager], CreateDate [SetupDate],
	WebContentLocation [SiteUrl], PurchaseType, Active, ca.CorporateAccountID [accountID]
FROM CorporateAccounts ca
   INNER JOIN vw_User mgr ON ca.AccountManagerID = mgr.UserID
WHERE ca.CorporateAccountID = @accountID" 
        UpdateCommand="UPDATE CorporateAccounts SET AccountName = @accountName, WebContentLocation = @siteURL, Active = @active WHERE (CorporateAccountID = @accountID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="DA6AB785-A800-4BDA-8AD8-92CA3B380997" 
                Name="accountID" QueryStringField="id" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="accountName" />
            <asp:Parameter Name="siteURL" />
            <asp:Parameter Name="active" />
            <asp:Parameter Name="accountID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqldsPurchaseDetails" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ePDIConnectionString %>" SelectCommand="
SELECT ca.AccountName, mgr.FirstName + ' ' + mgr.LastName [Manager],
	tr.TestCompleteDate, i.FirstName, i.LastName, i.EmailAddress
FROM vw_User u
   INNER JOIN Userinfo i ON u.userinfoid = i.userinfoid
   INNER JOIN Purchase_TestCode ptc ON u.userid = ptc.testtakerid
   INNER JOIN TestCode tc ON ptc.testcodeid = tc.testcodeid
   INNER JOIN TestResults tr ON tc.testcodeid = tr.testcodeid and tr.testcompleted = 1
   INNER JOIN TrTest t ON tc.TrTestID = t.TrTestID
   INNER JOIN CorporatePurchases cp ON ptc.purchaseID = cp.purchaseID
   INNER JOIN CorporateAccounts ca ON cp.CorporateAccountID = ca.CorporateAccountID
   INNER JOIN vw_User mgr ON ca.AccountManagerID = mgr.UserID
WHERE ptc.Invoiced = 0 AND ca.CorporateAccountID = @accountID
ORDER BY i.LastName, i.FirstName">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="DA6AB785-A800-4BDA-8AD8-92CA3B380997" 
                Name="accountID" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

