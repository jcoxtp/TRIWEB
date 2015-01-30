<%@ Language=VBScript %>
<% intPageID = 74 %>
<!--#Include virtual="/pdi/Include/common.asp" -->
<html>
	<head>
		<title>Performance Management DISC Module</title>
		<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
		<link rel="stylesheet" href="AppModStyle.css" type="text/css">
	</head>
	<body>
<%
	Dim HighType1
	Dim HighType2
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
	Dim pageFull

	strTopPgSpacing = ""
	HighType1 = UCase(Request.QueryString("HT1"))
	HighType2 = UCase(Request.QueryString("HT2"))

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
	oConn.Open strDbConnString
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
		username1 = UCase(Left(username1, 1)) & Mid(username1, 2)
		
		UserName = username1 & " " & oRs("LastName")
		Dim TestDate
		TestDate = oRs("FileCreationDate")
		
		
	else
		Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
		Response.End
	end if 
	
%>

<!-- Beginning of Cover Page --------------------------------------------------------------------------------->
	<div id="performancecover" style="position:relative; text-align: center; width: 750px; height: 800px; border: 1px dotted black;">
	
	<div style="position:absolute; top:80px; left: 100px; z-index: 100">
		<IMG SRC="images/selling_pdf_cover_03.jpg" WIDTH="406" HEIGHT="279" ALT="">
	</div>
	
	<div style="position: absolute; top: 340px; left: 50px; background-color: green; width: 650px; height: 100px; z-index: 10; 
					padding-left: 80px; padding-bottom: 10px; padding-top: 20px; text-align: left; color: white; font-size: 16pt;">
		<b>Performance Management</b><br>
		with<br>
		<b>Style</b>
	</div>
	
	<hr style="position: absolute; top: 450px; left: 50px; width: 650px;">
	
	<div style="position: absolute; top: 453px; left: 50px; width: 650px; text-align: left; padding-left: 30px;">
		<b>A DISC Profile System <sup>&reg;</sup> Application Report</b>
	</div>
	
	<div style="position: absolute; top: 600px; left: 50px; width: 650px; text-align: left;">
		<%=UserName%><br>
		<%=TestDate%>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<IMG SRC="images/<%=strLanguageCode%>/PDICover.gif">
	</div>
	
	</div>

	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END OF Cover Page --------------------------------------------------------------------------------->
		
	<div style="position: relative; width:750px; margin:0px auto; align:center; text-align:left; padding:15px; background-color:#ffffff;">
	<!-- Introduction -->
	<h1>Managing Performance:</h1>
	
	<h2 style="text-align:center">The Requirements</h2>
	
	<p>
		In the broadest of terms, the objective of any Performance Management strategy should be to maximize individual, 
		departmental, program, and organizational performance. Managers are accountable for the performance of their 
		subordinates. If people fail, then managers have failed as well.
	</p>
	
	<p>
		Performance management is not an event, but rather a process—not simply one meeting, but an ongoing dialogue
		 between you and your staff about goals, strategies, and the support needed to achieve them.
	</p>

	<p>Consider these critical components of the performance management cycle.</p>
	
	<h3>Planning and Goal Setting</h3>
	
	<p>The two main tools available to a manager to accomplish goals are people and plans. A good performance
	 appraisal/development strategy is the glue that unites these two elements. The process begins with creating 
	 performance measures that are aligned with the strategic initiatives of the organization. The next step consists 
	 of establishing and communicating goals and deciding on how to measure performance against these objectives. 
	 They should be mutually established by the manager and the employee and should be in writing.
	</p>
	
	<h3>Monitoring and Measuring Progress</h3>
	
	<p>This step turns goals into results. During this phase, your role as manager/leader includes coach, 
	problem-solver, and encourager. Through continuous communication, and informal reviews, you and your 
	employee are constantly comparing current results against desired results and taking the steps necessary 
	to create the appropriate outcome.
	</p>
	
	<h3>Performance Evaluation</h3>
	
	<p>Your objective in this phase of the process is to develop an accurate, objective evaluation of the 
	employee’s performance and to document it in a logical and acceptable manner. You have observed and 
	drawn conclusions throughout the year; now you must put them together in a composite summary of 
	performance and progress.
	</p>
	
	<h3>Development Review Session/Skills Development Strategies</h3>
	
	<p>Using your evaluation as the roadmap for your feedback session, you will conduct formal review 
	sessions to provide clear, specific feedback on performance along with career guidance and advice. 
	In addition, you recognize the employee’s contribution and build his or her confidence while identifying 
	areas for development and creating strategies to produce that development.
	</p>
	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	<!-- Intro Page 2 -->
	
	<h2>Performance Management and Style</h2>
	
	<p>Managing the performance of others in today’s workplace is more of an ongoing partnership than a 
	once-a-year conversation.  Ideally, communication should be honest, complete, precise, and motivating—all 
	in an atmosphere of openness and trust. 
	</p>

	<p>Few situations are quite as challenging as delivering unwelcome information to an employee about his 
	or her performance and then coming to an agreement about what that person can do to improve.  The discomfort 
	of the sender of the information coupled with the selective listening and message filtering of the receiver 
	can produce sub-standard results.
	</p>

	<p>Our personal style, or the way that we prefer to give and receive information, can inhibit, prohibit, 
	and distort the important messages that are critical to improved performance and organizational excellence.  
	This module looks at the various stages of the performance management process and provides insights regarding 
	your style’s strengths and limitations in the various phases of managing the performance of others. 
	</p>

	<p>Further, you will receive valuable tips and techniques for adapting to your employees’ styles in ways that 
	enable them to accept, understand, and move forward in their development.  
	</p>

	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	<!-- Performance Management Styles: User High Factor -->
	
	<div style="position:relative">
	
