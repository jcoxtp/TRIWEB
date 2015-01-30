<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditMail.aspx.cs" Inherits="SPSSMR.Management.Monitoring.Web.EditMail" %>


<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>
        Edit Email
    </title>
    <meta content="Microsoft Visual Studio 7.0" name="GENERATOR"/>
    <meta content="C#" name="CODE_LANGUAGE"/>
    <meta content="JavaScript" name="vs_defaultClientScript"/>
    <META http-equiv=Pragma content=no-cache/>
    <base target="_self"/>
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
    <link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet"/>

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
            var txt= document.getElementById("newText");
            var type = document.getElementById("hidType");
            
            if(type.value != "edit")
            {
                var parent = window.dialogArguments;
                var oListbox = parent.opener.document.getElementById("mailList");
                for (var i = 0; i < oListbox.options.length; i++)
                {
                    if(oListbox.options[i].text.toLowerCase() ==txt.value.toLowerCase())
                    {
                        lab.style.display="none";
                        labDuplicate.style.display="block";
                        labTitle.style.display="none";
                        return;
                    }
                }
            }

            if(txt)
            {
                var str = txt.value;
                if(isEmail(str))
                {
                     window.returnValue=str;
                     window.close();
                }
            }
		}
		
		function CancelClientClicked() 
        {
	        var button = document.getElementById("ClientCancel");
            if(button) button.click();
		}
		
		function isEmail(s){
            if(s == "") return false;
            s = s.replace(/£À/ig, "@");
            if (s.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1) return true;
            else
            {
                lab.style.display="block";
                labDuplicate.style.display="none";
                labTitle.style.display="none";
                return false;
            }
        }
        
        function onClose()
        {
            window.returnValue="";
            window.close();
        }

		
//		function getI18N(resourceId) 
//        {
//	        try {
//		        if ( I18N == null ) {
//			        return "no resources : "+resourceId;
//			        return "";
//		        }
//        		
//		        if ( I18N[resourceId] == null ) {
//			        return "no such string in resources : "+resourceId;
//			        return "";
//		        }
//        		
//		        return I18N[resourceId];
//	        }
//	        catch (e) {
//		        return e.description;
//		        return "";
//	        }
//        }
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
                                           <asp:Label runat="server" id="labTitle" Text="13" ></asp:Label> <asp:Label runat="server" id="labInvalidMailAddress" Text="12" ForeColor="Red" ></asp:Label>
                                           <asp:Label runat="server" id="labDuplicateMailAddress" Text="12" ForeColor="Red" ></asp:Label>
                                        </td>
                                            
                                            
                                    </tr>
                                    <tr>
                                        <td>
                                            <input id="newText" runat="server"  type="text" style="width: 95%" onkeypress="return txtInput_onkeypress();"/>
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
                    <%--<asp:Button CssClass="stdbutton" ID="btnOK" runat="server" OnClick="btnOK_Click" style="DISPLAY: none" />--%>
                    <input class="stdbutton" id="ClientCancel" onclick="onClose()" type="button" value="<%=CancelText%>"/>
                </td>
            </tr>
        </table>
        <input id="hidType" type="hidden" runat=server />
    </form>
</body>
</html>
