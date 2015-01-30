<%@ Page language="c#"  %>
<%@ Register TagPrefix="pdf" Assembly="ABCpdf, Version=5.0.2.0, Culture=Neutral, PublicKeyToken=a7a0b3f5184f2169" Namespace="WebSupergoo.ABCpdf5" %>
<%@ Register TagPrefix="disc" Assembly="DISC" Namespace="DISC" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<script runat="server">
	
	private string ReturnMessage = "[Result Unknown]";
	private int TCID = 0;
	private int userID = 0;
	private int summaryID = 0;
	private int resellerID = 1;
	private int languageID = 1;
	private string reportFile = string.Empty;
	
	private void Page_Load(object sender, System.EventArgs e)
	{
		
		if(!initializeQueryVariables() )
			Response.Write(ReturnMessage);
		else
			createPDF();
	}
	
	private void createPDF()
	{
		string queryStr = string.Format("?SID={0}&TCID={1}&res={2}&lid={3}", summaryID, TCID, resellerID, languageID);
		string url = "http://" + Request.Url.Host + "/ChinesePDI/PDI/PDIReport.asp" + queryStr;

		
		WebSupergoo.ABCpdf5.Doc theDoc = DISC.PDFObject.createReportFromURL(url);

		
		theDoc.Save(ConfigurationSettings.AppSettings["pdfdirectory"] + reportFile);

		theDoc.Clear(); 
		theDoc.HtmlOptions.PageCacheClear();
		
		string pdfReportPath = ConfigurationSettings.AppSettings["pdfVirtualPath"];
		string pdfURL = "http://" + Request.Url.Host + pdfReportPath + reportFile;


		Response.Redirect(pdfURL);

		//Response.Clear();
		//Response.Write(pdfURL);
		//Response.End();

	}
	
	private bool initializeQueryVariables()
	{
		//IDs from querystring
		if(Request.QueryString["TCID"] != null)
			TCID = Convert.ToInt32(Request.QueryString["TCID"]);

		if(Request.QueryString["res"] != null)
			resellerID = Convert.ToInt32(Request.QueryString["res"]);

		if(Request.QueryString["lid"] != null)
			languageID = Convert.ToInt32(Request.QueryString["lid"]);

		if(Request.QueryString["u"] != null)
			userID = Convert.ToInt32(Request.QueryString["u"]);

		return getDatabaseIDs();
	}

	private void confirmReportCreation()
	{
		string connectionString = ConfigurationSettings.AppSettings["DB:TeamResources"];
		using(SqlConnection conn = new SqlConnection(connectionString) )
		{
			SqlCommand cmd = new SqlCommand("spTestSummaryFileCreatedUpdate", conn);
			cmd.CommandType = CommandType.StoredProcedure;

			cmd.Parameters.Add("@PDITestSummaryID", summaryID);
			cmd.Parameters.Add("@PDFFileName", reportFile);

			try
			{
				//int debugMe = 1 / forDebugZero;

				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				
				//cmd.Connection.Close();
			}
			catch(SqlException sqlX)
			{
				ReturnMessage = sqlX.Message;
				this.litObject.Text = sqlX.Message;
				
				
			}
			catch(Exception x)
			{
				ReturnMessage = x.Message;
				this.litObject.Text = x.Message;
				
				
			}
			finally
			{
				conn.Close();
			}
		}
	}

	private bool getDatabaseIDs()
	{
		string connectionString = ConfigurationSettings.AppSettings["DB:TeamResources"];
		using(SqlConnection conn = new SqlConnection(connectionString) )
		{
			SqlCommand cmd = new SqlCommand("sel_PDI_PDFFileName_Ex", conn);
			cmd.CommandType = CommandType.StoredProcedure;

			cmd.Parameters.Add("@TestCodeID", TCID);
			cmd.Parameters.Add("@UserID", userID);

			SqlParameter pPDITestSummaryID = new SqlParameter("@PDITestSummaryID", SqlDbType.Int);
			pPDITestSummaryID.Direction = ParameterDirection.Output;

			SqlParameter pPDFFileName = new SqlParameter("@PDFFileName", SqlDbType.VarChar, 50);
			pPDFFileName.Direction = ParameterDirection.Output;

			cmd.Parameters.Add(pPDITestSummaryID);
			cmd.Parameters.Add(pPDFFileName);

			try
			{
				cmd.Connection.Open();
				cmd.ExecuteNonQuery();

				reportFile = pPDFFileName.Value.ToString();
				summaryID = Convert.ToInt32(pPDITestSummaryID.Value);

				//cmd.Connection.Close();
			}
			catch(SqlException sqlX)
			{
				ReturnMessage = sqlX.Message;
				this.litObject.Text = sqlX.Message;
				
				
			}
			catch(Exception x)
			{
				ReturnMessage = x.Message;
				this.litObject.Text = x.Message;
				
				
			}
			finally
			{
				conn.Close();
			}

			cmd.Parameters.Clear();
			cmd.CommandText = "spTestSummaryFileCreationInProgressUpdate";
			cmd.CommandType = CommandType.StoredProcedure;

			pPDITestSummaryID.Direction = ParameterDirection.Input;

			cmd.Parameters.Add(pPDITestSummaryID);

			SqlParameter pCreateFile = new SqlParameter("@CreateFile", SqlDbType.Int);
			pCreateFile.Direction = ParameterDirection.Output;

			cmd.Parameters.Add(pCreateFile);

			int createFile = -1;
			try
			{
				cmd.Connection.Open();
				cmd.ExecuteNonQuery();

				createFile = Convert.ToInt32(pCreateFile.Value);
				
				//cmd.Connection.Close();
			}
			catch(SqlException sqlX)
			{
				ReturnMessage = sqlX.Message;
				this.litObject.Text = sqlX.Message;
				
				
			}
			catch(Exception x)
			{
				ReturnMessage = x.Message;
				this.litObject.Text = x.Message;
				
				
			}
			finally
			{
				conn.Close();
			}

			return createFile == 0 || createFile == 1;
			
		}
	}
</script>
<html>
  <head>
    <title>printPDF</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="Form1" method="post" runat="server">
		<asp:literal id="litObject" runat="server"></asp:literal>
     </form>
	
  </body>
</html>
