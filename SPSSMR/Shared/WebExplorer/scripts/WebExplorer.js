//Get Frames
function GetActionFrame()
{
    return top.frames["action"];
}

function GetTreeFrame()
{
    return top.frames["tree"];
}

function GetFileListFrame()
{
    return top.frames["filelist"];
}

function GetToolbarFrame()
{
    return top.frames["toolbar"];
}

function GetMainFrame()
{
    return top.frames[0];
}

function GetKeyCode(evt)
{
    var nKeyCode;

    evt = event;
    nKeyCode = evt.keyCode;
    
    return nKeyCode
}

function setUpdating(fileListFrame, value)
{
    var isUpdating = fileListFrame.document.getElementById("isUpdating");
    isUpdating.value = value;
}

//Move Up One Level via the keyboard
function KeyMoveUpOneLevel(evt)
{
   var nKeyCode;
   nKeyCode = GetKeyCode(evt);
   switch (nKeyCode)
    {
        case 13: //enter
            MoveUpOneLevel();
            break;
        default:
            //do nothing
            break;
    }
}

//Move Up One Level
function MoveUpOneLevel()
{
   var treeFrame = GetTreeFrame();
   var selectedNode = treeFrame.getSelectedTreeNode();
   if(selectedNode != null) //tree could be expanded but no node selected
   {
      var parentNode = selectedNode.getParent();
      if(parentNode != null) //check we are not at the top of the tree
      {
           var parentTag = parentNode.getTag();
           treeFrame.setSelectedTreeNode(parentTag);
      }
   }
}

//Delete via the keyboard
function KeyDeleteFileFolder(evt)
{
   var nKeyCode;
   nKeyCode = GetKeyCode(evt);
   switch (nKeyCode)
    {
        case 13: //enter
            DeleteFileFolder();
            break;
        default:
            //do nothing
            break;
    }
}

//Delete
function DeleteFileFolder() //Toolbar
{
   var fileListFrame = GetFileListFrame();
   var confirmDelete = GetConfirmDeleteMsg(fileListFrame);
   var doDelete = confirm(confirmDelete);

   if (doDelete == true)
   { 
       var identifier = fileListFrame.document.getElementById("currentIdentifier").value; 
       var gridname = fileListFrame.document.getElementById("gridName").value;
   
       SharedDelete(gridname, identifier, fileListFrame);
       fileListFrame.document.getElementById("deleteBtn").click();
   }
   else
   {
       setUpdating(fileListFrame, false);
   }
   
}

function rowDeleteAction(gridname, identifier) //Server
{
   var fileListFrame = GetFileListFrame();
   var confirmDelete = GetConfirmDeleteMsg(fileListFrame);
   var doDelete = confirm(confirmDelete);

   if (doDelete == true)
   {
       SharedDelete(gridname, identifier, fileListFrame);
       fileListFrame.document.getElementById("deleteBtn").click();
   }
   else
   {
       setUpdating(fileListFrame, false);
       return true; //cancels the action
   }
}

function SharedDelete(gridname, identifier, fileListFrame) //Shared
{
    setUpdating(fileListFrame, true);
    var currentIsDirectory = fileListFrame.document.getElementById("currentIsDirectory").value;
    var aliasValue = fileListFrame.document.getElementById("currentAlias").value; 
}

function GetConfirmDeleteMsg(fileListFrame)
{
   var confirmDelete = fileListFrame.document.getElementById("confirmDeleteMsg").value;
   var currentName = fileListFrame.document.getElementById("currentName").value;
   confirmDelete = confirmDelete + currentName + '?';
   return confirmDelete;
}

//CreateFolder via the keyboard
function KeyCreateFolder(evt)
{
   var nKeyCode;
   nKeyCode = GetKeyCode(evt);
   switch (nKeyCode)
    {
        case 13: //enter
            CreateFolder();
            break;
        default:
            //do nothing
            break;
    }
}

//Create Folder
function CreateFolder()
{
   var fileListFrame = GetFileListFrame();
   setUpdating(fileListFrame, true);
   
   var currentAlias = fileListFrame.document.getElementById("currentAlias");
       
   var treeFrame = GetTreeFrame();
   var selectedNode = treeFrame.getSelectedTreeNode();
   currentAlias.value = selectedNode.getTag();
    
   fileListFrame.document.getElementById("createBtn").click();
}

//Upload via the keyboard
function KeyOpenUploadDlg(evt)
{
   var nKeyCode;
   nKeyCode = GetKeyCode(evt);
   switch (nKeyCode)
    {
        case 13: //enter
            OpenUploadDlg();
            break;
        default:
            //do nothing
            break;
    }
}

