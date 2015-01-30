//**************************************************************** 
// You are free to copy the "Folder-Tree" script as long as you  
// keep this copyright notice: 
// Script found in: http://www.geocities.com/Paris/LeftBank/2178/ 
// Author: Marcelino Alves Martins (martins@hks.com) December '97. 
//**************************************************************** 
 
//Log of changes: 
//       17 Feb 98 - Fix initialization flashing problem with Netscape
//       
//       27 Jan 98 - Root folder starts open; support for USETEXTLINKS; 
//                   make the ftien4 a js file 
//       
 
 
// Definition of class Folder 
// ***************************************************************** 
var lastselectedfolderid = -1;
 
function Folder(folderDescription, hreference, alias, defSelection) //constructor 
{ 
  //constant data 
  this.desc = folderDescription 
  
  this.hreference = hreference 
  this.alias = alias
  // alert("Folder-1 hreference["+hreference+"]["+this.hreference+"]   description["+folderDescription+"]["+this.desc+"]");
  this.id = -1   
  this.navObj = 0  
  this.iconImg = 0  
  this.nodeImg = 0  
  this.foldercolor = 0
  this.isLastNode = 0 
 
  //dynamic data 
  this.isOpen = true
  this.iconSrc = "images/ftv2folderopen.gif"   
  this.children = new Array 
  this.nChildren = 0 
 
  //methods 
  this.initialize = initializeFolder 
  this.setState = setStateFolder 
  this.addChild = addChild 
  this.createIndex = createEntryIndex 
  this.hide = hideFolder 
  this.display = display 
  this.renderOb = drawFolder 
  this.totalHeight = totalHeight 
  this.subEntries = folderSubEntries 
  this.outputLink = outputFolderLink 
  this.folderFrame = "frmActionView"
  this.defSelection = defSelection
} 
 
function setStateFolder(isOpen) 
{ 
  var subEntries 
  var totalHeight 
  var fIt = 0 
  var i=0 
 
  if (isOpen == this.isOpen) 
    return 
 
  if (browserVersion == 2)  
  { 
    totalHeight = 0 
    for (i=0; i < this.nChildren; i++) 
      totalHeight = totalHeight + this.children[i].navObj.clip.height 
      subEntries = this.subEntries() 
    if (this.isOpen) 
      totalHeight = 0 - totalHeight 
    for (fIt = this.id + subEntries + 1; fIt < nEntries; fIt++) 
      indexOfEntries[fIt].navObj.moveBy(0, totalHeight) 
  }  
  this.isOpen = isOpen 
  propagateChangesInState(this) 
} 
 
function propagateChangesInState(folder) 
{   
  var i=0 
 
  if (folder.isOpen) 
  { 
    if (folder.nodeImg) 
      if (folder.isLastNode) 
        folder.nodeImg.src = "images/ftv2mlastnode.gif" 
      else 
	  folder.nodeImg.src = "images/ftv2mnode.gif" 
    folder.iconImg.src = "images/ftv2folderopen.gif" 
    for (i=0; i<folder.nChildren; i++) 
      folder.children[i].display() 
  } 
  else 
  { 
    if (folder.nodeImg) 
      if (folder.isLastNode) 
        folder.nodeImg.src = "images/ftv2plastnode.gif" 
      else 
	  folder.nodeImg.src = "images/ftv2pnode.gif" 
    folder.iconImg.src = "images/ftv2folderclosed.gif" 
    for (i=0; i<folder.nChildren; i++) 
      folder.children[i].hide() 
  }  
} 
 
function hideFolder() 
{ 
  if (browserVersion == 1) { 
    if (this.navObj.style.display == "none") 
      return 
    this.navObj.style.display = "none" 
  } else { 
    if (this.navObj.visibility == "hiden") 
      return 
    this.navObj.visibility = "hiden" 
  } 
   
  this.setState(0) 
} 
 
function initializeFolder(level, lastNode, leftSide) 
{ 
var j=0 
var i=0 
var numberOfFolders 
var numberOfDocs 
var nc 
      
  nc = this.nChildren 
   
  this.createIndex() 
 
  var auxEv = "" 
 
  if (browserVersion > 0) 
    auxEv = "<a href='javascript:clickOnNode("+this.id+")'>" 
  else 
    auxEv = "<a>" 
 
  if (level>0) 
    if (lastNode) //the last 'brother' in the children array 
    { 
      this.renderOb(leftSide + auxEv + "<img name='nodeIcon" + this.id + "' src='images/ftv2mlastnode.gif' width=22 height=22 border=0></a>") 
      leftSide = leftSide + "<img src='images/ftv2blank.gif' width=22 height=22>"  
      this.isLastNode = 1 
    } 
    else 
    { 
      this.renderOb(leftSide + auxEv + "<img name='nodeIcon" + this.id + "' src='images/ftv2mnode.gif' width=22 height=22 border=0></a>") 
      leftSide = leftSide + "<img src='images/ftv2vertline.gif' width=22 height=22>" 
      this.isLastNode = 0 
    } 
  else 
    this.renderOb("") 
   
  if (nc > 0) 
  { 
    level = level + 1 
    for (i=0 ; i < this.nChildren; i++)  
    { 
      if (i == this.nChildren-1) 
        this.children[i].initialize(level, 1, leftSide) 
      else 
        this.children[i].initialize(level, 0, leftSide) 
      } 
  } 
} 
 
