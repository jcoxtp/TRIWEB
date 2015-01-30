//<script language="javascript">

var weekend = [0,6];
var weekendColor = "white";
var fontface = "Verdana";
var fontsize = 2;

var gNow = new Date();
var gCurr = null;
var WinCal;
isNav = (navigator.appName.indexOf("Netscape") != -1) ? true : false;
isIE = (navigator.appName.indexOf("Microsoft") != -1) ? true : false;

Calendar.Months = ["January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December"];

// Non-Leap year Month days..
Calendar.DOMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
// Leap year Month days..
Calendar.lDOMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

function Calendar(p_item, p_WinCal, p_month, p_year, p_format) {
	if ((p_month == null) && (p_year == null))	return;

	if (p_WinCal == null)
		this.gWinCal = WinCal;
	else
		this.gWinCal = p_WinCal;
	
	if (p_month == null) {
		this.gMonthName = null;
		this.gMonth = null;
		this.gYearly = true;
	} else {
		this.gMonthName = Calendar.get_month(p_month);
		this.gMonth = new Number(p_month);
		this.gYearly = false;
	}

	this.gYear = p_year;
	this.gFormat = p_format;
	this.gBGColor = "white";
	this.gFGColor = "black";
	this.gTextColor = "black";
	this.gHeaderColor = "black";
	this.gReturnItem = p_item;
}

//Calendar.get_month = Calendar_get_month;
//Calendar.get_daysofmonth = Calendar_get_daysofmonth;
//Calendar.calc_month_year = Calendar_calc_month_year;
//Calendar.print = Calendar_print;

Calendar.get_month = function(monthNo) {
	return Calendar.Months[monthNo];
}

Calendar.get_daysofmonth = function(monthNo, p_year) {
	/* 
	Check for leap year ..
	1.Years evenly divisible by four are normally leap years, except for... 
	2.Years also evenly divisible by 100 are not leap years, except for... 
	3.Years also evenly divisible by 400 are leap years. 
	*/
	if ((p_year % 4) == 0) {
		if ((p_year % 100) == 0 && (p_year % 400) != 0)
			return Calendar.DOMonth[monthNo];
	
		return Calendar.lDOMonth[monthNo];
	} else
		return Calendar.DOMonth[monthNo];
}

Calendar.calc_month_year = function(p_Month, p_Year, incr) {
	/* 
	Will return an 1-D array with 1st element being the calculated month 
	and second being the calculated year 
	after applying the month increment/decrement as specified by 'incr' parameter.
	'incr' will normally have 1/-1 to navigate thru the months.
	*/
	var ret_arr = new Array();
	
	if (incr == -1) {
		// B A C K W A R D
		if (p_Month == 0) {
			ret_arr[0] = 11;
			ret_arr[1] = parseInt(p_Year) - 1;
		}
		else {
			ret_arr[0] = parseInt(p_Month) - 1;
			ret_arr[1] = parseInt(p_Year);
		}
	} else if (incr == 1) {
		// F O R W A R D
		if (p_Month == 11) {
			ret_arr[0] = 0;
			ret_arr[1] = parseInt(p_Year) + 1;
		}
		else {
			ret_arr[0] = parseInt(p_Month) + 1;
			ret_arr[1] = parseInt(p_Year);
		}
	}
	
	return ret_arr;
}

Calendar.print = function() {
	WinCal.print();
}

Calendar.calc_month_year = function(p_Month, p_Year, incr) {
	/* 
	Will return an 1-D array with 1st element being the calculated month 
	and second being the calculated year 
	after applying the month increment/decrement as specified by 'incr' parameter.
	'incr' will normally have 1/-1 to navigate thru the months.
	*/
	var ret_arr = new Array();
	
	if (incr == -1) {
		// B A C K W A R D
		if (p_Month == 0) {
			ret_arr[0] = 11;
			ret_arr[1] = parseInt(p_Year) - 1;
		}
		else {
			ret_arr[0] = parseInt(p_Month) - 1;
			ret_arr[1] = parseInt(p_Year);
		}
	} else if (incr == 1) {
		// F O R W A R D
		if (p_Month == 11) {
			ret_arr[0] = 0;
			ret_arr[1] = parseInt(p_Year) + 1;
		}
		else {
			ret_arr[0] = parseInt(p_Month) + 1;
			ret_arr[1] = parseInt(p_Year);
		}
	}
	
	return ret_arr;
}

