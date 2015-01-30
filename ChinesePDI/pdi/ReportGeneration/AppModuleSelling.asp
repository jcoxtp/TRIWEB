<%@ Language=VBScript %>
<!--#INCLUDE FILE="../include/common.asp" -->
<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>
<%
	Dim strTopPgSpacing
	Dim AppModTitleFont
	Dim EndAppModTitleFont
	Dim HighType1
	Dim HighType2
	Dim AppModParaFont
	Dim EndAppModParaFont
	Dim UserName
	Dim UserName1
	Dim PDITestSummaryID 
	Dim nC1
	Dim nC2
	Dim nC3
	Dim nC4
	Dim UserID 
	Dim oConn
	Dim oCmd
	Dim oRs

	strTopPgSpacing = "<br><br><br><br><br><br><br>"
	HighType1 = UCase(Request.QueryString("HT1"))
	HighType2 = UCase(Request.QueryString("HT2"))
	AppModTitleFont = "<strong><font size=4>"
	EndAppModTitleFont = "</strong></font>"
	AppModParaFont = "<blockquote><font size=3>"
	EndAppModParaFont = "</font></blockquote>"
	PDITestSummaryID = Request.QueryString("PDITSID")
	UserID = Request.QueryString("UID")

	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		  .CommandText = "sel_PDITestSummary_Ex"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
		  .Parameters.Append .CreateParameter("@PDITestSummaryID",3, 1,4, PDITestSummaryID)
	End With
	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	If oConn.Errors.Count > 0 then
		Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
		Response.End
	end if 
	
	if oRs.EOF = FALSE then
		nC1 = oRs("C_NumberD")
		nC2 = oRs("C_NumberI")
		nC3 = oRs("C_NumberS")
		nC4 = oRs("C_NumberC")	
		username1 = oRs("FirstName")
		UserName = oRs("FirstName") & " " & oRs("LastName")
		Dim TestDate
		TestDate = oRs("FileCreationDate")
		'==================================================================================================
		'MG: 2/9/2004 - Added to handle fake test scenarios
		Dim IsFakeResults : IsFakeResults = False
		If (nC1=0) and (nC2=0) and (nC3=0) and (nC4=0) then
			If (oRs("M_NumberD")=0) and (oRs("M_NumberI")=0) and (oRs("M_NumberS")=0) and (oRs("M_NumberC")=0) then
				If (oRs("L_NumberD")=0) and (oRs("L_NumberI")=0) and (oRs("L_NumberS")=0) and (oRs("L_NumberC")=0) then 
					If (isNull(oRs("CPD"))) and (isNull(oRs("CPI"))) and (isNull(oRs("CPS"))) and (isNull(oRs("CPC"))) then 
						IsFakeResults = True
					End If
				End If
			End If
		End If
		'==================================================================================================
	else
		Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
		Response.End
	end if 
	
%>
<TABLE WIDTH=612 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR>
		<TD COLSPAN=4><IMG SRC="images/selling_pdf_cover_01.gif" WIDTH=612 HEIGHT=45 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/selling_pdf_cover_02.gif" WIDTH=37 HEIGHT=279 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/selling_pdf_cover_03.jpg" WIDTH=406 HEIGHT=279 ALT=""></TD>
		<TD><IMG SRC="images/selling_pdf_cover_04.gif" WIDTH=169 HEIGHT=279 ALT=""></TD>
	</TR>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/selling_pdf_cover_05.gif" WIDTH=612 HEIGHT=128 ALT=""></TD>
	</TR>
	<TR>
		<TD background="images/selling_pdf_cover_06.gif" WIDTH=612 HEIGHT=259 COLSPAN=4><%=UserName%><br><%=TestDate%></TD>
	</TR>
	<TR>
		<TD COLSPAN=2><IMG SRC="images/selling_pdf_cover_07.gif" WIDTH=126 HEIGHT=81 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/selling_pdf_cover_08.gif" WIDTH=486 HEIGHT=81 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH=37 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=89 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=317 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=169 HEIGHT=1 ALT=""></TD>
	</TR>