<% If HighType1 = "D" then %>
	<!--#Include FILE="AppModulePerformance_Mgmt_Style_Main_D.asp" -->
<% elseif HighType1 = "I" then %>
	<!--#Include FILE="AppModulePerformance_Mgmt_Style_Main_I.asp" -->
<% elseif HighType1 = "S" then %>
	<!--#Include FILE="AppModulePerformance_Mgmt_Style_Main_S.asp" -->
<% else %>
	<!--#Include FILE="AppModulePerformance_Mgmt_Style_Main_C.asp" -->
<% end if %>

	</div>
		
<%If HighType1 <> "D" then %>
	<div style="position:relative">
	<!--#Include FILE="AppModulePerformance_Mgmt_Style_bp_D.asp" -->
	</div>
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	<h1>Performance Management Styles</h1>
<% End If

 If HighType1 <> "I" then %>
	<div style="position:relative">
	<!--#Include FILE="AppModulePerformance_Mgmt_Style_bp_I.asp" -->
	</div>
<%
		If HighType1 = "D" then %>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<h1>Performance Management Styles</h1>
	<% End If
  End If

 If HighType1 <> "S" then %>
	<div style="position:relative">
	<!--#Include FILE="AppModulePerformance_Mgmt_Style_bp_S.asp" -->
	</div>
<%End If 

 If  HighType1 <> "C" then%>
	<div style="position:relative">
	<!--#Include FILE="AppModulePerformance_Mgmt_Style_bp_C.asp" -->
	</div>
<% end if %>

	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	
	<!-- Strengths and Weaknesses -->

<% If HighType1 = "D" then %>
	<!--#Include FILE="AppModulePerformance_sw_D.asp" -->
<% elseif HighType1 = "I" then %>
	<!--#Include FILE="AppModulePerformance_sw_I.asp" -->
<% elseif HighType1 = "S" then %>
	<!--#Include FILE="AppModulePerformance_sw_S.asp" -->
<% else %>
	<!--#Include FILE="AppModulePerformance_sw_C.asp" -->
