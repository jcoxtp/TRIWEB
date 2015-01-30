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
<h1>个性鉴别清单DISC<sup>&reg;</sup></h1>

<h2><i>增强个人的有效能力</i></h2>

<p><hr>

<P></P>
<p>
<% If Site = "TDG" Then %>
	<img class="report_image_left" align="left" src="images/TakingDISC_TDG.gif"  alt="" >
<% Else %>
	<img class="report_image_left" align="left" src="images/TakingDISC.gif"  alt="" >
<% End If %>

我们每个人都有优点和弱点，这些优点和弱点使我们在一些场合下行事比较得力，而在另一些场合下行事又不太得力。其实，决定领导的才能和个人的有效能力的方法往往是看在某些情况下能否发挥个人的优点。个人的技巧和优点发挥得越好，成就可能就越高。

<br><br>如果有能力预见在某种情况下我们跟其他人如何交往联系，这对于我们跟其他人一起工作、跟他们交流、为他们服务、并且影响他们，具有不可估量的价值。

<br><br>行为受一系列复杂因素的影响，这些因素包括基本的个性或性情，现时的情感和身体状态，我们的技巧，经验，价值观，智能，以及个人的动力。这些因素以及许多其他因素对于行为有着直接和间接的作用。

<br><br>我们很多人都了解到，如果我们对自己和别人知晓得越多，我们就能更好地预测人的行为表现，因此，我们就能更好地与别人交往，为其服务。个性鉴别清单DISC<sup>&reg;</sup> 有助于我们理解人们的行为表现为什么不同，如何不同。

<br><br>个性鉴别清单DISC<sup>&reg;</sup> 将使你明确了解你是如何看待自己的，你想让别人如何看待你。经过这个过程后，你将认识真实的你---一个也许与你的想象略有不同的人。

<hr>
<font size=1>所有内容，版权所有<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> 全权所有.</font>
</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 2 *****-->


<!--***** Begin Page 3 *****-->
<div style="width:624px">
<h1>你个人的DISC<sup>&reg;</sup>档案</h1>
<h2><i>从三个不同的角度看人的行为</i></h2>
<hr>
<%=strUser2Name%>, 下面是你的个性鉴别清单的得分。运用你给予的答案分别绘制了三个图表，每一个图表从一个明确不同的角度探讨你的行为表现。

<br><br>
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="85%">
	<tr>
		<td align="center" width="33%"><strong>最能</strong></td>
		<td align="center" width="33%"><strong>最不能</strong></td>
		<td align="center" width="34%"><strong>综合</strong></td>
	</tr>
	<tr>
		<td align="center">
			<img src="discmost_small.asp?nD1=<%=nM1%>&amp;nD2=<%=nM2%>&amp;nD3=<%=nM3%>&amp;nD4=<%=nM4%>" alt="" >
			<br ><span class="captiontext"><strong>I. 设想的概念</strong></span>
		</td>
		<td align="center">
			<img src="discleast_small.asp?nD1=<%=nL1%>&amp;nD2=<%=nL2%>&amp;nD3=<%=nL3%>&amp;nD4=<%=nL4%>" alt="" >
			<br ><span class="captiontext"><strong>II.自身的概念</strong></span>
		</td>
		<td align="center">
			<img src="disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" >
			<br ><span class="captiontext"><strong>III. 公开的概念</strong></span>
		</td>
	</tr>
</table>
</div>

<br><br><strong>I. 设想的概念</strong>（“最能”的回答）：设想的概念所体现的是你认为别人希望你如何行事，或者你想让他们如何看待你。这是人们为了取得成功所带的“面具。”你的“设想的概念”的根源在于你从孩童到青年时期所经历过的一切：家庭，朋友，受的教育，和宗教。到达青年时期后，大部分人都想好了为了从生活中获取，自己必须怎样行事，这种行事的方式便是他们的“设想的概念。”

<br><br><strong>II．自身的概念</strong>（“最不能”的回答）：这是你自然的行为表现---你的本性。这种行为是遗传和童年环境的产物。人们在轻松的场合下（在家里或跟朋友在一起）表现出这种行为，因为这时候人们没有必要带上设想的概念的“面具，”或者在压力很大的情况下也表现出这种行为，因为这时候带面具过于吃力。

