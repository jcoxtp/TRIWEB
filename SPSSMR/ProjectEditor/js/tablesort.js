/////////////////////////////////////////////////////////////////////////
// Object used for sorting a single table/TBody.
//	- strTableId  : Id of table to sort.
function TableSortObject( strTableId ) {
	this.sortTable = sortTable;	/* ( iCol, iTBodyIndex, oCompareObject ) */
	
	this.tableId = strTableId;
	this.g_iSortColumn;
	this.g_iLastSortColumn =-1;
	this.g_iSortDirection  = 1;
}

/////////////////////////////////////////////////////////////////////////
// Object containing function that is used for comparing. This
// type of object is passed to the sortTable function
// 
//	- fnComparer  : (optional) function to use form comparing elements (default=sortCompareNumericLocale)
//					You can provide your own custom compare function.
//					Use sortCompare() below as a template for creating a a comparer function.
function TableSortComparerObject( fnComparer ) {
	this.fnCmp = fnComparer!=null?fnComparer:sortCompareNumericLocale;
	
	// private vars
	this.m_iSortColumn;
	this.m_iSortDirection;
}

/////////////////////////////////////////////////////////////////////////
// 	function sortTable()
//
// function to sort a table in a HTML page
// Sorts the table rows in the table with id as specified in 
// strTableId by the column 'iCol'.
// The placement of rows, that does not have at least 'iCol' columns,
// is not specified.
//
// Only 'TR' rows that are inside the first 'TBODY' tag will be sorted.
// Only 'TD' cells are compared, so 'TH' cells first in a table are
// not moved during sort.
//
// HTML for table must be well-formed.
//
// Think twice when using ROWSPAN & COLSPAN, as iCol is used to index
// columns on each row.
//
//	PARAMETERS 
//  	iCol			: Column index to sort table by.
//		iTBodyIndex		: (optional) The index of the TBODY element to sort (default=0)
//		oCompareObject	: (optional) object of type TableSortComparerObject (default=sortCompareNumericLocale)
function sortTable(iCol, iTBodyIndex, oCompareObject) {
	if ( iTBodyIndex == null ) iTBodyIndex=0;
	if ( oCompareObject == null ) oCompareObject = new TableSortComparerObject(null);
	
	var isBrowserIE = (navigator.appName.toUpperCase().match(/MICROSOFT INTERNET EXPLORER/) != null);
	
	var tbl     = document.getElementById(this.tableId);
	var tblBody = tbl.getElementsByTagName("tbody").item(iTBodyIndex);
	var tblRows = tblBody.getElementsByTagName("tr");
	
	var arr = new Array( tblRows.length );
	
	// create array of rows so we can sort
	if ( isBrowserIE ) {
		for ( i=0; i<arr.length; i++) {
			arr[i] = tblRows[i];
		}
	}
	else {
		for ( i=0; i<arr.length; i++) {
			arr[i] = tblRows[0].parentNode.removeChild( tblRows[0] );
		}
	}
	
	// set column that sort is based on
	this.g_iSortColumn = iCol;
	
	// find the sort direction
	if (this.g_iLastSortColumn==iCol)
		this.g_iSortDirection *= -1;
	else
		this.g_iSortDirection = 1;
	this.g_iLastSortColumn=iCol;
	
	
	oCompareObject.m_iSortColumn	= this.g_iSortColumn;
	oCompareObject.m_iSortDirection = this.g_iSortDirection;
	// perform the sort
	arr.sort( function f(v1,v2){ return oCompareObject.fnCmp(v1,v2) } );
	
	// write sorted data from array to table
	if ( isBrowserIE ) {
		for ( i=0; i < arr.length; i++) {
			tblRows[i].swapNode( arr[i] );
		}
	}
	else {
		for ( i=0; i < arr.length; i++) {
			tblBody.appendChild( arr[i] );
		}
	}
}


/////////////////////////////////////////////////////////////////////////
// DIFFERENT IMPLEMENTATIONS OF COMPARE FUNCTIONS
/////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////
// function sortCompare
// internal function used by sortTable function
// Input:
//	- val1 and val2 : two row elements that are being compared
// Return values
//	- Negative integer – signifies that the first argument is less than the second.
//	- Zero – Signifies that both arguments are the same.
//	- Positive integer – Signifies that the first argument is larger than the second.
function sortCompare( val1, val2 ) {
	var cells1= val1.getElementsByTagName("td");
	var cells2= val2.getElementsByTagName("td");
	
	if ( !cells1 || !cells2 ||
	     this.m_iSortColumn < 0 ||
		 cells1.length <= this.m_iSortColumn ||
		 cells2.length <= this.m_iSortColumn  )
	{
		return 0;
	}
	if ( cells1[this.m_iSortColumn].childNodes[0].nodeValue < cells2[this.m_iSortColumn].childNodes[0].nodeValue )
		return -1*this.m_iSortDirection;
		
	if ( cells1[this.m_iSortColumn].childNodes[0].nodeValue > cells2[this.m_iSortColumn].childNodes[0].nodeValue )
		return this.m_iSortDirection;
	
	return 0;
}

function sortCompareLocale( val1, val2 ) {
	var cells1= val1.getElementsByTagName("td");
	var cells2= val2.getElementsByTagName("td");
	
	if ( !cells1 || !cells2 ||
	     this.m_iSortColumn < 0 ||
		 cells1.length <= this.m_iSortColumn ||
		 cells2.length <= this.m_iSortColumn  )
	{
		return 0;
	}
    
    return (cells1[this.m_iSortColumn].childNodes[0].nodeValue).localeCompare( cells2[this.m_iSortColumn].childNodes[0].nodeValue )*this.m_iSortDirection;
}

function sortCompareNumericLocale( val1, val2 ) {
	try
	{
		var cells1= val1.getElementsByTagName("td");
		var cells2= val2.getElementsByTagName("td");
		
		if ( !cells1 || !cells2 ||
			this.m_iSortColumn < 0 ||
			cells1.length <= this.m_iSortColumn ||
			cells2.length <= this.m_iSortColumn  )
		{
			return 0;
		}
	    
		try {
			var f1 = parseFloat(cells1[this.m_iSortColumn].innerText); 
			var f2 = parseFloat(cells2[this.m_iSortColumn].innerText);
	        
	        
			if ( !isNaN(f1) && !isNaN(f2) ) {
				var result = (f1 - f2)*this.m_iSortDirection;
				if ( result != 0 )
					return result;
			}
		} catch ( E ) { }
	    var c1 = cells1[this.m_iSortColumn].innerText;
	    var c2 = cells2[this.m_iSortColumn].innerText;
		
		return (cells1[this.m_iSortColumn].innerText).localeCompare( cells2[this.m_iSortColumn].innerText )*this.m_iSortDirection;
	}
	catch(e) {
		return 0;
	}
}
