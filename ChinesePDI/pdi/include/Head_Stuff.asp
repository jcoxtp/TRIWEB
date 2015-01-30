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
	if (window.confirm("你肯定要退出吗?"))
	{
		window.location = "logout.asp?res=<%=intResellerID%>";
	}
}
</script>