</TABLE>	
<wxprinter PageBreak>				
<%=strTopPgSpacing%>
<table WIDTH="700"><tr><td>
<br><br>
<%=AppModParaFont%>
	When you completed the Personal DISCernment® Inventory, you identified the 
	particular pattern that best reflects your behavioral tendencies. <%=UserName1%>, based on the 
	&quot;Composite Graph&quot; of your Personal DISCernment® Inventory, your predominant style is 
	that of a high &quot;<%=HighType1%>&quot;.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<% If NOT IsFakeResults then%>
		<img src="../disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026">
	<% End If %>
	<em>The Personal DISCernment® Inventory measures</em> <br>
	four factors (D, I, S, and C) that influence behavioral styles. Although everyone has 
	threads of all four factors woven into our basic temperament, most of us find that one or 
	perhaps two of the factors express themselves more strongly than the others in our 
	behavioral style. Each person's temperament is, in part, an expression of the way the 
	four factors combine. For example, a High I who is also a fairly High D will approach 
	things differently than a High I whose D is low.
	<br><br>
	However, in order to maximize understanding and application in this module, we focus 
	primarily on the &quot;pure&quot; types, considering only the tendencies we can expect from our 
	most predominant factor. Although these are brief summaries, describing only a few of 
	the elements that influence behavior in a given arena, even this level of understanding 
	can greatly improve the way you relate to others.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The Art of Persuasion
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Webster defines the word persuasion as being able &quot;to win over to a course of action by 
	reasoning or inducement. To make a person believe something.&quot;
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	When we persuade, we successfully influence another's thinking toward a decision or in 
	a direction, yet within that person's own boundaries of willingness. To persuade means 
	to resolve, change, or form another's feelings or opinion in an effective but reputable 
	manner.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Human history attests to the power of persuasion. The ancient Romans believed that of 
	all the liberal arts, rhetoric (the ability to use language persuasively) overrode all other 
	talents. Every social, religious, or political revolution has had at its core a powerful 
	catalyst known as persuasion. In a free enterprise system, it is the way we do business.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Persuasion, Communication, and Sales
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Nowhere is the power of persuasion more graphically exemplified than in that unique 
	human interaction known as the buyer/seller relationship. Today, as never before, the 
	professional salesperson's job is as complex as it is interesting and rewarding. 
	Successful selling requires a broad range of skills and knowledge, and, most of all, 
	selling requires effective communication. This module concentrates on that aspect of 
	sales.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		In any communication situation, you want to accomplish certain objectives:
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Get the order, set an appointment<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Take the next step in the process, or<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Get approval to start a project. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	It is important to understand that a buyer also has objectives when faced with a selling 
	situation, and understanding the buyer's objectives, wants, and needs is critical to 
	success.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	This module will help you to recognize your personal persuasion style and the particular 
	strengths and weaknesses that go with it. Buyers also have their own decision-making 
	styles. Not only will you learn how to identify those styles, but you will also discover 
	ways of adapting your style to meet the buyer's needs.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		How has Sales Changed?
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	This century will be turbulent, risky, and unforgiving, but at the same time full of 
	opportunity, challenge, and adventure. The promises of the 90s are no longer sufficient 
	for success, or even survival. The business environment of the current decade will be 
	characterized by increasing competitive intensity, continued consolidation of 
	customer/client base, and more stringent demands for quality products and services. 
	The old ways of doing business just won't work, and nowhere is this challenge greater 
	than in sales.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The 90s taught us the lessons of on-time delivery, high levels of customer service, and 
	superior quality. For the most part, the companies that did not learn these lessons did 
	not survive. With the turn of the century come new lessons to be learned, one of which 
	is how to differentiate our product or services in the face of increasing commodity 
	pressures, or &quot;me too&quot; competition. What, then, differentiates one offering from another? 
	More than ever before, the critical ingredient becomes the salesperson who 
	understands the needs of the customer and who controls the intangible side of the sale 
	as well.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The loudest voice and the most outrageous claims no longer win the prize. Today's 
	market is buyer-oriented, and the salesperson must find out what the buyer needs as 
	well as how the buyer likes to be approached. Success demands that the salesperson 
	find common ground and build a relationship from the inside out.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Successful sales strategies in the next century will move:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
				<tr>
					<td>&#149;</td><td><font size="2">From one-shot deals to long-term relationships</td>
				</tr>
				<tr>
					<td>&#149;</td><td><font size="2">From transactional to consultative approaches</td>
				</tr>
				<tr>
					<td>&#149;</td><td><font size="2">Toward increased commitment and partnering with key customers/clients</td>
				</tr>
				<tr>
					<td>&#149;</td><td><font size="2">Toward offering greater expertise to customers/clients, not only about </td>
				</tr>
				<tr>
					<td>&#149;</td><td><font size="2">products or services, but also logistics, systems, methods, and marketing</td>
				</tr>
			</table>
		</td>
		<td>
			<img SRC="images/appmodselling_common.jpg" WIDTH="200" HEIGHT="82">		
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The increased complexities of sustaining long-term/team relationships and dealing with 
	augmented definitions of products and services place greater demands on our ability to 
	communicate. As a result, salespeople today succeed only when they can:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Earn buyer trust by building positive interpersonal relationships
	&#149;	Understand the buyer's specific hierarchy of needs and wants
	&#149;	Strengthen relationships with existing buyers by aligning the strategic intents of both companies
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The Secret of Successful Selling
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>
			It would be nice if we could combine the perfect sales system with the perfect 
			salesperson. Obviously, the perfect salesperson doesn't exist. Each person sells 
			differently, and certainly more than one sales style can be effective.
			<br><br>
			Each of us has a distinctive personal style that is based on our unique personality, and 
			we tend to use it most of the time in sales situations. As salespeople, we tend to &quot;sell to 
			ourselves,&quot; making points and behaving in a manner that would lead us to buy.		
		</td>
		<td>
			<img SRC="images/perfectsalesmen.gif" WIDTH="224" HEIGHT="252">
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	However, psychologists tell us that the average salesperson, using his or her own sales 
	style, tends to make the wrong sales approach in three out of four calls! Seventy-five 
	percent of the time, salespeople are actually turning off target customers.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Why&#149; Because our target customers are as individual as fingerprints, and their 
	behavioral styles may differ drastically from ours. Successful salespeople must be 
	experts at diagnosing all components of a selling situation: the market, the competition, 
	the timing, the corporate culture, and especially the buyer and the decision-making 
	process.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Our objective here is to look at one particular facet of selling: how personality impacts 
	the way sellers and buyers communicate with each other. We can generally view any 
	sales effort from two broad dimensions: process (the selling cycle) and approach (how 
	we implement the process). The process seldom varies. However, the approach always 
	varies depending on the selling situation.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The secret is to learn to sell people the way they want to be sold, not the way we want 
	to sell them. We must recognize the buyer's temperament so that we can adapt our 
	approach to suit each buyer's individual behavioral style. We must react to the total 
	situation, and that includes the buyer's personality. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The specific objective of this application module is to help you increase your 
	sales/communication effectiveness by:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149; Understanding the strengths and weaknesses of different selling styles&#151; especially your own.<br><br>
	&#149; Reading the unique wants and needs of your listeners (customers, decision-makers, team members, colleagues).<br><br>
	&#149; Adapting approaches to communicate most effectively with individual target customers.<br><br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	First, let's look at your behavioral tendencies in selling/communication situations, using 
	the <strong>DISC</strong> Profile System.&#153;
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Persuasion &amp; Personality
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, your predominant style is that of a high <%=HighType1%>. In the very broadest of 
	terms, we might describe the high <%=HighType1%> sales person as follows:
<%=EndAppModParaFont%>


<%If HighType1 = "D" then %>
	<!--#INCLUDE FILE="AppModuleSelling_pp_d.asp" -->
<% elseif HighType1 = "I" then %>
	<!--#INCLUDE FILE="AppModuleSelling_pp_i.asp" -->
<% elseif HighType1 = "S" then %>
	<!--#INCLUDE FILE="AppModuleSelling_pp_s.asp" -->
<% else %>
	<!--#INCLUDE FILE="AppModuleSelling_pp_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Strengths &amp; Weaknesses as a High <%=HighType1%> Salesperson
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%If HighType1 = "D" then %>
	<!--#INCLUDE FILE="AppModuleSelling_sw_d.asp" -->
<% elseif HighType1 = "I" then %>
	<!--#INCLUDE FILE="AppModuleSelling_sw_i.asp" -->
<% elseif HighType1 = "S" then %>
	<!--#INCLUDE FILE="AppModuleSelling_sw_s.asp" -->
<% else %>
	<!--#INCLUDE FILE="AppModuleSelling_sw_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Identifying the Style of Others
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	To successfully adapt your sales style to better match the temperament of your 
	customer, you must first be able to identify the style of that individual. Obviously, we 
	can't always administer the Personal DISCernment® Inventory (PDI), so how can we 
	recognize the temperament of others? One of the strengths of the PDI, as well as other 
	DISC instruments, is that it deals largely with &quot;observable&quot; behavior. A careful, informed 
	observation can help you develop a reasonably accurate &quot;guesstimate&quot; 
	of someone's personal style. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		In identifying the styles of others the following principles will help:
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<em>Understand the limitations of trying to identify others' styles by observation alone. </em><br>
	Although certainly influenced by inner, unseen forces, behavior is not clear evidence 
	of values, motives, intelligence, feelings, or attitudes. As you observe a person 
	behaving or &quot;acting&quot; in a certain manner, don't ascribe the underlying emotion or 
	motive. Confine your conclusions to &quot;observable&quot; behavior. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<em>Withhold final judgment until you have had more than one encounter. </em><br>
	Often it takes time to develop the confidence that you have accurately assessed an 
	individual. If others don't trust you or don't perceive the environment as safe, they 
	may put up a mask. Create an atmosphere that encourages others to be 
	themselves.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<em>Pay particular attention to nonverbal communication. </em><br>
	Words account for less than 10 percent of any communication. Watch the body 
	language, facial expressions, and gestures of the other individual. For example, an 
	action-oriented person may be more animated with gestures, use more vocal 
	inflection and facial expressions.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<em>Use your knowledge to increase your understanding of and response to others' 
	needs.</em> <br>
	Your ability to recognize styles in others, coupled with an understanding of the 
	needs of various styles, can greatly increase your effectiveness as a salesperson.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	Let's review the four-element model that we introduced in the PDI.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Figure 1
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<img SRC="images/fourelementmodel.gif" WIDTH="652" HEIGHT="564">
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	On the following pages, we expand on this model to identify the more visible behavioral 
	tendencies of different styles.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		People vs. Task
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Using this model, we can see in Figure 2 that those to the right of the vertical line are 
	more people-oriented and those to the left are more task-oriented. These groups also 
	have certain &quot;observable&quot; characteristics. People-oriented individuals tend to connect 
	more readily with others, often with warmth and openness. On the other hand, task-
	oriented people are generally cooler, more reserved, and somewhat less expressive. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Figure 2
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<img SRC="images/peoplevtaskvertical.gif" WIDTH="652" HEIGHT="564">
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Action vs. Response
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Now, notice the horizontal line. People above the horizontal line tend to be active or 
	assertive; these individuals generally demonstrate a bold, confident, and directive 
	demeanor to others. Those below the line are more responsive or accommodating; 
	others see them as low key, collaborative, and self-controlled. Detailed descriptions of 
	tendencies in assertive and responsive temperaments are shown in the diagram below:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Figure 3
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<img SRC="images/appmodselling_Figure3.gif" WIDTH="652" HEIGHT="564">
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		How to Identify a High D Buyer
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High D buyers come on strong, often testing a seller by applying pressure early in the 
	relationship to see what the reaction will be. Frequently, the High D buyer will run late 
	and may appear rude when first approached. During the sales call, the High D may 
	interrupt you, take calls, read letters, and give instructions to his or her administrative 
	assistant, all the time saying something like, &quot;Keep talking. I'm listening.&quot;
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		High D's are usually interested in new products and innovations.
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The High D's office and desk may be disorganized, but what the seller will most quickly 
	recognize is this buyer's impatience and impulsiveness. The High D buyer will want 
	options, presented at a rapid pace, from which to make a decision. High D buyers can 
	be intimidating and may take control of the situation.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High D's Expectations
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High D's expect sellers to adopt a businesslike attitude. They have a job to do, and they 
	prefer to concentrate on that. They expect sellers to make efficient use of their time. 
	They tend to be busy people who operate from schedules and lists of things to do. They 
	like to see that they are making progress.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	D's want you to provide them with evidence early in the process. They want to deal with 
	someone who is competent and self-confident&#151;someone they can respect. They 
	expect you to present your product or service in terms of how it will solve their 
	problems. They aren't afraid to take risks, but they expect you to provide them with 
	probabilities associated with the risk.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		How to Identify a High I Buyer
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High I buyers are friendly, people-oriented folks who usually would rather talk and 
	socialize than do detail work. They will have awards, certificates, trophies, and photos 
	featured on the wall. You'll know who lives there, and the ego will be evident. High I's 
	will be glad to see you arrive; they will trade jokes and stories, and won't want to 
	discuss business too much. They talk a lot about themselves. They will interrupt and 
	digress occasionally, but they are generally enthusiastic and receptive, particularly if 
	your product or service is innovative and the latest.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	The High I buyer will be well-dressed and poised. They are motivated by how an 
	offering will impact their goals and personal expectations. The approval of the High I's 
	management is extremely important.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High I's Expectations
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	High I buyers expect you to be tolerant of their casual use of time. They aren't clockwatchers and don't want you to be 
	either. Once they make a decision, however, they want quick results.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High I's like to know who they're dealing with. They want to know what you think and 
	how you feel about things.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High I's expect you to support them personally and may be sensitive to how you work 
	with their management. They like positive feedback that helps them relate to you 
	personally.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		How to Identify a High S Buyer
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High S buyers will usually have pictures on the office wall&#151;not only of themselves, but 
	also of family members and possessions.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	This person will most likely have a name plate on the door or desk, or both.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Although they appear easygoing and personable, the High S buyer is very security 
	conscious and possessive, so be careful what you touch. They also resist sudden 
	change. They like proven, traditional concepts.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	This person will be sincere, open, amiable, and relationship-oriented, after an initial 
	shyness. They need to be able to trust you.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	You can't judge this book by its cover: dress will be varied, ranging from frumpy to high 
	style.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High S's Expectations
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High S buyers expect you to take time to develop the relationship: to be willing to build a 
	personal as well as a business relationship. They want to make fairly slow, deliberate 
	progress.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High S buyers expect you to present the benefits of your product or service in terms of 
	why it is the best solution to their problem. They want guarantees and assurances, 
	since they are not assertive risk takers. They make decisions cautiously, and they want 
	others to affirm those decisions.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		How to Identify a High C Buyer
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High C buyers work in neat, orderly offices. In most cases, their desks will be clean. 
	The High C will be prepared for the visit, on time, and will have read any advance 
	material. The atmosphere will be businesslike, but unhurried and deliberate. The High C 
	buyer may be suspicious of you and your products.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The High C will exhibit a precise, restrained manner, but will be courteous and 
	diplomatic. A stickler for accuracy and thoroughness, the High C will be process-
	oriented, with an emphasis on detailed organization. High C buyers are not innovators. 
	They will not readily try out new and innovative technology.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High C's will dress conservatively and unobtrusively. They don't want their clothes to 
	call attention to them.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High C's Expectations
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High C buyers expect the sales call to move at a pace that provides them with just 
	enough time to consider the key points thoughtfully.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High C buyers will want you to present all the facts you have at your disposal and will 
	then want time to think about the data before making a decision.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Like High S's, High C buyers want guarantees and assurances to protect them if 
	something goes wrong.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Questions that Buyers Might Ask
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In sales situations, you can often identify buyers' behavioral styles by listening carefully 
	to the questions they ask. Here are some typical questions that D, I, S, and C buyers 
	will ask about your product or service.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<strong>D . . .</strong>