//Upload
function OpenUploadDlg() 
{
    var hash = "";
    showUploadConfigFileDialog(hash)
    
}

function showUploadConfigFileDialog(hash)
{
	var subfolder = generateRandomHash();
	var theURL = "../../../../shared/uploadfile/default.aspx?projid=&subfolder=" + subfolder + "&hash=" + hash;
	var result = ShowUploadDialogFromUrl(theURL);
	var fileListFrame = GetFileListFrame();
	result = true;
	
	if(result == true)
	{
	    setUpdating(fileListFrame, true);
	
	    var mySubFolder = fileListFrame.document.getElementById("subFolder");
        mySubFolder.value = subfolder;
        
        var currentAlias = fileListFrame.document.getElementById("currentAlias");
       
        var treeFrame = GetTreeFrame();
        var selectedNode = treeFrame.getSelectedTreeNode();
        currentAlias.value = selectedNode.getTag();
        
        fileListFrame.document.getElementById("uploadBtn").click();
    }
    else
    {
        setUpdating(fileListFrame, false);
	    top.frames["filelist"].window.location.href=node.getTargetUrl();
    }

     
}

function generateRandomHash()
{
	var hex = new Array('0','1','2','3','4','5','6','7','8', '9','a','b','c','d','e','f');
	var outB = '';
	
	for (count = 0; count < 32; count++)
		outB += hex[Math.floor(Math.random() * 16)];
	return outB;
}

//Download via the keyboard
function KeyOpenDownloadDlg(evt)
{
   var nKeyCode;
   nKeyCode = GetKeyCode(evt);
   switch (nKeyCode)
    {
        case 13: //enter
            OpenDownloadDlg();
            break;
        default:
            //do nothing
            break;
    }
}

//Download
function OpenDownloadDlg()
{     
   var fileListFrame = GetFileListFrame(); 
   fileListFrame.document.getElementById("downloadBtn").click(); 
}

//Copy via the keyboard
function KeyCopy(evt)
{
   var nKeyCode;
   nKeyCode = GetKeyCode(evt);
   switch (nKeyCode)
    {
        case 13: //enter
            Copy();
            break;
        default:
            //do nothing
            break;
    }
}

//Copy
function Copy()
{
    var fileListFrame = GetFileListFrame();
    setUpdating(fileListFrame, true);
    
    fileListFrame.document.getElementById("copyBtn").click();
}

//Paste via the keyboard
function KeyPaste(evt)
{
   var nKeyCode;
   nKeyCode = GetKeyCode(evt);
   switch (nKeyCode)
    {
        case 13: //enter
            Paste();
            break;
        default:
            //do nothing
            break;
    }
}

//Paste
function Paste()
{
    var fileListFrame = GetFileListFrame();
    setUpdating(fileListFrame, true);
    
    var currentAlias = fileListFrame.document.getElementById("currentAlias");
       
    var treeFrame = GetTreeFrame();
    var selectedNode = treeFrame.getSelectedTreeNode();
    currentAlias.value = selectedNode.getTag();
    
    fileListFrame.document.getElementById("pasteBtn").click();
}

//Cut via the keyboard
function KeyCut(evt)
{
   var nKeyCode;
   nKeyCode = GetKeyCode(evt);
   switch (nKeyCode)
    {
        case 13: //enter
            Cut();
            break;
        default:
            //do nothing
            break;
    }
}

//Cut
function Cut()
{
    var fileListFrame = GetFileListFrame();
    setUpdating(fileListFrame, true);
    
    fileListFrame.document.getElementById("cutBtn").click();
}

//Called when a file list item is selected
function fileListItemSelected(gridname, identifier, other) //Server
{
    var treeFrame = GetTreeFrame();
    var selectedTreeNode = treeFrame.getSelectedTreeNode();

    var treeTag = selectedTreeNode.getTag();
    var currentTreeAlias = escape(treeTag);

    var fileListFrame = GetFileListFrame();
    var currentAlias = fileListFrame.document.getElementById("currentAlias").value;
    var currentFileListAlias = escape(currentAlias);
   
    var toolbarFrame = GetToolbarFrame();
    toolbarFrame.location.href = "Toolbar.aspx?currentFileListAlias=" + currentFileListAlias + "&currentTreeAlias=" + currentTreeAlias;
    
    var currentIsDirectory = fileListFrame.document.getElementById("currentIsDirectory").value;
    var userControlId = fileListFrame.document.getElementById("userControlId").value;
    updateFileNameAndButtons(userControlId, currentIsDirectory, currentAlias);
}

