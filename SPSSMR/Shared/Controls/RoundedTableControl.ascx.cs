namespace SPSS.Dimensions.Web.UI.CommonControls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	/// <summary>
	///		Summary description for DarkRoundedTableControl.
	/// </summary>
	public class RoundedTableControl : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Table		tblTable;

        private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
		}

		public void AddDarkHeader(string headerText, bool showBullet)
		{
			if (showBullet)
				headerText = _getBulletedText(headerText);

			if (tblTable.Rows.Count==0)
			{
				TableRow tr = new TableRow();
				_addTableCell(tr, "", 10, -1, 2, 2, @"<IMG height='30' alt='' src='shared/images/RoundedTableControl/dark_topleft.gif' width='10'>");
				_addTableCell(tr, "RoundedTableOuterBorder", -1, 1, 2, -1, "");
				_addTableCell(tr, "", -1, -1, 2, 2, @"<img src='shared/images/RoundedTableControl/dark_topright.gif' height='30' width='10' alt=''>");
				tblTable.Rows.Add(tr);
				tr=null;

				tr=new TableRow();
				_addTableCell(tr, "RoundedTableDarkHeader", -1, -1, 2, -1, headerText);
				tblTable.Rows.Add(tr);
				tr=null;

				tr=new TableRow();
				_addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
				_addTableCell(tr, "RoundedTableProjectInfoBackground", 9, -1, -1, -1, "");
				_addTableCell(tr, "RoundedTableProjectInfoBackground", Unit.Percentage(100), -1, 2, -1, "");
				_addTableCell(tr, "RoundedTableProjectInfoBackground", 9, -1, -1, -1, "");
				_addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
				tblTable.Rows.Add(tr);
			}
			else
				_addHeader(true, headerText);
		}

		public void AddLightHeader(string headerText, bool showBullet)
		{
			if (showBullet)
				headerText = _getBulletedText(headerText);

			if (tblTable.Rows.Count==0)
			{
				TableRow tr = new TableRow();
				_addTableCell(tr, "", 10, -1, 2, 2, @"<IMG height='30' alt='' src='shared/images/RoundedTableControl/light_topleft.gif' width='10'>");
				_addTableCell(tr, "RoundedTableOuterBorder", -1, 1, 2, -1, "");
				_addTableCell(tr, "", -1, -1, 2, 2, @"<img src='shared/images/RoundedTableControl/light_topright.gif' height='30' width='10' alt=''>");
				tblTable.Rows.Add(tr);
				tr=null;

				tr=new TableRow();
				_addTableCell(tr, "RoundedTableLightHeader", -1, -1, 2, -1, headerText);
				tblTable.Rows.Add(tr);
				tr=null;

				tr=new TableRow();
				_addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
				_addTableCell(tr, "RoundedTableProjectInfoBackground", 9, -1, -1, -1, "");
				_addTableCell(tr, "RoundedTableProjectInfoBackground", Unit.Percentage(100), -1, 2, -1, "");
				_addTableCell(tr, "RoundedTableProjectInfoBackground", 9, -1, -1, -1, "");
				_addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
				tblTable.Rows.Add(tr);
			}
			else
				_addHeader(false, headerText);
		}

		public void AddDarkInfo(string infoText)
		{
			if (tblTable.Rows.Count==0)
				AddDarkHeader("", false);

			_addInfo(true, infoText);
		}

		public void AddLightInfo(string infoText)
		{
			if (tblTable.Rows.Count==0)
				AddLightHeader("", false);

			_addInfo(false, infoText);
		}

        public void AddDarkControl(System.Web.UI.Control ctrl)
        {
            if (tblTable.Rows.Count == 0)
                AddDarkHeader("", false);

            _addControl(true, ctrl);
        }

        public void AddLightControl(System.Web.UI.Control ctrl)
        {
            if (tblTable.Rows.Count == 0)
                AddLightHeader("", false);

            _addControl(false, ctrl);
        }

		public void AddFooter()
		{
			TableRow tr = new TableRow();
			_addTableCell(tr, "RoundedTableDarkInfo", -1, -1, 2, 2, @"<img src='shared/images/RoundedTableControl/light_bottomleft.gif' height='10' width='10'");
			_addTableCell(tr, "RoundedTableDarkInfo", -1, 9, 2, -1, "");
			_addTableCell(tr, "RoundedTableDarkInfo", -1, -1, 2, 2, @"<img src='shared/images/RoundedTableControl/light_bottomright.gif' height='10' width='10'>");
			tblTable.Rows.Add(tr);			
			tr=null;
			
			tr=new TableRow();
			_addTableCell(tr, "RoundedTableOuterBorder", -1, 1, 2, -1, "");
			tblTable.Rows.Add(tr);
		}

		private void _addHeader(bool isDarkHeader, string headerText)
		{
			string cssClass = "RoundedTableDarkHeader";
			if (!isDarkHeader)
				cssClass="RoundedTableLightHeader";

			TableRow tr=new TableRow();
			_addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
			_addTableCell(tr, cssClass, 9, -1, -1, -1, "");
			_addTableCell(tr, cssClass, Unit.Percentage(100), 28, 2, -1, headerText);
			_addTableCell(tr, cssClass, 9, -1, -1, -1, "");
			_addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
			tblTable.Rows.Add(tr);
		}
		
		private void _addInfo(bool isDarkInfo, string infoText)
		{
			string cssClass = "RoundedTableDarkInfo";
			if (!isDarkInfo)
				cssClass="RoundedTableLightInfo";

			TableRow tr=new TableRow();
			_addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
			_addTableCell(tr, cssClass, 9, -1, -1, -1, "");
			_addTableCell(tr, cssClass, Unit.Percentage(100), -1, 2, -1, infoText);
			_addTableCell(tr, cssClass, 9, -1, -1, -1, "");
			_addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
			tblTable.Rows.Add(tr);
		}

        private void _addControl(bool isDarkInfo, System.Web.UI.Control ctrl)
        {
            string cssClass = "RoundedTableDarkInfo";
            if (!isDarkInfo)
                cssClass = "RoundedTableLightInfo";

            TableRow tr = new TableRow();
            _addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
            _addTableCell(tr, cssClass, 9, -1, -1, -1, "");
            _addTableCell(tr, cssClass, Unit.Percentage(100), -1, 2, -1, ctrl);
            _addTableCell(tr, cssClass, 9, -1, -1, -1, "");
            _addTableCell(tr, "RoundedTableOuterBorder", 1, -1, -1, -1, "");
            tblTable.Rows.Add(tr);
        }

		private void _addTableCell(TableRow parentRow, string cssClass, Unit width, Unit height, int columnSpan, int rowSpan, string cellText)
		{
			TableCell tc = new TableCell();
			if (columnSpan!=-1)
				tc.ColumnSpan=columnSpan;
			if (rowSpan!=-1)
				tc.RowSpan=rowSpan;
			
			if (width!=-1)
				tc.Width=width;
			if (height!=-1)
				tc.Height=height;
		
			if (cssClass.CompareTo("")!=0)
				tc.CssClass=cssClass;
			
			tc.Text = cellText;
			parentRow.Cells.Add(tc);
		}

        private void _addTableCell(TableRow parentRow, string cssClass, Unit width, Unit height, int columnSpan, int rowSpan, System.Web.UI.Control ctrl)
        {
            TableCell tc = new TableCell();
            if (columnSpan != -1)
                tc.ColumnSpan = columnSpan;
            if (rowSpan != -1)
                tc.RowSpan = rowSpan;

            if (width != -1)
                tc.Width = width;
            if (height != -1)
                tc.Height = height;

            if (cssClass.CompareTo("") != 0)
                tc.CssClass = cssClass;

            tc.Controls.Add(ctrl);
            parentRow.Cells.Add(tc);
        }
		private string _getBulletedText(string headerText)
		{
			return String.Format(@"<img src='shared/images/RoundedTableControl/chevron_small.gif' alt=''>&nbsp;{0}", headerText);
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
}
