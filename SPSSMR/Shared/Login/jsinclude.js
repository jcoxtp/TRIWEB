function Redirect()
{
	var qs = new QueryString()
	var returnUrl = qs.get("ReturnUrl","");
	window.parent.location.href=returnUrl;
}

function QueryString()
{
// get the query string, ignore the ? at the front.
	var querystring=location.search.substring(1,location.search.length);

// parse out name/value pairs separated via &amp;
	var args = querystring.split('&amp;');

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

	this.get=QueryString_get;
}

function QueryString_get(strKey,strDefault)
{
	var value=this[strKey];
	if (value==null){value=strDefault;}
	
	return value;
}