<% end if %>	
	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	
		
	<!-- Managing Performance Under Stress -->
	<h2 style="margin-bottom:0px;">Managing Performance</h2>
	<h1 style="text-align:center; margin-top:0px;">Under Stress</h1>
	
	<p>Managing performance, challenging at best, becomes even more complex in our 
	highly charged workplaces when tempers flair, fatigue sets in, and people resist 
	or resent the task or the leader. Indeed, the most challenging situations occur 
	when employees aren’t meeting their goals or developing on schedule. A rise in 
	stress levels introduces an interesting dimension to temperament we call stress 
	behavior. People with similar temperaments tend to behave alike in those situations 
	in which we find ourselves “at the end of our rope and just can’t take it any more.”</p>

	<p>Different styles handle stress differently, based on whether they are active/
	assertive in nature or responsive/accommodating. And we behave differently if 
	stress continues over time. Most of us have an initial response to stress and a 
	secondary response.</p>

	
	<table WIDTH="100%" class="with-border" CELLSPACING="5" CELLPADDING="1" ID="Table3">
	<tr>
		<td COLSPAN="3" ALIGN="center"><font size="2"><strong>Initial Stress Response<!--Initial Stress Response--></strong></font></td>
		<td COLSPAN="2" ALIGN="center"><font size="2"><strong>Alternative Stress Response<!--Alternative Stress Response--></strong></font></td>
	</tr>
	<tr>
		<td style="font-size:24pt; color: #999999; font-weight: bold; text-align: center;">D</td>
		<td style="font-size:16pt; font-weight: bold; text-align: right">Demands<!--Demands--></td>
		<td><font size="2">Message: &quot;What do you mean we don't have the budget to complete my project? No way will I accept that.&quot;<!--Message: &quot;What do you mean we don't have the budget to complete my project? No way will I accept that.&quot;--></font></td>
		<td style="font-size:16pt; font-weight: bold; text-align: right">Detaches<!--Detaches--></td>
		<td><font size="2">Message: &quot;I don't have time to bother with this. I have bigger issues to be concerned with.&quot;<!--Message: &quot;I don't have time to bother with this. I have bigger issues to be concerned with.&quot;--></font></td>
	</tr>
	<tr>
		<td style="font-size:24pt; color: #999999; font-weight: bold; text-align: center;">I</td>
		<td style="font-size:16pt; font-weight: bold; text-align: right">Attacks<!--Attacks--></td>
		<td><font size="2">Message: &quot;I'm not about to go to the board with this absurd proposal. We'll get killed if we present it this way.&quot;<!--Message: &quot;I'm not about to go to the board with this absurd proposal. We'll get killed if we present it this way.&quot;--></font></td>
		<td style="font-size:16pt; font-weight: bold; text-align: right">Agrees<!--Agrees--></td>
		<td><font size="2">Message: &quot;Okay, we'll try it your way. But don't forget that I warned you.&quot;<!--Message: &quot;Okay, we'll try it your way. But don't forget that I warned you.&quot;--></font></td>
	</tr>
	<tr>
		<td style="font-size:24pt; color: #999999; font-weight: bold; text-align: center;">S</td>
		<td style="font-size:16pt; font-weight: bold; text-align: right">Agrees<!--Agrees--></td>
		<td><font size="2">Message: &quot;I know you've been swamped, or you wouldn't have missed that critical deadline.&quot;<!--Message: &quot;I know you've been swamped, or you wouldn't have missed that critical deadline.&quot;--></font></td>
		<td style="font-size:16pt; font-weight: bold; text-align: right">Attacks<!--Attacks--></td>
		<td><font size="2">Message: &quot;You've taken advantage of my good nature for the last time!&quot;<!--Message: &quot;You've taken advantage of my good nature for the last time!&quot;--></font></td>
	</tr>
	<tr>
		<td style="font-size:24pt; color: #999999; font-weight: bold; text-align: center;">C</td>
		<td style="font-size:16pt; font-weight: bold; text-align: right">Detaches<!--Detaches--></td>
		<td><font size="2">Message: &quot;I just don't have time to consider your request. I have too much on my plate as it is.&quot;<!--Message: &quot;I just don't have time to consider your request. I have too much on my plate as it is.&quot;--></font></td>
		<td style="font-size:16pt; font-weight: bold; text-align: right">Demands<!--Demands--></td>
		<td><font size="2">Message: &quot;If I bend the rules for you, I'll have to bend them for everyone, and that's not going to happen. We'll stick to procedure.&quot;<!--Message: &quot;If I bend the rules for you, I'll have to bend them for everyone, and that's not going to happen. We'll stick to procedure.&quot;--></font></td>
	</tr>
