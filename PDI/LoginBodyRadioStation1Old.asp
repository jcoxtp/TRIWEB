	<div id="login_section01">
		<form name="PurchaseForm" id="PurchaseForm" method="post" action="UserRegistration.asp?res=<%=intResellerID%>" target="_top">
		<input type="hidden" name="txtSubmit" value="0">
		<table width="675" border="0">
			<tr>
				<td>
		<p class="logintext">Are you excited about your Dream Journey, but aren't sure where to start? DISC and the Dream Assessment will give you the tools you need to pursue and achieve your Dream.</p>
		<p class="logintext">To identify your unique personality type, DISC is a simple, effective tool that has been tested and used by millions of people worldwide. The short, online assessment helps you understand what motivates you, your personal strengths and weaknesses, and how you relate to other people.</p>
		<p class="logintext">Once you've taken DISC, a Dream Assessment is instantly customized for you based on your personality type. Everyone approaches the Dream Journey differently, and you have a unique way of pursuing your Dreams! Discover more about each stage of your Dream Journey and how you handle the challenges along the way.</p>
		<p class="logintext">There is a $35 fee for the Dream Assessment. You will be asked to create a separate user id and password for this service.</p>
		<p class="logintext"><input type="submit" name="Submit" value="Purchase Now"><strong>&nbsp;&nbsp;Yes! I'm ready to start on my Dream Journey! </strong></p>
				</td>
			</tr>
		</table>
	</div>
	</form>
	
	<div id="login_section02">
		<table border="0" cellspacing="0" cellpadding="0" width="350" height="175" style="background-image: url('/RS/<%=SitePathName%>/BackgroundPane.jpg'); background-repeat:no-repeat; border-color: #FFFFFF; border-size: 1">
			<tr>
				<td>
					<p class="big_learnmore">&nbsp;&nbsp;&nbsp;Learn More</p>
					<ul>
						<li class="logintext">The <a class="login_section02_link" href="DISCBackground.asp?res=<%=intResellerID%>" target="_top">History and Theory</a> of DISC</li>
						<li class="logintext">The <a class="login_section02_link" href="OnlinePDIReport.asp?res=<%=intResellerID%>" target="_top">Online</a> <!--#Include FILE="Include/pdi.asp" --></li>
						<li class="logintext">The <a class="login_section02_link" href="DGAssessment.asp?res=<%=intResellerID%>" target="_top">Dream Giver Assessment</a></li>
						<li class="logintext">The <a class="login_section02_link" href="disc_profile.asp?res=<%=intResellerID%>" target="_top">DISC Profile</a> System <sup>&reg;</sup></li>
						<li class="logintext">Our <a class="login_section02_link" href="PrivacyPolicy.asp?res=<%=intResellerID%>" target="_top">Privacy Policy</a></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>

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
							<td valign="middle">
								<input name="txtUserName" class="loginform_field" type="text" size="20" maxlength="32" />
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right">
								<span class="logintext"><strong>Password:&nbsp;</strong></span>
							</td>
							<td valign="middle">
								<input name="txtPassword" class="loginform_field" type="password" size="20" maxlength="32" />
							</td>
						</tr>
					</table>
				</td>
				<td valign="middle" align="right">
					<input type="submit" value="Enter" id="add" name="add" />
					<input type="hidden" name="txtSubmit" id="txtSubmit" value="1" />
				</td>
				<td width="5%">&nbsp;</td>
			</tr>
		</table>
		</form>
	</div>
