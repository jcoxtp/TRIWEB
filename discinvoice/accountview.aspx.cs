using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class accountview : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.DataBind();
        DetailCountLabel.Text = gvwPurchaseDetails.Rows.Count.ToString() + " PDI Code";
        DetailCountLabel.Text += gvwPurchaseDetails.Rows.Count > 1 ? "s" : string.Empty;

    }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
    }
    protected void ExportToExcel_Click(object sender, EventArgs e)
    {
        Response.Redirect("exportexcel.aspx?id=" + Request.QueryString["id"]);
    }
    protected void InvoiceThis_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ePDIConnectionString"].ConnectionString);

        SqlCommand cmd = new SqlCommand("invoiceCorporatePurchaseDetails", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlParameter acctID = new SqlParameter("@accountID", Request.QueryString["id"]);
        cmd.Parameters.Add(acctID);

        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }
        catch (SqlException sqlX)
        {
            // do something when all hell breaks loose
        }

        Response.Redirect("accountlist.aspx");
    }
    protected void returnLink_Click(object sender, EventArgs e)
    {
        Response.Redirect("accountlist.aspx");
    }
}
