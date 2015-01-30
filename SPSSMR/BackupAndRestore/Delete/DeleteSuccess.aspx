<%@ Page language="c#" Codebehind="DeleteSuccess.aspx.cs" Inherits="Brad.Delete.DeleteSuccess" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>
            <%=SetDocumentTitle()%>
        </title>
        <meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
        <meta name="CODE_LANGUAGE" Content="C#">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <!-- SPSS applications stylesheet -->
        <LINK href="..\Shared/spssmrNet.css" type="text/css" rel="stylesheet">
        <script>
            function CloseWindow()
            {
                window.close();
            }

            function IsTargetOk()
            {
                if(window.top.frames.length > 1)
                {
                    window.Form1.submit();
                }
            }
            
            function OnWindowUnload()
            {
                try
                {
                    var o = window.opener;
                    if(o != null)
                    	window.opener.refreshLauncher2("../../DimensionNet/default2.aspx");
                }
                catch(exception)
                {
                    // http://support.microsoft.com/default.aspx?scid=kb;en-us;314209
                    // Article ID : 314209 
                    // Last Review : April 4, 2005 
                    // Revision : 3.6 
                    // When a child window calls a function in its parent window in Microsoft Internet 
                    // Explorer 6.0, the function may not access the window.location DOM object, all of 
                    // the object properties and methods may stop responding (crash), and you may 
                    // receive the following error: "Variable uses an automation type not supported by JScript"

                    // Raise a message to the user that the problem is most likely caused by this problem.
                    OpenerAlert();
                }
            }
        </script>
    </HEAD>
    <body MS_POSITIONING="GridLayout" onload="JavaScript:IsTargetOk()" onunload="OnWindowUnload()">
        <form id="Form1" method="post" runat="server" target="_top">
            <asp:Button id="btnOk" style="Z-INDEX: 104; LEFT: 360px; POSITION: absolute; TOP: 264px" runat="server"
                Width="80px" Text="btnOk" tabIndex="1"></asp:Button>
            <asp:Label id="lblMessage" style="Z-INDEX: 103; LEFT: 24px; POSITION: absolute; TOP: 56px"
                runat="server">lblMessage</asp:Label>
        </form>
    </body>
</HTML>