</table>
	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
		
	<!-- Reacting to Stress -->
	<h2 style="margin-bottom:0px;">Managing Performance</h2>
	<h1 style="text-align:center; margin-top:0px;">Under Stress</h1>
	
	<p>Performance reviews, particularly unfavorable ones, are huge stress triggers—for both the manager and the employee.   </p>

	<p>Below is a list of more sources of stress for different temperaments. Review the list for your behavioral style and check the items you have found create stress for you. Add additional items if relevant.</p>

	<p>Now think of those whose performance you manage.  What situations create stress for them?  How do their stressors differ from yours?</p>

	<h2>Reacting to Stress</h2>
	
	<p>In most cases, the four temperaments react to stress in the following ways.  Take the following steps to identify stress behaviors in yourself and others.</p>

	<ul>
		<li>Read through the list for your temperament and check the items you believe describe your behavior under stress. Add additional behaviors you believe are descriptive if not included in the list. </li>
		<li>Think of those you lead who have different behavioral styles. How would you describe their behavior under stress? Again, check the behaviors on the list for their temperament below. List additional behaviors if relevant.</li>
	</ul>
	
	<table align="center" width="100%" cellpadding="1px" class="with-border" ID="Table4">
	<tr valign="top">
		<td width="50%" class="with-border">
			<div style="position: relative;"> 
				<div class="style-watermark" style="font-size:72pt; LEFT: 0px; TOP: 0px; Z-Index:10">
					D
				</div>

				<div style="position:relative;z-index:100">
					<!-- D Content -->
					<b>A High D encounters stress when...</b>
					<ul class="checkbox">
						<li>He/she must submit to authority</li>
						<li>Has a personal goal blocked or threatened</li>
						<li>When he/she believes they are being taken advantage of</li>
					</ul>
				</div>
			</div>
		</td>
		<td width="50%" class="with-border">
			<div style="position: relative;"> 
				<div class="style-watermark" style="font-size:72pt; LEFT: 0px; TOP: 0px; Z-Index:10">
					I
				</div>
				<div style="position:relative;z-index:100">
					<!-- I Content -->
					<b>A High I encounters stress when...</b>
					<ul class="checkbox">
						<li>Caught between the contrary wishes of an authority figure and peers</li>
						<li>When he/she fears loss of social approval or public embarrassment</li>
					</ul>
				</div>
			</div>
		</td>
	</tr>
	<tr valign="top">
		<td width="50%" class="with-border">
			<div style="position: relative;"> 
				<div class="style-watermark" style="font-size:72pt; LEFT: 0px; TOP: 0px; Z-Index:10">
					C
				</div>
				<div style="position:relative;z-index:100">
				<!-- C Content -->
				<b>A High C encounters stress when...</b>
				<ul class="checkbox">
					<li>Someone changes his/her plans</li>
					<li>Someone criticizes his/her work</li>
					<li>When forced to make decisions or commitments with what he/she feels is insufficient information</li>
					<li>When there is not enough time to double check and ensure quality stands are met</li>
				</ul>
			</div>
			</div>
		</td>
		<td width="50%" class="with-border">
			<div style="position: relative;"> 
				<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;
								font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: absolute; TOP: 0px; Z-Index:10">
					S
				</div>
				<div style="position:relative;z-index:100">
				<!-- S Content -->
				<b>A High S encounters stress when...</b>
				<ul class="checkbox">
					<li>Routine action does not create expected results</li>
					<li>Another takes an aggressive, take- control attitude</li>
					<li>When there is a lot of unexplained change</li>
				</ul>
			</div>
			</div>
		</td>
	</tr>