<br><br><strong>III．公开的概念</strong>（综合）：综合的图表所代表的是自身和设想的概念的最后的结果，极为清楚地表现了其他人是怎么看待你的。注意到既然自身（最不能）的概念设立于孩童时期，设想（最能）的概念开始于青年时期，那么“综合”行为的设立也相对较早。因此，当我们到达成年后，根深蒂固的行为非常难以改变。

<hr>
</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 3 *****-->


<!--***** Begin Page 4 *****-->
<div style="width:624px">
<h2><i>解释答案</i></h2>
<hr>

个性鉴别清单DISC<sup>&reg;</sup> 使我们能够从第二页上所见到的三个不同的角度，观照我们的行为：设想的概念（最能），自身的概念（最不能）以及公开的概念（综合）。在多数情况下，三个图表的模式相类似，综合的图表代表了“最能”和“最不能”的组合的结果。所以，我们建议在测试时自始至终使用综合图表。

<br><br>但是，一些人将发现他们的“最能”和“最不能”图表非常不一样。在这种情况下，综合图表仍可显现出一张他们的行为风格的可靠的图画，你要把它当作解释测试工具的首要方法。但是，你也要密切地注意“最能”和“最不能”的图表。

<br><br>记住，“最能”的图表所描述的行为是你觉得可以使你成功的行为。“最不能”的图表所描述的是你自然的行为---你本性中的东西。当两个图表之间出现了很大的不同时，你就觉得为了成功，你的行为跟你“通常”的表现必须要有所不同。即使你把综合图表当作你主要的解读方式，你在使用测试工具时，也要看看“最能”和“最不能”的模式。这样会帮助你理解两个图表之间的行为上的变化。

<br><br><h2><i>发现你的主要的行为风格</i></h2>

<br>
<table border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
		<td valign="top" align="center" width="120">
			<img src="disccomposite_small_withHPtsCircled.asp?nD1H=<%=CHPT(1)%>&amp;nD2H=<%=CHPT(2)%>&amp;nD3H=<%=CHPT(3)%>&amp;nD4H=<%=CHPT(4)%>&amp;nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" class="report_image" align="top" alt="" >
			<br >
		</td>
		<td valign="top">
			<br>每一种个性在某种程度上都包含着行为的所有四个要素。<%=strUser2Name%>       , 我们大多数人都发现，就我们的行为风格来说，一个或两个因素比其他因素表现得更强烈。注意左侧的综合图表上方划圈的点。你的主要风格是<%=HighType1%>。

			<br><br>下面几页里，你会看到对于这些风格的详细描述。为了帮助你更有效地理解、结交他人，这里也包括了对于其他因素的总的看法。
		</td>
	</tr>
</table>
<hr>
<font size=1>所有内容，版权所有<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> 全权所有.</font>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 4 *****-->


<!--***** Begin Page 5 *****-->
<h1>DISC<sup>&reg;</sup>的历史和理论</h1>
<hr>
威廉马斯顿博士是20世纪初哥伦比亚大学的一位心理学家和教授。他所创立的人的行为的理论为DISC肖像系统?提供了基础。通过广泛的研究，他辨认了人们行为的四种主要模式，但是四种模式存在的程度不同。

<br><br>马斯顿的理论说，这四种模式的出现是由于某些关键的因素的多种组合。大多数人不是<em>善于处事，</em>就是<em>善于为人</em>。描述人的另一种方法是看其对于环境的反应。有些人是<em>有主见的</em>或<em>主动的</em>；他们想影响或改变自己的环境，使环境更适应他们。另一些人比较<em>随和</em>；他们倾向于接受事实，试图在现有的环境内尽可能做好自己的工作。我们运用这四种因素：处事对为人，有主见的对随和的，就可以把人们放在四个部分的其中之一。

<p class="aligncenter"><img src="images/arrow_chart_small.gif" alt="" width="456" height="280" ></p>

