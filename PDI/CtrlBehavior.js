
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