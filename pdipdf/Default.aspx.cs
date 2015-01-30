using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebSupergoo.ABCpdf7;

public partial class _Default : System.Web.UI.Page 
{
    private string ReturnMessage = "[Result Unknown]";
    private int TCID = 0;
    private int userID = 0;
    private int summaryID = 0;
    private int resellerID = 1;
    private int languageID = 1;
//    protected System.Web.UI.WebControls.Literal litObject;
    private string reportFile = string.Empty;

    private const string backButton = "<br><br><input type=\"button\" value=\"Return to Previous Page\" onclick=\"history.back();\" />";
    private int forDebugZero = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
	
	/*
        Doc theDoc = new Doc();
        theDoc.FontSize = 96;
        theDoc.AddText("Hello World");
        theDoc.Save(@"C:\PDFReports\docsave3.pdf"); //Server.MapPath("docsave.pdf"));
        theDoc.Clear();

        Response.ContentType = "Application/pdf";
        
        string FilePath = @"C:\PDFReports\docsave3.pdf"; //MapPath("docsave.pdf");
      
        Response.WriteFile(FilePath);
        Response.End();
	*/
	
	/*
	
	Doc theDoc = new Doc();
	theDoc.AddImageUrl("http://www.pdiprofile.com/ChinesePDI/pdi/login.asp?res=1");
	theDoc.Save(@"C:\PDFReports\docsave4.pdf"); 
        theDoc.Clear();

	Response.ContentType = "Application/pdf";
        
        string FilePath = @"C:\PDFReports\docsave4.pdf"; //MapPath("docsave.pdf");
      
        Response.WriteFile(FilePath);
        Response.End();	
	
	*/

	
	
        if (!initializeQueryVariables())
            Response.Write(ReturnMessage);
        else
            createPDF();
	

    }

    private void createPDF()
    {
        string queryStr = string.Format("?SID={0}&TCID={1}&res={2}&lid={3}", summaryID, TCID, resellerID, languageID);
        string url = "http://" + Request.Url.Host + "/ChinesePDI/PDI/PDIReport.asp" + queryStr;


        Doc theDoc = createReportFromURL(url);

       
        theDoc.Save(ConfigurationSettings.AppSettings["pdfdirectory"] + reportFile);

        theDoc.Clear();
        theDoc.HtmlOptions.PageCacheClear();

        confirmReportCreation();

        Response.Clear();
        Response.ContentType = "Application/pdf";
        //Get the physical path to the file.
        string FilePath = ConfigurationSettings.AppSettings["pdfdirectory"] + reportFile; //MapPath("docsave.pdf");
        //Write the file directly to the HTTP content output stream.
        Response.WriteFile(FilePath);
        Response.End();

    }

    private bool initializeQueryVariables()
    {
        //IDs from querystring
        if (Request.QueryString["TCID"] != null)
            TCID = Convert.ToInt32(Request.QueryString["TCID"]);

        if (Request.QueryString["res"] != null)
            resellerID = Convert.ToInt32(Request.QueryString["res"]);

        if (Request.QueryString["lid"] != null)
            languageID = Convert.ToInt32(Request.QueryString["lid"]);

        if (Request.QueryString["u"] != null)
            userID = Convert.ToInt32(Request.QueryString["u"]);

        return getDatabaseIDs();
    }


    private void confirmReportCreation()
    {
        string connectionString = ConfigurationSettings.AppSettings["DB:TeamResources"];
        using (SqlConnection conn = new SqlConnection(connectionString))
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
            catch (SqlException sqlX)
            {
                ReturnMessage = sqlX.Message;
                this.litObject.Text = sqlX.Message;
                this.litObject.Text += backButton;

            }
            catch (Exception x)
            {
                ReturnMessage = x.Message;
                this.litObject.Text = x.Message;
                this.litObject.Text += backButton;

            }
            finally
            {
                conn.Close();
            }
        }
    }

    private Doc createReportFromURL(string url)
    {
        Doc theDoc = new Doc();
        //theDoc.EmbedFont("Helvetica");
        theDoc.HtmlOptions.PageCacheClear();

        theDoc.Rect.String = "20 30 592 772";
        theDoc.Page = theDoc.AddPage();
        int theID = theDoc.AddImageUrl(url);
        //theDoc.FrameRect();

        while (true)
        {
            if (!theDoc.Chainable(theID))
                break;
            theDoc.Page = theDoc.AddPage();
            theID = theDoc.AddImageToChain(theID);
            //theDoc.FrameRect();
        }

        string copyright = ConfigurationSettings.AppSettings["copyright"];
        theDoc.Rect.String = "30 10 570 30";
        theDoc.VPos = 1.0;
        theDoc.Font = theDoc.AddFont("Verdana");
        theDoc.FontSize = 8;
        for (int i = 2; i <= theDoc.PageCount; i++)
        {
            theDoc.PageNumber = i;
            theDoc.AddText(copyright);
        }

        theDoc.Rect.String = "510 10 572 30";
        theDoc.HPos = 1.0;
        theDoc.VPos = 1.0;
        theDoc.Font = theDoc.AddFont("Verdana");
        theDoc.FontSize = 8;
        int pages = theDoc.PageCount - 1;
        for (int i = 2; i <= theDoc.PageCount; i++)
        {
            theDoc.PageNumber = i;
            int page = i - 1;
            theDoc.AddText("Page " + page.ToString() + " of " + pages.ToString());

        }

        for (int i = 1; i <= theDoc.PageCount; i++)
        {
            theDoc.PageNumber = i;
            theDoc.Flatten();
        }

        return theDoc;
    }

    private bool getDatabaseIDs()
    {
        string connectionString = ConfigurationSettings.AppSettings["DB:TeamResources"];
        using (SqlConnection conn = new SqlConnection(connectionString))
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
            catch (SqlException sqlX)
            {
                ReturnMessage = sqlX.Message;
                this.litObject.Text = sqlX.Message;
                this.litObject.Text += backButton;

            }
            catch (Exception x)
            {
                ReturnMessage = x.Message;
                this.litObject.Text = x.Message;
                this.litObject.Text += backButton;

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
            catch (SqlException sqlX)
            {
                ReturnMessage = sqlX.Message;
                this.litObject.Text = sqlX.Message;
                this.litObject.Text += backButton;

            }
            catch (Exception x)
            {
                ReturnMessage = x.Message;
                this.litObject.Text = x.Message;
                this.litObject.Text += backButton;

            }
            finally
            {
                conn.Close();
            }

            return createFile == 0 || createFile == 1;

        }
    }
}
