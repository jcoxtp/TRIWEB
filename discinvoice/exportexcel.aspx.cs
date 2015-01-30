using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text;
using System.IO;

public partial class exportexcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.DataBind();
        PrepareGridViewForExport(gvwPurchaseDetails);
        exportToExcel();
        
        ///*
        //string attachment = "attachment; filename=Contacts.xls";
        //Response.ClearContent();
        //Response.AddHeader("content-disposition", attachment);
        //Response.ContentType = "application/ms-excel";
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter htw = new HtmlTextWriter(sw);
        //gvwPurchaseDetails.RenderControl(htw);
        //Response.Write(sw.ToString());
        //Response.End();
        //*/

        //string attachment = "attachment; filename=Contacts.xls";
        //Response.ClearContent();
        //Response.AddHeader("content-disposition", attachment);
        //Response.ContentType = "application/ms-excel";
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter htw = new HtmlTextWriter(sw);


        //// Create a form to contain the grid
        //HtmlForm frm = new HtmlForm();
        //gvwPurchaseDetails.Parent.Controls.Add(frm);
        //frm.Attributes["runat"] = "server";
        //frm.Controls.Add(gvwPurchaseDetails);

        //frm.RenderControl(htw);
        ////gvwPurchaseDetails.RenderControl(htw);
        //Response.Write(sw.ToString());
        //Response.End();

    }

    protected override void OnInit(EventArgs e)
    {

        base.OnInit(e);
    }

    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //    //base.VerifyRenderingInServerForm(control);
    //}

    private void PrepareGridViewForExport(Control gv)
    {

        LinkButton lb = new LinkButton();

        Literal l = new Literal();

        string name = String.Empty;

        for (int i = 0; i < gv.Controls.Count; i++)
        {

            if (gv.Controls[i].GetType() == typeof(LinkButton))
            {

                l.Text = (gv.Controls[i] as LinkButton).Text;

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);

            }

            else if (gv.Controls[i].GetType() == typeof(DropDownList))
            {

                l.Text = (gv.Controls[i] as DropDownList).SelectedItem.Text;

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);

            }

            else if (gv.Controls[i].GetType() == typeof(CheckBox))
            {

                l.Text = (gv.Controls[i] as CheckBox).Checked ? "True" : "False";

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);

            }

            if (gv.Controls[i].HasControls())
            {

                PrepareGridViewForExport(gv.Controls[i]);

            }

        }

    }

    private void exportToExcel()
    {
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment; filename=FileName.xls");
        //Response.Charset = "";

        //// If you want the option to open the Excel file without saving than
        //// comment out the line below
        //// Response.Cache.SetCacheability(HttpCacheability.NoCache);

        //Response.ContentType = "application/vnd.xls";
        //System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        //System.Web.UI.HtmlTextWriter htmlWrite =
        //new HtmlTextWriter(stringWrite);
        //gvwPurchaseDetails.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();

        string attachment = "attachment; filename=purchasedetails.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);

        // Create a form to contain the grid
        HtmlForm frm = new HtmlForm();
        gvwPurchaseDetails.Parent.Controls.Add(frm);
        frm.Attributes["runat"] = "server";
        frm.Controls.Add(gvwPurchaseDetails);

        frm.RenderControl(htw);
        //GridView1.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

}
