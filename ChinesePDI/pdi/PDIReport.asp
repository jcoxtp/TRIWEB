<%@ Language=VBScript %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
  <HEAD>
<!--#INCLUDE FILE="include/common.asp" -->
<!--#INCLUDE FILE="include/PDIBehavioralRelationships.asp" -->
<%
Dim Site
Site = Request.Cookies("Site")
If Site = "" Then
	Site = Request.QueryString("st")
	If Site = "" Then
		Site = "TDI"
	End If
End If
%>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312" >
	<link rel="stylesheet" href="_system.css" type="text/css">
	<link rel="stylesheet" href="/Resellers/<%=SitePathName%>/system.css" type="text/css">
  </HEAD>
<body>
<%
Dim nTitleSize
nTableWidth = 700
Dim strUserName
Dim strUser2Name
Dim nRepProfile1
Dim nRepProfile2
Dim TestDate
Dim nCustomProfileExists
Dim nM1, nM2, nM3, nM4, nL1, nL2, nL3, nL4, nC1, nC2, nC3, nC4
Dim CPD, CPI, CPS, CPC
Dim PDITestSummaryID, TestCodeID
PDITestSummaryID = Request.QueryString("SID")
TestCodeID = Request.QueryString ("TCID")
Dim HP(4)
Dim HPValue(4)
Dim HPHPT(4)
Dim CHPT(4)
Dim oConn
Dim oCmd
Dim oRs

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
     .CommandText = "sel_PDITestSummary"
     .CommandType = 4
     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@PDITestSummaryID", 3, 1, 4, PDITestSummaryID)
End With
oConn.Open strDBaseConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1

If oConn.Errors.Count < 1 Then
	If oRs.EOF = FALSE Then
		nM1 = oRs("M_NumberD")
		nM2 = oRs("M_NumberI")
		nM3 = oRs("M_NumberS")
		nM4 = oRs("M_NumberC")
		nL1 = oRs("L_NumberD")
		nL2 = oRs("L_NumberI")
		nL3 = oRs("L_NumberS")
		nL4 = oRs("L_NumberC")
		nC1 = oRs("C_NumberD")
		nC2 = oRs("C_NumberI")
		nC3 = oRs("C_NumberS")
		nC4 = oRs("C_NumberC")
		CPD = oRs("CPD")
		CPI = oRs("CPI")
		CPS = oRs("CPS")
		CPC = oRs("CPC")
		HP(1) = oRs("HighFactorType1")
		HP(2) = oRs("HighFactorType2")
		HP(3) = oRs("HighFactorType3")
		HP(4) = oRs("HighFactorType4")
		HPValue(1) = oRs("HighFactorType1Value")
		HPValue(2) = oRs("HighFactorType2Value")
		HPValue(3) = oRs("HighFactorType3Value")
		HPValue(4) = oRs("HighFactorType4Value")
		nRepProfile1 = oRs("ProfileID1")
		nRepProfile2 = oRs("ProfileID2")
		nCustomProfileExists = oRs("CustomProfile")
		strUserName = oRs("FirstName") & " " & oRs("LastName")
		strUser2Name = oRs("FirstName")	
		TestDate = oRs("TestDate")
		HighType1 = oRs("HighFactorType1")
		HighType2 = oRs("HighFactorType2")
	Else
		Response.Write "Error in creating PDF report. Please contact Team Resources"
		Response.End
	End If
Else
	Response.Write "Error in creating PDF report. Please contact Team Resources"
	Response.End
End If

Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing

If ISNULL(HPValue(1)) = TRUE Then
	HPValue(1) = 0
End If

If ISNULL(HPValue(2)) = TRUE Then
	HPValue(2) = 0
End If

If ISNULL(HPValue(3)) = TRUE Then
	HPValue(3) = 0
End If

If ISNULL(HPValue(4)) = TRUE Then
	HPValue(4) = 0
End If

HPHPT(1) = 0
HPHPT(2) = 0
HPHPT(3) = 0
HPHPT(4) = 0

CHPT(1) = 0
CHPT(2) = 0
CHPT(3) = 0
CHPT(4) = 0

' Calculate what items are the highpoints
' You have the highpoints in letter in order and their values
' but you have to calculate because you don't know which ones are equal
' etc, etc.
' HPValue array contains the value of the highpoint in order of highest point to
' lowest point
' The HP array contains the character of the highpoint in order of highest point to
' lowest point
If CInt(HPValue(1)) = CInt(HPValue(2)) AND CInt(HPValue(2)) = CInt(HPValue(3)) AND CInt(HPValue(3)) = CInt(HPValue(4)) Then
	HPHPT(1) = 1
	HPHPT(2) = 1
	HPHPT(3) = 1
	HPHPT(4) = 1
Else
		If HPValue(1) = HPValue(2) AND HPValue(2) = HPValue(3) Then
			HPHPT(1) = 1
			HPHPT(2) = 1
			HPHPT(3) = 1
		Else
			' the 4 pts are not equal
			' the 3 pts are not equal
			' then check for 2 points equal
			If HPValue(1) = HPValue(2) Then
				' 2 points are equal
				HPHPT(1) = 1
				HPHPT(2) = 1
			Else
				' display the 2 highest points
				HPHPT(1) = 1
				' [SM] Disabled the following if...end if block because TR only wants the highest point shown, not
				' [SM] the highest and second highest points, unless of course they are equal, which is addressed above.
				'If ISNULL(HP(2)) = FALSE Then
					'Your second highest point is HP(2)
					'HPHPT(2) = 1
				'End If
			End If
		End If
End If

Dim nCounter
' the highpoints are in an array listed in order of the highpoint, convert this to the
' order of the params passed into the asp chart page
' CHPT(1) - if 1 means that D is the highpoint
' CHPT(2) - if 1 means that I is the highpoint
' CHPT(3) - if 1 means that S is the highpoint
' CHPT(4) - if 1 means that C is the highpoint