function updateFileNameAndButtons(userControlId, isDirectory, currentAlias)
{
    var txtFileName = top.frames.document.getElementById(userControlId + "_txtFileName");
    var okBtn = top.frames.document.getElementById(userControlId + "_btnOK"); 
    
    if(isDirectory == "false")
    {
        var lastSeparatorIndex = currentAlias.lastIndexOf("\\"); 
        if(lastSeparatorIndex != -1)
        {
            txtFileName.value = currentAlias.substring(lastSeparatorIndex + 1);
            okBtn.disabled = false;
        }
    }
    else
    {
         txtFileName.value = "";
         okBtn.disabled = true;
    }

}

function UpdateOKButton(userControlId)
{
    var txtFileName = top.frames.document.getElementById(userControlId + "_txtFileName");
    var okBtn = top.frames.document.getElementById(userControlId + "_btnOK"); 
    
    if(txtFileName.value != "")
    {
       okBtn.disabled = false;
    }
    else
    {
       okBtn.disabled = true;
    }
}

//Called when a file list item is double clicked
function doubleClickAction(gridname, identifier)
{
    var row = igtbl_getRowById(identifier);
    
    var treeFrame = GetTreeFrame();
    var isDirectoryCell = row.getCellFromKey("IsDirectory");
    var isDirectory = isDirectoryCell.getValue();
    
    var aliasCell = row.getCellFromKey("Alias");
    var aliasValue = unescape(aliasCell.getValue());
    if(isDirectory)
    { 
        treeFrame.setSelectedTreeNode(aliasValue);
    }
    else //a file
    {
    }
}

function isValidFilename(value)
{
    var length = value.length;
	var name = value;
    	
    var isValid = true;
    
	if (name=="")
	    isValid = false;

	var errorMsg = "";
    var containsBadChars = "";
    var i = 0;
	if( isValid != false)
	{
        while(i<length) 
        {		
		    var pos = 0;
		    pos = i;
		    var charCode = name.charCodeAt(i);		
		    i=i+1;
        		
		    if (charCode > 0x7F && charCode < 0xffff) 
		        continue;
        		
		    var character = name.charAt(pos);
            if ((character >= 'A' && character <= 'Z') || (character >= 'a' && character <= 'z') || character == '_') {
                continue;       // a-z, A-Z and _ allowed in any position
            }
            if (i == 1) {
		        isValid = false;   // first char isn't alpha or _
		        var fileListFrame = GetFileListFrame();
	            var invalidFirstCharMsg = fileListFrame.document.getElementById("invalidFirstCharMsg").value;
	            errorMsg = errorMsg + invalidFirstCharMsg;
		        break;
            }
            if ((character >= '0' && character <= '9') || character == '#' || character == '@' || character == '$' || character == '.') {
                continue;       // digits and # @ $ allowed after first char
            }
		    isValid = false;
		    containsBadChars = containsBadChars + character; 
		    var fileListFrame = GetFileListFrame();
	        var invalidFileNameMsg = fileListFrame.document.getElementById("invalidFileNameMsg").value;
	        errorMsg = errorMsg + invalidFileNameMsg + containsBadChars + '\n'; 
		    break;
        } 
           
    }
	
	if(errorMsg != "")
	{
	    alert(errorMsg);
	}
	
	return isValid;
}

function enableNodeInTree(identifier, enabled)
{
    var row = igtbl_getRowById(identifier);
    
    var treeFrame = GetTreeFrame();
    var isDirectoryCell = row.getCellFromKey("IsDirectory");
    var isDirectory = isDirectoryCell.getValue();
    
    var aliasCell = row.getCellFromKey("Alias");
    var aliasValue = unescape(aliasCell.getValue());
    if(isDirectory)
    { 
        treeFrame.setEnabledTreeNode(aliasValue, enabled);
    }
    else //a file
    {
    }
}

function beforeRenameAction(gridname, identifier, value)
{
  if(isValidFilename(value) == true)
  {
      var fileListFrame = GetFileListFrame();
      setUpdating(fileListFrame, true);
        
      var newNameValue = document.getElementById("newName");
      newNameValue.value = value;
      
      var treeFrame = GetTreeFrame();
      treeFrame.setEnabledTree(false);  
      fileListFrame.document.getElementById("renameBtn").click();
  }
  else
  {
      return true; // cancels the edit
  }
}

function enterCellEditMode(gridname, identifier)
{
   var toolbarFrame = GetToolbarFrame();
   disableToolbarButtons(toolbarFrame);
}

