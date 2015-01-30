function MultiSelector()
{
	// How many elements?
	this.count = 0;
	//element name id
	this.id = 0;
	
	// check maximum file count?
    this.max =10;
	/**
	 * Add a new file input element
	 */
	this.addElement = function(element )
	{
		// Make sure it's a file input element
		if (element==null)
		{
		  return;
		}
		if( element.tagName == 'INPUT' && element.type == 'file' )
		{
			// Element name 
			element.name = 'file_' + this.id++;
			element.id = element.name;
			element.multi_selector = this;
			// when a file is selected, add another new file input
			element.onchange = function()
			{
			   // New file input
				var new_element = document.createElement( 'input' );
				new_element.type = 'file';
				new_element.runat='server';
				new_element.style.position='absolute';
				new_element.style.width=element.style.width;
				new_element.style.cursor='hand';
				new_element.contentEditable='false';
				
				// Add new element
				this.parentNode.insertBefore( new_element, this );

				// Apply 'update' to element
				this.multi_selector.addElement( new_element );

                //check whether selected file existed in the selected file list
				var inputList=document.getElementsByTagName('input');
   	            var inputFile;
   	            for(var i=0;i<=inputList.length-1;i++)
  	            {
  	                inputFile=inputList[i];
  	                if (inputFile.type == 'file')
  	                {
                        //since all the files will be save to a same folder,the system only check the filename duplicate or not here
                        if(element.value.substring(element.value.lastIndexOf('\\')+1)==inputFile.value.substring(inputFile.value.lastIndexOf('\\')+1)&&element.name!=inputFile.name)
			            {
			                var oStr=new String(document.getElementById('hFileSelectedWarn').value);
			                alert(oStr.replace('{0}', element.value.substring(element.value.lastIndexOf('\\')+1)));
			                element.parentNode.removeChild(element);
			                multi_selector.count--;
                            
                            fileCount=document.getElementById('hFileCount');
		                    fileCount.value=multi_selector.count;
			      
			                pnlMaxFileCntErr=document.getElementById('pnlMaxFileCountErr');
    		                pnlMaxFileCntErr.style.visibility='hidden';
    		                new_element.disabled = false;
			                return;
			            };
			            
			             if(element.value.length>128)
			            {
			                var oStr=new String(document.getElementById('hLongestFileName').value);
			                alert(oStr);
			                element.parentNode.removeChild(element);
			                multi_selector.count--;
                            
                            fileCount=document.getElementById('hFileCount');
		                    fileCount.value=multi_selector.count;
			      
			                pnlMaxFileCntErr=document.getElementById('pnlMaxFileCountErr');
    		                pnlMaxFileCntErr.style.visibility='hidden';
    		                new_element.disabled = false;
			                return;
			            };
			            
			            //invalid files are not allowed to be uploaded.
			             invalidFileExts=document.getElementById('hInvalidFileExt').value.toLowerCase()+';';
                        if(invalidFileExts.indexOf(element.value.substring(element.value.lastIndexOf('.')+1).toLowerCase()+';')>0)
			            {
			                var oStr=new String(document.getElementById('hExeFileWarn').value);
			                alert(oStr);
			                element.parentNode.removeChild(element);
			                multi_selector.count--;
                            
                            fileCount=document.getElementById('hFileCount');
		                    fileCount.value=multi_selector.count;
			      
			                pnlMaxFileCntErr=document.getElementById('pnlMaxFileCountErr');
    		                pnlMaxFileCntErr.style.visibility='hidden';
    		                new_element.disabled = false;
			                return;
			            };	
   	                };
                };

			    // Update list
			    this.multi_selector.addListRow( this );
                
			    this.style.position = 'absolute';
			    this.style.left = '-1000px';
			};//element.onchange = function()

			// If file count reached maximum number, disable input element
		    this.max=document.getElementById('hMaxFileCount').value
		    
		    if( this.max != -1 && this.count >= this.max )
		    {
		        pnlMaxFileCntErr=document.getElementById('pnlMaxFileCountErr');
    		    pnlMaxFileCntErr.style.visibility='visible';    		   
    		    element.disabled = true;
		    };
		    // File counter 
		    this.count++;
    
            fileCount=document.getElementById('hFileCount');
            fileCount.value=this.count;          
            
            this.current_element = element;
			
		}//if( element.tagName == 'INPUT' && element.type == 'file' ) 
		else 
		{
			alert( 'Error: not a file input element' );
		};

	};//this.addElement = function( element )
	
	
	//Add a new row to the list of files
	this.addListRow = function(element)
	{
		var RoundedTable2 = document.getElementById( 'tblFilesToUpload_tblTable' );
	    //there are 4 rows in the header
	    var oT2Row1=RoundedTable2.insertRow(4);
	    oT2Row1.id='rowFile_'+element.name;
      	 
		//add a new table which has one row contains a checkbox and a file name text
		var new_table = document.createElement( 'table' );
        new_table.setAttribute('border','0');
        new_table.setAttribute('width','100%');

        var oTBody=document.createElement('tbody');
        new_table.appendChild(oTBody);

        var oTRow1=document.createElement('tr');
        oTRow1.setAttribute('valign','top');
        oTBody.appendChild(oTRow1);

        //add a table cell which contains a file name text
        oTCell11=document.createElement('td');
        oTCell11.style.width='98%';
        oTCell11.appendChild(document.createTextNode(element.value.substring(element.value.lastIndexOf('\\')+1)));
        oTRow1.appendChild(oTCell11);

	    //add new cell which contains a delete image
        oTCell12=document.createElement('td');
        oTCell12.align='right';
        var imgDel=document.createElement('img');
        imgDel.name = 'img_' + element.name;
        imgDel.src='Shared/Images/delete.png';
        imgDel.style.cursor='hand';
             
        imgDel.onclick=function deleteThisRow()
                        {
                            //get the current row in RoundedTable2
                           var curRow=document.getElementById('rowFile_'+element.name);
                       
                           inputFile=document.getElementById(element.name);
                           if (inputFile!=null)
                           {
                                //decrease the input file count, enable the current input file Browse Button
                                multi_selector.count--;
                                multi_selector.current_element.disabled=false;
                                inputFile.parentNode.removeChild(inputFile);
                                pnlMaxFileCntErr=document.getElementById('pnlMaxFileCountErr');
    		                    pnlMaxFileCntErr.style.visibility='hidden';
	                           
	                            //update the fileCount, it will be transfer to the query string FileCount which will show in the progressbar window
	                            fileCount=document.getElementById('hFileCount');
    		                    fileCount.value=multi_selector.count;	                     
	                           	
	                            curRow.parentNode.removeChild(curRow);
	                        }// if element!=null

                            setRoundTableStyle();
                        }
                                   
        oTCell12.appendChild(imgDel);
        oTCell12.style.width='10%';
        oTRow1.appendChild(oTCell12);	
    		
    	//add cells to table Files to Upload
    	oT2Cell11=document.createElement('td');
    	oT2Row1.appendChild(oT2Cell11);		
 	    oT2Cell11.style.width='1px';
        oT2Cell11.className='RoundedTableOuterBorder';
        
    	oT2Cell12=document.createElement('td');;
        oT2Row1.appendChild(oT2Cell12);
        oT2Cell12.style.width='9px';
		
		
		//add a cell contains the new table which contains a file name text and delete Icon
		oT2Cell13=document.createElement('td');
        oT2Row1.appendChild(oT2Cell13);
        oT2Cell13.setAttribute('style','width:100%;');
        oT2Cell13.setAttribute('colspan','2');        
        oT2Cell13.appendChild(new_table);
	
		oT2Cell14=document.createElement('td');
        oT2Row1.appendChild(oT2Cell14);
        oT2Cell14.setAttribute('style','width:9px;');
 		
        oT2Cell15=document.createElement('td');
        oT2Row1.appendChild(oT2Cell15);      
        oT2Cell15.setAttribute('style','width:1px;');
        setRoundTableStyle();
	};//this.addListRow = function( element )

};//MultiSelector( list_target, max )