For nCounter = 1 to 4
	If HP(nCounter) = "D" AND CInt(HPHPT(nCounter)) = 1 Then
		CHPT(1) = 1
	End If
	If HP(nCounter) = "I" AND CInt(HPHPT(nCounter)) = 1 Then
		CHPT(2) = 1
	End If
	If HP(nCounter) = "S" AND CInt(HPHPT(nCounter)) = 1 Then
		CHPT(3) = 1
	End If
	If HP(nCounter) = "C" AND CInt(HPHPT(nCounter)) = 1 Then
		CHPT(4) = 1
	End If
Next
%>

<!--************* B E G I N  R E P O R T *************-->

<!--***** Begin Page 1 *****-->
<div style="width:624px">
<TABLE WIDTH=612 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
<% If Site = "TDG" Then %>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/DreamGiverTitle2.jpg" WIDTH=600 HEIGHT=400 ALT=""></TD>
	</TR>
<% Else %>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/pdi_title_top.jpg" WIDTH=612 HEIGHT=416 ALT=""></TD>
	</TR>
<% End If %>
	<TR>
		<TD background="images/personal_disc_pdf_cover_06.gif" WIDTH=612 HEIGHT=251 COLSPAN=4><%=strUserName%><br><%=TestDate%></TD>
	</TR>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/pdi_pdi_chinese.gif" WIDTH=612 HEIGHT=79 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH=36 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=88 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=319 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=169 HEIGHT=1 ALT=""></TD>
	</TR>
</TABLE>
</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 1 *****-->


<!--***** Begin Page 2 *****-->
<div style="width:624px">
<h1>���Լ����嵥DISC<sup>&reg;</sup></h1>

<h2><i>��ǿ���˵���Ч����</i></h2>

<p><hr>

<P></P>
<p>
<% If Site = "TDG" Then %>
	<img class="report_image_left" align="left" src="images/TakingDISC_TDG.gif"  alt="" >
<% Else %>
	<img class="report_image_left" align="left" src="images/TakingDISC.gif"  alt="" >
<% End If %>

����ÿ���˶����ŵ�����㣬��Щ�ŵ������ʹ������һЩ���������±Ƚϵ�����������һЩ�����������ֲ�̫��������ʵ�������쵼�Ĳ��ܺ͸��˵���Ч�����ķ��������ǿ���ĳЩ������ܷ񷢻Ӹ��˵��ŵ㡣���˵ļ��ɺ��ŵ㷢�ӵ�Խ�ã��ɾͿ��ܾ�Խ�ߡ�

<br><br>���������Ԥ����ĳ����������Ǹ���������ν�����ϵ����������Ǹ�������һ�����������ǽ�����Ϊ���Ƿ��񡢲���Ӱ�����ǣ����в��ɹ����ļ�ֵ��

<br><br>��Ϊ��һϵ�и������ص�Ӱ�죬��Щ���ذ��������ĸ��Ի����飬��ʱ����к�����״̬�����ǵļ��ɣ����飬��ֵ�ۣ����ܣ��Լ����˵Ķ�������Щ�����Լ�����������ض�����Ϊ����ֱ�Ӻͼ�ӵ����á�

<br><br>���Ǻܶ��˶��˽⵽��������Ƕ��Լ��ͱ���֪����Խ�࣬���Ǿ��ܸ��õ�Ԥ���˵���Ϊ���֣���ˣ����Ǿ��ܸ��õ�����˽�����Ϊ����񡣸��Լ����嵥DISC<sup>&reg;</sup> ����������������ǵ���Ϊ����Ϊʲô��ͬ����β�ͬ��

<br><br>���Լ����嵥DISC<sup>&reg;</sup> ��ʹ����ȷ�˽�������ο����Լ��ģ������ñ�����ο����㡣����������̺��㽫��ʶ��ʵ����---һ��Ҳ��������������в�ͬ���ˡ�

<hr>
<font size=1>�������ݣ���Ȩ����<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> ȫȨ����.</font>
</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 2 *****-->


<!--***** Begin Page 3 *****-->
<div style="width:624px">
<h1>����˵�DISC<sup>&reg;</sup>����</h1>
<h2><i>��������ͬ�ĽǶȿ��˵���Ϊ</i></h2>
<hr>
<%=strUser2Name%>, ��������ĸ��Լ����嵥�ĵ÷֡����������Ĵ𰸷ֱ����������ͼ��ÿһ��ͼ���һ����ȷ��ͬ�ĽǶ�̽�������Ϊ���֡�

<br><br>
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="85%">
	<tr>
		<td align="center" width="33%"><strong>����</strong></td>
		<td align="center" width="33%"><strong>���</strong></td>
		<td align="center" width="34%"><strong>�ۺ�</strong></td>
	</tr>
	<tr>
		<td align="center">
			<img src="discmost_small.asp?nD1=<%=nM1%>&amp;nD2=<%=nM2%>&amp;nD3=<%=nM3%>&amp;nD4=<%=nM4%>" alt="" >
			<br ><span class="captiontext"><strong>I. ����ĸ���</strong></span>
		</td>
		<td align="center">
			<img src="discleast_small.asp?nD1=<%=nL1%>&amp;nD2=<%=nL2%>&amp;nD3=<%=nL3%>&amp;nD4=<%=nL4%>" alt="" >
			<br ><span class="captiontext"><strong>II.����ĸ���</strong></span>
		</td>
		<td align="center">
			<img src="disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" >
			<br ><span class="captiontext"><strong>III. �����ĸ���</strong></span>
		</td>
	</tr>
</table>
</div>

<br><br><strong>I. ����ĸ���</strong>�������ܡ��Ļش𣩣�����ĸ��������ֵ�������Ϊ����ϣ����������£�����������������ο����㡣��������Ϊ��ȡ�óɹ������ġ���ߡ�����ġ�����ĸ���ĸ�Դ������Ӻ�ͯ������ʱ������������һ�У���ͥ�����ѣ��ܵĽ��������ڽ̡���������ʱ�ں󣬴󲿷��˶������Ϊ�˴������л�ȡ���Լ������������£��������µķ�ʽ�������ǵġ�����ĸ����

