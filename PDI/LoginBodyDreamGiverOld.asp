<div id="CenterAll">
	<table border="0" cellspacing="0" cellpadding="0" width="768" height="650" style="background-image: url('/RS/<%=SitePathName%>/background.jpg'); background-repeat:no-repeat;">
		<tr><td></td></tr>
	</table>
	<div id="login_form">
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
			<tr align="left">
				<td valign="middle" width="50%" height="55">
					<span class="logintext">First-time user? Please <a class="loginform_link" href="UserRegistration.asp?res=<%=intResellerID%>" target="_top">register</a>.<br /></span>
					<span class="logintext">Forgot username or password? Have it <a class="loginform_link" href="emailusernamepswd.asp?res=<%=intResellerID%>" target="_top">sent</a> to you.</span>
				</td>
				<td valign="middle" width="5%">&nbsp;</td>
				<td valign="middle">
					<table border="0" cellspacing="0" cellpadding="2">
						<form name="thisForm" id="thisForm" method="post" action="login.asp?res=<%=intResellerID%>" target="_top">
						<tr>
							<td valign="middle" align="right">
								<span class="logintext"><strong>Username:&nbsp;</strong></span>
							</td>
							<td valign="middle"><input name="txtUserName" class="loginform_field" type="text" size="20" maxlength="32" />
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right"><span class="logintext"><strong>Password:&nbsp;</strong></span>
							</td>
							<td valign="middle">
								<input name="txtPassword" class="loginform_field" type="password" size="20" maxlength="32" />
							</td>
						</tr>
					</table>
				</td>
				<td valign="middle" align="right"><input type="submit" value="Enter" id="add" name="add" />
					<input type="hidden" name="txtSubmit" id="txtSubmit" value="1" />
				</td>
				<td width="5%">&nbsp;</td>
			</tr>
		</table>
		</form>
	</div>
	<div id="login_section01">
		<p class="logintext">The more we know about ourselves and others, the better we can work with and relate to other people. The <!--#Include FILE="Include/pdi.asp" --> (PDI) helps us understand how and why people are likely to behave in one way or another.</p>
		<p class="logintext">This unique educational instrument is based on the time-tested DISC theory that provides powerful insights into your work and social style. It will enable you to discover and define how you view yourself and how you want others to see you. And through that process, you will learn more about the real you - a person who might be slightly different than you thought.</p>
		<p class="logintext">The <!--#Include FILE="Include/pdi.asp" --> isn't an exam; <strong>there are no "right" or "wrong" answers</strong>. It is a tool for helping you discover and analyze your own behavioral style so that you can better adapt your behavior to particular situations and create more productive working and interpersonal relationships with others.</p>
		<% IF intResellerID = 2 Then 'The Dream Giver %>
			<p class="logintext">The DreamGiver Assessment connects the insights from your DISC profile to your personal Dream Journey.  This customized report explores each stage of your Dream and describes the unique challenges you will encounter due to your style's particular strengths and weaknesses.  Learn about the major issues in each stage and discover how to successfully navigate the path to fulfilling your Dream.</p>
		<% End If %>
	</div>
	
	<div id="login_section02">
		<p class="big_learnmore">Learn More</p>
		<ul>
			<li class="logintext">The <a class="login_section02_link" href="DISCBackground.asp?res=<%=intResellerID%>" target="_top">History and Theory</a> of DISC</li>
			<li class="logintext">The <a class="login_section02_link" href="OnlinePDIReport.asp?res=<%=intResellerID%>" target="_top">Online</a> <!--#Include FILE="Include/pdi.asp" --></li>
				<% IF intResellerID = 2 Then 'The Dream Giver %>
					<li class="logintext">The <a class="login_section02_link" href="DGAssessment.asp?res=<%=intResellerID%>" target="_top"> DreamGiver Assessment</a></li>
					<li class="logintext">The <a class="login_section02_link" href="disc_profile.asp?res=<%=intResellerID%>" target="_top"> DISC Profile</a> System<sup>®</sup></li>
				<% Else %>
					<li class="logintext">Tailored <a class="login_section02_link" href="PDIAppReports.asp?res=<%=intResellerID%>" target="_top">Application Reports</a></li>
					<li class="logintext"><a class="login_section02_link" href="VolumeDiscounts.asp?res=<%=intResellerID%>" target="_top">Multiple Copies</a> / Volume Discounts</li>
				<% End If %>
			<li class="logintext"><a class="login_section02_link" href="PrivacyPolicy.asp?res=<%=intResellerID%>" target="_top">Privacy Policy</a></li>
		</ul>
	</div>
</div>