// This is for compatibility with Navigator 3, we have to create and discard one object before the prototype object exists.
new Calendar();

Calendar.prototype.getMonthlyCalendarCode = function() {
	var vCode = "";
	var vHeader_Code = "";
	var vData_Code = "";
	
	// Begin Table Drawing code here..
	vCode = vCode + "<TABLE width='175' BORDER=0 cellspacing='4' cellpadding='0' BGCOLOR=\"" + this.gBGColor + "\">";
	
	vHeader_Code = this.cal_header();
	vData_Code = this.cal_data();
	vCode = vCode + vHeader_Code + vData_Code;
	
	vCode = vCode + "</TABLE>";
	
	return vCode;
}

Calendar.prototype.show = function() {
	var vCode = "";
	
	this.gWinCal.document.open();

	// Setup the page...
	this.wwrite("<html>");
	this.wwrite("<head><title>Calendar</title>");
	this.wwrite("<style>body {margin: 0px;} a {text-decoration:underline;} a:hover{color:#ff0000;}</style>");
	this.wwrite("</head>");

	this.wwrite("<body " + 
		"link=\"" + this.gLinkColor + "\" " + 
		"vlink=\"" + this.gLinkColor + "\" " +
		"alink=\"" + this.gLinkColor + "\" " +
		"text=\"" + this.gTextColor + "\"><center>");

	// Show navigation buttons
	var prevMMYYYY = Calendar.calc_month_year(this.gMonth, this.gYear, -1);
	var prevMM = prevMMYYYY[0];
	var prevYYYY = prevMMYYYY[1];

	var nextMMYYYY = Calendar.calc_month_year(this.gMonth, this.gYear, 1);
	var nextMM = nextMMYYYY[0];
	var nextYYYY = nextMMYYYY[1];
	
	this.wwrite("<TABLE WIDTH=175 BORDER=0 CELLSPACING=0 CELLPADDING=0 BGCOLOR='#eeeeee'><TR>");
    this.wwrite("<TD ALIGN='left'>");
	this.wwrite("<A HREF=\"" +
		"javascript:window.opener.Build(" + 
		"'" + this.gReturnItem + "', '" + prevMM + "', '" + prevYYYY + "', '" + this.gFormat + "'" +
		");" +
		"\"><img src='images/calPrev.gif' border='0' width='11' height='15' /></A></TD>");
	this.wwrite("<td align='center'>");
	this.wwriteA("<FONT FACE='" + fontface + "' SIZE=2><B>");
	this.wwriteA(this.gMonthName + " " + this.gYear);
	this.wwriteA("</B></td>");

	this.wwrite("<td align='right'>");
	this.wwrite("<A HREF=\"" +
		"javascript:window.opener.Build(" + 
		"'" + this.gReturnItem + "', '" + nextMM + "', '" + nextYYYY + "', '" + this.gFormat + "'" +
		");" +
		"\"><img src='images/calNext.gif' border='0' width='11' height='15' /></A></TD>");
	this.wwrite("</TR></TABLE>");

	// Get the complete calendar code for the month..
	vCode = this.getMonthlyCalendarCode();
	this.wwrite(vCode);
    this.wwrite("<center><input type='button' value='Today'" 
        + "onClick=\"self.opener.document." + this.gReturnItem + ".value='" + 
					this.format_date(new Date()) + 
					"';window.close();\"></center>");

    this.wwrite("</font></body></html>");
	this.gWinCal.document.close();
}

