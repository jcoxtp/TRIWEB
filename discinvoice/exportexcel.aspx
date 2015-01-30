<%@ Page Language="C#" AutoEventWireup="true" CodeFile="exportexcel.aspx.cs" Inherits="exportexcel" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
     <asp:GridView ID="gvwPurchaseDetails" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" DataSourceID="sqldsPurchaseDetails">
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
    </div>
    </form>
</body>
</html>