注意支配人的（D）和认真的（C）个性认为环境是艰难的。他们做决定时注重事实。

<br><br>但是，在艰难的情况下，支配（D）程度高的人就变得非常主动，控制局面，冲破逆境。在另一方面，认真的个性反应会是谨慎的，试图适应现有的环境，避免麻烦或冲突。

<br><br>其他两个因素把环境看成是积极的或友好的。他们的注意力在于人和人际关系。有影响力的（I）个性调动其他人的积极性，劝说他们，跟他们交往充满活力，因而这种个性对于事情的反应是主动的。踏实的（S）的个性跟别人相处会不动声色；他们善于支持，肯定并且体谅别人。

<hr>
<font size=1>所有内容，版权所有<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> 全权所有.</font>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 5 *****-->


<!--***** Begin Page 6 *****-->
<h1>行为的特征</h1>
<% If Site = "TDG" Then %>
	<table border="1" cellpadding="5" cellspacing="0" width="600">
		<tr align="left" valign="top" cellpadding="0" cellspacing="0">
			<td>
				<img SRC="images/HighD.gif" width=280 height=152 alt="" border="0">
				<br><b>鏀厤浜虹殑</b>
				<br><i>鍏锋湁鍔ㄥ姏鐨勫叧閿細闈㈠鎸戞垬</i>
				<br><i>鍩烘湰鐨勬剰鍥撅細<strong>鍏嬫湇鍥伴毦</strong></i>
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
<font size=1>所有内容，版权所有<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> 全权所有.</font>
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
				<br><b>支配人的</b>
				<br><i>具有动力的关键：面对挑战</i>
				<br><i>基本的意图：<strong>克服困难</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>直接的，直率的，有时是生硬的</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>喜欢居于中心、管事</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>有挑战、压力和困难时茁壮成长</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>自信，严于要求自己和别人</td></tr>
				</table>
			</td>
			<td>
				<img SRC="images/HighI.gif" width=280 height=152 alt="" border="0">
				<br><b>有影响力的</b>
				<br><i>具有动力的关键：被人认可</i>
				<br><i>基本的意图：<strong>说服别人</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>友好的，外向的，具有说服力的</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>对人感兴趣，沉着，很会结交陌生人</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>有社会交往、不受控制、不讲细节时茁壮成长</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>跟大多数人合得来</td></tr>
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
				<br><b>认真的</b>
				<br><i>具有动力的关键：保护/安全</i>
				<br><i>基本的意图：<strong>正确</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>精确的，注重细节的，谨慎的</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>有命令、预先设计的方法、先例时茁壮成长</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>喜欢有认真作计划的空间，不喜欢突然变化</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>适应情况，避免冲突和对抗，迁就别人</td></tr>
				</table>
			</td>
			<td>
				<img SRC="images/HighS.gif" width=280 height=128 alt="" border="0">
				<br><b>踏实的</b>
				<br><i>具有动力的关键：理解别人</i>
				<br><i>基本的意图：<strong>支持别人</strong></i>
				<table border="0" cellpadding="3" cellspacing="0" width="95%" align="center">
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>善意的，随和的，热心肠的，友好的</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>性情温和的、不表现的、感情上成熟的，不抛头露面的</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>在轻松的、友好的、没有压力的气氛中茁壮成长</td></tr>
					<tr><td>&nbsp;&#8226;&nbsp;&nbsp;</td><td>不喜欢变化和最后期限，工作踏实、耐心</td></tr>
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
<h2>行为特征 </h2>
<hr>
<br>
<% If UCase(HighType1) = "D" Then %>
	<!-- <p class="aligncenter"><img src="images/pdi_overview_d.gif" alt="" width="480" height="287" /></p> -->
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr>
			<td valign="top" align="center" colspan="2"><span class="headertext2">支配人的 ("D")</span></td>
		</tr>
		<tr>
			<td valign="top" align="right" width="35%"><strong>其他的词：</strong></td>
			<td valign="top" align="left" width="65%">驱使的，指挥的</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>强调：</strong></td>
			<td valign="top" align="left">控制环境，克服障碍来取得预想的结果</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>具有动力的关键：</strong></td>
			<td valign="top" align="left">面对挑战</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>基本的意图：</strong></td>
			<td valign="top" align="left">克服困难</td>
		</tr>
		<tr>
			<td valign="top" align="center" colspan="2"><img src="images/dominance.gif" alt="" width="370" height="213" ></td>
		</tr>
	</table>
	
	<br><br>“支配人的”这组人是有创建的人，困难重重时开展工作。你在有竞争的情况下茁壮成长，你通常很直接，积极，直率---有时生硬。你喜欢身居中央，喜欢管事。
	
	<br><br>你如果觉得你的方法是正确的，就会竭力为此奋斗，但是你也能接受暂时的失败，而不会心怀不满。你讨厌例行公事，特别在事业早期，如果找不到你所需要的挑战， 你就会更换工作。
	
	<br><br>“支配人的”人在有竞争，任务艰巨，工作繁重，有压力，个人有机会有所成就的情况下，茁壮成长。你对现状不满足。
	
	<br><br>你是一个确确实实的个人主义者，非常自给自足。你对人对己要求很高。
	
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- <p class="aligncenter"><img src="images/pdi_overview_i.gif" alt="" width="480" height="287" /></p> -->
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr>
			<td valign="top" align="center" colspan="2"><span class="headertext2">有影响力的 ("I")</span></td>
		</tr>
		<tr>
			<td valign="top" align="right" width="35%"><strong>其他的词：</strong></td>
			<td valign="top" align="left" width="65%">善于表现的，有说服力的</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>强调：</strong></td>
			<td valign="top" align="left">创造环境，激发、联合他人来完成任务</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>具有动力的关键：</strong></td>
			<td valign="top" align="left">被人承认</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>基本的意图：</strong></td>
			<td valign="top" align="left">说服别人</td>
		</tr>
		<tr>
			<td valign="top" align="center" colspan="2"><img src="images/influence.gif" alt="" width="331" height="209" ></td>
		</tr>
	</table>
	<br><br>“有说服力”一组的人在有社会交往，有个人关系，没有控制，不讲细节的情况下，茁壮成长。“有说服力”的人很友好，外向，有说服力，自信。
	
	<br><br>你的基本的兴趣是人。你很沉着，很会跟陌生人结交。人们对你的反应很自然，你通常结实的人很广泛。你生性乐观，跟人打交道有技巧，这有助于你跟大多数人都合得来，包括你的竞争者在内。
	
	<br><br>“有影响力”的人经常穿着时髦，加入某些组织是为了个人的荣誉和地位。
	
	<br><br>
	
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- <p class="aligncenter"><img src="images/pdi_overview_s.gif" alt="" width="480" height="287" /></p> -->
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr>
			<td valign="top" align="center" colspan="2"><span class="headertext2">踏实的 ("S")</span></td>
		</tr>
		<tr>
			<td valign="top" align="right" width="35%"><strong>其他的词：</strong></td>
			<td valign="top" align="left" width="65%">友善的，支持别人的</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>强调：</strong></td>
			<td valign="top" align="left">维持环境，完成具体的任务</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>具有动力的关键：</strong></td>
			<td valign="top" align="left">理解</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>基本的意图：</strong></td>
			<td valign="top" align="left">提供支持</td>
		</tr>
		<tr>
			<td valign="top" align="center" colspan="2"><img src="images/steadiness.gif" alt="" width="344" height="200" ></td>
		</tr>
	</table>
	<br><br>属于“踏实”一组的人茁壮成长的气氛是一个轻松、友好、没有压力的气氛，一个提供安全，有范围限度，有惯例，完成工作有荣誉的气氛。

	<br><br>你通常是友善的，随和的，热心的，热爱家庭的，跟别人和睦相处的。从另一方面说，你可能有事不外露，自我控制。你隐藏你的情感，有时心怀不满。

	<br><br>多数情况下，“踏实”的人性情温和，不显露自己，感情上成熟，不引人注目。你一般来说对现状满足，对人对己都宽厚。

	<br><br>“踏实”的人不喜欢变化。一旦开始工作，你就很踏实，很有耐心。你不喜欢最后期限。你通常相当喜欢占有，对你的东西，你的家庭，你的部门，你的职位有深厚的感情。

	<br><br>