<br><br>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Will it get results?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will it do what you say it will do?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How will this product help me meet my goals?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How will it improve my bottom line?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will it work now?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What does it cost?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What's the value?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What is your company's record?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How long have you been selling this?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Are you sure you know what you're talking about?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How many have you sold?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How fast can I get it?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What will it do for my company?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Is this the best you have to offer?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How quickly will it be on line?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Is this product up-to-date?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>If it doesn't work, how will you fix it?</td>
	</tr>
	<tr>
		<td VALIGN="TOP">&#149;</td>
		<td>What . . . 	are the options?<br>
		- are the probabilities?
		<br>
		- are the results?
		</td>
	</tr>
	
</table>

<wxprinter PageBreak><%=strTopPgSpacing%>

<strong>I . . .</strong>
<br><br>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Will you sit down so we can talk about this? Coffee?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can you tell me a little about yourself? Your company?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What kinds of premiums or incentives are available?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can you give me a special deal?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What will it take for us to win the contest?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>I'm excited about the purchase. Did you watch the game Sunday?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will my bosses approve of this product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How will this help me with the people I work with?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Who else uses this product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What do others say about the product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Why is this the best available?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Is this the first application of this product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Is this your best selling product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How soon can I tell my boss we'll have it?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>When can I say it will be on line?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Is this the newest on the market?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Is this product well-accepted by others? Who?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What happens if I change my mind?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will you be the person I should call if something goes wrong?</td>
	</tr>
	<tr>
		<td VALIGN="TOP">&#149;</td>
		<td>Who . . . 	are you?<br>
		- do you know?		
		<br>
		- uses your product or service?		
		</td>
	</tr>
	
