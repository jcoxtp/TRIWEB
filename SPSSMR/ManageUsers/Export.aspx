<%@ OutputCache Location="none" %>

<%@ Page Language="c#" Codebehind="Export.aspx.cs" AutoEventWireup="false" Inherits="ManageUsers.Export" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Exporting...</title>
    <meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <meta id="metaRefresh" runat="server"></meta>
    <base target="_self">
    <!-- STANDARD SPSS STYLESHEET SETTINGS -->
    <link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">

    <script language="javascript">
            function doDownload()
            {
                var iframe = document.createElement('IFRAME');
                iframe.src='DownloadFile.aspx';
                iframe.style.visibility = 'hidden';
                document.body.appendChild(iframe);
                document.body.removeChild(iframe);
            }
			function doCloseDialog()
			{
				window.returnValue = false; 
				window.close();
			}
			function doCloseAndDownload()
			{
				window.returnValue = true; 
				window.close();
			}
    </script>

</head>
<body id="body" runat="server">
    <form id="Export" method="post" runat="server">
        <span id="dialogSize" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px;
            width: 400px; padding-top: 0px">
            <asp:Panel Visible="false" ID="pnlExport" runat="server" Height="160px" Width="100%">
                <div class="DarkBlueBackground" align="center">
                    <img src="../Shared/images/molecules.gif" />
                </div>
                <br>
                <div align="left">
                    &nbsp;&nbsp;
                    <label id="lblStatus"><%=GetResourceString("exporting_wait")%></label></div>
                <br>
                <br>
            </asp:Panel>
            <asp:Panel Visible="false" ID="pnlDone" runat="server" Height="175px" Width="100%">
                <br>
                <div align="left">
                    &nbsp;&nbsp;
                    <label id="lblDone"><%=GetResourceString("exporting_done")%></label></div>
                <br>
                <br>
            </asp:Panel>
            <asp:Panel Visible="false" ID="pnlError" runat="server">
                <div align="left">
                    <asp:TextBox ID="tbError" runat="server" ForeColor="#000066" BackColor="Transparent"
                        TextMode="MultiLine" Height="160px" Width="400px" Wrap="False" BorderStyle="None" />
                </div>
                <br>
            </asp:Panel>
            <div align="center">
                <button visible="false" id="btnCancel" runat="server" style="width: 6em" type="button"
                    onserverclick="btnCancel_ServerClick">
                    <%=GetResourceString("run_cancel")%>
                </button>
            </div>
            <div align="center">
                <button visible="false" id="btnOK" runat="server" style="width: 6em" type="button"
                    onserverclick="btnOK_ServerClick">
                    <%=GetResourceString("run_ok")%>
                </button>
            </div>
            <div align="center">
                <button visible="false" id="btnError" runat="server" style="width: 6em" type="button"
                    onserverclick="btnError_ServerClick">
                    <%=GetResourceString("run_ok")%>
                </button>
            </div>
        </span>
    </form>
    <iframe style="display: none; width: 0px; height: 0px" src="shared/sessionkeepalive.aspx">
    </iframe>
</body>
</html>