</table>

	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	
	<!-- Your style under stress -->

<h1>Your Style Under Stress...</h1>	
<% If HighType1 = "D" then %>
	<!--#Include FILE="AppModulePerformance_under_stress_D.asp" -->
<% elseif HighType1 = "I" then %>
	<!--#Include FILE="AppModulePerformance_under_stress_I.asp" -->
<% elseif HighType1 = "S" then %>
	<!--#Include FILE="AppModulePerformance_under_stress_S.asp" -->
<% else %>
	<!--#Include FILE="AppModulePerformance_under_stress_C.asp" -->
<% end if %>
<br><br>
<h2>Other Styles Under Stress...</h2>
<% If HighType1 <> "D" then %>
	<!--#Include FILE="AppModulePerformance_under_stress_D.asp" -->
<% end if
	if HighType1 <> "I" then %>
	<!--#Include FILE="AppModulePerformance_under_stress_I.asp" -->
<% end if
	if HighType1 <> "S" then %>
	<!--#Include FILE="AppModulePerformance_under_stress_S.asp" -->
<% end if
	if HighType1 <> "C" then %>
	<!--#Include FILE="AppModulePerformance_under_stress_C.asp" -->
<% end if %>
	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	
	<!-- How to handle stress -->
	<h2 style="margin-bottom:0px;">When You're Under Stress:</h2>
	<h1 style="text-align:center; margin-top:0px;">How to Handle</h1>
	
	<p><%=username1%>, when you’re under stress, you can take certain steps to relieve the stress you feel and its effects on others.</p>
	
	<ul>
		<li>Create support systems, alleviating stress through humor, balancing work and 
			play, talking it out, or seeking counseling if necessary.  Remember that 
			managers need support also, and they need to be able to recognize when those
			who follow them need support.<br><br></li>
		<li>Admit to your employees that performance management is often stressful.  
			If people understand what’s going on in your life, they will be more apt 
			to understand your actions.  You don’t have to be superhuman, and sometimes 
			admitting your own vulnerability actually causes others to respect you for 
			your honesty and forthrightness.<br><br></li>
		<li>Improve your physical ability to cope by making sure that you get the proper 
			nutrition, adequate rest, and regular exercise.<br><br></li>
		<li>Change your environment by structuring time off from work, avoiding certain 
			meetings or situations, getting involved in an education program, or in some 
			cases changing jobs or even vocations.<br><br></li>
	</ul>
	<br><br>
	<h2 style="margin-bottom:0px;">When You're Employees are Under Stress:</h2>
	<h1 style="text-align:center; margin-top:0px;">How to Handle</h1>
	
	<ul>
		<li>Acknowledge that person’s behavior as stress induced, and accept the fact 
			that the requirements of the job will include stress.  The faster that you 
			determine that someone’s behavior is stress related, the more effectively 
			you can deal with the situation.<br><br></li>
		<li>Recognize the environment (either internal or external) that is causing the 
			stress.  If you are causing or contributing to that stress, evaluate what you 
			can change and what you can’t.  Many times we know if someone is on deadline or 
			under the gun to make quota.  It’s harder to pinpoint when the stress is coming 
			from one’s personal life, since we may not know a lot about that person away 
			from the office.  Take responsibility to look for clues that may give you an 
			idea of the cause, and give people the benefit of the doubt, at least initially.<br><br></li>
		<li>Try to keep from reacting in a way that escalates the situation.  Many times, 
			someone’s behavior can be so unpleasant that we begin to demonstrate our own 
			stress behavior.  Keep your focus on the stress that is causing this behavior, 
			and find ways to alleviate it, if possible. For example, if that person seems 
			unable to deal with one more problem, delay telling her about the unhappy 
			customer who called to complain about her.<br></li>
	</ul>
	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	
	<!-- Identifying the styles of others -->
	<h1>
		Identifying the Style of Others
	</h1>