</table>

<wxprinter PageBreak><%=strTopPgSpacing%>

<strong>S . . .</strong>
<br><br>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Why should I change? I've bought from XYZ for years with good service.  (new customer)</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What's the price? I always buy on your recommendations. (old customer)</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Why have you changed the product (or service)? I was just getting used to it the way it was.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can I still get the old version?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>If I buy today, can I be sure of delivery in three months?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can you call me back in a week?	I'd like to check with some other people.?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How long has this been on the market?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Is this your most reliable product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How soon can my people learn to use it?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will it provide the same quality as the old version?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will this reduce tension in my department?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>What's the best way to get my people involved with this product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Has anyone had trouble with this product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>If something goes wrong, what do I do?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will it disrupt our way of doing things?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can you meet with some other members of my team to explain the product?</td>
	</tr>
	<tr>
		<td VALIGN="TOP">&#149;</td>
		<td>Why . . . 	is your product best?<br>
		- should I change? 
		<br>
		- should I do it now?
		</td>
	</tr>
	
</table>
<wxprinter PageBreak><%=strTopPgSpacing%>
<strong>C . . .</strong>
<br><br>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Who has used (or tested) this product before?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can you tell me more? I still don't see how this works.?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Who makes this product?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How is it made?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How long have you been making it?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can you tell me about the warranty?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How much does the extended warranty cost?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Who will pay for delivery?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How can you be sure that this will have the same quality as the previous model?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can I see the test results?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can I think about it and get back to you?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How soon must I decide? I need time to read your material.?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will you be able to follow my exact specifications?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Is this your best value for the money?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>How soon will it pay for itself?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Has this product been thoroughly tested?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will it do the job right?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>If it doesn't work, how do I get my money back?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Will it fit within my established procedures and guidelines?</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Can you put your offer in writing?</td>
	</tr>
	<tr>
		<td VALIGN="TOP">&#149;</td>
		<td>How . . . 	can this product meet my need?
		<br>
		- does it work?
		<br>
		- can I be sure?
		</td>
	</tr>
</table>

<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		How to Influence and Sell Buyers who are
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High D Style &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build credibility for yourself
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Let them know you value their time.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be sure of yourself; use straightforward communication.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be confident.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Demonstrate results.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Inform the buyer of your personal and corporate qualifications.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build credibility for your product or service
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149; Stress why your product or service will help the buyer and meet his/her 
	objectives.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149; Be prepared to show proof of results.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149; Demonstrate value.<br>
<%=EndAppModParaFont%>
	
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Structure your presentation to fit this style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<blockquote>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Learn and study their goals and objectives.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Be prepared and well-organized.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Be professional and businesslike.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Be brief, direct, and fast-paced, and get to the point quickly. &quot;What's the bottom line?&quot;</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Hit the buyer quickly and hard, because High D's are decisive and act on impulse.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Suggest solutions with clearly-defined and agreed-upon consequences as well as rewards that relate to the buyer's goals.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Clarify risks and probabilities.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Provide options.</td>
	</tr>
</table>
</blockquote>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High I Style &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build credibility for yourself
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
	