<br><br><strong>II������ĸ���</strong>������ܡ��Ļش𣩣���������Ȼ����Ϊ����---��ı��ԡ�������Ϊ���Ŵ���ͯ�껷���Ĳ�����������ɵĳ����£��ڼ�����������һ�𣩱��ֳ�������Ϊ����Ϊ��ʱ������û�б�Ҫ��������ĸ���ġ���ߣ���������ѹ���ܴ�������Ҳ���ֳ�������Ϊ����Ϊ��ʱ�����߹��ڳ�����

<br><br><strong>III�������ĸ���</strong>���ۺϣ����ۺϵ�ͼ��������������������ĸ�������Ľ������Ϊ����ر���������������ô������ġ�ע�⵽��Ȼ������ܣ��ĸ��������ں�ͯʱ�ڣ����루���ܣ��ĸ��ʼ������ʱ�ڣ���ô���ۺϡ���Ϊ������Ҳ��Խ��硣��ˣ������ǵ������󣬸���ٹ̵���Ϊ�ǳ����Ըı䡣

<hr>
</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 3 *****-->


<!--***** Begin Page 4 *****-->
<div style="width:624px">
<h2><i>���ʹ�</i></h2>
<hr>

���Լ����嵥DISC<sup>&reg;</sup> ʹ�����ܹ��ӵڶ�ҳ����������������ͬ�ĽǶȣ��������ǵ���Ϊ������ĸ�����ܣ�������ĸ����ܣ��Լ������ĸ���ۺϣ����ڶ�������£�����ͼ���ģʽ�����ƣ��ۺϵ�ͼ������ˡ����ܡ��͡���ܡ�����ϵĽ�������ԣ����ǽ����ڲ���ʱ��ʼ����ʹ���ۺ�ͼ��

<br><br>���ǣ�һЩ�˽��������ǵġ����ܡ��͡���ܡ�ͼ��ǳ���һ��������������£��ۺ�ͼ���Կ����ֳ�һ�����ǵ���Ϊ���Ŀɿ���ͼ������Ҫ�����������Ͳ��Թ��ߵ���Ҫ���������ǣ���ҲҪ���е�ע�⡰���ܡ��͡���ܡ���ͼ��

<br><br>��ס�������ܡ���ͼ������������Ϊ������ÿ���ʹ��ɹ�����Ϊ������ܡ���ͼ����������������Ȼ����Ϊ---�㱾���еĶ�����������ͼ��֮������˺ܴ�Ĳ�ͬʱ����;���Ϊ�˳ɹ��������Ϊ���㡰ͨ�����ı��ֱ���Ҫ������ͬ����ʹ����ۺ�ͼ��������Ҫ�Ľ����ʽ������ʹ�ò��Թ���ʱ��ҲҪ���������ܡ��͡���ܡ���ģʽ��������������������ͼ��֮�����Ϊ�ϵı仯��

<br><br><h2><i>���������Ҫ����Ϊ���</i></h2>

<br>
<table border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
		<td valign="top" align="center" width="120">
			<img src="disccomposite_small_withHPtsCircled.asp?nD1H=<%=CHPT(1)%>&amp;nD2H=<%=CHPT(2)%>&amp;nD3H=<%=CHPT(3)%>&amp;nD4H=<%=CHPT(4)%>&amp;nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" class="report_image" align="top" alt="" >
			<br >
		</td>
		<td valign="top">
			<br>ÿһ�ָ�����ĳ�̶ֳ��϶���������Ϊ�������ĸ�Ҫ�ء�<%=strUser2Name%>       , ���Ǵ�����˶����֣������ǵ���Ϊ�����˵��һ�����������ر��������ر��ֵø�ǿ�ҡ�ע�������ۺ�ͼ���Ϸ���Ȧ�ĵ㡣�����Ҫ�����<%=HighType1%>��

			<br><br>���漸ҳ���ῴ��������Щ������ϸ������Ϊ�˰��������Ч����⡢�ύ���ˣ�����Ҳ�����˶����������ص��ܵĿ�����
		</td>
	</tr>
</table>
<hr>
<font size=1>�������ݣ���Ȩ����<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> ȫȨ����.</font>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 4 *****-->


<!--***** Begin Page 5 *****-->
<h1>DISC<sup>&reg;</sup>����ʷ������</h1>
<hr>
������˹�ٲ�ʿ��20���ͳ����ױ��Ǵ�ѧ��һλ����ѧ�Һͽ��ڡ������������˵���Ϊ������ΪDISCФ��ϵͳ?�ṩ�˻�����ͨ���㷺���о�����������������Ϊ��������Ҫģʽ����������ģʽ���ڵĳ̶Ȳ�ͬ��

<br><br>��˹�ٵ�����˵��������ģʽ�ĳ���������ĳЩ�ؼ������صĶ�����ϡ�������˲���<em>���ڴ��£�</em>����<em>����Ϊ��</em>�������˵���һ�ַ����ǿ�����ڻ����ķ�Ӧ����Щ����<em>��������</em>��<em>������</em>��������Ӱ���ı��Լ��Ļ�����ʹ��������Ӧ���ǡ���һЩ�˱Ƚ�<em>���</em>�����������ڽ�����ʵ����ͼ�����еĻ����ھ����������Լ��Ĺ����������������������أ����¶�Ϊ�ˣ��������Ķ���͵ģ��Ϳ��԰����Ƿ����ĸ����ֵ�����֮һ��

<p class="aligncenter"><img src="images/arrow_chart_small.gif" alt="" width="456" height="280" ></p>

ע��֧���˵ģ�D��������ģ�C��������Ϊ�����Ǽ��ѵġ�����������ʱע����ʵ��

<br><br>���ǣ��ڼ��ѵ�����£�֧�䣨D���̶ȸߵ��˾ͱ�÷ǳ����������ƾ��棬�����澳������һ���棬����ĸ��Է�Ӧ���ǽ����ģ���ͼ��Ӧ���еĻ����������鷳���ͻ��

<br><br>�����������ذѻ��������ǻ����Ļ��Ѻõġ����ǵ�ע���������˺��˼ʹ�ϵ����Ӱ�����ģ�I�����Ե��������˵Ļ����ԣ�Ȱ˵���ǣ������ǽ�������������������ָ��Զ�������ķ�Ӧ�������ġ�̤ʵ�ģ�S���ĸ��Ը������ദ�᲻����ɫ����������֧�֣��϶��������±��ˡ�

<hr>
<font size=1>�������ݣ���Ȩ����<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> ȫȨ����.</font>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 5 *****-->


<!--***** Begin Page 6 *****-->
<h1>��Ϊ������</h1>
<% If Site = "TDG" Then %>
	<table border="1" cellpadding="5" cellspacing="0" width="600">
		<tr align="left" valign="top" cellpadding="0" cellspacing="0">
			<td>
				<img SRC="images/HighD.gif" width=280 height=152 alt="" border="0">
				<br><b>支配人的</b>
				<br><i>具有动力的关键：面对挑战</i>
				<br><i>基本的意图：<strong>克服困难</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Active and Task-oriented</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Welcomes difficult assignments and challenges</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Decisive</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Embraces change</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Individualistic</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Has little tolerance for feedback</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Doesn't encourage opposing views</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Has difficulty relinquishing control</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Needs to see clear progress</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Rarely shirks conflict</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Needs to be in charge</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Will sacrifice for the goal</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Takes risks</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Ready to accept bigger challenges</td></tr>
				</table>
			</td>
			<td>
				<img SRC="images/HighI.gif" width=280 height=152 alt="" border="0">
				<br><b>Influential</b>
				<br><i>Key to Motivation: Recognition</i>
				<br><i>Basic Intent: to <b>Persuade</b></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Active and relationship-oriented</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Quick to grasp big Dreams and their possibilities</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Receptive to change</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Needs approval of other people for self and the Dream</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Exhibits creative and innovative thinking</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Encourages input and ideas from others</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Proficient at communicating Dream to others</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Optimistic and enthusiastic</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Trusting</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Self-promoting</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Tends to oversell and underestimate difficulties</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Enthusiastic and positive even during difficult times</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>More effective at overcoming obstacles involving  people issues</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Believes passionately in the Dream</td></tr>
				</table>
			</td>
		</tr>
	</table>
<font size=1>�������ݣ���Ȩ����<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> ȫȨ����.</font>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>

<h1>Behavioral Characteristics continued</h1>
	<table border="1" cellpadding="5" cellspacing="0" width="600">
		<tr align="left" valign="top">
			<td>
				<img SRC="images/HighC.gif" width=280 height=150 alt="" border="0">
				<br><b>Conscientious</b>
				<br><i>Key to Motivation: Protection/Security</i>
				<br><i>Basic Intent: to <b>Be Correct</b></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Responsive and task-oriented</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Carefully weighs pros and cons before following the Dream</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Makes extensive plans and gathers information</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Creates an accurate and believable picture of the future</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Conveys level of expertise that fosters confidence in others</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Needs both internal and external assurance of the correctness of the Dream</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Risk-averse</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Questions and second-guesses decision when events don't follow well-laid plans</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Pessimistic and suspicious</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Anticipates eventualities and creates contingency plans</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Has difficulty turning the Dream over to others</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Motivated by excellence, accuracy, detail, quality</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Inspires by expertise and knowledge</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Sensitive to criticism of work</td></tr>
				</table>
			</td>
			<td>
				<img SRC="images/HighS.gif" width=280 height=150 alt="" border="0">
				<br><b>Steady</b>
				<br><i>Key to Motivation: Appreciation</i>
				<br><i>Basic Intent: to <b>Support</b></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Responsive and relationship-oriented</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Eager to serve, support, and collaborate</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Realistic and down-to-earth</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Strives to maintain status quo</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Requires time to adjust to change</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Needs support and approval of close friends, family, and associates</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Has a strong sense of possession and ownership regarding Dream</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Even-tempered</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Patient and persistent</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Conflict averse</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Identifies with group</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Eager to share glory with others</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Needs minimum risk and the assurance of support</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>Needs sincere appreciation for effort</td></tr>
				</table>
			</td>
		</tr>
	</table>
<% Else %>
	<table border="1" cellpadding="5" cellspacing="0" width="600">
		<tr align="left" valign="top" cellpadding="0" cellspacing="0">
			<td>
				<img SRC="images/HighD.gif" width=280 height=152 alt="" border="0">
				<br><b>֧���˵�</b>
				<br><i>���ж����Ĺؼ��������ս</i>
				<br><i>��������ͼ��<strong>�˷�����</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>ֱ�ӵģ�ֱ�ʵģ���ʱ����Ӳ��</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>ϲ���������ġ�����</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>����ս��ѹ��������ʱ��׳�ɳ�</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>���ţ�����Ҫ���Լ��ͱ���</td></tr>
				</table>
			</td>
			<td>
				<img SRC="images/HighI.gif" width=280 height=152 alt="" border="0">
				<br><b>��Ӱ������</b>
				<br><i>���ж����Ĺؼ��������Ͽ�</i>
				<br><i>��������ͼ��<strong>˵������</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>�Ѻõģ�����ģ�����˵������</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>���˸���Ȥ�����ţ��ܻ�ύİ����</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>����ύ�������ܿ��ơ�����ϸ��ʱ��׳�ɳ�</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>��������˺ϵ���</td></tr>
				</table>
			</td>
		</tr>
<!--
	</table>
<p style="page-break-after: always">&nbsp;</p>
	<table border="1" cellpadding="5" cellspacing="0" width="600">
