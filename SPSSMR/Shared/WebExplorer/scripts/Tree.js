function treeNodeSelected(treename, nodeId, newNodeId)
{
    var nodeTag = refreshToolbar(treename, newNodeId);
    var isDirectory = "true";
    var treeFrame = GetTreeFrame();
    var userControlId = treeFrame.document.getElementById("userControlId").value;
    updateFileNameAndButtons(userControlId, isDirectory, nodeTag);
}

function refreshToolbarFromAlias(tag)
{
    var toolbarFrame = top.frames["toolbar"];
    var currentTreeAlias = escape(tag);
    toolbarFrame.location.href = "Toolbar.aspx?currentTreeAlias=" + currentTreeAlias;
}

function refreshToolbarFromTags(treeTag, fileListTag)
{
    var toolbarFrame = top.frames["toolbar"];
    var currentTreeAlias = escape(treeTag);
    var currentFileListAlias = escape(fileListTag);
    toolbarFrame.location.href = "Toolbar.aspx?currentFileListAlias=" + currentFileListAlias + "&currentTreeAlias=" + currentTreeAlias;
}

function refreshToolbar(treename, newNodeId)
{
    var node = igtree_getNodeById(newNodeId);
    var nodeTag = node.getTag();
  
    refreshToolbarFromAlias(nodeTag);
    return nodeTag;
}

function setSelectedTreeNode(selectedTag)
{
    var tree = igtree_getTreeById("MyTree");
    var nodes = tree.getNodes();
    var node = getNodeByTag(nodes[0], selectedTag)
    if (node!=null)
    {
        node.setSelected(true);
        top.frames["filelist"].window.location.href=node.getTargetUrl();
    }
}

function deleteSelectedTreeNode(selectedTag)
{
    var tree = igtree_getTreeById("MyTree");
    var nodes = tree.getNodes();
    var node = getNodeByTag(nodes[0], selectedTag)
    if (node!=null)
    {
        var parentNode = node.getParent();
        parentNode.setSelected(true);
        node.remove();
    }
}

function addSelectedTreeNode(selectedTag, newTag, newText,addNewNode)
{
    var tree = igtree_getTreeById("MyTree");
    var nodes = tree.getNodes();
    var node = getNodeByTag(nodes[0], selectedTag)
    if (node!=null)
    {
        if (addNewNode)
        {
            var newNode = node.addChild(newText);
            newNode.setTag(newTag);
            newNode.setTargetFrame("filelist");
            var escapedNewTag = escape(newTag);
            var targetUrl = "Filelist2.aspx?alias=" + escapedNewTag;
            newNode.setTargetUrl(targetUrl);
        }
    }
}

function renameSelectedTreeNode(selectedTag, newTag, newText)
{
    var tree = igtree_getTreeById("MyTree");
    var nodes = tree.getNodes();
    var node = getNodeByTag(nodes[0], selectedTag)
    if (node!=null)
    {
        node.setTag(newTag);
        node.setText(newText);
        var escapedNewTag = escape(newTag);
        var targetUrl = "Filelist2.aspx?alias=" + escapedNewTag;
        node.setTargetUrl(targetUrl);
        var parentNode = node.getParent();
        parentNode.setSelected(true);
    }
}

function moveSelectedTreeNode(selectedTag, parentTag, destTag, copyName,addNewNode)
{
    var tree = igtree_getTreeById("MyTree");
    var nodes = tree.getNodes();
    var node = getNodeByTag(nodes[0], selectedTag)
    if (node!=null)
    {
        var oldText = node.getText();
        node.remove();
        var parentNode = getNodeByTag(nodes[0], parentTag)
        if (parentNode!=null)
        {
            if (addNewNode)
            {
                var newNode = parentNode.addChild(copyName);
                newNode.setTag(destTag);            
                newNode.setTargetFrame("filelist");
                var escapedDestTag = escape(destTag);
                var targetUrl = "Filelist2.aspx?alias=" + escapedDestTag;
                newNode.setTargetUrl(targetUrl);
            }
        }
    }
}

function getNodeByTag(node, selectedTag)
{
    while (node!=null)
    {
        var upperNodeTag = node.getTag().toUpperCase();
        var upperSelectedTag = selectedTag.toUpperCase();
        if (upperNodeTag==upperSelectedTag)
            return node;
            
        var childNode = node.getFirstChild()
        if (childNode!=null)
        {
            var selectedNode = getNodeByTag(childNode, selectedTag);
            if (selectedNode!=null)
                return selectedNode;
        }

        node = node.getNextSibling();
    }
    return null;
}

function getSelectedTreeNode()
{
    var tree = igtree_getTreeById("MyTree");
    var selectedNode = tree.getSelectedNode();
    return selectedNode;
}

function getTextFromTag(tag)
{
    var tree = igtree_getTreeById("MyTree");
    var nodes = tree.getNodes();
    var node = getNodeByTag(nodes[0], tag);
    var nodeText = "";
    if(node != null)
    {
       nodeText = node.getText();
    }
    return nodeText;
}

function setEnabledTreeNode(selectedTag, enabled)
{
    var tree = igtree_getTreeById("MyTree");
    var nodes = tree.getNodes();
    var node = getNodeByTag(nodes[0], selectedTag)
    if (node!=null)
    {
        node.setEnabled(enabled);
    }
}

function setEnabledTree(enabled)
{
    var tree = igtree_getTreeById("MyTree");
    tree.Enabled = enabled;
}
