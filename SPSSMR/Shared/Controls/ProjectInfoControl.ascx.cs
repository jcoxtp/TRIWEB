namespace SPSS.Dimensions.Web.UI.CommonControls
{
    using System;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;

    /// <summary>
    ///		Summary description for ProjectInfoControl.
    /// </summary>
    public class ProjectInfoControl : System.Web.UI.UserControl
    {
        protected System.Web.UI.HtmlControls.HtmlTable tblTable;

        protected System.Web.UI.WebControls.LinkButton lbtnMinMax;
        protected System.Web.UI.WebControls.Label lblProjectIdLabel;
        protected System.Web.UI.WebControls.Label lblProjectIdValue;
        protected System.Web.UI.WebControls.Label lblProjectNameLabel;
        protected System.Web.UI.WebControls.Label lblProjectNameValue;
        protected System.Web.UI.WebControls.Label lblProjectDescriptionLabel;
        protected System.Web.UI.WebControls.Label lblProjectDescriptionValue;
        protected System.Web.UI.WebControls.Label lblAdviceValue;
        protected System.Web.UI.WebControls.Label lblHeader;
        protected System.Web.UI.WebControls.Image imgMinMax;
        protected System.Web.UI.WebControls.Panel panelProjectInfoBox;
        public delegate void MinMaxBtnHandler(object observee, MinMaxBtnEventArgs e);
        public event MinMaxBtnHandler OnMinMaxClick = null;

        // This number used for default position of new property inserted into the 
        // table. The number should equal the rows count under it so new item will be
        // under the existed properties.
        // NOTE: You may need change this number if you modify the table structure.
        private const int INDEX_COUNT_FROM_TABLE_BOTTOM = 3;

        private void Page_Load(object sender, System.EventArgs e)
        {
            // Put user code to initialize the page here
        }

        public bool Expanded
        {
            set { _toggleInfo(value); }
            get
            {
                foreach (HtmlTableRow row in tblTable.Rows)
                {
                    if (row.Attributes["class"] == "MinMax")
                    {
                        return row.Visible;
                    }
                }
                return true; // Should not goes to here.
            }
        }

        /// <summary>
        ///     Add an additional Label/Description pair in the project description.
        /// </summary>
        /// <param name="labelText"> The label text shown in the left. </param>
        /// <param name="description"> Description information shown in the right. </param>
        /// <param name="canMinMax"> 
        ///     True means the property will be minimized/maximized when click min/max button; false otherwise.
        ///     It is usually should be true.
        /// </param>
        /// <param name="insertPosition">
        ///     The position of the property row inserted into the table.
        ///     Usually you should put -1 there. It means you add a property at the bottom of other property and above the advice information.
        ///     If you really want to specify the position, please be careful the table structure.
        /// </param>
        public void AddPropertyToDescription(String labelText, String description, bool canMinMax, int insertPosition)
        {
            System.Web.UI.HtmlControls.HtmlTableRow row = new HtmlTableRow();

            // The "MinMax" row can be minimized and maximized.
            if (canMinMax)
            {
                row.Attributes["class"] = "MinMax";
            }

            HtmlTableCell cell = new HtmlTableCell();
            cell.Attributes["class"] = "RoundedTableOuterBorder";
            cell.Attributes["width"] = "1";
            row.Cells.Add(cell);

            cell = new HtmlTableCell();
            cell.Attributes["class"] = "RoundedTableLightInfo";
            cell.Attributes["width"] = "9";
            row.Cells.Add(cell);

            cell = new HtmlTableCell();
            cell.Attributes["class"] = "RoundedTableLightInfo";
            cell.Attributes["width"] = "25%";
            System.Web.UI.WebControls.Label label = new Label();
            label.Text = labelText;
            label.CssClass = "RoundedTableLabel";
            cell.Controls.Add(label);
            row.Cells.Add(cell);

            cell = new HtmlTableCell();
            cell.Attributes["class"] = "RoundedTableLightInfo";
            cell.Attributes["width"] = "75%";
            label = new Label();
            label.Text = description;
            label.CssClass = "RoundedTableText";
            cell.Controls.Add(label);
            row.Cells.Add(cell);

            cell = new HtmlTableCell();
            cell.Attributes["class"] = "RoundedTableLightInfo";
            cell.Attributes["width"] = "9";
            row.Cells.Add(cell);

            cell = new HtmlTableCell();
            cell.Attributes["class"] = "RoundedTableOuterBorder";
            cell.Attributes["width"] = "1";
            row.Cells.Add(cell);


            if (insertPosition < 0 || insertPosition > tblTable.Rows.Count)
            {
                tblTable.Rows.Insert(tblTable.Rows.Count - INDEX_COUNT_FROM_TABLE_BOTTOM, row);
            }
            else
            {
                tblTable.Rows.Insert(insertPosition, row);
            }

        }

        public void lbtnMinMax_OnClick(object sender, System.EventArgs e)
        {
            if (Expanded)
                _toggleInfo(false);
            else
                _toggleInfo(true);

            if (OnMinMaxClick != null)
            {
                OnMinMaxClick(sender, new MinMaxBtnEventArgs(Expanded));
            }
        }

        public System.Web.UI.WebControls.Label ProjectId
        {
            get { return lblProjectIdValue; }
        }

        public System.Web.UI.WebControls.Label ProjectName
        {
            get { return lblProjectNameValue; }
        }

        public System.Web.UI.WebControls.Label ProjectDescription
        {
            get { return lblProjectDescriptionValue; }
        }

        public System.Web.UI.WebControls.Label Advice
        {
            get { return lblAdviceValue; }
        }

        public System.Web.UI.WebControls.Label Header
        {
            get { return lblHeader; }
        }

        public System.Web.UI.WebControls.Label ProjectIdLabel
        {
            get { return lblProjectIdLabel; }
        }

        public System.Web.UI.WebControls.Label ProjectNameLabel
        {
            get { return lblProjectNameLabel; }
        }

        public System.Web.UI.WebControls.Label ProjectDescriptionLabel
        {
            get { return lblProjectDescriptionLabel; }
        }

        public void SetLabels(string projectIdLabel, string projectNameLabel, string projectDescriptionLabel)
        {
            ProjectIdLabel.Text = projectIdLabel;
            ProjectNameLabel.Text = projectNameLabel;
            ProjectDescriptionLabel.Text = projectDescriptionLabel;
        }

        public void SetValues(string projectHeader, string projectId, string projectName, string projectDescription, string projectAdvice)
        {
            ProjectId.Text = projectId;
            ProjectName.Text = projectName;
            ProjectDescription.Text = projectDescription;
            Header.Text = projectHeader;
            Advice.Text = projectAdvice;
        }

        public void ShowInfo()
        {
            _toggleInfo(true);
        }

        public void HideInfo()
        {
            _toggleInfo(false);
        }

        private void _toggleInfo(bool bShow)
        {
            foreach (HtmlTableRow row in tblTable.Rows)
            {
                if (row.Attributes["class"] == "MinMax")
                {
                    row.Visible = bShow;
                }
            }

            if (bShow)
                imgMinMax.ImageUrl = @"~/shared/images/RoundedTableControl/collapse.gif";
            else
                imgMinMax.ImageUrl = @"~/shared/images/RoundedTableControl/expand.gif";
        }
        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        ///		Required method for Designer support - do not modify
        ///		the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);

        }
        #endregion
    }

    public class MinMaxBtnEventArgs : System.EventArgs
    {
        private bool _state;

        public MinMaxBtnEventArgs(bool state)
        {
            _state = state;
        }

        public bool Expanded
        {
            get { return _state; }
        }
    }
}