-->
		<tr align="left" valign="top">
			<td>
				<img SRC="images/HighC.gif" width=280 height=128 alt="" border="0">
				<br><b>�����</b>
				<br><i>���ж����Ĺؼ�������/��ȫ</i>
				<br><i>��������ͼ��<strong>��ȷ</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>��ȷ�ģ�ע��ϸ�ڵģ�������</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>�����Ԥ����Ƶķ���������ʱ��׳�ɳ�</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>ϲ�����������ƻ��Ŀռ䣬��ϲ��ͻȻ�仯</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>��Ӧ����������ͻ�ͶԿ���Ǩ�ͱ���</td></tr>
				</table>
			</td>
			<td>
				<img SRC="images/HighS.gif" width=280 height=128 alt="" border="0">
				<br><b>̤ʵ��</b>
				<br><i>���ж����Ĺؼ���������</i>
				<br><i>��������ͼ��<strong>֧�ֱ���</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>����ģ���͵ģ����ĳ��ģ��Ѻõ�</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>�����º͵ġ������ֵġ������ϳ���ģ�����ͷ¶���</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>�����ɵġ��Ѻõġ�û��ѹ������������׳�ɳ�</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>��ϲ���仯��������ޣ�����̤ʵ������</td></tr>
				</table>
			</td>
		</tr>
	</table>
<% End If %>

</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 6 *****-->


<!--***** Begin Page 7 *****-->
<div style="width:624px">
<h2>��Ϊ���� </h2>
<hr>
<br>
<% If UCase(HighType1) = "D" Then %>
	<!-- <p class="aligncenter"><img src="images/pdi_overview_d.gif" alt="" width="480" height="287" /></p> -->
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr>
			<td valign="top" align="center" colspan="2"><span class="headertext2">֧���˵� ("D")</span></td>
		</tr>
		<tr>
			<td valign="top" align="right" width="35%"><strong>�����Ĵʣ�</strong></td>
			<td valign="top" align="left" width="65%">��ʹ�ģ�ָ�ӵ�</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>ǿ����</strong></td>
			<td valign="top" align="left">���ƻ������˷��ϰ���ȡ��Ԥ��Ľ��</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>���ж����Ĺؼ���</strong></td>
			<td valign="top" align="left">�����ս</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>��������ͼ��</strong></td>
			<td valign="top" align="left">�˷�����</td>
		</tr>
		<tr>
			<td valign="top" align="center" colspan="2"><img src="images/dominance.gif" alt="" width="370" height="213" ></td>
		</tr>
	</table>
	
	<br><br>��֧���˵ġ����������д������ˣ���������ʱ��չ�����������о������������׳�ɳ�����ͨ����ֱ�ӣ�������ֱ��---��ʱ��Ӳ����ϲ��������룬ϲ�����¡�
	
	<br><br>�����������ķ�������ȷ�ģ��ͻ����Ϊ�˷ܶ���������Ҳ�ܽ�����ʱ��ʧ�ܣ��������Ļ����������������й��£��ر�����ҵ���ڣ�����Ҳ���������Ҫ����ս�� ��ͻ����������
	
	<br><br>��֧���˵ġ������о����������ޣ��������أ���ѹ���������л��������ɾ͵�����£���׳�ɳ��������״�����㡣
	
	<br><br>����һ��ȷȷʵʵ�ĸ��������ߣ��ǳ��Ը����㡣����˶Լ�Ҫ��ܸߡ�
	
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- <p class="aligncenter"><img src="images/pdi_overview_i.gif" alt="" width="480" height="287" /></p> -->
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr>
			<td valign="top" align="center" colspan="2"><span class="headertext2">��Ӱ������ ("I")</span></td>
		</tr>
		<tr>
			<td valign="top" align="right" width="35%"><strong>�����Ĵʣ�</strong></td>
			<td valign="top" align="left" width="65%">���ڱ��ֵģ���˵������</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>ǿ����</strong></td>
			<td valign="top" align="left">���컷���������������������������</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>���ж����Ĺؼ���</strong></td>
			<td valign="top" align="left">���˳���</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>��������ͼ��</strong></td>
			<td valign="top" align="left">˵������</td>
		</tr>
		<tr>
			<td valign="top" align="center" colspan="2"><img src="images/influence.gif" alt="" width="331" height="209" ></td>
		</tr>
	</table>
	<br><br>����˵������һ�����������ύ�����и��˹�ϵ��û�п��ƣ�����ϸ�ڵ�����£���׳�ɳ�������˵���������˺��Ѻã�������˵���������š�
	
	<br><br>��Ļ�������Ȥ���ˡ���ܳ��ţ��ܻ��İ���˽ύ�����Ƕ���ķ�Ӧ����Ȼ����ͨ����ʵ���˺ܹ㷺���������ֹۣ����˴򽻵��м��ɣ������������������˶��ϵ�����������ľ��������ڡ�
	
	<br><br>����Ӱ���������˾�������ʱ�֣�����ĳЩ��֯��Ϊ�˸��˵������͵�λ��
	
	<br><br>
	
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- <p class="aligncenter"><img src="images/pdi_overview_s.gif" alt="" width="480" height="287" /></p> -->
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr>
			<td valign="top" align="center" colspan="2"><span class="headertext2">̤ʵ�� ("S")</span></td>
		</tr>
		<tr>
			<td valign="top" align="right" width="35%"><strong>�����Ĵʣ�</strong></td>
			<td valign="top" align="left" width="65%">���Ƶģ�֧�ֱ��˵�</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>ǿ����</strong></td>
			<td valign="top" align="left">ά�ֻ�������ɾ��������</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>���ж����Ĺؼ���</strong></td>
			<td valign="top" align="left">���</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>��������ͼ��</strong></td>
			<td valign="top" align="left">�ṩ֧��</td>
		</tr>
		<tr>
			<td valign="top" align="center" colspan="2"><img src="images/steadiness.gif" alt="" width="344" height="200" ></td>
		</tr>
	</table>
	<br><br>���ڡ�̤ʵ��һ�������׳�ɳ���������һ�����ɡ��Ѻá�û��ѹ�������գ�һ���ṩ��ȫ���з�Χ�޶ȣ��й�������ɹ��������������ա�

	<br><br>��ͨ�������Ƶģ���͵ģ����ĵģ��Ȱ���ͥ�ģ������˺����ദ�ġ�����һ����˵����������²���¶�����ҿ��ơ������������У���ʱ�Ļ�������

	<br><br>��������£���̤ʵ�����������ºͣ�����¶�Լ��������ϳ��죬������עĿ����һ����˵����״���㣬���˶Լ������

	<br><br>��̤ʵ�����˲�ϲ���仯��һ����ʼ��������ͺ�̤ʵ���������ġ��㲻ϲ��������ޡ���ͨ���൱ϲ��ռ�У�����Ķ�������ļ�ͥ����Ĳ��ţ����ְλ�����ĸ��顣

	<br><br>