<% ElseIf UCase(HighType1) = "C" then %>
	<!-- <p class="aligncenter"><img src="images/pdi_overview_c.gif" alt="" width="480" height="287" /></p> -->
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr>
			<td valign="top" align="center" colspan="2"><span class="headertext2">认真的 ("C")</span></td>
		</tr>
		<tr>
			<td valign="top" align="right" width="35%"><strong>其他的词：</strong></td>
			<td valign="top" align="left" width="65%">谨慎的，有分析能力的</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>强调：</strong></td>
			<td valign="top" align="left">建设环境，以便创造出达到高标准的产品</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>具有动力的关键：</strong></td>
			<td valign="top" align="left">保护/安全</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>基本的意图：</strong></td>
			<td valign="top" align="left">正确</td>
		</tr>
		<tr>
			<td valign="top" align="right"><strong>最怕：</strong></td>
			<td valign="top" align="left">出错，犯错误</td>
		</tr>
		<tr>
			<td valign="top" align="center" colspan="2"><img src="images/conscientiousness.gif" alt="" width="372" height="187" ></td>
		</tr>
	</table>
	<br><br>作为一个“高度认真”的人，你很随和，善于处事。你在有命令，有预先设计好的方法，有先例，没有冲突的气氛，有认真作计划的空间，没有什么变化的情况下，茁壮成长。

	<br><br>认真的人很精确，注重细节。你喜欢适应环境，避免冲突和对抗。你自我保护的需要是推动你每做一事就记录下来的动力，你试图做别人想让你做的事情。

	<br><br>你本性谨慎，在做决定之前喜欢等着看看风向。但是，你一旦做了决定，就会很坚定地按章行事。

	<br><br>
