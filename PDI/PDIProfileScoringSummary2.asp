<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 48	' PDI Profile Summary Page
	Dim TestCodeID, nextLink
	TestCodeID = Request.QueryString("TCID")
	nextLink = "PDIProfileBehavioralChar1.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID
%>
<!-- #Include File = "Include/CheckLogin.asp" -->
<!-- #Include File = "Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!-- #Include File = "Include/HeadStuff.asp" -->
</head>
<body>
<!-- #Include File = "Include/TopBanner.asp" -->
<div id="main">
    <div id="tabgraphic">
	    <img src="images/S2P1<%=strLanguageCode%>.gif" width="692" height="82" alt="" usemap="#tab" />
	    <map name="tab">
    <!--        <area shape=poly alt="" coords="622,53,663,53,678,60,663,66,621,66,615,58,622,53,625,53" href="PDIProfileRepProfile2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">-->
            <area shape=poly alt="" coords="622,53,663,53,678,60,663,66,621,66,615,58,622,53,625,53" href="PDIProfileBehavioralChar1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
	    </map>
    </div>
    <div id="maincontent_tab">
    <%
    ' Declare initial internal variables
	    Dim nM1, nM2, nM3, nM4
	    Dim nL1, nL2, nL3, nL4
	    Dim nC1, nC2, nC3, nC4

    ' Retrieve the most, least and composite numbers from the database
	    Set oConn = CreateObject("ADODB.Connection")
	    Set oCmd = CreateObject("ADODB.Command")
	    Set oRs = CreateObject("ADODB.Recordset")
	    With oCmd
	         .CommandText = "spTestSummarySelect"
	         .CommandType = 4
	         .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	         .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
	    End With
	    oConn.Open strDbConnString
	    oCmd.ActiveConnection = oConn
	    oRs.CursorLocation = 3
	    oRs.Open oCmd, , 0, 1

    If oConn.Errors.Count < 1 Then
	    nM1 = oRs("M_NumberD")
	    nM2 = oRs("M_NumberI")
	    nM3 = oRs("M_NumberS")
	    nM4 = oRs("M_NumberC")
	    nL1 = oRs("L_NumberD")
	    nL2 = oRs("L_NumberI")
	    nL3 = oRs("L_NumberS")
	    nL4 = oRs("L_NumberC")
	    nC1 = oRs("C_NumberD")
	    nC2 = oRs("C_NumberI")
	    nC3 = oRs("C_NumberS")
	    nC4 = oRs("C_NumberC")
    Else
	    Response.Write strTextUnableToRetrieveResultsFromDatabasePlease
	    Response.End
    End If
    Set oConn = Nothing
    Set oCmd = Nothing
    Set oRs = Nothing
    %>

    <p><%=strTextTheChoicesYouMadeWhenYouCompletedThe%></p>

    <div align="center">
    <table class="addtable" border="0" cellspacing="0" cellpadding="3" width="85%">
	    <tr>
		    <td align="center" width="33%"><strong><%=UCase(strTextMost)%></strong></td>
		    <td align="center" width="33%"><strong><%=UCase(strTextLeast)%></strong></td>
		    <td align="center" width="34%"><strong><%=UCase(strTextComposite)%></strong></td>
	    </tr>
	    <tr>
		    <td align="center">
			    <img src="http://www.pdiprofile.com/PDI/DiscMostSmall.asp?nD1=<%=nM1%>&nD2=<%=nM2%>&nD3=<%=nM3%>&nD4=<%=nM4%>&res=<%=intResellerID%>" alt="" /><br />
			    <span class="captiontext"><strong>I. <%=strTextProjectedConcept%></strong></span>
		    </td>
		    <td align="center">
			    <img src="http://www.pdiprofile.com/PDI/DiscLeastSmall.asp?nD1=<%=nL1%>&nD2=<%=nL2%>&nD3=<%=nL3%>&nD4=<%=nL4%>&res=<%=intResellerID%>" alt="" /><br />
			    <span class="captiontext"><strong>II. <%=strTextPrivateConcept%></strong></span>
		    </td>
		    <td align="center">
			    <img src="http://www.pdiprofile.com/PDI/DiscCompositeSmall.asp?nD1=<%=nC1%>&nD2=<%=nC2%>&nD3=<%=nC3%>&nD4=<%=nC4%>&res=<%=intResellerID%>" alt="" /><br />
			    <span class="captiontext"><strong>III. <%=strTextPublicConcept%></strong></span>
		    </td>
	    </tr>
    </table>
    </div>

    <p><strong>I. <%=strTextProjectedConcept%></strong> (<%=strTextMOSTResponses%>): <%=strTextTheProjectedConceptReflectsHow%></p>
    <p><strong>II. <%=strTextPrivateConcept%></strong> (<%=strTextLEASTResponses%>): <%=strTextThisIsYourNaturalBehaviorWhatYou%></p>
    <p><strong>III. <%=strTextPublicConcept%></strong> (<%=UCase(strTextComposite)%>): <%=strTextTheCompositeGraphRepresentsTheNet%></p>
    <% If strSiteType <> "Focus3" Then %>
    <!-- #Include File = "Include/PrintProfileLink.asp" -->
    <% End If %>
    <% If (SPN <> "0") And (oldButtons = True) Then %>
	    <table border="0" cellspacing="0" cellpadding="0" width="570">
		    <tr>
			    <td align="right">
				    <a href="PDIProfileBehavioralChar1.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>"><img src="images/PDINextPage.gif" alt="" /></a>
			    </td>
		    </tr>
	    </table>
    <% End If %>
    <script>
    <!--
    SetCookie("qcompleted", "1");
    function SetCookie (name, value) {
	    var argv = SetCookie.arguments;
	    var argc = SetCookie.arguments.length;
	    var expires = (2 < argc) ? argv[2] : null;
	    var path = (3 < argc) ? argv[3] : null;
	    var domain = (4 < argc) ? argv[4] : null;
	    var secure = (5 < argc) ? argv[5] : false;
	    document.cookie = name + "=" + escape (value) +
	    ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
	    ((path == null) ? "" : ("; path=" + path)) +
	    ((domain == null) ? "" : ("; domain=" + domain)) +
	    ((secure == true) ? "; secure" : "");
    }
    -->
    </script>
    </div>
</div>
</body>
</html>