<% ElseIf UCase(HighType1) = "C" then %>
	<!-- <p class="aligncenter"><img src="images/pdi_overview_c.gif" alt="" width="480" height="287" /></p> -->
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr>
			<td valign="top" align="center" colspan="2"><span class="headertext2">����� ("C")</span></td>
		</tr>
		<tr>
			<td valign="top" align="right" width="35%"><strong>�����Ĵʣ�</strong></td>
			<td valign="top" align="left" width="65%">�����ģ��з���������</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>ǿ����</strong></td>
			<td valign="top" align="left">���軷�����Ա㴴����ﵽ�߱�׼�Ĳ�Ʒ</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>���ж����Ĺؼ���</strong></td>
			<td valign="top" align="left">����/��ȫ</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>��������ͼ��</strong></td>
			<td valign="top" align="left">��ȷ</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>���£�</strong></td>
			<td valign="top" align="left">����������</td>
		</tr>
		<tr>
			<td valign="top" align="center" colspan="2"><img src="images/conscientiousness.gif" alt="" width="372" height="187" ></td>
		</tr>
	</table>
	<br><br>��Ϊһ�����߶����桱���ˣ������ͣ����ڴ��¡������������Ԥ����ƺõķ�������������û�г�ͻ�����գ����������ƻ��Ŀռ䣬û��ʲô�仯������£���׳�ɳ���

	<br><br>������˺ܾ�ȷ��ע��ϸ�ڡ���ϲ����Ӧ�����������ͻ�ͶԿ��������ұ�������Ҫ���ƶ���ÿ��һ�¾ͼ�¼�����Ķ���������ͼ�������������������顣

	<br><br>�㱾�Խ�������������֮ǰϲ�����ſ������򡣵��ǣ���һ�����˾������ͻ�ܼᶨ�ذ������¡�

	<br><br>
<% Else %>
	<br><br>Our database does not contain 
a valid predominant behavioral style for you. Please contact <!--#INCLUDE FILE="include/company_name.asp" -->.
<% End If %>
<hr>
<font size=1>�������ݣ���Ȩ����<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> ȫȨ����.</font>

</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 7 *****-->


<!--***** Begin Page 8 *****-->
<div style="width:624px">
<h1>�ŵ������</h1>
<hr>
<br>ÿ���˵��Ը��ж����ŵ�����㡣û��һ����Ϊ����������Ļ�����ġ���������ʲô��������ʺ����㡣���Գɳ��йؼ���һ����Ū�������������ŵ�����㣬�����Щ�ŵ�������໥�Ĺ�ϵ���ںܶ�����£����ǵ�������ǰ����ǵ��ŵ����򼫶ˡ����磬�������ܱ�ɹ�ִ���ֹۿ��ܱ�ɹ������š������������£�����һ��������ܸ���������Լ��һ���򵥡�

<br><br>�����оٵ��ŵ�������������㣺

	<div align="center">
		<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
			<tr>
				<td valign="top" align="center" width="33%">
					<img src="DISCComposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" >
					<br ><strong>�ۺ�ͼ��</strong>
				</td>
				<td valign="top" align="left" width="67%">
					<table border="0" cellspacing="0" cellpadding="6" width="100%">
						<tr>
							<td valign="top" align="left"><strong>�ŵ�</strong></td>
							<td valign="top" align="left"><strong>����</strong></td>
						</tr>
<% If UCase(HighType1) = "D" Then %>
						<tr>
							<td valign="top" align="left">���ϵ�</td>
							<td valign="top" align="left">�嶯��</td>
						</tr>
						<tr>
							<td valign="top" align="left">������</td>
							<td valign="top" align="left">���ŵ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">�����ĵ�</td>
							<td valign="top" align="left">�����ݵ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">�϶���</td>
							<td valign="top" align="left">�������۹��</td>
						</tr>
						<tr>
							<td valign="top" align="left">���ڲ�׽Ŀ���</td>
							<td valign="top" align="left">Ҫ����ߵ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">��������</td>
							<td valign="top" align="left">������</td>
						</tr>
						<tr>
							<td valign="top" align="left">��Ȩ���Ե�</td>
							<td valign="top" align="left">ר�ϵ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">������</td>
							<td valign="top" align="left">û���ĵ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">��ȡ��</td>
							<td valign="top" align="left">ר������</td>
						</tr>
						<tr>
							<td valign="top" align="left">̹�ϵ�</td>
							<td valign="top" align="left">��Ӳ��</td>
						</tr>
<% ElseIf UCase(HighType1) = "I" Then %>
						<tr>
							<td valign="top" align="left">�г���������</td>
							<td valign="top" align="left">�嶯��</td>
						</tr>
						<tr>
							<td valign="top" align="left">�����ĵ�</td>
							<td valign="top" align="left">���ڱ����</td>
						</tr>
						<tr>
							<td valign="top" align="left">��Զ����</td>
							<td valign="top" align="left">����ʵ��</td>
						</tr>
						<tr>
							<td valign="top" align="left">��˵������</td>
							<td valign="top" align="left">����Ϸ�绯��</td>
						</tr>
						<tr>
							<td valign="top" align="left">�ɽӽ���</td>
							<td valign="top" align="left">���ұ�����</td>
						</tr>
						<tr>
							<td valign="top" align="left">�����˵�</td>
							<td valign="top" align="left">���������˵�</td>
						</tr>
						<tr>
							<td valign="top" align="left">�ֹ۵�</td>
							<td valign="top" align="left">������������</td>
						</tr>
						<tr>
							<td valign="top" align="left">�̼���</td>
							<td valign="top" align="left">�Լ�̧���Լ���</td>
						</tr>
						<tr>
							<td valign="top" align="left">���ڽ�����</td>
							<td valign="top" align="left">��רע��</td>
						</tr>