<p>
	To successfully adapt our own style to match the temperament of another person, we 
	must first be able to identify the style of that individual. Obviously, we can't always 
	administer the Personal DISCernment® Inventory (PDI), so how can we recognize the 
	temperament of others? One of the strengths of the PDI, as well as other DISC 
	instruments, is that it deals largely with &quot;observable&quot; behavior. A careful, informed 
	observation can help you develop a reasonably accurate &quot;guesstimate&quot; 
	of someone's personal style.
</p>

<h3>
	In identifying the styles of others the following principles will help:
</h3>

<ul>
	<li>
		Understand the limitations of trying to identify others' styles by observation alone. 
		Although certainly influenced by inner, unseen forces, behavior is not clear evidence 
		of values, motives, intelligence, feelings, or attitudes. As you observe a person 
		behaving or &quot;acting&quot; in a certain manner, don't ascribe the underlying emotion or 
		motive. Confine your conclusions to &quot;observable&quot; behavior.
		<br><br></li>
	<li>
		Withhold final judgment until you have had more than one encounter. 
		Often it takes time to develop the confidence that you have accurately assessed an 
		individual. If others don't trust you or don't perceive the environment as safe, they 
		may put up a mask. Create an atmosphere that encourages others to be themselves.
		<br><br></li>
	<li>
		Pay particular attention to nonverbal communication. 
		Words account for less than 10 percent of any communication. Watch the body 
		language, facial expressions, and gestures of the other individual. For example, an 
		action-oriented person may be more animated with gestures, use more vocal 
		inflection and facial expressions.
		<br><br></li>
	<li>
		Use your knowledge to increase your understanding of and response to others' needs. 
		Your ability to recognize styles in others, coupled with an understanding of the 
		needs of various styles, can greatly increase your effectiveness as a manager.
	</li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

																	
<h3>
	Let's review the four-element model that we introduced in the PDI.
</h3>

<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/fourelementmodel.jpg"><br>
	<b>Figure 1</b>
</div>

<p>
	On the following pages, we expand on this model to identify the more visible behavioral 
	tendencies of different styles.
</p>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																		
<h3>
	People vs. Task
</h3>
<p>
Using this model, we can see in Figure 2 that those to the right of the vertical line are 
more people-oriented and those to the left are more task-oriented. These groups also 
have certain &quot;observable&quot; characteristics. People-oriented individuals tend to connect 
more readily with others, often with warmth and openness. On the other hand, task-
oriented people are generally cooler, more reserved, and somewhat less expressive.
</p>
<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/peoplevtaskvertical.jpg"><br>
	<b>Figure 2</b>
</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																			
<h3>
Action vs. Response
</h3>
<p>
Now, notice the horizontal line. People above the horizontal line tend to be active or 
assertive; these individuals generally demonstrate a bold, confident, and directive 
demeanor to others. Those below the line are more responsive or accommodating; 
others see them as low key, collaborative, and self-controlled. Detailed descriptions of 
tendencies in assertive and responsive temperaments are shown in the diagram below:
</p>

<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/peoplevtaskhorizontal.gif"><br>
	<b>Figure 3</b>
</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																				
<h1>
	DISC Compatibility Matrix