Calendar.prototype.showY = function() {
	var vCode = "";
	var i;
	var vr, vc, vx, vy;		// Row, Column, X-coord, Y-coord
	var vxf = 285;			// X-Factor
	var vyf = 200;			// Y-Factor
	var vxm = 10;			// X-margin
	var vym;				// Y-margin
	if (isIE)	vym = 75;
	else if (isNav)	vym = 25;
	
	this.gWinCal.document.open();

	this.wwrite("<html>");
	this.wwrite("<head><title>Calendar</title>");
	this.wwrite("<style type='text/css'>\n<!--");
	for (i=0; i<12; i++) {
		vc = i % 3;
		if (i>=0 && i<= 2)	vr = 0;
		if (i>=3 && i<= 5)	vr = 1;
		if (i>=6 && i<= 8)	vr = 2;
		if (i>=9 && i<= 11)	vr = 3;
		
		vx = parseInt(vxf * vc) + vxm;
		vy = parseInt(vyf * vr) + vym;

		this.wwrite(".lclass" + i + " {position:absolute;top:" + vy + ";left:" + vx + ";}");
	}
	this.wwrite("-->\n</style>");
	this.wwrite("</head>");

	this.wwrite("<body " + 
		"link=\"" + this.gLinkColor + "\" " + 
		"vlink=\"" + this.gLinkColor + "\" " +
		"alink=\"" + this.gLinkColor + "\" " +
		"text=\"" + this.gTextColor + "\">");
	this.wwrite("<FONT FACE='" + fontface + "' SIZE=2><B>");
	this.wwrite("Year : " + this.gYear);
	this.wwrite("</B><BR>");

	// Show navigation buttons
	var prevYYYY = parseInt(this.gYear) - 1;
	var nextYYYY = parseInt(this.gYear) + 1;
	
	this.wwrite("<TABLE WIDTH='100%' BORDER=1 CELLSPACING=0 CELLPADDING=0 BGCOLOR='#e0e0e0'><TR><TD ALIGN=center>");
	this.wwrite("[<A HREF=\"" +
		"javascript:window.opener.Build(" + 
		"'" + this.gReturnItem + "', null, '" + prevYYYY + "', '" + this.gFormat + "'" +
		");" +
		"\" alt='Prev Year'><<<\/A>]</TD><TD ALIGN=center>");
	this.wwrite("[<A HREF=\"javascript:window.print();\">Print</A>]</TD><TD ALIGN=center>");
	this.wwrite("[<A HREF=\"" +
		"javascript:window.opener.Build(" + 
		"'" + this.gReturnItem + "', null, '" + nextYYYY + "', '" + this.gFormat + "'" +
		");" +
		"\">>><\/A>]</TD></TR></TABLE><BR>");

	// Get the complete calendar code for each month..
	var j;
	for (i=11; i>=0; i--) {
		if (isIE)
			this.wwrite("<DIV ID=\"layer" + i + "\" CLASS=\"lclass" + i + "\">");
		else if (isNav)
			this.wwrite("<LAYER ID=\"layer" + i + "\" CLASS=\"lclass" + i + "\">");

		this.gMonth = i;
		this.gMonthName = Calendar.get_month(this.gMonth);
		vCode = this.getMonthlyCalendarCode();
		this.wwrite(this.gMonthName + "/" + this.gYear + "<BR>");
		this.wwrite(vCode);

		if (isIE)
			this.wwrite("</DIV>");
		else if (isNav)
			this.wwrite("</LAYER>");
	}

	this.wwrite("</font><BR></body></html>");
	this.gWinCal.document.close();
}

Calendar.prototype.wwrite = function(wtext) {
	this.gWinCal.document.writeln(wtext);
}

Calendar.prototype.wwriteA = function(wtext) {
	this.gWinCal.document.write(wtext);
}

Calendar.prototype.cal_header = function() {
	var vCode = "";
	
	vCode = vCode + "<TR>";
	vCode = vCode + "<TD align='right' WIDTH='14%'><FONT SIZE='2' FACE='" + fontface + "' COLOR='" + this.gHeaderColor + "'><B>S</B></FONT></TD>";
	vCode = vCode + "<TD align='right' WIDTH='14%'><FONT SIZE='2' FACE='" + fontface + "' COLOR='" + this.gHeaderColor + "'><B>M</B></FONT></TD>";
	vCode = vCode + "<TD align='right' WIDTH='14%'><FONT SIZE='2' FACE='" + fontface + "' COLOR='" + this.gHeaderColor + "'><B>T</B></FONT></TD>";
	vCode = vCode + "<TD align='right' WIDTH='14%'><FONT SIZE='2' FACE='" + fontface + "' COLOR='" + this.gHeaderColor + "'><B>W</B></FONT></TD>";
	vCode = vCode + "<TD align='right' WIDTH='14%'><FONT SIZE='2' FACE='" + fontface + "' COLOR='" + this.gHeaderColor + "'><B>T</B></FONT></TD>";
	vCode = vCode + "<TD align='right' WIDTH='14%'><FONT SIZE='2' FACE='" + fontface + "' COLOR='" + this.gHeaderColor + "'><B>F</B></FONT></TD>";
	vCode = vCode + "<TD align='right' WIDTH='14%'><FONT SIZE='2' FACE='" + fontface + "' COLOR='" + this.gHeaderColor + "'><B>S</B></FONT></TD>";
	vCode = vCode + "</TR>";
	vCode = vCode + "<tr><td colspan='7' height='1' bgcolor='black'><img src='../images/spacer.gif' width='1' height='1'></td></tr>";
	return vCode;
}

