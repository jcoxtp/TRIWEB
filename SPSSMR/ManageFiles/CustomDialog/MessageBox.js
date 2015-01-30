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


function ShowError(Prompt)
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
        
       var len=Prompt.split('\n').length;
       
        winHeigth=160;
        winWidth=400;
         
         if (len>10)
          {
           winHeigth=14*(len-10)+200;
          }
        
        dialogHeightWidth='dialogHeight:'+winHeigth+'px; dialogWidth:'+winWidth+'px;';

	    window.showModalDialog('CustomDialog/Error.aspx',Prompt, dialogHeightWidth+' status:no; help:no; scroll:no');
	    }

function ShowMergeOverwriteQuestion(Prompt)
{
    //the return value will be Merge, Overwrite or Cancel as a string.
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
       
       if (len*8<360)
        {
            winWidth=360;
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
    return window.showModalDialog('CustomDialog/MergeOverwriteCancel.aspx',Prompt,dialogHeightWidth+' status:no; help:no; scroll:no');
}