</h1>
<p>
As you observed in the previous exercise, different personal style combinations present 
opportunities and potential for compatibility or for conflict. Although not carved in stone, 
the following matrices present typical relational and task compatibilities of the various 
styles and rank them on a scale from Excellent to Poor.
</p>
<p>
First, let's consider Relational Compatibility. How well do two styles interact in casual or 
general situations? For example, how do you get along with a coworker who may be in 
your department but rarely intersects with your job? Or, in your experience with 
roommates, which ones stand out as delights or disasters? Relational Compatibility 
involves the aspects and attributes of a relationship, whether casual or intimate.
</p>
<h3 style="text-align:center">
	Relational Compatibility
</h3>
<div align="center"><!--#Include FILE="relationshipcompatibility.asp" --></div>
<p>
Next, let's look at Task Compatibility. Some combinations that rank low on Relational 
Compatibility have excellent Task Compatibility. You may work extremely well on a 
project with someone that you might not want to take on vacation!
</p>
<h3 style="text-align:center">
Task Compatibility
</h3>

<div align="center"><!--#Include FILE="taskcompatibility.asp" --></div>

	<p>
	Notice also that these are tendencies or potential compatibilities. They aren't 
	rules for behavior, and people find many ways to adapt and compensate to offset 
	the potential for conflict.
	</p>
	
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

	
	<!-- Managing Employees with Different Styles -->

	<h2 style="margin-bottom:0px;">Performance Management with</h2>
	<h1 style="text-align:center; margin-top:0px;">Employees of Different Styles</h1>
	<br>
	
	<table align="center" width="100%" cellpadding="1px" class="with-border" ID="Table5">
	<tr valign="top">
		<td width="50%" class="with-border">
			<div style="position: relative;"> 
				<div class="style-watermark" style="font-size:72pt; LEFT: 0px; TOP: 0px; Z-Index:10">
					D
				</div>

				<div style="position:relative;z-index:100">
					<!-- D Content -->
					<b>Managing Performance of Another High D</b>
					<ul>
						<li>Set goals that will challenge logic and analytical ability.</li>
						<li>Offer options when possible.</li>'
						<li>Give the D control of certain projects.</li>
						<li>Be alert for possible interpersonal issues with other employees.</li>
						<li>Give feedback in a direct and straightforward way.</li>
						<li>Provide enough details for the D to do the job.</li>
					</ul>
				</div>
			</div>
		</td>
		<td width="50%" class="with-border">
			<div style="position: relative;"> 
				<div class="style-watermark" style="font-size:72pt; LEFT: 0px; TOP: 0px; Z-Index:10">
					I
				</div>
				<div style="position:relative;z-index:100">
					<!-- I Content -->
					<b>Managing Performance of a High I</b>
					<ul>
						<li>Be friendly and democratic.</li>
						<li>Allow the High I to talk through issues.</li>
						<li>Make sure that you give this person recognition for accomplishments.</li>
						<li>Present negative feedback in a way that doesn’t seem to indicate that you think less of this person.</li>
						<li>Take some time to show interest in the person as well as the performance.</li>
						<li>Help the High I to prioritize, manage time, and meet deadlines.</li>
						<li>Create some structure.</li>
					</ul>
				</div>
			</div>
		</td>
	</tr>
	<tr valign="top">
		<td width="50%" class="with-border">
			<div style="position: relative;"> 
				<div class="style-watermark" style="font-size:72pt; LEFT: 0px; TOP: 0px; Z-Index:10">
					C
				</div>
				<div style="position:relative;z-index:100">
				<!-- C Content -->
				<b>Managing Performance of a High C</b>
				<ul>
					<li>Outline exactly what you expect.</li>
					<li>Provide resources, procedures, and guidelines.</li>
					<li>Modify your usual high-key, pressure-cooker style.</li>
					<li>Help the High C keep projects moving.</li>
					<li>Be available to discuss key moves in stressful situations.</li>
					<li>Commend the High C’s good work</li>
				</ul>
			</div>
			</div>
		</td>
		<td width="50%" class="with-border">
			<div style="position: relative;"> 
				<div class="style-watermark" style="font-size:72pt; LEFT: 0px; TOP: 0px; Z-Index:10">
					S
				</div>
				<div style="position:relative;z-index:100">
				<!-- S Content -->
				<b>Managing Performance of a High S</b>
				<ul>
					<li>Be low key and non-threatening.</li>
					<li>Schedule multiple sessions along the way.</li>
					<li>Provide sincere appreciation.</li>
					<li>Couch negative feedback in a positive environment.</li>
					<li>Provide plenty of warning for change.</li>
					<li>Allow the High S to work at an established and self-regulated pace.</li>
				</ul>
			</div>
			</div>
		</td>
	</tr>