<% Else %>
	<br><br>Our database does not contain 
a valid predominant behavioral style for you. Please contact <!--#INCLUDE FILE="include/company_name.asp" -->.
<% End If %>
<hr>
<font size=1>所有内容，版权所有<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> 全权所有.</font>

</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 7 *****-->


<!--***** Begin Page 8 *****-->
<div style="width:624px">
<h1>优点和弱点</h1>
<hr>
<br>每个人的性格中都有优点和弱点。没有一种行为风格是完美的或理想的。不论你是什么风格，它最适合于你。个性成长中关键的一步是弄清楚我们自身的优点和弱点，理解这些优点和弱点相互的关系。在很多情况下，我们的弱点就是把我们的优点拉向极端。比如，毅力可能变成固执，乐观可能变成过于自信。在这种情形下，消除一个弱点可能跟进行自我约束一样简单。

<br><br>下面列举的优点和弱点适用于你：

	<div align="center">
		<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
			<tr>
				<td valign="top" align="center" width="33%">
					<img src="DISCComposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" >
					<br ><strong>综合图表</strong>
				</td>
				<td valign="top" align="left" width="67%">
					<table border="0" cellspacing="0" cellpadding="6" width="100%">
						<tr>
							<td valign="top" align="left"><strong>优点</strong></td>
							<td valign="top" align="left"><strong>弱点</strong></td>
						</tr>
<% If UCase(HighType1) = "D" Then %>
						<tr>
							<td valign="top" align="left">果断的</td>
							<td valign="top" align="left">冲动的</td>
						</tr>
						<tr>
							<td valign="top" align="left">开创的</td>
							<td valign="top" align="left">威吓的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有信心的</td>
							<td valign="top" align="left">不宽容的</td>
						</tr>
						<tr>
							<td valign="top" align="left">肯定的</td>
							<td valign="top" align="left">有批评眼光的</td>
						</tr>
						<tr>
							<td valign="top" align="left">善于捕捉目标的</td>
							<td valign="top" align="left">要求过高的</td>
						</tr>
						<tr>
							<td valign="top" align="left">表达清楚的</td>
							<td valign="top" align="left">对立的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有权威性的</td>
							<td valign="top" align="left">专断的</td>
						</tr>
						<tr>
							<td valign="top" align="left">积极的</td>
							<td valign="top" align="left">没耐心的</td>
						</tr>
						<tr>
							<td valign="top" align="left">进取的</td>
							<td valign="top" align="left">专横跋扈的</td>
						</tr>
						<tr>
							<td valign="top" align="left">坦诚的</td>
							<td valign="top" align="left">生硬的</td>
						</tr>
