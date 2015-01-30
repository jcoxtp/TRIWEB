<%@ Page Language="c#" AutoEventWireup="true" %>
<%@ Register Tagprefix="MyTag" Namespace="SPSSMR.Management.Monitoring.DimensionNet.Sessions" Assembly="SPSSMR.Management.Monitoring.DimensionNet,Version=1.0.2.0,Culture=neutral,PublicKeyToken=8174058f62942e31" %>
<%@ Register Tagprefix="MyTag" Namespace="AppLogLib" Assembly="AppLogLib,Version=1.0.2.0,Culture=neutral,PublicKeyToken=8174058f62942e31" %>
<html>
<head>
	<script language="C#" runat="server">
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				Response.Write("Page refreshed: " +  DateTime.Now.ToString() + "<br>");

				if (this.Session!=null)
				{
					ApplicationSession appSession = (ApplicationSession)Session["ApplicationSession"];
					if (appSession!=null)
						appSession.UpdateSession();
			
					UserSession userSession = (UserSession)Session["UserSession"];
					if (userSession!=null)
						userSession.UpdateSession();
				}
			}
			catch(Exception ex) 
            {
                string appName = "";
                try { appName = (string)Application["Name"]; }
                catch { }
		                       
                string msg = String.Format("Exception was thrown in the SessionKeepAlive page ({0}).\r\n\r\nError: {1}", appName, ex.Message);

                try
                {
                    AppLogLib.AppLog log = (AppLogLib.AppLog)Session["SessionLog"];
                    log.Log(msg, (int)AppLogLib.logLevels.LOGLEVEL_ERROR);
                }
                catch { } 
                
                try { System.Diagnostics.EventLog.WriteEntry("DimensionNet", msg, System.Diagnostics.EventLogEntryType.Error); }
                catch { }
            }
			
		}
	</script>
	<script language="javascript">
	<!--
	function keepSessionAlive()
	{
	   	location="sessionkeepalive.aspx";
	}

	var timeoutID = null;
	function init()
	{
	    if ( timeoutID != null ) {
			clearTimeout(timeoutID);
			timeoutID=null;
		}
		timeoutID = setTimeout("keepSessionAlive()", <% int iVal = 0;
								if (Session.Timeout!=0)
								iVal = Convert.ToInt32((Session.Timeout*60000)*0.9);
								Response.Write(iVal);
								string appName = "";
								try { appName = (string)Application["Name"]; }
								catch {}
		                        try { 
                                    string logMsg = String.Format("[{0}] SessionKeepAlive page has been refreshed. Timer is set to {1}", appName, iVal.ToString());
		                            AppLogLib.AppLog log = (AppLogLib.AppLog)Session["SessionLog"];
		                            log.Log(logMsg, (int)AppLogLib.logLevels.LOGLEVEL_INFO);
                                }		                        
                                catch { } 
            %>, "javascript"); 
	}
	-->
	</script>
</head>
<body onload="init()">
</body>
</html>