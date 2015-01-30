function ShowYesNoQuestion(Prompt)
{
        version=0;           
        if (navigator.appVersion)
        {
            if (navigator.appVersion.indexOf("MSIE")!=-1)
            {
                temp=navigator.appVersion.split("MSIE");
                version=parseFloat(temp[1]);
            }
        }
        
        len=Prompt.length;
        if  (version>6.0)           
         winHeigth=150;
        else
         winHeigth=160;

       if (len*8<240)
        {
            winWidth=240;
        }
        else
        if (len<100)
        {
           winWidth=len*8;
         }
        else
        {
            winWidth=800;
            winHeigth=100+40*(1+len/300);
        }
        
        dialogHeightWidth='dialogHeight:'+winHeigth+'px; dialogWidth:'+winWidth+'px;';

	    if (window.showModalDialog('CustomDialog/QuestionYesNo.aspx',Prompt, dialogHeightWidth+' status:no; help:no; scroll:no')=='Yes')
	    {
	        return true;
	    }
	    else
	    {
	        return false;
	    }
}