function drawFolder(leftSide) 
{ 
  if (browserVersion == 2) { 
    if (!doc.yPos) 
      doc.yPos=8 
    doc.write("<layer id='folder" + this.id + "' top=" + doc.yPos + " visibility=hidden>") 
  } 
   
  doc.write("<table ") 
  if (browserVersion == 1) 
    doc.write(" id='folder" + this.id + "' style='position:block;' ") 
  doc.write(" border=0 cellspacing=0 cellpadding=0>") 
  doc.write("<tr><td>") 
  doc.write(leftSide) 
  this.outputLink() 
  doc.write("<img name='folderIcon" + this.id + "' ") 
  doc.write("src='" + this.iconSrc+"' border=0></a>") 
  doc.write("</td><td valign=middle nowrap id='foldercolor"+ this.id + "' class='treeitem'>") 
  if (USETEXTLINKS) 
  { 
    this.outputLink() 
    doc.write(this.desc + "</a>") 
  } 
  else
    doc.write(this.desc) 
  doc.write("</td>")  
  doc.write("</table>") 
   
  if (browserVersion == 2) { 
    doc.write("</layer>") 
  } 
 
  if (browserVersion == 1) { 
    this.navObj = doc.all["folder"+this.id] 
    this.iconImg = doc.all["folderIcon"+this.id] 
    this.nodeImg = doc.all["nodeIcon"+this.id] 
    this.foldercolor = doc.all["foldercolor"+this.id] 
  } else if (browserVersion == 2) { 
    this.navObj = doc.layers["folder"+this.id] 
    this.iconImg = this.navObj.document.images["folderIcon"+this.id] 
    this.nodeImg = this.navObj.document.images["nodeIcon"+this.id] 
    this.foldercolor = doc.layers["foldercolor"+this.id]
    doc.yPos=doc.yPos+this.navObj.clip.height 
  } 
  
  if( this.defSelection == true )
  {
	executeAction('frmFilemgrFilelist', escape(this.hreference), this.alias, this.id)
  }
} 

function executeAction(ftarget, eahref, alias, id)
{
	parent.frames[ftarget].window.location="filelist.asp?path="+eahref+"&alias="+alias;
	
	clickOnFolder(id);
}
 
function outputFolderLink() 
{ 
	doc.write("<a onclick=javascript:executeAction('frmFilemgrFilelist','"+escape(this.hreference)+"','"+escape(this.alias)+"',"+this.id+")>")   
} 
 
function addChild(childNode) 
{ 
  this.children[this.nChildren] = childNode 
  this.nChildren++ 
  return childNode 
} 
 
function folderSubEntries() 
{ 
  var i = 0 
  var se = this.nChildren 
 
  for (i=0; i < this.nChildren; i++){ 
    if (this.children[i].children) //is a folder 
      se = se + this.children[i].subEntries() 
  } 
 
  return se 
} 
 
 
// Definition of class Item (a document or link inside a Folder) 
// ************************************************************* 
 
function Item(itemDescription, itemLink) // Constructor 
{ 
  // constant data 
  this.desc = itemDescription 
  this.link = itemLink 
  this.id = -1 //initialized in initalize() 
  this.navObj = 0 //initialized in render() 
  this.iconImg = 0 //initialized in render() 
  this.iconSrc = "images/ftv2doc.gif" 
 
  // methods 
  this.initialize = initializeItem 
  this.createIndex = createEntryIndex 
  this.hide = hideItem 
  this.display = display 
  this.renderOb = drawItem 
  this.totalHeight = totalHeight 
} 
 
function hideItem() 
{ 
  if (browserVersion == 1) { 
    if (this.navObj.style.display == "none") 
      return 
    this.navObj.style.display = "none" 
  } else { 
    if (this.navObj.visibility == "hiden") 
      return 
    this.navObj.visibility = "hiden" 
  }     
} 
 
function initializeItem(level, lastNode, leftSide) 
{  
  this.createIndex() 
 
  if (level>0) 
    if (lastNode) //the last 'brother' in the children array 
    { 
      this.renderOb(leftSide + "<img src='images/ftv2lastnode.gif' width=16 height=22>") 
      leftSide = leftSide + "<img src='images/ftv2blank.gif' width=16 height=22>"  
    } 
    else 
    { 
      this.renderOb(leftSide + "<img src='images/ftv2node.gif' width=16 height=22>") 
      leftSide = leftSide + "<img src='images/ftv2vertline.gif' width=16 height=22>" 
    } 
  else 
    this.renderOb("")   
} 
 
