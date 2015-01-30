function showDefaultAboutBox(hash)
{
	showAboutBox("shared/aboutbox/aboutbox.aspx?hash=" + hash, 300, 400, false);
}

function showAboutBox(sUrl, iHeight, iWidth, bScrollBars)
{
	var winleft = (screen.width / 2) - (iWidth / 2); // center the window right to left     
	var wintop = (screen.height / 2) - (iHeight / 2); // center the window top to bottom
	var scrollbar="no";
	if (bScrollBars)
		scrollbar="yes";
		
	window.open(sUrl, null, "top="+wintop+", left="+winleft+", height="+iHeight+"px, width="+iWidth+"px, toolbar=no, menubar=no, scrollbars="+scrollbar+", resizable=yes, location=no, directories=no, status=no");
}