<% ElseIf UCase(HighType1) = "S" Then %>
						<tr>
							<td valign="top" align="left">�����ĵ�</td>
							<td valign="top" align="left">������</td>
						</tr>
						<tr>
							<td valign="top" align="left">����������</td>
							<td valign="top" align="left">��׷����</td>
						</tr>
						<tr>
							<td valign="top" align="left">�򶨵�</td>
							<td valign="top" align="left">�����ڱ��ֵ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">ǰ��һ�µ�</td>
							<td valign="top" align="left">��ܳ�ͻ��</td>
						</tr>
						<tr>
							<td valign="top" align="left">Ͷ���</td>
							<td valign="top" align="left">�䵭��</td>
						</tr>
						<tr>
							<td valign="top" align="left">�к��ĵ�</td>
							<td valign="top" align="left">������̸��</td>
						</tr>
						<tr>
							<td valign="top" align="left">��������</td>
							<td valign="top" align="left">��ԥ������</td>
						</tr>
						<tr>
							<td valign="top" align="left">Ϊ�˷�����쵼</td>
							<td valign="top" align="left">����仯��</td>
						</tr>
						<tr>
							<td valign="top" align="left">ע��ʵ�ʵ�</td>
							<td valign="top" align="left">����Ϊ�ε�</td>
						</tr>
						<tr>
							<td valign="top" align="left">�����˵�</td>
							<td valign="top" align="left">ֻ�����µ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">����Լ����</td>
							<td valign="top" align="left">ȱ�������Ե�</td>
						</tr>
<% ElseIf UCase(HighType1) = "C" then %>
						<tr>
							<td valign="top" align="left">��ȷ��</td>
							<td valign="top" align="left">���ɵ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">��׼����</td>
							<td valign="top" align="left">������</td>
						</tr>
						<tr>
							<td valign="top" align="left">֪ʶ�ḻ��</td>
							<td valign="top" align="left">׿����Ⱥ��</td>
						</tr>
						<tr>
							<td valign="top" align="left">�����</td>
							<td valign="top" align="left">�������е�</td>
						</tr>
						<tr>
							<td valign="top" align="left">�����θе�</td>
							<td valign="top" align="left">��ë��õ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">�������ɵ�</td>
							<td valign="top" align="left">���õ�</td>
						</tr>
						<tr>
							<td valign="top" align="left">��Ϣ��ͨ��</td>
							<td valign="top" align="left">����ί�ɱ���</td>
						</tr>
						<tr>
							<td valign="top" align="left">���׵�</td>
							<td valign="top" align="left">��ԥ������</td>
						</tr>
						<tr>
							<td valign="top" align="left">�����</td>
							<td valign="top" align="left">�����</td>
						</tr>
						<tr>
							<td valign="top" align="left">��ϵͳ�Ե�</td>
							<td valign="top" align="left">���۵�</td>
						</tr>
<% End If %>
					</table>
				</td>
			</tr>
		</table>
</div>

<br><br>1��	��ϰ�����оٵĴʡ����ǵ������ڵ�״��������������Щ�д���ġ����ڵĸı䣬�Ա����Ч����������ŵ㣿

<br >
<ul style="LIST-STYLE-TYPE: none">
	<li>
	<!--#INCLUDE FILE="include/divider.asp" --><br >
	<!--#INCLUDE FILE="include/divider.asp" --><br >
	<!--#INCLUDE FILE="include/divider.asp" --><br >
	</li>
</ul>
<hr>

</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 8 *****-->


<!--***** Begin Page 9 *****-->
<div style="width:624px">
<h2><i>DISC<sup>&reg;</sup>���Ժ�гģ��</i></h2>
<hr>

<br><br>ǰ�����ѿ�������ͬ���Է��������ɺ�г���ͻ��Ǳ�ڿ����ԡ�����ģ����Ȼ����һ�ɲ���ģ��������Ǳ�������ͬ�ĸ��Է���ڴ��º�Ϊ���ϵĺ�г�ԣ��Դӡ��š�������ĳ߶Ⱥ������ǡ�

<br><br>���ȣ�����������һ��Ϊ�˵ĺ�г�ԡ������ĺ���ͨ�������£��������·����ô���໥��ϵ�أ����磬����һλͬ�¸�����ͬһ���Ź������������ϼ��ٽ���������θ���λͬ���ദ�أ����ߣ������ͬ���ҵ����ദ�ľ����У���Щ���������˸��˵ģ���Щ����������ģ���ϵ�ĺ�г�漰��ĳ�ֹ�ϵ���ص㣬���ֹ�ϵҲ�������ģ�Ҳ�������ܵġ�

<br><br><strong>Ϊ�˵ĺ�г</strong>

<br><br>
<table border="1" width="600" cellpadding="1" cellspacing="1">
	<tr>
		<td><strong>&nbsp;</strong></td>
		<td><strong>D֧��</strong></td>
		<td><strong>IӰ��</strong></td>
		<td><strong>S̤ʵ</strong></td>
		<td><strong>C����</strong></td>
	</tr>
	<tr>
		<td><strong>D֧��</strong></td>
		<td>��</td>
		<td>��</td>
		<td>�Ϻ�</td>
		<td>��</td>
	</tr>
	<tr>
		<td><strong>IӰ��</strong></td>
		<td>��</td>
		<td>��</td>
		<td>�Ϻ�</td>
		<td>��</td>
	</tr>
	<tr>
		<td><strong>S̤ʵ</strong></td>
		<td>�Ϻ�</td>
		<td>�Ϻ�</td>
		<td>��</td>
		<td>��</td>
	</tr>
	<tr>
		<td><strong>C����</strong></td>
		<td>��</td>
		<td>��</td>
		<td>��</td>
		<td>��</td>
	</tr>
</table>

<br><br>���棬�������������µĺ�г�ԡ���Ϊ�˵ĺ�г�������е��µ�ĳЩ��������ڴ��µĺ�г���ϱ��ּ��ѡ�����ĳ����Ŀ�����˺����ü��ã������Ҳ��������Ϣһ�¡�

