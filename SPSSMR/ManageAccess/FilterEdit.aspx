<%@ Page Language="c#" Codebehind="FilterEdit.aspx.cs" AutoEventWireup="false" Inherits="ManageAccess.FilterEdit" EnableEventValidation="false" ValidateRequest="false"%>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>
        <%=TitleText%>
    </title>
    <meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <META http-equiv=Pragma content=no-cache>
    <base target="_self"/>
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">

    <script src="../shared/Dialog/dialog.js" type="text/javascript"></script>

    <script type="text/javascript">
		<!--
		function handleOnLoad() 
		{
		   resizeDlg( 1000 );
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
			        ClientOKClicked();
			        break;
		        case 27: // esc
			        CancelClientClicked();
			        break;
	        }
        }
        
        function txtInput_onkeypress() 
        {
            switch ( event.keyCode )
	        {
		        case 13: // enter
			        ClientOKClicked();
			        return false;
		        case 27: // esc
			        CancelClientClicked();
			        break;
	        }
        }

        function ClientOKClicked() 
        {
            window.onbeforeunload = null;
            var button = document.getElementById("ClientOK");
            if(button)
            { 
                var strNewFilter = document.getElementById("newText").value;
                var strCurrFilter = document.getElementById("currFilter").value;
                if(strCurrFilter != strNewFilter )
                {   
                    if(strNewFilter == "")
                    {
                        var msg = getI18N("IDS_INTRO_FILTEREDIT_EMPTY")
                        if(!confirm(msg))
                        {
                            return;
                        }
                    }
                    var button = document.getElementById("btnOK");
                    if(button) button.click();   
                  
                    var parent = window.dialogArguments
                    parent.opener.location.href=parent.opener.location.href;
                }
                else
                {
                    closeDialog();   
                }
            }
		}
		
		function CancelClientClicked() 
        {
	        var button = document.getElementById("ClientCancel");
            if(button) button.click();
		}
		
		function getI18N(resourceId) 
        {
	        try {
		        if ( I18N == null ) {
			        return "no resources : "+resourceId;
			    }
        		
		        if ( I18N[resourceId] == null ) {
			        return "no such string in resources : "+resourceId;
		        }
    	        return I18N[resourceId];
	        }
	        catch (e) {
		        return e.description;
	        }
        }
		-->
    </script>

</head>
<body onload="javascript:handleOnLoad();">
    <form id="filteredit" method="post" runat="server">
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
                                            <input id="newText" runat="server" type="text" style="width: 95%" onkeypress="return txtInput_onkeypress();">
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
                    <input class="stdbutton" ID="ClientOK" onclick="ClientOKClicked();" type="button" value="<%=OKText%>"/>
                    <asp:Button CssClass="stdbutton" ID="btnOK" runat="server" OnClick="btnOK_Click" style="DISPLAY: none" />
                    <input class="stdbutton" id="ClientCancel" onclick="closeDialog()" type="button" value="<%=CancelText%>">
                </td>
            </tr>
        </table>
        <input id="currFilter" type="hidden" name="currFilter" runat="server">
        <input id="projectId" type="hidden" name="projectId" runat="server">
        <input id="principalId" type="hidden" name="principalId" runat="server">
    </form>
</body>
</html>