<%=AppModParaFont%>
<blockquote>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Give special attention and be interested and enthusiastic, without dominating the discussion.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Affirm the buyer's dreams and goals.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Stress how your product or service will make the buyer look good or provide 
attention and recognition.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Inform the buyer of your personal and corporate reputation.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Provide plenty of follow-up.</td>
	</tr>
</table>
</blockquote>
<%=EndAppModParaFont%>
	

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build credibility for your product or service
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Appeal to the buyer's affinity for the new, the special, and the novel.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Indicate that the buyer will be the first to use the product or service.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Focus on the product's prestige and reputation. <br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Give testimonials of &quot;experts.&quot;<br>
<%=EndAppModParaFont%>
	

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Structure your presentation to fit this style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<blockquote>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Present with style.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Involve the buyer in the selling process; solicit his/her ideas and opinions.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Be open to topics the buyer introduces.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Stress the special or novel aspects of the product or service.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Illustrate your ideas with anecdotes and emotional descriptions.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Clearly summarize detail and direct the buyer toward mutually agreeable objectives and action steps.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Encourage the purchase decision by offering incentives.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Present testimonials from others using the product or service.</td>
	</tr>
</table>
</blockquote>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High S Style &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build credibility for yourself
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
	
<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Sell yourself first. You must win the High S as a friend.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Take a sincere, personal interest in the buyer as a person.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Take the time to build a relationship; find common interests.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Develop trust, friendship, and credibility slowly.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Focus on your reliability and loyalty.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Communicate regularly; make repeat visits.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build credibility for your product or service
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<blockquote>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Talk security, service, safety, dependability, and backup.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Emphasize that the product or service won't disrupt the way things are done or have been done.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Focus on why the product should be used.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Emphasize proven products.</td>
	</tr>
</table>
</blockquote>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Structure your presentation to fit this style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
	
<%=AppModParaFont%>
<blockquote>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Don't move too fast. High S's can handle change, but at their own pace.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Avoid high-pressure tactics.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Don't appear to create problems for the buyer or let your product or service seem to threaten the buyer or his/her standing with the company.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Give reassurances that the buyer is making the right decision and assurances that all promises will be kept.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Stress reliability, service, and safety.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Identify the buyer's emotional needs as well as the task or business expectations.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Provide plenty of proof and statistics, and give the buyer a chance to digest facts.</td>
	</tr>	
</table>
</blockquote>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High C Style &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build credibility for yourself
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<blockquote>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&#149;</td>
		<td>Greet cordially and get right to the task. Don't begin with personal or social talk.</td>
	</tr>
	<tr>
		<td>&#149;</td>
		<td>Demonstrate your expertise: your knowledge of the product or service, the process, and the industry.</td>
	</tr>
	
	<tr>
		<td>&#149;</td>
		<td>Be well prepared so that you can answer all questions.<br>	Follow through and deliver what you promise.</td>
	</tr>
</table>
</blockquote>
<%=EndAppModParaFont%>
	

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Build credibility for your product or service
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Use comparative data: research statistics, test results, etc.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Appeal to logic, showing facts and benefits.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Use detailed, documented evidence to support product or service claims.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress quality and reliability, and be able to show precedent to appeal to the buyer's caution.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Structure your presentation to fit this style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
	
