<%@ Page Language="C#" MasterPageFile="~/InvoiceMaster.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="login">
    <asp:LoginView ID="MasterLoginView" runat="server">
        <LoggedInTemplate>
        </LoggedInTemplate>
        <AnonymousTemplate>
            Welcome: 
            <asp:LoginName ID="MasterLoginName" runat="server" />
        </AnonymousTemplate>
    </asp:LoginView>
    &nbsp;&nbsp;&nbsp;<asp:LoginStatus ID="MasterLoginStatus" runat="server" />
</div>
</asp:Content>