<% ElseIf UCase(HighType1) = "I" Then %>
						<tr>
							<td valign="top" align="left">有超凡魅力的</td>
							<td valign="top" align="left">冲动的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有信心的</td>
							<td valign="top" align="left">浮于表面的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有远见的</td>
							<td valign="top" align="left">不现实的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有说服力的</td>
							<td valign="top" align="left">过分戏剧化的</td>
						</tr>
						<tr>
							<td valign="top" align="left">可接近的</td>
							<td valign="top" align="left">自我保护的</td>
						</tr>
						<tr>
							<td valign="top" align="left">鼓励人的</td>
							<td valign="top" align="left">过于信任人的</td>
						</tr>
						<tr>
							<td valign="top" align="left">乐观的</td>
							<td valign="top" align="left">不善于聆听的</td>
						</tr>
						<tr>
							<td valign="top" align="left">刺激的</td>
							<td valign="top" align="left">自己抬高自己的</td>
						</tr>
						<tr>
							<td valign="top" align="left">善于交流的</td>
							<td valign="top" align="left">不专注的</td>
						</tr>
<% ElseIf UCase(HighType1) = "S" Then %>
						<tr>
							<td valign="top" align="left">有耐心的</td>
							<td valign="top" align="left">自满的</td>
						</tr>
						<tr>
							<td valign="top" align="left">善于聆听的</td>
							<td valign="top" align="left">不追究的</td>
						</tr>
						<tr>
							<td valign="top" align="left">镇定的</td>
							<td valign="top" align="left">不善于表现的</td>
						</tr>
						<tr>
							<td valign="top" align="left">前后一致的</td>
							<td valign="top" align="left">躲避冲突的</td>
						</tr>
						<tr>
							<td valign="top" align="left">投入的</td>
							<td valign="top" align="left">冷淡的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有恒心的</td>
							<td valign="top" align="left">不善言谈的</td>
						</tr>
						<tr>
							<td valign="top" align="left">可依赖的</td>
							<td valign="top" align="left">犹豫不决的</td>
						</tr>
						<tr>
							<td valign="top" align="left">为人服务的领导</td>
							<td valign="top" align="left">讨厌变化的</td>
						</tr>
						<tr>
							<td valign="top" align="left">注重实际的</td>
							<td valign="top" align="left">画地为牢的</td>
						</tr>
						<tr>
							<td valign="top" align="left">容纳人的</td>
							<td valign="top" align="left">只会做事的</td>
						</tr>
						<tr>
							<td valign="top" align="left">自我约束的</td>
							<td valign="top" align="left">缺乏主动性的</td>
						</tr>
<% ElseIf UCase(HighType1) = "C" then %>
						<tr>
							<td valign="top" align="left">精确的</td>
							<td valign="top" align="left">怀疑的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有准备的</td>
							<td valign="top" align="left">消极的</td>
						</tr>
						<tr>
							<td valign="top" align="left">知识丰富的</td>
							<td valign="top" align="left">卓而不群的</td>
						</tr>
						<tr>
							<td valign="top" align="left">认真的</td>
							<td valign="top" align="left">过于敏感的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有责任感的</td>
							<td valign="top" align="left">吹毛求疵的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有条不紊的</td>
							<td valign="top" align="left">推诿的</td>
						</tr>
						<tr>
							<td valign="top" align="left">信息灵通的</td>
							<td valign="top" align="left">不能委派别人</td>
						</tr>
						<tr>
							<td valign="top" align="left">彻底的</td>
							<td valign="top" align="left">犹豫不决的</td>
						</tr>
						<tr>
							<td valign="top" align="left">热情的</td>
							<td valign="top" align="left">内向的</td>
						</tr>
						<tr>
							<td valign="top" align="left">有系统性的</td>
							<td valign="top" align="left">悲观的</td>
						</tr>
