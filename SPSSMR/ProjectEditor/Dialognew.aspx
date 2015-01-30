<%@ Page Language="c#" Codebehind="dialognew.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.Dialognew" EnableEventValidation="false"%>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>
        <%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dialognew_title"))%>
    </title>
    <meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <base target="_self"></base>
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">

    <script src="../shared/Dialog/dialog.js" type="text/javascript"></script>

    <script type="text/javascript" src="general.js"></script>

    <script type="text/javascript">
		<!--
		function handleOnLoad() 
		{
	       if ( document.dialognew.doResizeWindow.value == "1" )
	        {
		        resizeDlg( 1000 );
		        document.dialognew.doResizeWindow.value = "0";
	        }
	    }
        
        function keyPressed() 
        {
	        switch ( event.keyCode )
	        {
		        case 13: // enter
			        if ( document.activeElement.id == "btnCancel" ) 
			        {
				        return;
			        }
			        btnOK_ClickedClient();
			        break;
		        case 27: // esc
			        btnCancel_ClickedClient();
			        break;
	        }
        }
        
        function btnOK_ClickedClient() 
        {
            window.onbeforeunload = null;
            var button = document.getElementById("btnOk");
            if(button) button.click();
		}
		
		function btnCancel_ClickedClient() 
        {
	        var button = document.getElementById("btnCancel");
            if(button) button.click();
		}
		-->
    </script>

</head>
<body onkeyup="javascript:keyPressed()"  onload="javascript:handleOnLoad();">
    <form id="dialognew" method="post" runat="server">
        <table>
            <tr>
                <td>
                    <table class="OuterTable" style="width: 250px">
                        <tr>
                            <td>
                                <table class="InnerTable" cellspacing="2">
                                    <tr>
                                        <td>
                                            <%=LabelText%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input id="newText" runat="server" type="text" style="width: 95%">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="middle" valign="bottom">
                    <asp:Button CssClass="stdbutton" ID="btnOk" runat="server" OnClick="BtnOk_Click" />
                    <input class="stdbutton" id="btnCancel" onclick="closeDialog()" type="button" value="<%=GetResourceString("cancel")%>">
                </td>
            </tr>
        </table>
        <input id="doResizeWindow" type="hidden" name="doResizeWindow" runat="server">
    </form>
</body>
</html>
