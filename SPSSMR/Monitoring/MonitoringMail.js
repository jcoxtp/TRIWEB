
function showTab(tabselected) 
{
	var oSelectedTab = document.getElementById('hSelectedTab');
	var tabLicense = document.getElementById('tabLicense');
	var tabCounter = document.getElementById('tabCounter');
	
	
	if ( oSelectedTab == null || tabLicense == null || tabCounter== null) 
	{
	    alert("No tab");
		return;
	}
	
	switch(tabselected)
	{
		case 0: // License
			oSelectedTab.value = 0;
			tabLicense.style.display = '';
			tabCounter.style.display = 'none';
			break;
		case 1: // Concurrent
			oSelectedTab.value = 1;
			tabLicense.style.display = 'none';
			tabCounter.style.display = '';
			
			break;
	}
	parent.oTabCtrl.Select(tabselected);
}