Calendar.prototype.cal_data = function() {
	var vDate = new Date();
	vDate.setDate(1);
	vDate.setMonth(this.gMonth);
	vDate.setFullYear(this.gYear);

	var vFirstDay=vDate.getDay();
	var vDay=1;
	var vLastDay=Calendar.get_daysofmonth(this.gMonth, this.gYear);
	var vOnLastDay=0;
	var vCode = "";
	var vNumWeeks = 0;

	/*
	Get day for the 1st of the requested month/year..
	Place as many blank cells before the 1st day of the month as necessary. 
	*/

    
    var vFirstOfMonth = new Date(this.gYear, this.gMonth, 1);
    var vLastOfPrevMonth = new Date(vFirstOfMonth.valueOf() - 86400000);
    var lastDateOfPrevMonth = vLastOfPrevMonth.getDate();
    
	vCode = vCode + "<TR>";
	for (i=0; i<vFirstDay; i++) {
		vCode = vCode + "<TD align='right' WIDTH='14%'" + this.write_weekend_string(i) + "><FONT SIZE='2' FACE='" + fontface + "' color='gray'>"
        vCode = vCode + (lastDateOfPrevMonth - vFirstDay + i + 1).toString();
		vCode = vCode + "</FONT></TD>";
	}

	// Write rest of the 1st week
	for (j=vFirstDay; j<7; j++) {
		vCode = vCode + "<TD align='right' WIDTH='14%'" + this.write_weekend_string(j) + "><FONT SIZE='2' FACE='" + fontface + "'>" + 
			"<A HREF='#' " + 
				"onClick=\"self.opener.document." + this.gReturnItem + ".value='" + 
				this.format_data(vDay) + 
				"';window.close();\">" + 
				this.format_day(vDay) + 
			"</A>" + 
			"</FONT></TD>";
		vDay=vDay + 1;
	}
	vCode = vCode + "</TR>";
    vNumWeeks++;
    
	// Write the rest of the weeks
	for (k=2; k<7; k++) {
		vCode = vCode + "<TR>";

		for (j=0; j<7; j++) {
			vCode = vCode + "<TD align='right' WIDTH='14%'" + this.write_weekend_string(j) + "><FONT SIZE='2' FACE='" + fontface + "'>" + 
				"<A HREF='#' " + 
					"onClick=\"self.opener.document." + this.gReturnItem + ".value='" + 
					this.format_data(vDay) + 
					"';window.close();\">" + 
				this.format_day(vDay) + 
				"</A>" + 
				"</FONT></TD>";
			vDay=vDay + 1;

			if (vDay > vLastDay) {
				vOnLastDay = 1;
				break;
			}
		}

		if (j == 6)
			vCode = vCode + "</TR>";
		if (vOnLastDay == 1)
			break;
        vNumWeeks++;    			
	}
	
	// Fill up the rest of last week with proper blanks, so that we get proper square blocks
	for (m=1; m<(7-j); m++) {
		if (this.gYearly)
			vCode = vCode + "<TD align='right' WIDTH='14%'" + this.write_weekend_string(j+m) + 
			"><FONT SIZE='2' FACE='" + fontface + "' COLOR='gray'> </FONT></TD>";
		else
			vCode = vCode + "<TD align='right' WIDTH='14%'" + this.write_weekend_string(j+m) + 
			"><FONT SIZE='2' FACE='" + fontface + "' COLOR='gray'>" + m + "</FONT></TD>";
	}
	vCode = vCode + "</tr>";
	vNumWeeks++;
	
	if(vNumWeeks < 6) {
    	vCode = vCode + "<tr>";
	    for (n = 0; n < 7; n++, m++) {
	    	if (this.gYearly)
	    		vCode = vCode + "<TD align='right' WIDTH='14%'" + this.write_weekend_string(j+m) + 
	    		"><FONT SIZE='2' FACE='" + fontface + "' COLOR='gray'> </FONT></TD>";
	    	else
	    		vCode = vCode + "<TD align='right' WIDTH='14%'" + this.write_weekend_string(j+m) + 
	    		"><FONT SIZE='2' FACE='" + fontface + "' COLOR='gray'>" + m + "</FONT></TD>";
	    }
	    vCode = vCode + "</tr>";

    }	
    vNumWeeks++;
    
	
	vCode = vCode + "<tr><td colspan='7' height='1' bgcolor='black'><img src='/images/spacer.gif' width='1' height='1'></td></tr>";

	return vCode;
}