<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be logical, factual, and detailed in your presentation.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be precise and technically correct in response to the buyer's detailed questions.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Ask questions that reveal a clear direction and that fit into the overall scheme of things.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Answer all questions carefully.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Deal with objections completely.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress reliability and safety to minimize risk.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Give the buyer time to think.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Follow up with a written proposal; the High C buyer will usually require it.<br>
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Strategy
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		With a High D Buyer...
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To communicate better with a High D Buyer do &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide direct answers and be brief and to the point.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress what has to be done, not why it has to be done.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress results.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide options and possibilities.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Emphasize logic of ideas and approaches.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Agree with the facts, position, or idea&#151;not just the person.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Avoid rambling.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Summarize and close.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To communicate better with a High D Buyer don't &#133; 
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Appear indecisive.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be problem oriented.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be overly friendly.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Generalize.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide too many details.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Repeat yourself or talk too much.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Make unsupportable statements.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Make decisions for them.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;As High D Buyers hear and analyze information, they may &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not consider risks.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not weigh pros and cons.<br>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		With a High I Buyer...
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To communicate better with a High I Buyer do &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress the new, the special, and the novel.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Demonstrate the ability to be articulate.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress testimonies or feedback from &quot;experts.&quot;<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide opportunity for give and take.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be open, friendly, and warm.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be enthusiastic.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Listen attentively.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Spend time developing the relationship.<br>
<%=EndAppModParaFont%>
 
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To communicate better with a High I Buyer don't &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Ignore the social dimensions.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Do all the talking.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Restrict suggestions or interruptions.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Let him or her take you too far off track.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be curt, cold, or tight-lipped.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Talk down to them.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;As High I Buyers hear and analyze information, they may &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not concentrate.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Ignore important facts.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Interrupt.<br>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		With a High S...
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To communicate better with a High S Buyer do &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Use patience in drawing out his/her goals.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Emphasize how a deliberate approach will work.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Talk service and dependability.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Ask how questions and get feedback.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Listen attentively.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be sincere.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Communicate in a low-key, relaxed manner.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To communicate better with a High S Buyer don't &#133; 
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be too directive.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Push too aggressively or demand.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Move too fast.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Omit too many details.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be abrupt.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;As High S Buyers hear and analyze information, they may &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be quietly unyielding.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not be assertive in communicating their concerns.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not provide a lot of feedback during presentations.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Hesitate to make a decision, particularly if unpopular.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Slow down the action.<br>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		With a High C...
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To communicate better with a High C Buyer do &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Use comparative data.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Appeal to logic, showing facts and benefits.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Concentrate on specifics.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Have all the facts, and stick to them.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be organized.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide written proposals for major decisions.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Appeal to interest in research, statistics, etc.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide detailed responses to questions.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Deal fully with objections.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress quality, reliability, and security.<br>
<%=EndAppModParaFont%>
 
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To communicate better with a High C Buyer don't &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be vague or casual, particularly when answering questions.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Move to the bottom line too quickly.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Get personal about family if you don't know this him/her.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Pat on the back or otherwise be too familiar.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Speak too loudly.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Threaten, cajole, wheedle, or coax.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;As High C Buyers hear and analyze information, they may &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be too conservative and cautious.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Bog down in the collection process.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Become buried in detail.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Delay or avoid decisions, particularly if risky.<br>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Strategies for Dealing with Different Buyers
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		As a High <%=HighType1%> salesperson, you may need to adapt your style to match the situation.
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%If HighType1 = "D" then %>
	<!--#INCLUDE FILE="AppModuleSelling_sdb_d.asp" -->
<% elseif HighType1 = "I" then %>
	<!--#INCLUDE FILE="AppModuleSelling_sdb_i.asp" -->
<% elseif HighType1 = "S" then %>
	<!--#INCLUDE FILE="AppModuleSelling_sdb_s.asp" -->
<% else %>
	<!--#INCLUDE FILE="AppModuleSelling_sdb_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Selling Situations: Frustration or Fulfillment
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Think of a selling situation that frustrates you or makes you uncomfortable and 
	ineffective. Describe the typical elements of this situation (such as buyer personality, 
	environment, timing, presentation, presence of competitors, appropriateness of your 
	product or service for the situation, economic conditions).
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	How could you adjust your selling style to be more effective in this selling situation?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>

<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Personality and the Selling Process
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, let's reflect for a moment on how your high <%=HighType1%> behavioral style impacts 
	your approach: the way you implement the process&#151;sometimes helping, other times 
	hindering. Every personality will bring different strengths and weaknesses to each stage 
	of the sales process (targeting, preparation, presentation, commitment, and partnering).
<%=EndAppModParaFont%>	

<%=AppModParaFont%>
	Below are the more typical process elements. Please adapt accordingly to fit your 
	situation.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Take a minute to consider the possibilities, and jot down your ideas in the spaces 
	provided.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="20%">&nbsp;</td>
		<td WIDTH="40%" ALIGN="MIDDLE"><font size="3"><strong>Helps</strong></td>
		<td WIDTH="40%" ALIGN="MIDDLE"><font size="3"><strong>Hinders</strong></td>
	</tr>
	<tr>
		<td><font size="3"><strong>Targeting</strong></td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Gathering Information</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Initial Contact</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="3"><strong>Preparation</strong></td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Preliminary Meeting</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Developing Rapport</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Finding the Need</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Analysis</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="3"><strong>Presentation</strong></td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Proposing Solutions/Benefits</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Handling Objections</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Presenting Capabilities</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2"><strong>Commitment</strong></td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Obtaining Decision</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Outlining Next Steps</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="3"><strong>Partnering</strong></td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Providing Follow-up</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Building Credibility</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">Continuing Service</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
</table>