function setRoundTableStyle()
{
    var curTable=document.getElementById('tblFilesToUpload_tblTable');
    var rowsCollect=curTable.tBodies[0].rows;
    var isLight=true;
	for(var i = rowsCollect.length-3; i>=4; i--)
	{
    	if (isLight)
	    {
	        rowsCollect[i].cells[1].className='RoundedTableLightInfo';
	        rowsCollect[i].cells[2].className='RoundedTableLightInfo';
	        rowsCollect[i].cells[3].className='RoundedTableLightInfo';
	        rowsCollect[i].cells[4].className='RoundedTableLightInfo';
	    }
	    else
	    {
	        rowsCollect[i].cells[1].className='RoundedTableDarkInfo';
	        rowsCollect[i].cells[2].className='RoundedTableDarkInfo';
	        rowsCollect[i].cells[3].className='RoundedTableDarkInfo';
	        rowsCollect[i].cells[4].className='RoundedTableDarkInfo';
	    }
	   isLight=!isLight;
    }
}

function closeWindow()
{
    var inputList=document.getElementsByTagName('input');
    
    closeConfirm=true;
    var inputFileCount=0;
    for(var i=0;i<=inputList.length-1;i++)
    {
        inputFile=inputList[i];
        if (inputFile.type == 'file')
        {                       
           inputFileCount++;
           
           if (inputFileCount>2)
           {
                break;
           }
        };
    };
    
    if(inputFileCount>1)
    {
      hCancelMsg=document.getElementById('hCancelUploadWarn').value;          
      closeConfirm=ShowYesNoQuestion(hCancelMsg);
    }
    
    if (closeConfirm)
    window.close();
}