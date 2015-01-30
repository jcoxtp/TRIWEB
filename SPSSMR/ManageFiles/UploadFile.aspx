<%@ OutputCache Location= "none" %>
<%@ Page language="c#" Codebehind="UploadFile.aspx.cs" AutoEventWireup="false" EnableEventValidation="false" Inherits="ManageFiles.UploadFile" %>

<%@ Register Src="Controls/RoundedTableControl.ascx" TagName="RoundedTableControl"
    TagPrefix="uc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>
            <%=Server.HtmlEncode(ManageFiles.Utilities.I18N.GetResourceString("dlgUploadFiles_dialog_title"))%>
        </title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="C#" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
        <base target="_top"/>
  		<script type="text/javascript" src="Main.js"></script>
		<script src="Shared/Dialog/dialog.js" type="text/javascript"></script>
		<script type="text/javascript" src="CustomDialog/MessageBox.js"></script>
        <script type="text/javascript" src="MultiFileSelector.js"></script>
</HEAD>
    <body>
		<form id="frmUpload" method="post" encType="multipart/form-data" runat="server">
            <input id="hFileCount" type="hidden" runat="server" value=0 style="width: 56px" />
            <input id="hMaxFileCount" runat="server" style="width: 55px" type="hidden" value="20" />
            <input id="hFileSelectedWarn" runat="server" style="width: 74px" type="hidden" />
            <input id="hCancelUploadWarn" runat="server" style="width: 67px" type="hidden" />
            <input id="hExeFileWarn" runat="server" style="width: 67px" type="hidden" />
            <input id="hInvalidFileExt" runat="server" style="width: 67px" type="hidden" />
            <INPUT id="hLongestFileName" runat="server" style="width: 67px" type="hidden" />
            <table width=100% >
                            <tr>
                                <td>
                                    <uc1:RoundedTableControl ID="tblInputFile" runat="server" />
                                </td>
                            <tr>
                            <tr>
                                <td>
                                    <uc1:RoundedTableControl ID="tblFilesToUpload" runat="server" />
                                </td>
                            <tr>
                                <td >&nbsp;<br />
                                    <asp:Button ID="btnUpload" runat="server" Text="Upload" Width="73px"  />
                                    <input id="btnCancel" onclick="closeWindow();" style="width: 74px"
                                            type="button" value="Cancel" runat="server" /></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label id="lblError" runat="server"></asp:Label></td>
                            </tr>
                        </table>
            <script>
            var multi_selector = new MultiSelector();
                multi_selector.addElement(document.getElementById('fileUpload' ));	     
        </script>
       </form>        
        <script type="text/javascript" src="jsinclude.js"></script>
        <script type="text/javascript">
         InitHandler();
      </script>     
    </body>
</HTML>