<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Tips to the Sales Manager When managing different styles&#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="1" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><font size="4"><strong>D...</strong></td>
		<td><strong>I...</strong></td>
	</tr>
	<tr>
		<td><font size="2">
			&#149;	Offer commission compensation.<br>
			&#149;	Create contests in which there are a limited number of winners.<br>
			&#149;	Give difficult assignments that challenge logic and analytical ability.<br>
			&#149;	Make the High D aware of possible overbearing manner with buyers.<br>
			&#149;	Give as much freedom as possible to run things.<br>
			&#149;	Make the High D understand the limits to authority.<br>
			&#149;	Allow the High D to &quot;tell it like it is&quot; and openly discuss what is expected on a no-holds-barred basis.<br>
			&#149;	Acknowledge successes openly and often.<br>
			&#149;	Tolerate criticism.<br>
			&#149;	Delegate whenever possible.<br>
		</td>
		<td><font size="2">
			&#149;	Encourage the High I to set goals that provide awards and recognition.<br>
			&#149;	Give freedom and the opportunity to be &quot;number one.&quot;<br>
			&#149;	Be generous with recognition.<br>
			&#149;	Discuss sales situations openly and freely.<br>
			&#149;	Make status symbols and perks available.<br>
			&#149;	Allow the High I the chance to speak and be heard.<br>
			&#149;	Exchange ideas and advice.<br>
			&#149;	Be involved socially.<br>
			&#149;	Keep supervision to a minimum to encourage independence.<br>
			&#149;	Provide clear but general instructions.<br>
			&#149;	Motivate with emotional appeals.<br>
		</td>
	</tr>
	<tr>
		<td><font size="4"><strong>C...</strong></td>
		<td><strong>S...</strong></td>
	</tr>
	<tr>
		<td><font size="2">
			&#149;	Allow the High C to compete against long-term commitments rather than short-term, &quot;contest&quot; goals.<br>
			&#149;	Be supportive and responsive.<br>
			&#149;	Outline exactly what is expected.<br>
			&#149;	Provide projects that require precision, organization, and planning.<br>
			&#149;	Be available to discuss key moves and make useful suggestions in stressful situations.<br>
			&#149;	Deflect pressure whenever possible.<br>
			&#149;	Provide support and backup in difficult situations.<br>
			&#149;	Provide detailed instructions and develop exact job descriptions.<br>
			&#149;	Encourage the High C to complete projects.<br>
		</td>
		<td><font size="2">
			&#149;	Develop contests in which everyone can win something.<br>
			&#149;	Take an interest in the High S both as a producer and as a person.<br>
			&#149;	Allow the High S to work at an established and self-regulated pace.<br>
			&#149;	Provide a stable environment that evidences permanence, security, and consistency. <br>
			&#149;	Provide sincere appreciation.<br>
			&#149;	Give help in meeting deadlines.<br>
			&#149;	Give advance warning before change.<br>
			&#149;	Express sincere appreciation for contributions.<br>
			&#149;	Be patient.<br>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	The <strong>DISC Profile System®</strong> is a family of instruments and workbooks designed specifically to increase 
	understanding of yourself and others to achieve greater personal and interpersonal effectiveness.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	The <strong>Personal DISCernment® Inventory</strong>, the basic module, provides a unique insight into your 
	temperament, producing both a general and a detailed description of your behavioral style. This 
	instrument also allows you to develop a comprehensive list of your strengths and weaknesses.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	A second core module, the <strong>Position Discernment® Inventory</strong>, examines personalities and how they lend 
	themselves to positions within an organization. The <strong>Position Discernment® Inventory</strong> is not intended to 
	perform screening for a selection process, but rather to allow you to explore in detail why specific 
	positions attract certain individuals and why some people perform best in particular situations. This 
	instrument provides valuable information that can increase individual effectiveness in the work setting as 
	well as enhance the general overall performance of the organization.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	The <strong>DISC Profile® System</strong> includes a series of application modules that will guide you in applying these 
	insights to specific situations. The module workbooks provide additional information each behavioral style 
	as it relates to that arena and suggest how you may apply this information to yourself and your 
	teammates.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Five application modules are available:
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Teamwork with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	Each temperament brings unique strengths and weaknesses to the team setting. Your behavioral 
	style influences the way you plan and organize your work, communicate and make decisions. 
	This workbook will provide the opportunity for you to identify, explore, and discuss the effects of 
	the individual behavioral styles on your team. The result will be enhanced understanding of how 
	to build on individual differences for greater team effectiveness.
<%=EndAppModParaFont%>

	
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leading with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Our behavioral traits are not only a major influence on our leadership style, but also provide the 
	template through which we view the leadership of others. When we are led by those with different 
	behavioral styles from our own, we have a tendency to feel overled. Understanding these 
	differences will not only help you to better serve those you lead, but also help you to better 
	respond to the leadership of others.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communicating with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	This module will help you recognize how your personal communication style enhances or 
	impedes the messages that you send to others. In addition, you will learn to identify the styles of 
	those receiving your message, and discover ways to adapt your style to meet their needs. As a 
	result, you will greatly improve the effectiveness of your written and spoken communication in a 
	variety of situations.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>
	
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Selling with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Behavioral style not only influences how we persuade or convince others, but how we ourselves 
are persuaded. This module, designed for the sales environment, provides insights into the 
strengths and weaknesses of each behavioral style as we attempt to communicate with and 
convince others. You will also discover how different temperaments receive and respond to such 
overtures. These insights can greatly increase your effectiveness in communicating a point of 
view, as well as understanding and meeting the needs of others.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Time Management with Style
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Our personalities often determine our attitudes toward time: how we respond to time constraints, 
	how we discipline ourselves, how much energy we have to get things done, and how we view 
	deadlines. This workbook outlines each behavioral style's response to the various aspects of time 
	and personal management.
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	For more information call Team Resources at 1.800.214.3917 or visit our website: www.teamresources.com
<%=EndAppModParaFont%>
</td></tr></table>
</body>
</html>