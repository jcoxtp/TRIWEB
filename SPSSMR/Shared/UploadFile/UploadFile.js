function ShowUploadDialog(projId, multipleFiles, subFolder, hash)
{	
	var multiple = "";
	if (multipleFiles)
		multiple = "&multiple=1";
		
    var theURL = "../shared/uploadfile/default.aspx?projid=" + projId + multiple + "&subfolder=" + subFolder + "&hash=" + hash;
	
	return ShowUploadDialogFromUrl(theURL);
   
}

function ShowUploadDialogWithLanguage(projId, multipleFiles, subFolder, hash,language)
{	
	var multiple = "";
	if (multipleFiles)
		multiple = "&multiple=1";
		
    var theURL = "../shared/uploadfile/default.aspx?projid=" + projId + multiple + "&subfolder=" + subFolder + "&hash=" + hash + "&language=" + language;
	
	return ShowUploadDialogFromUrl(theURL);
   
}

function ShowUploadDialogFromSharedApp(projId, multipleFiles, subFolder, hash)
{
	var multiple = "";
	if (multipleFiles)
		multiple = "&multiple=1";
		
    var theURL = "../../../shared/uploadfile/default.aspx?projid=" + projId + multiple + "&subfolder=" + subFolder + "&hash=" + hash;
	
	return ShowUploadDialogFromUrl(theURL);
	
}

function ShowUploadDialogFromUrl(theURL)
{
    var theHeight = "150px";
	var theWidth = "380px";

   	if(navigator.appName == "Microsoft Internet Explorer")
	{
		var args = {opener: window};
		options = "resizable:yes;scroll:off;status:no;help:no;dialogHeight:" + theHeight + ";dialogWidth:" + theWidth + ";";
		return window.showModalDialog(theURL,args,options);
	}
	else
	{
		var dlgX = top.screenX + (top.innerWidth/2) - parseInt(theWidth)/2;
		var dlgY = top.screenY + (top.innerHeight/2) - parseInt(theHeight)/2;
		
		window.dialog_return_value = "";
		options = "menubar=no,status=no,location=no,dependent=yes,scrollbars=no,resizable=yes,height=" + theHeight + ",width=" + theWidth + ",screenX=" + dlgX + ",screenY=" + dlgY + ",modal=yes";
		window.open(theURL,"",options);
		return window.dialog_return_value;
	}

}