Calendar.prototype.format_day = function(vday) {
	var vNowDay = gNow.getDate();
	var vNowMonth = gNow.getMonth();
	var vNowYear = gNow.getFullYear();

    var span1 = "";
    var span2 = "";        

    if (gCurr) {
   	    var vCurrDay = gCurr.getDate();
	    var vCurrMonth = gCurr.getMonth();
	    var vCurrYear = gCurr.getFullYear();
        
	    if (vday == vCurrDay && this.gMonth == vCurrMonth && this.gYear == vCurrYear) {
	        span1 = '<span style="background-color: #cccccc">';
	        span2 = '</span>';
	    }
	}
  
	if (vday == vNowDay && this.gMonth == vNowMonth && this.gYear == vNowYear)
		return ("<FONT COLOR=\"RED\"><B>" + span1 + vday + span2 + "</B></FONT>");
	else
		return span1 + vday + span2;
}

Calendar.prototype.write_weekend_string = function(vday) {
	var i;

	// Return special formatting for the weekend day.
	for (i=0; i<weekend.length; i++) {
		if (vday == weekend[i])
			return (" BGCOLOR=\"" + weekendColor + "\"");
	}
	
	return "";
}

Calendar.prototype.format_data = function(p_day) {
    
    return this.format_date(new Date(this.gYear, this.gMonth, p_day));
}

Calendar.prototype.format_date = function(p_date) {
	var vData;
	var vMonth = 1 + p_date.getMonth();
	vMonth = (vMonth.toString().length < 2) ? "0" + vMonth : vMonth;
	var vMon = Calendar.get_month(p_date.getMonth()).substr(0,3).toUpperCase();
	var vFMon = Calendar.get_month(p_date.getMonth()).toUpperCase();
	var vY4 = new String(p_date.getFullYear());
	var vY2 = new String(p_date.getFullYear().toString().substr(2,2));
	var vDD = (p_date.getDate().toString().length < 2) ? "0" + p_date.getDate() : p_date.getDate();

	switch (this.gFormat) {
		case "MM\/DD\/YYYY" :
			vData = vMonth + "\/" + vDD + "\/" + vY4;
			break;
		case "MM\/DD\/YY" :
			vData = vMonth + "\/" + vDD + "\/" + vY2;
			break;
		case "MM-DD-YYYY" :
			vData = vMonth + "-" + vDD + "-" + vY4;
			break;
		case "MM-DD-YY" :
			vData = vMonth + "-" + vDD + "-" + vY2;
			break;

		case "DD\/MON\/YYYY" :
			vData = vDD + "\/" + vMon + "\/" + vY4;
			break;
		case "DD\/MON\/YY" :
			vData = vDD + "\/" + vMon + "\/" + vY2;
			break;
		case "DD-MON-YYYY" :
			vData = vDD + "-" + vMon + "-" + vY4;
			break;
		case "DD-MON-YY" :
			vData = vDD + "-" + vMon + "-" + vY2;
			break;

		case "DD\/MONTH\/YYYY" :
			vData = vDD + "\/" + vFMon + "\/" + vY4;
			break;
		case "DD\/MONTH\/YY" :
			vData = vDD + "\/" + vFMon + "\/" + vY2;
			break;
		case "DD-MONTH-YYYY" :
			vData = vDD + "-" + vFMon + "-" + vY4;
			break;
		case "DD-MONTH-YY" :
			vData = vDD + "-" + vFMon + "-" + vY2;
			break;

		case "DD\/MM\/YYYY" :
			vData = vDD + "\/" + vMonth + "\/" + vY4;
			break;
		case "DD\/MM\/YY" :
			vData = vDD + "\/" + vMonth + "\/" + vY2;
			break;
		case "DD-MM-YYYY" :
			vData = vDD + "-" + vMonth + "-" + vY4;
			break;
		case "YYYY-MM-DD" :
			vData = vY4 + "-" + vMonth + "-" + vDD;
			break;
		case "DD-MM-YY" :
			vData = vDD + "-" + vMonth + "-" + vY2;
			break;

		default :
			vData = vMonth + "\/" + vDD + "\/" + vY4;
	}

	return vData;
}

