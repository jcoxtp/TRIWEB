<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 12	' Purchase a Profile Page
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>-->
<script type="text/javascript">
_uacct = "UA-368995-2";
//urchinTracker();

</script>
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">
        
        <div id="maincontent">
        <%
        '----------------------------------------------------------------------------------------
        ' Created By: John Tisdale																 
        ' Creation Date: February 10, 2004														 
        ' Purpose: 	This ASP page allows users to purchase tests and reports					 
        '----------------------------------------------------------------------------------------

        'On Error Resume Next
        Response.Buffer = True

        ' Declare General Variables (alphabetical order)
	        Dim intCompanyID
	        Dim intCount
	        Dim intPurchaseID
	        Dim intProductQuantity
	        Dim intProductsCount
	        Dim intUserID
	        Dim mnyProductAmount
	        Dim mnyProductTotal
	        Dim mnyProductDiscounted
	        Dim mnyTotalAmount
	        Dim mnyTotalDiscounted
	        Dim mnyTotalGrand
	        Dim oCmd
	        Dim oConn
	        Dim oRsProducts
	        Dim strErrorMessage
	        Dim strPurchaseDescription
	        Dim strTemp
	        Dim strProductsPurchased
	        Dim intTakenPDI

        ' Set initial values for general variables
	        intUserID = Request.Cookies("UserID")
	        mnyProductsAmount = 0
	        mnyTotalDiscounted = 0
	        mnyProductDiscounted = 0
	        mnyTotalGrand = 0
	        strProductsPurchased = ""
	        intProductsCount = 0
	        intTakenPDI = 0

        ' Get any values that may have been passed into this form
	        mnyTotalGrand = Request.Form("mnyGrandTotal")
	        If mnyTotalGrand = "" Then
		        mnyTotalGrand = 0
	        End If
	        mnyTotalDiscounted = Request.Form("mnyTotalDiscounted")
	        If mnyTotalDiscounted = "" Then
		        mnyTotalDiscounted = 0
	        End If
	        intPurchaseID = Request.Form("intPurchaseID")
	        If intPurchaseID = "" Then
		        intPurchaseID = 0
	        End If
	        intCompanyID = Request.Form("intCompanyID")
	        If intCompanyID = "" Then
		        intCompanyID = 0
	        End If
	        strProductsDescription = Request.Form("txtProductsDescription")
	        If strProductsDescription = "" Then
		        strProductsDescription = 0
	        End If

        ' Get a list of all of the tests available for purchase along with pricing (based on udfProductsGetLowestPrice)
	        Set oConn = CreateObject("ADODB.Connection")
	        Set oCmd = CreateObject("ADODB.Command")
	        Set oRsProducts = CreateObject("ADODB.Recordset")
	        With oCmd
	            .CommandText = "spProductsGetAll"
	            .CommandType = 4
	            .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	            .Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intUserID)
		        .Parameters.Append .CreateParameter("@intLanguageID", 3, 1, 4, intLanguageID)
	            .Parameters.Append .CreateParameter("@intResellerID", 3, 1, 4, intResellerID)
	        End With
	        oConn.Open strDbConnString
	        oCmd.ActiveConnection = oConn
	        oRsProducts.CursorLocation = 3
	        oRsProducts.Open oCmd, , 0, 1
	        If oConn.Errors.Count > 0 Then
		        Response.Write "Unable to retrieve product information from database, please try again."
		        Response.End
	        End If
	
	        If oRsProducts.EOF = TRUE Then
        '		Response.Write "Unable to retrieve product information from database. Please try again."
        '		Response.End
	        End If
	        oRsProducts.MoveFirst
	        intProductCount = 0
	        While oRsProducts.EOF = FALSE
		        intProductsCount = intProductsCount + 1
		        oRsProducts.MoveNext
	        Wend

        ' Get a listing of all Product volume discounts
	        Set oConn = CreateObject("ADODB.Connection")
	        Set oCmd = CreateObject("ADODB.Command")
	        Set oRsDiscounts = CreateObject("ADODB.Recordset")
	        With oCmd
	            .CommandText = "spDiscountsGet"
	            .CommandType = 4
	            .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	            .Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intUserID)
	            .Parameters.Append .CreateParameter("@intResellerID", 3, 1, 4, intResellerID)
	        End With
	        oConn.Open strDbConnString
	        oCmd.ActiveConnection = oConn
	        oRsDiscounts.CursorLocation = 3
	        oRsDiscounts.Open oCmd, , 0, 1
	        If oConn.Errors.Count > 0 OR oRsDiscounts.EOF = TRUE Then
		        Response.Write "Unable to retrieve product information from database. Please try again."
		        Response.End
	        End If
	        oRsDiscounts.MoveFirst

        ' Determine whether the user has already taken the PDI or not
	        Set oConn = CreateObject("ADODB.Connection")
	        Set oCmd = CreateObject("ADODB.Command")
	        With oCmd
	            .CommandText = "spUserTakenPDI"
	            .CommandType = 4
	            .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	            .Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intUserID)
	            .Parameters.Append .CreateParameter("@intTakenPDI", 3, 3, 4, intTakenPDI)
	        End With
	        oConn.Open strDbConnString
	        oCmd.ActiveConnection = oConn
	        oCmd.Execute , , 128
	        If oConn.Errors.Count > 0 Then
		        Response.Write "Unable to retrieve product information from database. Please try again."
		        Response.End
	        Else
		        intTakenPDI = oCmd.Parameters("@intTakenPDI").value
	        End If
        %>

        <form name="thisForm" id="thisForm" method="post">
	        <input type="hidden" name="intUserID" id="intUserID" Value="<%=intUserID%>">
	        <input type="hidden" name="ResellerID" id="ResellerID" value="<%=intResellerID%>">
	        <input type="hidden" name="intResellerID" id="intResellerID" value="<%=intResellerID%>">
	        <input type="hidden" name="intPurchaseID" id="intPurchaseID" Value="<%=intPurchaseID%>">
	        <input type="hidden" name="txtProductsDescription" id="txtProductsDescription">
	        <input type="hidden" name="intNumberOfProducts" id="intNumberOfProducts" value="<%=intProductsCount%>">
	        <input type="hidden" name="mnyTotalDiscounted" id="mnyTotalDiscounted" Value="<%=mnyTotalDiscounted%>">

        <table border="0" cellspacing="0" cellpadding="0" width="100%">
	        <tr>
		        <td valign="top"><h1><%=strTextPurchaseAReport%></h1></td>
		        <td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	        </tr>
        </table>

        <div align="center">
        <table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	        <tr>
		        <td valign="middle" align="left" colspan="2">&nbsp;</td>
		        <td valign="middle" align="left">
        <%
		        If strErrorMessage <> "" Then
			        Response.Write "<span class=""errortext"">" & strErrorMessage & "</span>"
		        Else
			        Response.Write "&nbsp;"
		        End If
        %>
		        </td>
	        </tr>
	        <tr>
  		        <td valign="top" align="center"><span class="headertext2"><%=strTextReportNameAndDescription%></span></td>
   		        <td valign="top" align="center"><span class="headertext2"><%=strTextStandardPrice%></span></td>
 		        <td valign="top" align="center"><span class="headertext2"><%=strTextQuantity%></span></td>
   		        <td valign="top" align="center"><span class="headertext2"><%=strTextDiscountPrice%></span></td>
		        <td valign="top" align="center"><span class="headertext2"><%=strTextTotal%></span></td>
	        </tr>
        <%
	        oRsProducts.MoveFirst
	        If oRsProducts.EOF = False then
		        intCount = 1
		        oRsProducts.MoveFirst
		        Do While oRsProducts.EOF = False
			        ' Calculate the price of this product based on volume discount
			        mnyProductAmount = oRsProducts("SalePrice")
			        intProductQuantity = Request("intProductQuantity" & intCount)
			        If intProductQuantity = "" Then
				        intProductQuantity = 0
			        End If
			        mnyProductTotal = (intProductQuantity * mnyProductAmount)
			        If intProductQuantity <> 0 Then
				        oRsDiscounts.MoveFirst
				        ' Go through the volume discounts until we find the right quantity
				        Do While oRsDiscounts.EOF = False
					        If CLng(intProductQuantity) >= CLng(oRsDiscounts("MinVolumeAmt")) AND CLng(intProductQuantity) <= CLng(oRsDiscounts("MaxVolumeAmt")) Then
						        mnyProductDiscounted = (mnyProductAmount - (mnyProductAmount * oRsDiscounts("DiscountPercent")))
						        mnyProductTotal = (intProductQuantity * mnyProductDiscounted)
						        oRsDiscounts.MoveLast
					        Else
						        mnyProductDiscounted = mnyProductAmount
					        End If
					        oRsDiscounts.MoveNext
				        Loop
			        Else
				        mnyProductDiscounted = mnyProductAmount
			        End If
			        mnyTotalGrand = mnyTotalGrand + mnyProductTotal
			
			        Response.Write "<tr>" & VbCrLf
			        Response.Write VbTab & "<td valign='top' align='left'>" & VbCrLf
			        If 	(UCase(oRsProducts("TestCodePrefix")) = "PDIP") Or (UCase(oRsProducts("TestCodePrefix")) = "PDDG") 				Then
					        Response.Write "<a href='" & oRsProducts("DescLink") & "?res=" & intResellerID & "'>"
					        Response.Write oRsProducts("TestName")
					        Response.Write "</a>" & VbCrLf
				        Else
					        Response.Write "<a href='" & oRsProducts("DescLink") & "?res=" & intResellerID & "'>"
					        Response.Write oRsProducts("TestName")
					        Response.Write "</a>&nbsp;<strong>*</strong>" & VbCrLf
				        End If
				        Response.Write "<br /><span class='bodytext_gray'>" & oRsProducts("ShortDesc") & "</span>" & VbCrLf
				        Response.Write "</td>" & VbCrLF
				        Response.Write "<td valign='top' align='right'>" & FormatCurrency(oRsProducts("SalePrice"),2) & VbCrLf
				        Response.Write "<input type=""hidden"" name=""intTestID" & intCount & """ id=""intTestID" & intCount & """ Value=""" & oRsProducts("TRTestID") & """>" & VbCrLf
				        Response.Write "<input type=""hidden"" name=""mnyProductAmount" & intCount & """ id=""mnyProductAmount" & intCount & """ Value=""" & oRsProducts("SalePrice") & """>" & VbCrLf
				        Response.Write "</td>" & VbCrLf
				        Response.Write "<td valign='top' align='right'>" & VbCrLf
				        Response.Write "<input type=""text"" name=""intProductQuantity" & intCount & """ id=""intProductQuantity" & intCount & """ MaxLength=""4"" Size=""3"" Value=""" & intProductQuantity & """ onBlur='javascript:numbersOnly();'>"
				        Response.Write "</td>" & VbCrLf
				        Response.Write "<td valign='top' align='right'>" & VbCrLf
				        Response.Write FormatCurrency(mnyProductDiscounted,2)
				        Response.Write "</td>" & VbCrLf
				        Response.Write "<td valign='top' align='right'><strong>" & VbCrLf
				        Response.Write FormatCurrency(mnyProductTotal,2)
				        Response.Write "</strong></td>" & VbCrLf
				        Response.Write "</tr>" & VbCrLf
			        intCount = intCount + 1
			        oRsProducts.MoveNext
		        Loop
	        End If
        %>
	        <tr>
		        <td align="right" colspan="3"><%=strTextTotalInUSDollars%></td>
		        <td align="right"><input type="button" value="<%=strTextCalculate%>" onClick="calcTotal();"></td>
		        <td align="right"><input type="hidden" name="mnyTotalGrand" id="mnyTotalGrand" Value="<%=FormatCurrency(mnyTotalGrand,2)%>"><strong><%=FormatCurrency(mnyTotalGrand,2)%></strong></td>
	        </tr>
        </table>
        </div>

        <!--#Include file="Include/divider.asp" -->

        <div align="center">
        <table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	        <tr>
        <%
	        If intTakenPDI = 0 Then
		        Response.Write "<td valign=""top"" align=""left""><strong>*&nbsp;" & strTextACompletedPersonalDISCernmentIsRequired & "</strong></td>" & VbCrLf
	        Else
		        Response.Write "<td valign=""top"" align=""left""><strong>*&nbsp;" & strTextYourPersonalityHasBeenDeterminedYou & "</strong></td>" & VbCrLf
	        End If
        %>
		        <td valign="top" align="right">
			        <input type="hidden" name="txtSubmit" id="txtSubmit">
			        <input type="submit" value="<%=strTextProceedToCheckout%>" id="add" name="add" onClick="submitIt();">
		        </td>
	        </tr>
        </table>
        <table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
	        <tr>
		        <td valign="top" align="right" width="25%"><a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank"><img src="images/get_acrobat_reader.gif" alt="" width="88" height="31" /></a>
		        </td>
		        <td valign="top" align="left" width="75%"><strong><%=UCase(strTextNote)%>: </strong>
		        <%=strTextYouMustHaveAdobeAcrobatReader%>
		        <%=Application("strTextPlease" & strLanguageCode) & " <a href=""http://www.adobe.com/products/acrobat/readstep2.html"" target=""_blank"">" & strTextDownload & "</a>" & " " &  strTextThisFreeProgramFromAdobe & "." %>
		        </td>
	        </tr>
        </table>
        </div>
        </form>

        <script type="text/javascript">
        function numbersOnly()
        {
        <%
	        intCount = 1
	        While CInt(intCount) <= CInt(intProductsCount)
		        Response.Write "	var tempQuantity = document.thisForm.intProductQuantity" & intCount & ".value;" & VbCrLf
		        Response.Write "	if (isNaN(tempQuantity))"  & VbCrLf
		        Response.Write "		{" & VbCrLf
		        Response.Write "			document.thisForm.intProductQuantity" & intCount & ".value = 0;" & VbCrLf
		        Response.Write "		} " & VbCrLf
		        intCount = intCount + 1
	        Wend
        %>
        }

        function submitIt()
        {
            var strTestDescription = "";
            var mynumber;
            var mynumberformatted;
            mynumber = 0;
            <%
            //New lines are added to strTestDescription for Administrator invoice formatting. 
            Response.Write "	strTestDescription = 'TRI Personality Profile Purchase: " & intResellerID & ";\n';" & VbCrLf
            intCount = 1
            oRsProducts.MoveFirst
            Do While oRsProducts.EOF = FALSE

            //For each web product found in db, If 1 or more productions have been selected append the text to the description variable.
            Response.Write "	if (document.thisForm.intProductQuantity" & intCount & ".value > 0) { "  & VbCrLf

            Response.Write "		strTestDescription = strTestDescription + ' ' + ' " & oRsProducts("TestCodePrefix") & "';" & VbCrLf
            //Response.Write "		strTestDescription = strTestDescription + '=" & oRsProducts("TRTestID") & ";';" & VbCrLf

            //Response.Write "		strTestDescription = strTestDescription + document.thisForm.intProductQuantity" & intCount & ".value;" & VbCrLf
            Response.Write "		strTestDescription = strTestDescription + ' = ' + document.thisForm.intProductQuantity" & intCount & ".value + ';\n';"  & VbCrLf

            Response.Write "	} " & VbCrLf
            Response.Write "	mynumber = mynumber + document.thisForm.intProductQuantity" & intCount & ".value * document.thisForm.mnyProductAmount" & intCount & ".value;" & VbCrLf
            intCount = intCount + 1
            oRsProducts.MoveNext
            Loop

            Dim strSecureURL
            strSecureURL = "https://"
            strSecureURL = strSecureURL & Request.ServerVariables("SERVER_NAME")
    
            strSecureURL = strSecureURL & "/PDI/CreditCardInfo.asp?res=" & intResellerID

            '/****Testing page redirect. Should only be used for testing purposes.****/
            //strSecureURL = strSecureURL & "/PDI/creditCardInfo_test.asp?res=" & intResellerID


            Response.Write "mynumberformatted = new NumberFormat(mynumber);"
            Response.Write "mynumberformatted.setCurrency(false);"
            Response.Write "	strTestDescription = strTestDescription;" & VbCrLf
            Response.Write "	document.thisForm.txtProductsDescription.value = strTestDescription;" & VbCrLf

            'Response.Write "	document.thisForm.action='creditCardInfo.asp?res=" & intResellerID & "';" & VbCrLf
    
            '/***Testing page redirect. Should only be used for testing purposes.***/
            Response.Write "	document.thisForm.action='" & strSecureURL & "';" & VbCrLf
            Response.Write "	document.thisForm.txtSubmit.value = 1;" & VbCrLf
            Response.Write "}" & VbCrLf
            %>







        function submitIt2()
        {
            var strTestDescription = "";
            var mynumber;
            var mynumberformatted;
            var resellerId = <%=intResellerID%>;
    
            mynumber = 0;
            strTestDescription = 'TRI Personality Profile Purchase' & resellerId;

            if (document.thisForm.intProductQuantity1.value > 0) { 
                strTestDescription = strTestDescription + document.thisForm.intProductQuantity1.value;
                strTestDescription = strTestDescription + '=1;';
            } 
            mynumber = mynumber + document.thisForm.intProductQuantity1.value * document.thisForm.mnyProductAmount1.value;
            if (document.thisForm.intProductQuantity2.value > 0) { 
                strTestDescription = strTestDescription + document.thisForm.intProductQuantity2.value;
                strTestDescription = strTestDescription + '=2;';
            } 
            mynumber = mynumber + document.thisForm.intProductQuantity2.value * document.thisForm.mnyProductAmount2.value;
            if (document.thisForm.intProductQuantity3.value > 0) { 
                strTestDescription = strTestDescription + document.thisForm.intProductQuantity3.value;
                strTestDescription = strTestDescription + '=3;';
            } 
            mynumber = mynumber + document.thisForm.intProductQuantity3.value * document.thisForm.mnyProductAmount3.value;
            if (document.thisForm.intProductQuantity4.value > 0) { 
                strTestDescription = strTestDescription + document.thisForm.intProductQuantity4.value;
                strTestDescription = strTestDescription + '=4;';
            } 
            mynumber = mynumber + document.thisForm.intProductQuantity4.value * document.thisForm.mnyProductAmount4.value;
            if (document.thisForm.intProductQuantity5.value > 0) { 
                strTestDescription = strTestDescription + document.thisForm.intProductQuantity5.value;
                strTestDescription = strTestDescription + '=5;';
            } 
            mynumber = mynumber + document.thisForm.intProductQuantity5.value * document.thisForm.mnyProductAmount5.value;
            if (document.thisForm.intProductQuantity6.value > 0) { 
                strTestDescription = strTestDescription + document.thisForm.intProductQuantity6.value;
                strTestDescription = strTestDescription + '=6;';
            } 
            mynumber = mynumber + document.thisForm.intProductQuantity6.value * document.thisForm.mnyProductAmount6.value;
            if (document.thisForm.intProductQuantity7.value > 0) { 
                strTestDescription = strTestDescription + document.thisForm.intProductQuantity7.value;
                strTestDescription = strTestDescription + '=13;';
            } 
            mynumber = mynumber + document.thisForm.intProductQuantity7.value * document.thisForm.mnyProductAmount7.value;
            mynumberformatted = new NumberFormat(mynumber);mynumberformatted.setCurrency(false);	
            strTestDescription = strTestDescription + ')';
            document.thisForm.txtProductsDescription.value = strTestDescription;
    
            //document.thisForm.action ='http://localhost/PDI/creditCardInfo.asp?res=1';
            //window.location.replace('http://localhost/PDI/creditCardInfo.asp?res=' & resellerId);
            window.location.replace('creditCardInfo.asp?res=' & resellerId);


            document.thisForm.txtSubmit.value = 1;
        }













    
        function calcTotal()
        {
	        document.thisForm.txtSubmit.value = "";
	        var strTestDescription = "";
	        var mynumber;
	        var mynumberformatted;
	        mynumber = 0;
	        <%
	        oRsProducts.MoveFirst
	        intCount = 1
	        While oRsProducts.EOF = FALSE
		        Response.Write "	if (document.thisForm.intProductQuantity" & intCount & ".value > 0) { "  & VbCrLf
		        Response.Write "		strTestDescription = strTestDescription + document.thisForm.intProductQuantity" & intCount & ".value;" & VbCrLf
		        Response.Write "		strTestDescription = strTestDescription + '=" & oRsProducts("TRTestID") & ";';" & VbCrLf
		        Response.Write "	} " & VbCrLf
		        Response.Write VbTab & "mynumber = mynumber + document.thisForm.intProductQuantity" & intCount & ".value * document.thisForm.mnyProductAmount" & intCount & ".value;" & VbCrLf
		        intCount = intCount + 1
		        oRsProducts.MoveNext
	        Wend
	        %>
	        mynumberformatted = new NumberFormat(mynumber);
	        mynumberformatted.setCurrency(false);
	        document.thisForm.action="purchasetest.asp?res=<%=intResellerID%>";
	        document.thisForm.submit();
        }

        /*
         * NumberFormat 1.0.3
         * v1.0.3 - 23-March-2002
         * v1.0.2 - 13-March-2002
         * v1.0.1 - 20-July-2001
         * v1.0.0 - 13-April-2000
         * http://www.mredkj.com
         */
 
        /*
         * NumberFormat -The constructor
         * num - The number to be formatted
         */
        function NumberFormat(num)
        {
	        // member variables
	        this.num;
	        this.numOriginal;
	        this.isCommas;
	        this.isCurrency;
	        this.currencyPrefix;
	        this.places;

	        // external methods
	        this.setNumber = setNumberNF;
	        this.toUnformatted = toUnformattedNF;
	        this.setCommas = setCommasNF;
	        this.setCurrency = setCurrencyNF;
	        this.setCurrencyPrefix = setCurrencyPrefixNF;
	        this.setPlaces = setPlacesNF;
	        this.toFormatted = toFormattedNF;
	        this.getOriginal = getOriginalNF;

	        // internal methods
	        this.getRounded = getRoundedNF;
	        this.preserveZeros = preserveZerosNF;
	        this.justNumber = justNumberNF;

	        // setup defaults
	        this.setNumber(num);
	        this.setCommas(true);
	        this.setCurrency(true);
	        this.setCurrencyPrefix('$');
	        this.setPlaces(2);
        }

        /*
         * setNumber - Sets the number
         * num - The number to be formatted
         */
        function setNumberNF(num)
        {
	        this.numOriginal = num;
	        this.num = this.justNumber(num);
        }

        /*
         * toUnformatted - Returns the number as just a number.
         * If the original value was '100,000', then this method will return the number 100000
         * v1.0.2 - Modified comments, because this method no longer returns the original value.
         */
        function toUnformattedNF()
        {
	        return (this.num);
        }

        /*
         * getOriginal - Returns the number as it was passed in, which may Include non-number characters.
         * This function is new in v1.0.2
         */
        function getOriginalNF()
        {
	        return (this.numOriginal);
        }

        /*
         * setCommas - Sets a switch that indicates if there should be commas
         * isC - true, if should be commas; false, if no commas
         */
        function setCommasNF(isC)
        {
	        this.isCommas = isC;
        }

        /*
         * setCurrency - Sets a switch that indicates if should be displayed as currency
         * isC - true, if should be currency; false, if not currency
         */
        function setCurrencyNF(isC)
        {
	        this.isCurrency = isC;
        }

        /*
         * setCurrencyPrefix - Sets the symbol that precedes currency.
         * cp - The symbol
         */
        function setCurrencyPrefixNF(cp)
        {
	        this.currencyPrefix = cp;
        }

        /*
         * setPlaces - Sets the precision of decimal places
         * p - The number of places. Any number of places less than or equal to zero is considered zero.
         */
        function setPlacesNF(p)
        {
	        this.places = p;
        }

        /*
         * toFormatted - Returns the number formatted according to the settings (a string)
         */
        function toFormattedNF()
        {
	        var pos;
	        var nNum = this.num; // v1.0.1 - number as a number
	        var nStr;            // v1.0.1 - number as a string

	        // round decimal places
	        nNum = this.getRounded(nNum);
	        nStr = this.preserveZeros(Math.abs(nNum)); // this step makes nNum into a string. v1.0.1 Math.abs

	        if (this.isCommas)
	        {
		        pos = nStr.indexOf('.');
		        if (pos == -1)
		        {
			        pos = nStr.length;
		        }
		        while (pos > 0)
		        {
			        pos -= 3;
			        if (pos <= 0) break;
			        nStr = nStr.substring(0,pos) + ',' + nStr.substring(pos, nStr.length);
		        }
	        }
	
	        nStr = (nNum < 0) ? '-' + nStr : nStr; // v1.0.1

	        if (this.isCurrency)
	        {
		        // add dollar sign in front
		        nStr = this.currencyPrefix + nStr;
	        }

	        return (nStr);
        }

        /*
         * getRounded - Used internally to round a value
         * val - The number to be rounded
         */
        function getRoundedNF(val)
        {
	        var factor;
	        var i;

	        // round to a certain precision
	        factor = 1;
	        for (i=0; i<this.places; i++)
	        {	factor *= 10; }
	        val *= factor;
	        val = Math.round(val);
	        val /= factor;

	        return (val);
        }

        /*
         * preserveZeros - Used internally to make the number a string
         * 	that preserves zeros at the end of the number
         * val - The number
         */
        function preserveZerosNF(val)
        {
	        var i;
	        // make a string - to preserve the zeros at the end
	        val = val + '';
	        if (this.places <= 0) return val; // leave now. no zeros are necessary - v1.0.1 less than or equal
	        var decimalPos = val.indexOf('.');
	        if (decimalPos == -1)
	        {
		        val += '.';
		        for (i=0; i<this.places; i++)
		        {
			        val += '0';
		        }
	        }
	        else
	        {
		        var actualDecimals = (val.length - 1) - decimalPos;
		        var difference = this.places - actualDecimals;
		        for (i=0; i<difference; i++)
		        {
			        val += '0';
		        }
	        }
	        return val;
        }

        /*
         * justNumber - Used internally to parse the value into a floating point number.
         * If the value is not set, then return 0.
         * If the value is not a number, then replace all characters that are not 0-9, a decimal point, or a negative sign.
         *
         *  Note: The regular expression cleans up the number, but doesn't get rid of - and .
         *  Because all negative signs and all decimal points are allowed,
         *  extra negative signs or decimal points may corrupt the result.
         *  parseFloat will ignore all values after any character that is NaN.
         *
         *  A number can be entered using special notation.
         *  For example, the following is a valid number: 0.0314E+2
         *
         * This function is new in v1.0.2
         */
        function justNumberNF(val)
        {
	        val = (val==null) ? 0 : val;

	        // check if a number, otherwise try taking out non-number characters.
	        if (isNaN(val))
	        {
		        var newVal = parseFloat(val.replace(/[^\d\.\-]/g, ''));

		        // check if still not a number. Might be undefined, '', etc., so just replace with 0.
		        // v1.0.3
		        return (isNaN(newVal) ? 0 : newVal); 
	        }
	        // return 0 in place of infinite numbers.
	        // v1.0.3
	        else if (!isFinite(val))
	        {
		        return 0;
          }
	        return val;
        }
        </script>
        </div>
    </div>
</body>
</html>
