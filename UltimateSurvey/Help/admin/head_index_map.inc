<script language="JavaScript">
<!--
var ver='6.1.2EnPro';
var dynLoad=0;
var dynPref='index_map';
var version = parseInt (navigator.appVersion) ;
Opera=(navigator.userAgent.indexOf('Opera')!=-1)||(navigator.appName.indexOf('Opera')!=-1)||(window.opera);
Opera7=(Opera&&document.createElement!=null&&document.addEventListener!=null);
NS4 = (document.layers) ? true : false ;
IE4 = ((document.all) && (version >= 4) && !Opera) ? true : false ;
DOM=document.documentElement&&!NS4&&!IE4&&!Opera;
ver4 = NS4 || IE4 || DOM || Opera;

if (NS4||Opera)
	{
	origWidth = innerWidth;
	origHeight = innerHeight;
	if(Opera)setTimeout("reDo()", 500);
	}
function reDo()
	{
	if (innerWidth != origWidth || innerHeight != origHeight){location.reload();}else {if(Opera)setTimeout("reDo()",500);}
	}
if (NS4)
	onresize = reDo;

var firstItem = 0 ;
var lastItem ;
if (NS4)
	lastItem = document.layers.length - 1 ;
if (IE4)
	lastItem = document.all.tags ("DIV").length - 1 ;

function onClicked (elm,lev,el) {}
function onExpandAll () {}
function onCollapseAll () {}

function getIndexIE (el)
	{
	ind = -1 ;
	tempColl = document.all.tags ("DIV") ;
	for (i = 0 ; i < tempColl.length ; i++)
		{
		var theItem = tempColl (i) ;
		if (theItem == el)
			{
			ind = i ;
			break ;
			}
		}
	return ind ;
	}

function getFntSize(s)
	{
	if(!IE4&&!Opera)
		{
		if (s=="xx-small")
			return "x-small";
		if (s=="x-small")
			return "small";
		if (s=="small")
			return "medium";
		if (s=="medium")
			return "large";
		if (s=="large")
			return "x-large";
		if (s=="x-large")
			return "xx-large";
		}
	return s;
	}

if (ver4)
  {
  with (document)
	{
	write("<STYLE TYPE='text/css'>");
	write (".SXLR,.SXR {color:#003063; font-family:Arial,Verdana,Helvetica; font-size:"+getFntSize("11px")+"; }") ;
	write (".SXLP0,.SXP0 {color:#003063; font-family:Arial,Verdana,Helvetica; font-size:"+getFntSize("11px")+"; }") ;
	write (".SXLC0,.SXC0 {color:#003063; font-family:Arial,Verdana,Helvetica; font-size:"+getFntSize("11px")+"; }") ;
	write (".SXLP1,.SXP1 {color:#003063; font-family:Arial,Verdana,Helvetica; font-size:"+getFntSize("11px")+"; }") ;
	write (".SXLC1,.SXC1 {color:#003063; font-family:Arial,Verdana,Helvetica; font-size:"+getFntSize("11px")+"; }") ;
	write (".SXLP2,.SXP2 {color:#003063; font-family:Arial,Verdana,Helvetica; font-size:"+getFntSize("11px")+"; }") ;
	if(NS4&&!dynLoad)
		{
		write (".TP {position:"+(Opera?"absolute":"relative")+"}");
		leftpos = 10 ;
		toppos = 40 ;

		write (".below {left:"+leftpos+";position:absolute}") ;
		write (".im {vertical-align:top}") ;
		write (".SXP0 {left:"+leftpos+";position:absolute; visibility:hidden}") ;
		write (".SXR {left:"+leftpos+";position:absolute;top:"+toppos+";visibility:hidden}") ;
		write (".SXP1 {left:"+leftpos+";position:absolute; visibility:hidden}") ;
		write (".SXC0 {left:"+leftpos+";position:absolute;visibility:hidden}") ;
		write (".SXP2 {left:"+leftpos+";position:absolute; visibility:hidden}") ;
		write (".SXC1 {left:"+leftpos+";position:absolute;visibility:hidden}") ;
		}
	if(DOM||IE4||Opera7)
		{
		write (".tbl {width='100%'}") ;
		}

	write("</style>");
	}
  }
//-->
</script>
