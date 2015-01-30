<%@ Page Language="C#" Debug="false" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<HTML>
	<HEAD>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<LINK href="MarriagePDI/styles.css" type="text/css" rel="stylesheet">
		<SCRIPT runat="server"> 
public void Page_Load(Object sender, EventArgs e)
{
	string id = string.Empty;
	if(Request.QueryString["id"] != null)
		id = Request.QueryString["id"];
	else
		return;
		
	if(!IsNumeric(id))
		return;
		
	string strConn = "Data Source=65.205.160.188,1433;Network Library=DBMSSOCN;Trusted_Connection=False;Initial Catalog=UltimateSurvey;User Id=sa;Password=s3rv3r pa33word!;"
;	string strSQL = "select s.SurveyTitle, COUNT(u.userID) TotalParticipants, SUM(r.completed) Completed, COUNT(responseID) Responded " + 
						"from usd_surveyUser u " + 
						"inner join usd_userGroupMap ug ON u.userID = ug.userID " + 
						"inner join usd_surveyToGroupMap sg ON ug.groupName = sg.groupName " + 
						"inner join usd_survey s ON s.surveyID = sg.surveyID " + 
						"left join usd_response r ON r.userID = u.userID AND s.surveyID = r.surveyID " + 
						"where s.surveyID = " + id + 
						"GROUP BY s.SurveyTitle";

	
	using( SqlConnection conn = new SqlConnection(strConn) )
	{
		SqlCommand cmd = new SqlCommand(strSQL, conn);
		
		cmd.Connection.Open();
		SqlDataReader dr = cmd.ExecuteReader();
		
		if( dr.Read() )
		{
			lblHeader.Text = dr.IsDBNull(0) ? "Survey does not exist." : dr.GetString(0);
			double total = dr.IsDBNull(1) ? 0 : dr.GetInt32(1);
			double complete = dr.IsDBNull(2) ? 0 : dr.GetInt32(2);
			double responded = dr.IsDBNull(3) ? 0 : dr.GetInt32(3);
			
			lblTotal.Text = total.ToString();

			if(total == 0)
				return;
			
			lblComplete.Text = complete.ToString();
			lblCompletePct.Text = (complete / total * 100).ToString("00.00") + "%";
			
			lblInProcess.Text = (responded - complete).ToString();
			lblInProcessPct.Text = ( (responded - complete) / total * 100).ToString("00.00") + "%";
			
			lblNotStarted.Text = (total - responded).ToString();
			lblNotStartedPct.Text = ( (total - responded) / total * 100).ToString("00.00") + "%";
			
		}
		else
		{
			lblHeader.Text = "Survey does not exist.";
		}
		cmd.Connection.Close();
	}
	//lblHeader.Text = "Hello World.";		
}

public bool IsNumeric(object Expression)
{
      bool isNum;
      double retNum;
      isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any,System.Globalization.NumberFormatInfo.InvariantInfo, out retNum );
      return isNum;
}
		</SCRIPT>
	</HEAD>
	<body>
		<table class="page-header" id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="bottom" align="left" width="20%"><IMG src="images/logo.gif"></td>
					<td align="center" width="60%"><span class="banner-text">Survey&nbsp;Status</span></td>
					<td width="20%">&nbsp;</td>
				</tr>
			</table>
			<table id="Table3" style="MARGIN-TOP: 1px" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<tr>
					<td class="tab-active-footer" vAlign="middle" align="right" colSpan="4">&nbsp;
					</td>
				</tr>
			</table>
		<h1><asp:Label ID="lblHeader" Runat="server" /></h1>
		<table>
			<tr>
				<th>
					&nbsp;</th>
				<TD align="center"></TD>
				<th align="center">
					Total Count</th>
				<TD align="center"></TD>
				<th align="center">
					Percentage</th></tr>
			<tr>
				<td>
				Invitations Sent:
				<TD align="center">&nbsp;&nbsp;&nbsp;</TD>
				<td align="center"><asp:Label ID="lblTotal" Runat="server" /></td>
				<TD align="center">&nbsp;&nbsp;&nbsp;</TD>
				<td align="center">-</td>
			</tr>
			<tr>
				<td>
				Responses Completed:
				<TD align="center"></TD>
				<td align="center"><asp:Label ID="lblComplete" Runat="server" /></td>
				<TD align="center"></TD>
				<td align="center"><asp:Label ID="lblCompletePct" Runat="server" /></td>
			</tr>
			<tr>
				<td>In Process:</td>
				<TD align="center"></TD>
				<td align="center"><asp:Label ID="lblInProcess" Runat="server" /></td>
				<TD align="center"></TD>
				<td align="center"><asp:Label ID="lblInProcessPct" Runat="server" /></td>
			</tr>
			<tr>
				<td>Not Started:</td>
				<TD align="center"></TD>
				<td align="center"><asp:Label ID="lblNotStarted" Runat="server" /></td>
				<TD align="center"></TD>
				<td align="center"><asp:Label ID="lblNotStartedPct" Runat="server" /></td>
			</tr>
		</table>
	</body>
</HTML>
