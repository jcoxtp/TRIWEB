// Updates the tree control size when the browser or frame is resized
function resizeTree()
{
    var theWidth, theHeight;
    var treeWidthOffset = 21;
    var treeHeightOffset = 70;     
    
    if (window.innerWidth) 
    {
        theWidth=window.innerWidth;
    }
    else if (document.documentElement && document.documentElement.clientWidth) 
    {
        theWidth=document.documentElement.clientWidth;
    }
    else if (document.body) 
    {
        theWidth=document.body.clientWidth;
    }

    if (window.innerHeight)
    {
        theHeight=window.innerHeight;
    }
    else if (document.documentElement && document.documentElement.clientHeight) 
    {
        theHeight=document.documentElement.clientHeight;
    }
    else if (document.body) 
    {
        theHeight=document.body.clientHeight;
    }
    var treeDiv = igtree_getTreeById("webTreeProjects").Element;
    
    theWidth = theWidth-treeWidthOffset;
    theHeight = theHeight-treeHeightOffset;
    if(theWidth < 0) theWidth = 0;
    if(theHeight < 0) theHeight = 0;
    treeDiv.style.width = theWidth + "px";
    treeDiv.style.height = theHeight + "px";
}

function scrollInSelectedNode()
{
    var tree = igtree_getTreeById("webTreeProjects");
    var selectedNode = tree.getSelectedNode();
    if(selectedNode)
    {
        selectedNode.scrollIntoView();
    }
    tree.Element.scrollLeft = 0;
}

function cutProject()
{
    var selectedNode = document.forms[0].tbSelection;
    if(!selectedNode)
    {
        return;
    }
    var nodeType = selectedNode.getAttribute("nodetype"); 
    if(nodeType !="project")
	{
	    alert(getI18N("JUSTFORPROJECT"));
	    return;
	}
    var selectedProjectName = selectedNode.value;
    
    var cutNode = document.forms[0].tbCut; 
    var lastCutProjectName = cutNode.value;
    
    var lastCutNodeId = cutNode.value;
    if(lastCutNodeId)
    {
        setNodeCut(lastCutNodeId , false);
    }
    var cutNodeId =  selectedNode.getAttribute("nodeid");
    cutNode.value = cutNodeId;
    setNodeCut(cutNodeId , true)     
}
function setNodeCut(nodeId, cut)
{
    if(nodeId == "")
        return;
    var selectNode = igtree_getNodeById(nodeId);
    if(!selectNode)
        return;
    var subElements = selectNode.Element.children;
    for(x=0; x<subElements.length; x++)
    {
        var subElement = subElements.item(x);
        if(subElement.tagName == 'IMG')
        {
            if(subElement.src != '')
            {
                if(cut)
                {
                    subElement.style.cssText = "filter:progid:DXImageTransform.Microsoft.Alpha(opacity=50);";
                }
                else
                {
                    subElement.style.cssText = "";
                }   
            }
        }
    }
}
function pasteProject()
{
    var cutNode = document.forms[0].tbCut;
    if(cutNode.value == '')
    {
        alert(getI18N("NOCUTNODE"));
		return;
    }
    
    var selectedNode = document.forms[0].tbSelection;
    var nodeType = selectedNode.getAttribute("nodetype"); 
    if(nodeType =="folder" || nodeType =="root")   
         document.forms[0].submit();
    else  //is project
    {
        alert(getI18N("JUSTFORFOLDER"));
        return;
    }
}
function treeKeyUp(treeId,keycode)
{
    if(event.ctrlKey && keycode==88) //ctrl+x
    {
        cutProject();
    }
    else if(event.ctrlKey && keycode==86) //ctrl+v
    {
        pasteProject();
    }

}
function setNodesExpanded(expanded)
{
    var hidden = document.forms[0].tbExpend;
    hidden.value = expanded;
    document.forms[0].submit();
}

function getI18N(resourceId) 
{
	try {
		if ( I18N == null ) {
			return "no resources : "+resourceId;
			return "";
		}
		
		if ( I18N[resourceId] == null ) {
			return "no such string in resources : "+resourceId;
			return "";
		}
		
		return I18N[resourceId];
	}
	catch (e) {
		return e.description;
		return "";
	}
}

