<!-- Performance Drivers -->
	
	<h2 style="margin-bottom:0px;">High <%=HighType1%> Application of</h2>
	<h1 style="text-align:center; margin-top:0px;">Performance Drivers</h1>	
	
	<p>Research demonstrates that application of the following Performance Drivers 
	increases employee learning and accomplishment</p>
	
	<ol>
		<li>Fairness and accuracy</li>
		<li>Climate that allows risk taking</li>
		<li>Emphasis on performance strengths</li>
		<li>Understanding of standards</li>
		<li>Internal communication</li>
		<li>Manager’s knowledge of employee’s job</li>
		<li>Matching abilities to the situation</li>
		<li>Feedback that contains timely and usable advice</li>
		<li>Opportunity to work for a strong team</li>
	</ol>
	
	<table class="with-border" cellpadding="3" ID="Table2">
		<tr>
			<th align="left" width="50%">Application Strengths</th>
			<th align="left" width="50%">Application Weaknesses</th>
		</tr>
		<tr valign="top">
			<td>
				<% If HighType1 = "D" then %>
					<!--#Include FILE="AppModulePerformance_pd_s_D.asp" -->
				<% elseif HighType1 = "I" then %>
					<!--#Include FILE="AppModulePerformance_pd_s_I.asp" -->
				<% elseif HighType1 = "S" then %>
					<!--#Include FILE="AppModulePerformance_pd_s_S.asp" -->
				<% else %>
					<!--#Include FILE="AppModulePerformance_pd_s_C.asp" -->
				<% end if %>	
			</td>
			<td>
				<% If HighType1 = "D" then %>
					<!--#Include FILE="AppModulePerformance_pd_w_D.asp" -->
				<% elseif HighType1 = "I" then %>
					<!--#Include FILE="AppModulePerformance_pd_w_I.asp" -->
				<% elseif HighType1 = "S" then %>
					<!--#Include FILE="AppModulePerformance_pd_w_S.asp" -->
				<% else %>
					<!--#Include FILE="AppModulePerformance_pd_w_C.asp" -->
				<% end if %>	
			</td>
		</tr>
	</table>
	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>