<% End If %>
					</table>
				</td>
			</tr>
		</table>
</div>

<br><br>1．	复习以上列举的词。考虑到你现在的状况，你能作出那些有创意的、短期的改变，以便更有效地利用你的优点？

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
<h2><i>DISC<sup>&reg;</sup>个性和谐模型</i></h2>
<hr>

<br><br>前面你已看到，不同个性风格的组合造成和谐或冲突的潜在可能性。下列模型虽然不是一成不变的，但是它们表明，不同的个性风格在处事和为人上的和谐性，以从“优”到“差”的尺度衡量它们。

<br><br>首先，我们来考虑一下为人的和谐性。在随便的和普通的情形下，两种行事风格怎么样相互联系呢？比如，你有一位同事跟你在同一部门工作，但工作上极少交往，你如何跟这位同事相处呢？或者，在你跟同寝室的人相处的经历中，哪些事情是令人高兴的，哪些是令人讨厌的？关系的和谐涉及到某种关系的特点，这种关系也许是随便的，也许是亲密的。

<br><br><strong>为人的和谐</strong>

<br><br>
<table border="1" width="600" cellpadding="1" cellspacing="1">
	<tr>
		<td><strong>&nbsp;</strong></td>
		<td><strong>D支配</strong></td>
		<td><strong>I影响</strong></td>
		<td><strong>S踏实</strong></td>
		<td><strong>C认真</strong></td>
	</tr>
	<tr>
		<td><strong>D支配</strong></td>
		<td>好</td>
		<td>好</td>
		<td>较好</td>
		<td>差</td>
	</tr>
	<tr>
		<td><strong>I影响</strong></td>
		<td>好</td>
		<td>优</td>
		<td>较好</td>
		<td>差</td>
	</tr>
	<tr>
		<td><strong>S踏实</strong></td>
		<td>较好</td>
		<td>较好</td>
		<td>优</td>
		<td>优</td>
	</tr>
	<tr>
		<td><strong>C认真</strong></td>
		<td>差</td>
		<td>差</td>
		<td>优</td>
		<td>优</td>
	</tr>
</table>

<br><br>下面，我们来看看处事的和谐性。在为人的和谐性上排列低下的某些个性组合在处事的和谐性上表现极佳。你在某个项目上与人合作得极好，因此你也许都不想休息一下。

<br><br><strong>处事的和谐</strong>

<table border="1" width="600" cellpadding="1" cellspacing="1">
	<tr>
		<td><strong>&nbsp;</strong></td>
		<td><strong>D支配</strong></td>
		<td><strong>I影响</strong></td>
		<td><strong>S踏实</strong></td>
		<td><strong>C认真</strong></td>
	</tr>
	<tr>
		<td><strong>D支配</strong></td>
		<td>较好</td>
		<td>较好</td>
		<td>优</td>
		<td>较好</td>
	</tr>
	<tr>
		<td><strong>I影响</strong></td>
		<td>较好</td>
		<td>差</td>
		<td>优</td>
		<td>好</td>
	</tr>
	<tr>
		<td><strong>S踏实</strong></td>
		<td>优</td>
		<td>优</td>
		<td>好</td>
		<td>优</td>
	</tr>
	<tr>
		<td><strong>C认真</strong></td>
		<td>较好</td>
		<td>好</td>
		<td>优</td>
		<td>好</td>
	</tr>
</table>
<br><hr>
<font size=1>所有内容，版权所有<sup>&copy;</sup>1998-<%=Year(Now())%> Team Resources, Inc.<sup>&reg;</sup> 全权所有.</font>

</div>
<p style="PAGE-BREAK-AFTER: always">&nbsp;</p>
<!--***** End Page 9 *****-->


<!--***** Begin Page 10 *****-->
<div style="width:624px">
<h2><i>在交流中要看</i></h2>
<hr>
<p><h1 align="center">什么样的行事风格</h1>
<P></P>