function drawItem(leftSide) 
{ 
  if (browserVersion == 2) 
    doc.write("<layer id='item" + this.id + "' top=" + doc.yPos + " visibility=hiden>") 
     
  doc.write("<table ") 
  if (browserVersion == 1) 
    doc.write(" id='item" + this.id + "' style='position:block;' ") 
  doc.write(" border=0 cellspacing=0 cellpadding=0>") 
  doc.write("<tr><td>") 
  doc.write(leftSide) 
  doc.write("<a href=" + this.link + ">") 
  doc.write("<img id='itemIcon"+this.id+"' ") 
  doc.write("src='"+this.iconSrc+"' border=0>") 
  doc.write("</a>") 
  doc.write("</td><td valign=middle nowrap>") 
  if (USETEXTLINKS) 
    doc.write("<a href=" + this.link + ">" + this.desc + "</a>") 
  else 
    doc.write(this.desc) 
  doc.write("</table>") 
   
  if (browserVersion == 2) 
    doc.write("</layer>") 
 
  if (browserVersion == 1) { 
    this.navObj = doc.all["item"+this.id] 
    this.iconImg = doc.all["itemIcon"+this.id] 
  } else if (browserVersion == 2) { 
    this.navObj = doc.layers["item"+this.id] 
    this.iconImg = this.navObj.document.images["itemIcon"+this.id] 
    doc.yPos=doc.yPos+this.navObj.clip.height 
  } 
} 
 
 
// Methods common to both objects (pseudo-inheritance) 
// ******************************************************** 
 
function display() 
{ 
  if (browserVersion == 1) 
    this.navObj.style.display = "block" 
  else 
    this.navObj.visibility = "show" 
} 
 
function createEntryIndex() 
{ 
  this.id = nEntries 
  indexOfEntries[nEntries] = this 
  nEntries++ 
} 
 
// total height of subEntries open 
function totalHeight() //used with browserVersion == 2 
{ 
  var h = this.navObj.clip.height 
  var i = 0 
   
  if (this.isOpen) //is a folder and _is_ open 
    for (i=0 ; i < this.nChildren; i++)  
      h = h + this.children[i].totalHeight() 
 
  return h 
} 
 
 
// Events 
// ********************************************************* 
 
function clickOnFolder(folderId) 
{ 
  var clicked = indexOfEntries[folderId] 
  if( lastselectedfolderid != -1 )
	var lastclicked = indexOfEntries[lastselectedfolderid] 
 
  if (!clicked.isOpen)
  {
    clickOnNode(folderId) 
  }
  clicked.foldercolor.bgColor ="#DBE9F7";
  
  if( lastselectedfolderid != -1 )
	lastclicked.foldercolor.bgColor ="white";
  
  lastselectedfolderid = folderId
  
  if (clicked.isSelected) 
  {
    return 
  }
} 
 
function clickOnNode(folderId) 
{ 
  var clickedFolder = 0 
  var state = 0 
 
  clickedFolder = indexOfEntries[folderId] 
  state = clickedFolder.isOpen 
 
  clickedFolder.setState(!state) //open<->close  
} 
 
function initializeDocument() 
{ 
  if (doc.all) 
    browserVersion = 1 //IE4   
  else 
    if (doc.layers) 
      browserVersion = 2 //NS4 
    else 
      browserVersion = 0 //other 
 
  foldersTree.initialize(0, 1, "") 
  foldersTree.display()
  
  if (browserVersion > 0) 
  { 
    doc.write("<layer top="+indexOfEntries[nEntries-1].navObj.top+">&nbsp;</layer>") 
 
    // close the whole tree 
    clickOnNode(0) 
    // open the root folder 
    clickOnNode(0) 
  } 
} 
 
// Auxiliary Functions for Folder-Treee backward compatibility 
// ********************************************************* 
 
function gFld(description, hreference, alias, defSelection)
{ 
  folder = new Folder(description, hreference, alias, defSelection) 

  return folder 
} 
 
function gLnk(target, description, linkData) 
{ 
  fullLink = "" 
 
  if (target==0) 
  { 
    fullLink = "'"+linkData+"' target=\"folderFrame\"" 
  } 
  else 
  { 
    if (target==1) 
       fullLink = "'http://"+linkData+"' target=_blank" 
    else 
       fullLink = "'http://"+linkData+"' target=\"folderFrame\"" 
  } 
 
  linkItem = new Item(description, fullLink)   
  return linkItem 
} 
 
function insFld(parentFolder, childFolder) 
{ 
  return parentFolder.addChild(childFolder) 
} 
 
function insDoc(parentFolder, document) 
{ 
  parentFolder.addChild(document) 
} 
 
// Global variables 
// **************** 
 
USETEXTLINKS = 0 
indexOfEntries = new Array 
nEntries = 0 
doc = document 
browserVersion = 0 
selectedFolder=0