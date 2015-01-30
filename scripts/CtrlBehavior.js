
function setVisibility(objectID,state)
{
	var obj = findDOM(objectID,1);
	obj.visibility = state;
}


function toggleVisibility(objectID)
{
	var obj = findDOM(objectID,1);
	state = obj.visibility;
	if(state == 'hidden' || state == 'hide')
		obj.visibility = 'visible';
	else
	{
		if(state == 'visible' || state == 'show')
			obj.visibility = 'hidden';
		else
			obj.visibility = 'visible';
	}
}

function loadSubForm(objectID,evt)
{
	setVisibility(objectID,'visible');
	var obj = findDOM(objectID,1);
	obj.top = findYCoord(evt) - 20;
	obj.left = findXCoord(evt) - 30;
	
	var saveX = findDOM('posX',0);
	var saveY = findDOM('posY',0);
	
	saveX.value = obj.left;
	saveY.value = obj.top;
}

function findXCoord(evt)
{
	if(evt.x) return evt.x;
	if(evt.pageX) return evt.pageX;
}

function findYCoord(evt)
{
	if(evt.y) return evt.y;
	if(evt.pageY) return evt.pageY;
}

function ChangeColorOver(obj,clrO,clrC)
{
	if(obj.style.backgroundColor!=clrC)
	{
		obj.style.backgroundColor=clrO;
	}
}

function ChangeColorOut(obj,clrO,clrC)
{
	if(obj.style.backgroundColor!=clrC)
	{
		obj.style.backgroundColor=clrO;
	}
}

function ChangeColorClick(obj, clrO, clrC)
{
	//--Delete lines from here  if you want multiple selection
	var tableID='DGshoppingHistory'  //your datagrids id
	var table;
	if (document.all) table=document.all[tableID];
		if (document.getElementById) table=document.getElementById(tableID);
		
	if (table)
	{
		for ( var i = 1 ;  i < table.rows.length-1 ;  i++)
		table.rows [ i ] . style . backgroundColor = "clrO";
	}
	//--Delete lines till here if you want multiple selection
	obj.style.backgroundColor = clrC;
}

function resizeObjectHeight(obj, lessUnit, minHeight) 
{
	var divObj = findDOM(obj,1);
	var divHeight = document.body.clientHeight - lessUnit;
	if(divHeight < minHeight) {
		divHeight = minHeight;
	}
	divObj.height = divHeight;
}