现在你了解了其他的个性风格，看到了这些风格怎样相互联系，你便可以学着跟不同性情的人进行交流。

<br><br>
<table border="1" width="600" cellpadding="1" cellspacing="1">
	<tr>
		<td valign="top">
			<ul>
				<img SRC="images/HighDLetter.gif" width=70 height=70 alt="" border="0">
				<li class="smallFont">简洁 
        
				<li class="smallFont">抓住主题 
        
				<li class="smallFont">有组织计划能力 
        
				<li class="smallFont">注重利润 
        
				<li class="smallFont">提早说明福利 
        
				<li class="smallFont">提出各种选择 
        
				<li class="smallFont">创新 
        
				<li class="smallFont">权威 
        
				<li class="smallFont">公事公办的态度 
        
				<li class="smallFont">有效利用时间（讲话，开会） 
        
				<li class="smallFont">有能力，自信 
        
				<li class="smallFont">注重结果 
        
				<li class="smallFont">有逻辑性</li>
			</ul>
		</td>
		<td valign="top">
			<ul>
				<img SRC="images/HighILetter.gif" width=70 height=70 alt="" border="0">
				<li class="smallFont">热情 
        
				<li class="smallFont">有创造力 
        
				<li class="smallFont">精力旺盛，但口气友好 
        
				<li class="smallFont">给予很多反馈机会 
        
				<li class="smallFont">明确奖励和福利 
        
				<li class="smallFont">福利和个人认可联系起来 
        
				<li class="smallFont">幽默 
        
				<li class="smallFont">对时间的态度随便 
        
				<li class="smallFont">抓住人的注意力 
        
				<li class="smallFont">着眼于大局 
        
				<li class="smallFont">参考他人的反应 
        
				<li class="smallFont">方法惹人注目 
        
				<li class="smallFont">个人的掌故很多 
        
				<li class="smallFont">诉诸于“有影响力的”人想曝光的需要</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<ul>
				<img SRC="images/HighCLetter.gif" width=70 height=70 alt="" border="0">
				<li class="smallFont">讲事实和数据 
        
				<li class="smallFont">检查和评价的时间和信息很多 
        
				<li class="smallFont">消除疑虑 
        
				<li class="smallFont">对风险的清楚评估 
        
				<li class="smallFont">高质量的交流（书面和口头） 
        
				<li class="smallFont">对个人的关注 
        
				<li class="smallFont">对过程清楚的描述 
        
				<li class="smallFont">遵守原则 
        
				<li class="smallFont">寻求“正确的”或“最佳的”答案 
        
				<li class="smallFont">追求杰出、准确，细节、质量 
        
				<li class="smallFont">表达思想细致、有条理 
        
				<li class="smallFont">程序、方针、规定清晰 
        
				<li class="smallFont">诚挚的 
        
				<li class="smallFont">数字准确</li>
			</ul>
		</td>
		<td valign="top">
			<ul>
				<img SRC="images/HighSLetter.gif" width=70 height=70 alt="" border="0">
				<li class="smallFont">口气诚恳 
        
				<li class="smallFont">传统式的、低调的表现 
        
				<li class="smallFont">新主意与老方法联系起来 
        
				<li class="smallFont">有逻辑性，讲事实，注意结构 
        
				<li class="smallFont">方法细致入微 
        
				<li class="smallFont">提供担保和保证 
        
				<li class="smallFont">有条有理地表现出不同的部分和观点怎样联系在一起 
        
				<li class="smallFont">需要别人的肯定 
        
				<li class="smallFont">保证提供支持 
        
				<li class="smallFont">注重福利与人们的联系 
        
				<li class="smallFont">没有争议 
        
				<li class="smallFont">个人和工作的关系都注意 
        
				<li class="smallFont">诉诸于“踏实的”人对安全和稳定的需要</li>
			</ul>
		</td>
	</tr>
</table>

</div>
<!--***** End Page 10 *****-->

<!--************* E N D  R E P O R T *************-->
</body>
</HTML>