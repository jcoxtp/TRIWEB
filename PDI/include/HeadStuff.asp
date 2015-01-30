<% If strSiteType = "TR" Then%>
<!--[if lt IE 9]>
<script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<link href='//fonts.googleapis.com/css?family=Open+Sans:300,400,600,600italic,400italic' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">

<link href="include/global.css" rel="stylesheet" />
<link href="include/header.css" rel="stylesheet" />

<script src="./Scripts/jquery-1.11.2.min.js"></script>
<script src="./Scripts/jquery-ui-1.11.2.min.js"></script>
<script src="./Scripts/modernizr.custom.60251.js"></script>
<script type="text/javascript" src="/PDI/Scripts/jquery.placeholder.min.js"></script>
<script src="./Scripts/jquery.popupoverlay.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/PDI/Scripts/jquery.flexverticalcenter.js"></script>
<script src="./Scripts/FooterLoader.js"></script>

<!--SELECTIVIZR-->
<!--[if (gte IE 6)&(lte IE 8)]>
  <script type="text/javascript" src="selectivizr.js"></script>
  <noscript><link rel="stylesheet" href="[fallback css]" /></noscript>
<![endif]-->

<%End If %>

<!--ANALYTICS:-->
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-368995-2', 'pdiprofile.com');
ga('require', 'displayfeatures');
ga('send', 'pageview');
</script> 

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
    if (window.confirm('<%=Application("strTextAreYouSureYouWantToLogOutAs" & strLanguageCode) & " " & Request.Cookies("UserName")%>')) {
        <%
            Response.buffer=true
            Response.Expires = -1
            Response.ExpiresAbsolute = Now() -1 
            Response.AddHeader "pragma", "no-store"
            Response.AddHeader "cache-control","no-store, no-cache, must-revalidate"    
        %>

		window.location = "logout.asp?res=<%=intResellerID%>";
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

    <%
	    strProtocol = Request.ServerVariables("SERVER_PROTOCOL")
	    intPos = (InStr(strProtocol, "/") -1)
	    strProtocol = LCase(Mid(strProtocol, 1, intPos))
	    strWebAddress = Request.ServerVariables("HTTP_HOST")
	    strURL = Request.ServerVariables("URL")
	    strQS = Request.ServerVariables("QUERY_STRING")
	    strThisPageURL = strProtocol & "://" & strWebAddress & strURL & "?" & strQS
	    Response.Write "		window.location.href = """ & strThisPageURL & """;"
    %>
}

</script>
