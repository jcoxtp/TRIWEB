<%@ Page language="c#" Codebehind="BradDeleteConfirm.aspx.cs" Inherits="Brad.Delete.BradDeleteConfirm" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>
            <%=SetDocumentTitle()%>
        </title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="C#" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <!-- SPSS applications stylesheet --><LINK href="../Shared/spssmrNet.css" type="text/css" rel="stylesheet">
        <script>
            function CloseWindow()
            {
                window.close();
            }

            function SetDisabled(ctrl, b)
            {
                try
                {
                    document.Form1.item(ctrl).disabled = b;
                }
                catch (e)
                {
                }
            }

            function EnableOptions()
            {
                //document.Form1.item("chkDeleteQuota").disabled = false;
                SetDisabled("chkDeleteQuota", false);
                // document.Form1.item("chkDeleteSample").disabled = false;
                SetDisabled("chkDeleteSample", false);
            }

            function DisableOptions()
            {
                // document.Form1.item("chkDeleteQuota").disabled = true;
                 SetDisabled("chkDeleteQuota", true);
                // document.Form1.item("chkDeleteSample").disabled = true;
                 SetDisabled("chkDeleteSample", true);
            }

        </script>
    </HEAD>
    <body onload="DisableOptions()" MS_POSITIONING="GridLayout">
        <form id="Form1" method="post" runat="server">
            <asp:label id="lblMessage" style="Z-INDEX: 101; LEFT: 32px; POSITION: absolute; TOP: 32px"
                runat="server">lblMessage</asp:label><asp:button id="btnContinue" style="Z-INDEX: 103; LEFT: 24px; POSITION: absolute; TOP: 264px"
                tabIndex="1" runat="server" Text="btnContinue" Width="120px"></asp:button><asp:button id="btnCancel" style="Z-INDEX: 102; LEFT: 360px; POSITION: absolute; TOP: 264px"
                tabIndex="2" runat="server" Text="btnCancel" Width="80"></asp:button><asp:radiobutton id="radioDeleteDPMOnly" style="Z-INDEX: 104; LEFT: 24px; POSITION: absolute; TOP: 72px"
                runat="server" Checked="True" GroupName="DeleteOption"></asp:radiobutton><asp:radiobutton id="radioDeleteAll" style="Z-INDEX: 105; LEFT: 24px; POSITION: absolute; TOP: 104px"
                runat="server" GroupName="DeleteOption"></asp:radiobutton><asp:checkbox id="chkDeleteQuota" style="Z-INDEX: 106; LEFT: 48px; POSITION: absolute; TOP: 136px"
                runat="server"></asp:checkbox><asp:checkbox id="chkDeleteSample" style="Z-INDEX: 107; LEFT: 48px; POSITION: absolute; TOP: 160px"
                runat="server"></asp:checkbox></form>
    </body>
</HTML>