<br><br><strong>���µĺ�г</strong>

<table border="1" width="600" cellpadding="1" cellspacing="1">
	<tr>
		<td><strong>&nbsp;</strong></td>
		<td><strong>D֧��</strong></td>
		<td><strong>IӰ��</strong></td>
		<td><strong>S̤ʵ</strong></td>
		<td><strong>C����</strong></td>
	</tr>
	<tr>
		<td><strong>D֧��</strong></td>
		<td>�Ϻ�</td>
		<td>�Ϻ�</td>
		<td>��</td>
		<td>�Ϻ�</td>
	</tr>
	<tr>
		<td><strong>IӰ��</strong></td>
		<td>�Ϻ�</td>
		<td>��</td>
		<td>��</td>
		<td>��</td>
	</tr>
	<tr>
		<td><strong>S̤ʵ</strong></td>
		<td>��</td>
		<td>��</td>
		<td>��</td>
		<td>��</td>
	</tr>
	<tr>
		<td><strong>C����</strong></td>
		<td>�Ϻ�</td>
		<td>��</td>
		<td>��</td>
		<td>��</td>
	</tr>
</table>
<br><hr>
<font size=1>�������ݣ���Ȩ����<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> ȫȨ����.</font>

</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 9 *****-->


<!--***** Begin Page 10 *****-->
<div style="width:624px">
<h2><i>�ڽ�����Ҫ��</i></h2>
<hr>
<p><h1 align="center">ʲô�������·��</h1>
<P></P>

�������˽��������ĸ��Է�񣬿�������Щ��������໥��ϵ��������ѧ�Ÿ���ͬ������˽��н�����

<br><br>
<table border="1" width="600" cellpadding="1" cellspacing="1">
	<tr>
		<td valign="top">
			<ul>
				<img SRC="images/HighDLetter.gif" width=70 height=70 alt="" border="0">
				<li class="smallFont">��� 
        
				<li class="smallFont">ץס���� 
        
				<li class="smallFont">����֯�ƻ����� 
        
				<li class="smallFont">ע������ 
        
				<li class="smallFont">����˵������ 
        
				<li class="smallFont">�������ѡ�� 
        
				<li class="smallFont">���� 
        
				<li class="smallFont">Ȩ�� 
        
				<li class="smallFont">���¹����̬�� 
        
				<li class="smallFont">��Ч����ʱ�䣨���������ᣩ 
        
				<li class="smallFont">������������ 
        
				<li class="smallFont">ע�ؽ�� 
        
				<li class="smallFont">���߼���</li>
			</ul>
		</td>
		<td valign="top">
			<ul>
				<img SRC="images/HighILetter.gif" width=70 height=70 alt="" border="0">
				<li class="smallFont">���� 
        
				<li class="smallFont">�д����� 
        
				<li class="smallFont">������ʢ���������Ѻ� 
        
				<li class="smallFont">����ܶ෴������ 
        
				<li class="smallFont">��ȷ�����͸��� 
        
				<li class="smallFont">�����͸����Ͽ���ϵ���� 
        
				<li class="smallFont">��Ĭ 
        
				<li class="smallFont">��ʱ���̬����� 
        
				<li class="smallFont">ץס�˵�ע���� 
        
				<li class="smallFont">�����ڴ�� 
        
				<li class="smallFont">�ο����˵ķ�Ӧ 
        
				<li class="smallFont">��������עĿ 
        
				<li class="smallFont">���˵��ƹʺܶ� 
        
				<li class="smallFont">�����ڡ���Ӱ�����ġ������ع����Ҫ</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<ul>
				<img SRC="images/HighCLetter.gif" width=70 height=70 alt="" border="0">
				<li class="smallFont">����ʵ������ 
        
				<li class="smallFont">�������۵�ʱ�����Ϣ�ܶ� 
        
				<li class="smallFont">�������� 
        
				<li class="smallFont">�Է��յ�������� 
        
				<li class="smallFont">�������Ľ���������Ϳ�ͷ�� 
        
				<li class="smallFont">�Ը��˵Ĺ�ע 
        
				<li class="smallFont">�Թ������������ 
        
				<li class="smallFont">����ԭ�� 
        
				<li class="smallFont">Ѱ����ȷ�ġ�����ѵġ��� 
        
				<li class="smallFont">׷��ܳ���׼ȷ��ϸ�ڡ����� 
        
				<li class="smallFont">���˼��ϸ�¡������� 
        
				<li class="smallFont">���򡢷��롢�涨���� 
        
				<li class="smallFont">��ֿ�� 
        
				<li class="smallFont">����׼ȷ</li>
			</ul>
		</td>
		<td valign="top">
			<ul>
				<img SRC="images/HighSLetter.gif" width=70 height=70 alt="" border="0">
				<li class="smallFont">�����Ͽ� 
        
				<li class="smallFont">��ͳʽ�ġ��͵��ı��� 
        
				<li class="smallFont">���������Ϸ�����ϵ���� 
        
				<li class="smallFont">���߼��ԣ�����ʵ��ע��ṹ 
        
				<li class="smallFont">����ϸ����΢ 
        
				<li class="smallFont">�ṩ�����ͱ�֤ 
        
				<li class="smallFont">��������ر��ֳ���ͬ�Ĳ��ֺ͹۵�������ϵ��һ�� 
        
				<li class="smallFont">��Ҫ���˵Ŀ϶� 
        
				<li class="smallFont">��֤�ṩ֧�� 
        
				<li class="smallFont">ע�ظ��������ǵ���ϵ 
        
				<li class="smallFont">û������ 
        
				<li class="smallFont">���˺͹����Ĺ�ϵ��ע�� 
        
				<li class="smallFont">�����ڡ�̤ʵ�ġ��˶԰�ȫ���ȶ�����Ҫ</li>
			</ul>
		</td>
	</tr>
</table>

</div>
<!--***** End Page 10 *****-->

<!--************* E N D  R E P O R T *************-->
</body>
</HTML>