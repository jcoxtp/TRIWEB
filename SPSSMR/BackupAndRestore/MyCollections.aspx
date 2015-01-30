<%@ Page language="c#" Codebehind="MyCollections.aspx.cs" AutoEventWireup="false" Inherits="Brad.Collections" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>Collections</title>
        <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
        <meta name="CODE_LANGUAGE" Content="C#">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <!-- SPSS Launcher applications stylesheet -->
        <link href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
        <script type="text/javascript">
    <!--
    
    var wBradBackup;
    var wBradDelete;
    
    function deleteProject(anchor)
    {    
		
		var project;
		project = Collections.cmbProjectList.options[Collections.cmbProjectList.selectedIndex].value;
		
		var lang = '&lang=';
		try
		{
		    lang = lang + document.ProjListClass.tbPreferredLanguage.value;
		}
		catch (exception)
		{
		    //lang = lang + 'en-us';
		    //lang = lang + 'ja';
		    lang = lang + 'lisa';
		}

		var sUrl = "MyApplicationInit.aspx?project=" + project + lang;

       	var sHash = getHash(top.location);

		if (sHash!="")
		{
			sUrl+= "&hash="+sHash;
		}

		sUrl += "&action=delete";

		alert (sUrl);
		
		wBradDelete = window.open(sUrl, "", "width=470,height=300,location=no,menubar=no,toolbar=no");
		wBradDelete.focus();
	}
    
    function backupProject(anchor)
    {
				
		var project;
		project = Collections.cmbProjectList.options[Collections.cmbProjectList.selectedIndex].value;
						
		var sWindowName = "brad_backup";
		var sUrl = "BradBackupStart.aspx?project=" + project
       	var sHash = getHash(top.location);
		var sTitle = "Backup And Restore";
		var sFeatures = "";
		if (sHash!="")
		{
			sUrl+="&hash="+sHash;
		}
		
		//Check if the window is open				
		if(wBradBackup != null)
		{			
			try
			{
				if(wBradBackup.closed)
				{					
					wBradBackup = window.open(sUrl, sWindowName, "width=470,height=300,location=no,menubar=no,toolbar=no");
					wBradBackup.focus();
				}
				else
				{			
					wBradBackup.focus();	
				}
			}
			catch(exception)
			{
				if(exception.description == null)
				{
					alert("Error: " + exception.message);
				}
				else
				{
					alert("Error: " + exception.description);
				}				
			}			
		}
		else
		{						
			wBradBackup = window.open(sUrl, sWindowName, "width=470,height=300,location=no,menubar=no,toolbar=no");
			wBradBackup.focus();
        }
    }
    
    
	function getHash(sLocation)
	{
		// get the query string, ignore the ? at the front.
		var querystring="";
		if (sLocation=="")
			querystring=location.search.substring(1,location.search.length);		
		else
			querystring=sLocation.search.substring(1,sLocation.search.length);		
		
		// parse out name/value pairs separated via &amp;
		var args = querystring.split('&');

		// split out each name = value pair
		for (var i=0;i<args.length;i++)
		{
			var pair = args[i].split('=');
			if (pair[0]=="hash")
				return pair[1];		
		}			
		return "";
	}
    -->
        </script>
    </HEAD>
    <body>
        <form id="Collections" method="post" runat="server">
            <TABLE id="LayoutTable" cellSpacing="0" cellPadding="0" width="100%" border="0" height="100%">
                <TR height="79">
                    <td align="center" valign="middle" bordercolor="gainsboro">Logo Here</td>
                </TR>
                <TR height="20">
                    <td align="center" valign="middle" bordercolor="gainsboro" bgColor="gainsboro">Collection 
                        Options</td>
                </TR>
                <TR height="100%">
                    <TD align="center" valign="middle" bordercolor="gainsboro">
                        <P>&nbsp;</P>
                        <P>
                            <asp:DropDownList id="cmbProjectList" runat="server"></asp:DropDownList></P>
                        <P>
                            <asp:HyperLink id="lnkNewWindow" runat="server"> Backup</asp:HyperLink></P>
                        <P>
                            <asp:HyperLink id="lnkDelete" runat="server">Delete</asp:HyperLink></P>
                        <P>
                            <asp:LinkButton id="lnkRestore" runat="server">Restore</asp:LinkButton></P>
                    </TD>
                </TR>
            </TABLE>
        </form>
    </body>
</HTML>