</table>
	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	
	<!-- Back Page -->
	<p>
	The <strong>DISC Profile System<sup>&reg;</sup></strong> is a family of instruments and workbooks designed specifically to increase 
	understanding of yourself and others to achieve greater personal and interpersonal effectiveness.
	</p>
	<p>
		The <strong>Personal DISCernment<sup>&reg;</sup> Inventory</strong>, the basic module, provides a unique insight into your 
		temperament, producing both a general and a detailed description of your behavioral style. This 
		instrument also allows you to develop a comprehensive list of your strengths and weaknesses.
	</p>


	<h1>
		Five application modules are available:
	</h1>

	<p>
		The <strong>DISC Profile<sup>&reg;</sup> System</strong> includes a series of application modules that will guide you in applying these 
		insights to specific situations. The module workbooks provide additional information each behavioral style 
		as it relates to that arena and suggest how you may apply this information to yourself and your 
		teammates.
	</p>

	<h3>
		Teamwork with Style
	</h3>

	<p>
		Each temperament brings unique strengths and weaknesses to the team setting. Your behavioral 
		style influences the way you plan and organize your work, communicate and make decisions. 
		This workbook will provide the opportunity for you to identify, explore, and discuss the effects of 
		the individual behavioral styles on your team. The result will be enhanced understanding of how 
		to build on individual differences for greater team effectiveness.
	</p>
		

	<h3>
		Leading with Style
	</h3>


	<p>
		Our behavioral traits are not only a major influence on our leadership style, but also provide the 
		template through which we view the leadership of others. When we are led by those with different 
		behavioral styles from our own, we have a tendency to feel overled. Understanding these 
		differences will not only help you to better serve those you lead, but also help you to better 
		respond to the leadership of others.
	</p>
		

	<h3>
		Communicating with Style
	</h3>


	<p>
		This module will help you recognize how your personal communication style enhances or 
		impedes the messages that you send to others. In addition, you will learn to identify the styles of 
		those receiving your message, and discover ways to adapt your style to meet their needs. As a 
		result, you will greatly improve the effectiveness of your written and spoken communication in a 
		variety of situations.
	</p>


	<h3>
		Selling with Style
	</h3>


	<p>
		Behavioral style not only influences how we persuade or convince others, but how we ourselves 
		are persuaded. This module, designed for the sales environment, provides insights into the 
		strengths and weaknesses of each behavioral style as we attempt to communicate with and 
		convince others. You will also discover how different temperaments receive and respond to such 
		overtures. These insights can greatly increase your effectiveness in communicating a point of 
		view, as well as understanding and meeting the needs of others.
	</p>
		

	<h3>
		Time Management with Style
	</h3>


	<p>
		Our personalities often determine our attitudes toward time: how we respond to time constraints, 
		how we discipline ourselves, how much energy we have to get things done, and how we view 
		deadlines. This workbook outlines each behavioral style's response to the various aspects of time 
		and personal management.
	</p>

	<p>
		For more information call Triaxia Partners, Inc. at 1.800.214.3917 or visit our website: www.triaxiapartners.com
	</p>
	
	
	</div> <!-- END OF HTML CONTENT -->
</body>
</html>