function exitCellEditMode(gridname, identifier)
{
   var fileListFrame = GetFileListFrame();
   var newNameValue = document.getElementById("newName").value;
   if(newNameValue == "")
   {
      var treeFrame = GetTreeFrame();
      var selectedNode = treeFrame.getSelectedTreeNode();
      var treeAlias = selectedNode.getTag();
      var fileListAlias = fileListFrame.document.getElementById("currentAlias").value; 
    
      setGridVisibility("hidden");
      treeFrame.refreshToolbarFromTags(treeAlias, fileListAlias); 
      setTimeout('setGridVisibility("visible")', 1000);
   }
   
}

//mrBug00043904
//function activateRow(gridname)
//{
//    var myGrid = igtbl_getGridById(gridname);
//    if (myGrid.Rows.length > 0) 
//    { 
//        myGrid.Rows.getRow(0).getCell(0).activate();
//    }
//}

function setGridVisibility(visibility)
{
    var myGrid = igtbl_getGridById("MyGrid");
    var enclosingDiv = myGrid.getDivElement();
    enclosingDiv.style.visibility = visibility;
}

function disableToolbarButtons(toolbarFrame)
{
  var imgUp = toolbarFrame.document.getElementById("imgUp");
  imgUp.onclick = null;
  imgUp.className = "dimmed";
  var imgDelete = toolbarFrame.document.getElementById("imgDelete");
  imgDelete.onclick = null;
  imgDelete.className = "dimmed";
  var imgCreate = toolbarFrame.document.getElementById("imgCreate");
  imgCreate.onclick = null;
  imgCreate.className = "dimmed";
  var imgUpload = toolbarFrame.document.getElementById("imgUpload");
  imgUpload.onclick = null;
  imgUpload.className = "dimmed";
  var imgDownload = toolbarFrame.document.getElementById("imgDownload");
  imgDownload.onclick = null;
  imgDownload.className = "dimmed";
  var imgCopy = toolbarFrame.document.getElementById("imgCopy");
  imgCopy.onclick = null;
  imgCopy.className = "dimmed";
  var imgPaste = toolbarFrame.document.getElementById("imgPaste");
  imgPaste.onclick = null;
  imgPaste.className = "dimmed";
  var imgCut = toolbarFrame.document.getElementById("imgCut");
  imgCut.onclick = null;
  imgCut.className = "dimmed";
}






//Called when file types drop down is changed
function updateFileList(filesOfTypeObj)
{
    var filesOfTypeId = filesOfTypeObj.id;
    var filesOfType = document.getElementById(filesOfTypeId);
    var fileType = filesOfType.value;
    var fileListFrame = GetFileListFrame();
    var filePattern = fileListFrame.document.getElementById("filePattern");
    filePattern.value = fileType;
    setUpdating(fileListFrame, true);
    fileListFrame.document.getElementById("displayFilesBtn").click();       
}

//Helpers
function saveCurrentData(gridname, identifier) //Server
{
    var fileListFrame = GetFileListFrame();
    SharedSaveCurrentData(gridname, identifier, fileListFrame)
}

function SharedSaveCurrentData(gridname, identifier, fileListFrame) //Shared
{
    var currentRow = igtbl_getRowById(identifier); 
    
    var currentName = fileListFrame.document.getElementById("currentName");
    var nameCell = currentRow.getCellFromKey("Name");
    currentName.value = nameCell.getValue(); 
    
    var currentAlias = fileListFrame.document.getElementById("currentAlias");
    var aliasCell = currentRow.getCellFromKey("Alias");
    currentAlias.value = unescape(aliasCell.getValue());
    
    var currentIsDirectory = fileListFrame.document.getElementById("currentIsDirectory");
    var isDirectoryCell = currentRow.getCellFromKey("IsDirectory");
    currentIsDirectory.value = isDirectoryCell.getValue();
    
    var currentIdentifier = fileListFrame.document.getElementById("currentIdentifier");
    currentIdentifier.value = identifier;
    
    var gridName = fileListFrame.document.getElementById("gridName");
    gridName.value = gridname;
    
}

//Open or Save a file
function OpenFile(webControlId)
{
   OpenOrSaveHelper(webControlId);
}

function SaveFile(webControlId)
{
   OpenOrSaveHelper(webControlId);
}

function OpenOrSaveHelper(webControlId)
{
    var treeFrame = GetTreeFrame();
    var node = treeFrame.getSelectedTreeNode();
    var aliasValue = node.getTag();
    
    var selectedAlias = document.getElementById(webControlId + "_selectedAlias"); 
    selectedAlias.value = escape(aliasValue);
}


//Not Implemented
function ChangeView()
{
    alert("ChangeView (NOT IMPLEMENTED)");
}




