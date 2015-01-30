"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

	<title></title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">

	<link rel="stylesheet" href="Include/Default.css" type="text/css">

	<link rel="stylesheet" href="/RS/TeamResources/Reseller.css" type="text/css">

	<script type="text/javascript">



function openAnyWindow(url, name) {



  // store number of arguments passed in

  var l = openAnyWindow.arguments.length;



  // initialize w (width)

  var w = "";

  // initialize h (height)

  var h = "";

  // initialize features (comma-delineated list of window features)

  var features = "";



  // loop through array of arguments to build list of features

  // begin loop with 2 (third element of array) to skip url and name

  for (i=2; i<l; i++) {



    // store current argument in variable param

    var param = openAnyWindow.arguments[i];



    // if param isn't a number, it's not width or height

    // in that case, append to features with comma

    if ( (parseInt(param) == 0) || (isNaN(parseInt(param))) ) {

      features += param + ',';



    // else param is a number; must be width or height

    } else {



      // if w hasn't been set yet, param must be the width

      // otherwise, w has been set, so param must be the height

      (w == "") ? w = "width=" + param + "," : h = "height=" + param;

    }

  }



  // append width and height strings to list of features

  features += w + h;



  // begin building statement to open window

  var code = "popupWin = window.open(url, name";



  // if l>2, there were more than two arguments

  // in that case, append comma, parenthesis, and list of features

  if (l > 2) code += ", '" + features;



  // finish building statement to open window

  code += "')";



  // execute statement to open window

  eval(code);

}



function confirmLogout()

{

	if (window.confirm('Are you sure you want to log out as jerrycox')) {

		window.location = "logout.asp?res=1";

	}

}



	function setCookie(name, value, expires)

{

    document.cookie= name + "=" + escape(value) + ((expires) ? "; expires=" + expires.toGMTString() : "");

}



function changeLanguage() {

	val = document.langChooser.LanguageID.options[document.langChooser.LanguageID.selectedIndex].value;

	var expdate = new Date ();

	expdate.setTime (expdate.getTime() + (24 * 60 * 60 * 1000 * 365)); 

	setCookie("intLanguageID", val, expdate);



    		window.location.href = "http://localhost/pdi/authresponse.asp?";

}



</script>

</head>

<body>



<img src="/RS/TeamResources/TopBannerEN.gif" border="0" alt="" width="791" height="89" usemap="#banner" />

<map name="banner">

	<area shape="rect" alt="" coords="711,59,761,84" href="javascript:openAnyWindow('help.asp?pageID=','Help',325,200,'left=425','top=200')">



</map>







<div id="leftnavbar">

<p>



	<img src="images/TRLeftNavEN7.jpg" border="0" alt="" usemap="#navbar" />

	<map name="navbar">

		<area shape="rect" alt="" coords="5,234,86,252" href="main.asp?res=1">

		<area shape="rect" alt="" coords="5,255,86,273" href="ContactUs.asp?res=1&lid=1">

		<area shape="rect" alt="" coords="5,278,86,296" href="javascript:confirmLogout()">



	</map>

	</p>



</div>

<div id="maincontent">



				<img src="images/your_purchase.gif">

				<p style="margin-bottom:0px">

				<table border="0" cellspacing="0" cellpadding="6" width="100%">

					<tr>

						<td valign="top" align="center" width="32"><img src="images/reports.gif" alt="" width="32" height="32" /></td>

						<td valign="top">

							<h2>Take Profile or Create an Application Report</h2>

							<p>To take the profile or create an application report, click on the code you would like to use.</p>

							<div align="center">

							<p style="margin-bottom:0px">

							<table border="0" cellspacing="0" cellpadding="6" width="90%">

								<tr>

									<td valign="top" align="center" width="5%"><strong>Number</strong></td>

									<td valign="top" width="60%"><strong>Title</strong></td>

									<td valign="top" width="35%"><strong>Profile Code(s) Purchased</strong></td>

								</tr>

							

								<tr>

                                    <!--Number Column-->

									<td valign="top" align="center">1

									</td>

                                    <!--Title Column-->

									<td valign="top">

									<a href="OnlinePDIReport.asp?res=1">Personal DISCernment Inventory<sup>&reg;</sup></a><br /><span class="bodytext_gray">The Core of the DISC Profile System<sup>&reg;</sup></span>

									</td>

                                    <!--Profile Code Column Column-->

									<td valign="top">

									

										<a href="entertestcode.asp?res=1&MPS=1&TCODE=PDIPMHKJECFD">PDIPMHKJECFD</a>

									

									</td>

								</tr>

							

							</table>

	<!--Javascript to make new links work (ePDI Punch List #3)-->

	<script>	

	function confirmAppPDFCreation(TCID)

	{

		if (window.confirm("It will take about a minute to generate your application report.\r\rYou will then be provided a download link."))

		{

			var goToNextURL;

			goToNextURL = "AppModuleCreatePDF.asp?res=1&TCID=" + TCID + "";

			document.location = goToNextURL;

		}

	}

	</script>

							</p>

							</div>

						</td>

					</tr>

				</table>

				</p>

				<p class="divider"><img src="images/divider.gif" alt="" width="100%" height="9" /></p>

		<p style="margin-bottom:0px">

		<table border="0" cellspacing="0" cellpadding="6" width="100%">

			<tr>

				<td valign="top" align="center" width="32"><img src="images/PrintEN.gif" alt="" width="40" height="36" /></td>

				<td valign="top">

					<h2><a href="logout.asp?res=1">Logout</a> and Use Codes Later</h2>

					<p>Available codes will be stored for future access, but it is recommended that you print this page for your records.</p>

				</td>

			</tr>

		</table>

		</p>

		<p class="addtable">

		<table border="0" cellspacing="0" cellpadding="3" width="100%">

			<tr>

				<td valign="top" align="right"><a href="main.asp?res=1"><img src="images/return_home.gif" alt="" width="93" height="16" /></a></td>

			</tr>

		</table>

		</p>

		"