function afterNodeSelChange(treeId, nodeId) 
{
    var treeDiv = igtree_getTreeById("webTreeProjects").Element;
    treeDiv.scrollLeft = 0;
    
    var node = igtree_getNodeById(nodeId);
    if(node == null)
	    return;
	
    var projectName = node.getDataPath();
    var hiddenField = document.forms[0].tbSelection;
    
    var oldtype = hiddenField.getAttribute("nodetype");
    var oldvalue = hiddenField.value;

    hiddenField.setAttribute("nodetext",node.getText());
    hiddenField.setAttribute("nodeid", nodeId);
    hiddenField.setAttribute("nodetag", node.getTag());
    hiddenField.value = projectName;
    
    var tree = igtree_getTreeById("webTreeProjects");
	
	if(node.getParent())  
	{
        if(node.hasChildren())   //is folder
        {
            hiddenField.setAttribute("nodetype","folder");
            hiddenField.value = node.getText();
        }
        else                     // is project
        {
            hiddenField.setAttribute("nodetype","project");
        }
    }
    else                  //Root node
    {
        hiddenField.setAttribute("nodetype","root"); 
        hiddenField.value = node.getText();
    }
   
    var currtype = hiddenField.getAttribute("nodetype");
    var currvalue = hiddenField.value;
 
    if((oldtype == currtype && currtype == "project" && oldvalue != currvalue) ||
       (oldtype != currtype && currtype == "project"))
    {
        showProjectInfo(node.getTag());
    }    
    return;
}
function afterBeginNodeEdit(treeId, nodeId,oEvent) 
{
    var node = igtree_getNodeById(nodeId);
    if(node)
    {
        var tree = igtree_getTreeById(treeId);
      
        if(node.hasChildren()) 
        {
            if(node.getParent()) //is folder
            {
                if(!canManageFolder())
                    tree.endEdit();
            }
            else                 // is root node  
            {
                tree.endEdit();
            }
        }
        else //is project
        {
            tree.endEdit();
        }
    }
}

function showProjectInfo(url)
{
    window.top.document.getElementById("frmeRHS").src = url;
}

function showCurrentProjectInfo()
{
    var hiddenField = document.forms[0].tbSelection;
    if(hiddenField)
    {
        var nodeTag = hiddenField.getAttribute("nodetag");
        if(nodeTag == null || nodeTag =='')
        {
	        return;
	    }
	    showProjectInfo(nodeTag);
    }
}

 function treeNodeDragStart(oTree, oNode, oDataTransfer, oEvent)
 {
    if(oNode.hasChildren())
    {
        oDataTransfer.dataTransfer.effectAllowed = "none";
        oEvent.returnValue = false;
        oTree.endDrag();
        return;
    }
    //oDataTransfer.dataTransfer.setData("Text", oNode.getDataPath());
    oDataTransfer.dataTransfer.setData("Text", oNode.Id);
    oDataTransfer.dataTransfer.effectAllowed = "move";
}

function treeNodeDragOver(oTree, oNode, oDataTransfer, oEvent)
{
    if(!oNode.hasChildren())   //is project
    {
         oDataTransfer.dataTransfer.effectAllowed = "none";
         oDataTransfer.dataTransfer.dropEffect = "none";
         oEvent.cancel = true;
         return ;
    }
 
    var sourceNode = oDataTransfer.sourceObject;
    
    if(sourceNode.getParent().Id == oNode.Id)
    {
         oDataTransfer.dataTransfer.effectAllowed = "none";
         oDataTransfer.dataTransfer.dropEffect = "none";
         oEvent.cancel = true;
         return ;
    }
}

function displayError( strErrorText ) 
{
	// support ' and " in error messages
	strErrorText = unescape(strErrorText);
	strErrorText = strErrorText.replace(/\\'/g, "\'");
	strErrorText = strErrorText.replace(/\\n/gi, '\n');
	strErrorText = escape(strErrorText);
	alert(unescape(strErrorText));
}

function canManageFolder()
{
    var hiddenField = document.forms[0].tbCanManageFolder;
    if(hiddenField.value == "1")
    {
        return true;
    }
    return false;
}