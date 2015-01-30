<%@ Page Language="C#" MasterPageFile="~/InvoiceMaster.master" AutoEventWireup="true" CodeFile="accountlist.aspx.cs" Inherits="accountlist" Title="Open Account List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
	<h3><a href="http://192.0.0.86:8082/Home">Corporate Admin Tools</a></h3>
</div>
    <asp:GridView ID="gvwAccountList" runat="server" AllowSorting="True" 
    AutoGenerateColumns="False" DataSourceID="sqldsAccountList">
    <Columns>
        <asp:HyperLinkField DataNavigateUrlFields="AccountID" 
            DataNavigateUrlFormatString="accountview.aspx?id={0}" 
            DataTextField="AccountName" HeaderText="Account" 
            NavigateUrl="~/accountview.aspx" SortExpression="AccountName" />
        <asp:BoundField DataField="Manager" HeaderText="Manager" ReadOnly="True" 
            SortExpression="Manager" />
        <asp:BoundField DataField="SetupDate" HeaderText="SetupDate" 
            SortExpression="SetupDate" DataFormatString="{0:M/dd/yyyy}" />
        <asp:BoundField DataField="MostRecent" HeaderText="Most Recent Redemption" 
            SortExpression="MostRecent" DataFormatString="{0:M/dd/yyyy}" />
    </Columns>
</asp:GridView>
    <asp:SqlDataSource ID="sqldsAccountList" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ePDIConnectionString %>" SelectCommand="
SELECT ca.AccountName, mgr.FirstName + ' ' + mgr.LastName [Manager], CreateDate [SetupDate], MAX(ptc.RedeemDate) [MostRecent], ca.CorporateAccountID [AccountID]
FROM vw_User u
   INNER JOIN Userinfo i ON u.userinfoid = i.userinfoid
   INNER JOIN Purchase_TestCode ptc ON u.userid = ptc.testtakerid
   INNER JOIN TestCode tc ON ptc.testcodeid = tc.testcodeid
   INNER JOIN TestResults tr ON tc.testcodeid = tr.testcodeid and tr.testcompleted = 1
   INNER JOIN TrTest t ON tc.TrTestID = t.TrTestID
   INNER JOIN CorporatePurchases cp ON ptc.purchaseID = cp.purchaseID
   INNER JOIN CorporateAccounts ca ON cp.CorporateAccountID = ca.CorporateAccountID
   INNER JOIN vw_User mgr ON ca.AccountManagerID = mgr.UserID
WHERE ptc.Invoiced = 0
GROUP BY ca.AccountName, mgr.FirstName + ' ' + mgr.LastName, CreateDate, ca.CorporateAccountID
ORDER BY 4 DESC"></asp:SqlDataSource>
</asp:Content>