function Build(p_item, p_month, p_year, p_format) {
	var p_WinCal = WinCal;
	gCal = new Calendar(p_item, p_WinCal, p_month, p_year, p_format);

	// Customize your Calendar here..
	gCal.gBGColor="white";
	gCal.gLinkColor="navy";
	gCal.gTextColor="black";
	gCal.gHeaderColor="navy";

	// Choose appropriate show function
	if (gCal.gYearly)	gCal.showY();
	else	gCal.show();
}

function show_calendar() {
	/* 
		p_item	: Return Item.
		p_month : 0-11 for Jan-Dec; 12 for All Months.
		p_year	: 4-digit year
		p_format: Date format (mm/dd/yyyy, dd/mm/yy, ...)
	*/

    gCurr = null;
    
	p_item = arguments[0];
	if (arguments.length == 1) {
	    var value = eval("window.document." + p_item + ".value");
	    //alert("window.document." + p_item + ".value=" + value);
	    try {
	        gCurr = new Date(Date.parse(value));
	    }
	    catch(e) {
	        gCurr = new Date();
	    }
	    if (gCurr == "NaN") gCurr = new Date();  	
	} 
	//alert("gCurr=" + gCurr);
	
	if (arguments[1] == null)
		p_month = new String(gCurr.getMonth());
	else
		p_month = arguments[1];
	if (arguments[2] == "" || arguments[2] == null)
		p_year = new String(gCurr.getFullYear().toString());
	else
		p_year = arguments[2];
	if (arguments[3] == null)
		p_format = "MM/DD/YYYY";
	else
		p_format = arguments[3];

    eval("var item = window.document." + p_item);
    //alert(item);
    
    var top = window.screenTop + getOffsetTop(item) + item.offsetHeight - window.document.body.scrollTop;
    var left = window.screenLeft + getOffsetLeft(item) - window.document.body.scrollLeft;
    //alert (top + ", " + left + ", " + item.offsetHeight);
    
	vWinCal = window.open("", "Calendar", 
		"width=180,height=200,status=no,resizable=no,top=" + top + ",left=" + left);
	vWinCal.opener = self;
	WinCal = vWinCal;

	// mag hack
	p_format = 'YYYY-MM-DD'
	
	Build(p_item, p_month, p_year, p_format);
}

function getOffsetTop(item)
{
    var top = item.offsetTop;
    while (item.tagName != "BODY") {
        item = item.offsetParent;
        top = top + item.offsetTop;
    }
    return top;
}

function getOffsetLeft(item)
{
    var left = item.offsetLeft;
    while (item.tagName != "BODY") {
        item = item.offsetParent;
        left = left + item.offsetLeft;
    }
    return left;
}

/*
Yearly Calendar Code Starts here
*/
function show_yearly_calendar(p_item, p_year, p_format) {
	// Load the defaults..
	if (p_year == null || p_year == "")
		p_year = new String(gNow.getFullYear().toString());
	if (p_format == null || p_format == "")
		p_format = "MM/DD/YYYY";

	var vWinCal = window.open("", "Calendar", "scrollbars=yes");
	vWinCal.opener = self;
	WinCal = vWinCal;

	Build(p_item, null, p_year, p_format);
}



//</script>