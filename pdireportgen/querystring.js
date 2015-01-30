function Querystring()
{
// get the query string, ignore the ? at the front.
	var querystring=location.search.substring(1,location.search.length);

// parse out name/value pairs separated via &
	var args = querystring.split('&');

// split out each name = value pair
	for (var i=0;i<args.length;i++)
	{
		var pair = args[i].split('=');

		// Fix broken unescaping
		temp = unescape(pair[0]).split('+');
		temp0 = temp.join(' ');
		
		temp = unescape(pair[1]).split('+');
		temp1 = temp.join(' ');
		
		this[temp0]=temp1;
	}

	this.get=Querystring_get;
}

function Querystring_get(strKey,strDefault)
{
	var value=this[strKey];
	if (value==null){value=strDefault;}
	
	return value;
}

function getCookie(c_name)
{
	if (document.cookie.length>0)
	{
	c_start=document.cookie.indexOf(c_name + "=")
	if (c_start!=-1)
		{ 
		c_start=c_start + c_name.length+1 
		c_end=document.cookie.indexOf(";",c_start)
		if (c_end==-1) c_end=document.cookie.length
		return unescape(document.cookie.substring(c_start,c_end))
		} 
	}
	return ""
}

function setCookie(c_name,value,expiredays) 
{
	var exdate=new Date();
	exdate.setDate(exdate.getDate()+expiredays);
	
	document.cookie = c_name + "=" + escape(value) +
	((expiredays==null) ? "" : ";expires=" + exdate.toGMTString());
}