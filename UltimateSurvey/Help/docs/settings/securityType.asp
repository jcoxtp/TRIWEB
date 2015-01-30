<html>
	<head>
		<title>Session Timeout</title>
		<link rel="stylesheet" href="../../includes/stylesheet.css" type="text/css">
	</head>
	<body Menumargin="20" leftmargin="5" class="help-body">
		<p class="help-title">Session Type</p>
		<hr color="#000000" size="1">
		<p class="help-body">
			This application supports both Cookie and IIS Session based session managment. 
			You can change this&nbsp;setting by toggling the "Session Type" option on the 
			settings page. <STRONG>IMPORTANT NOTE: </STRONG>Please note that&nbsp;changing 
			cause any users that are logged into the system to be logged out. Therefore, we 
			do not recommend changing this unless you are positive that you want to switch.
		</p>
		<P class="help-body"><STRONG>Which type should I choose?<BR>
			</STRONG>Both session types have their own pros and cons:</P>
		<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
			<P class="help-body"><STRONG>Cookies</STRONG> (recommended)<BR>
				Cookies are preferred and offer several additional benefits if using surveys 
				with Anonymous access enabled. Specifically, anonymous users are remembered 
				when they leave the site and return. This allows you to properly attach a 
				survey to an anonymous user to allow them to continue where they left off OR to 
				prevent them from taking surveys more than the specified number of times. In 
				addition, using cookies allows the application to be used in a load balanced or 
				redundant environment where IIS session management has been disabled.</P>
			<P class="help-body"><STRONG>Sessions </STRONG>(requires IIS session management to 
				be turned on)<BR>
				In the even that you do not wish to use cookies, the application can support 
				the built in IIS session management. As mentioned in the section above, some 
				features for anonymous survey taking are not available under this scenario as 
				there is no way to identify users that leave and return at a later time.</P>
		</BLOCKQUOTE>
	</body>
</html>
