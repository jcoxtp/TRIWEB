<%@ Language=VBScript CodePage=65001 %>




<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8" />
	<title>DISC Profile System | PDI Profile Questions 1</title>
	<link rel="stylesheet" href="_system.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
	<script language="javascript">
	<!--
		var isLoaded = 0;
		window.status = "请稍候...网页正在负载";
		image1 = new Image(692,82);
		image1.src = "images/sp1Loading.gif";
		image2 = new Image(692,82);
		image2.src = "images/s1p1.gif";

	<%
	' first check the QCompleted cookie - if the questions
	' were completed Then don't allow the user to see this
	' page - redirect them to the scoring summary page
	Dim strTempAns
	strTempAns = "false"
	Dim TestCodeID
	Dim nQuestionNumber
	' increment this for every question page
	' question page 1 = 1 
	' question page 2 = 13
	' question page 3 = 25
	' question page 4 = 37
	nQuestionNumber = 1
	
	' every page must acquire this value
	TestCodeID = Request.QueryString("TCID")
	
	Dim Submitted
	' tells you if this page has been submitted
	' the form calls the same page
	Submitted = Request.Form("Submitted")
	

	Dim Words(24)
	Dim DISC(24)
	Dim MostChoice(6)
	Dim LeastChoice(6)
	Dim nCount
	Dim nWord
	
	nWord = 1
	
	' Page 1
	Words(nWord) = "善于表达的"
	DISC(nWord) = "I"
	nWord = nWord + 1
	Words(nWord) = "依从的"
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = "强有力的"
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = "克制的"
	DISC(nWord) = "S"
	nWord = nWord + 1

	Words(nWord) = "精确的"
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = "专权的"
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = "乐于助人的"
	DISC(nWord) = "S"
	nWord = nWord + 1
	Words(nWord) = "有吸引力的"
	DISC(nWord) = "I"
	nWord = nWord + 1

	Words(nWord) = "有主见的"
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = "细心的"
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = "情绪化的"
	DISC(nWord) = "I"
	nWord = nWord + 1
	Words(nWord) = "满意的"
	DISC(nWord) = "S"
	nWord = nWord + 1

	Words(nWord) = "性情平和的"
	DISC(nWord) = "S"
	nWord = nWord + 1
	Words(nWord) = "刺激的"
	DISC(nWord) = "I"
	nWord = nWord + 1
	Words(nWord) = "小心翼翼的"
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = "有决心的"
	DISC(nWord) = "D"
	nWord = nWord + 1

	Words(nWord) = "正确的"
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = "勇于开拓的"
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = "平静的"
	DISC(nWord) = "S"
	nWord = nWord + 1
	Words(nWord) = "具影响力的"
	DISC(nWord) = "I"
	nWord = nWord + 1

	Words(nWord) = "胆怯的"
	DISC(nWord) = "C"
	nWord = nWord + 1
	Words(nWord) = "要求高的"
	DISC(nWord) = "D"
	nWord = nWord + 1
	Words(nWord) = "有耐心的"
	DISC(nWord) = "S"
	nWord = nWord + 1
	Words(nWord) = "有魅力的"
	DISC(nWord) = "I"
	nWord = nWord + 1

	Dim nChineseNumbers()
	Redim nChineseNumbers(48)
	nChineseNumbers(0) = "零"
	nChineseNumbers(1) = "一"
	nChineseNumbers(2) = "二"
	nChineseNumbers(3) = "三"
	nChineseNumbers(4) = "四"
	nChineseNumbers(5) = "五"
	nChineseNumbers(6) = "六"
	nChineseNumbers(7) = "七"
	nChineseNumbers(8) = "八"
	nChineseNumbers(9) = "九"
	nChineseNumbers(10) = "十"
	nChineseNumbers(11) = "十一"
	nChineseNumbers(12) = "十二"
	nChineseNumbers(13) = "十三"
	nChineseNumbers(14) = "十四"
	nChineseNumbers(15) = "十五"
	nChineseNumbers(16) = "十六"
	nChineseNumbers(17) = "十七"
	nChineseNumbers(18) = "十八"
	nChineseNumbers(19) = "十九"
	nChineseNumbers(20) = "二十"
	nChineseNumbers(21) = "二十一"
	nChineseNumbers(22) = "二十二"
	nChineseNumbers(23) = "二十三"
	nChineseNumbers(24) = "二十四"
	nChineseNumbers(25) = "二十五"
	nChineseNumbers(26) = "二十六"
	nChineseNumbers(27) = "二十七"
	nChineseNumbers(28) = "二十八"
	nChineseNumbers(29) = "二十九"
	nChineseNumbers(30) = "三十"
	nChineseNumbers(31) = "三十一"
	nChineseNumbers(32) = "三十二"
	nChineseNumbers(33) = "三十三"
	nChineseNumbers(34) = "三十四"
	nChineseNumbers(35) = "三十五"
	nChineseNumbers(36) = "三十六"
	nChineseNumbers(37) = "三十七"
	nChineseNumbers(38) = "三十八"
	nChineseNumbers(39) = "三十九"
	nChineseNumbers(40) = "四十"
	nChineseNumbers(41) = "四十一"
	nChineseNumbers(42) = "四十二"
	nChineseNumbers(43) = "四十三"
	nChineseNumbers(44) = "四十四"
	nChineseNumbers(45) = "四十五"
	nChineseNumbers(46) = "四十六"
	nChineseNumbers(47) = "四十七"
	nChineseNumbers(48) = "四十八"

	' I have encased the following javascript code into a function so that it will not
	' run until after the entire page has been loaded. This is a workaround because it
	' causes problems for users in China where the connection is very slow...JT
	Response.Write VbCrLf & "function checkAnswers() {" & VbCrLf
	Response.Write VrTab & "// This function is only used when form has been submitted" & VbCrLf
	Response.Write "}" & VbCrLf

	Response.Write "var bNextPage;" & VbCrLf
	Response.Write "var bQuestion1MostAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion2MostAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion3MostAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion4MostAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion5MostAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion6MostAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion1LeastAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion2LeastAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion3LeastAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion4LeastAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion5LeastAns = " & strTempAns & ";" & VbCrLf
	Response.Write "var bQuestion6LeastAns = " & strTempAns & ";" & VbCrLf
%>

	function SeeIfBoxesAreCheckedOnLoad() {
		// check if least are checked
		if(document.form1.chkLeast1Ans.checked == true || document.form1.chkLeast2Ans.checked == true || document.form1.chkLeast3Ans.checked == true || document.form1.chkLeast4Ans.checked == true) {
			bQuestion1LeastAns = true;
		}
		
		if(document.form1.chkLeast5Ans.checked == true || document.form1.chkLeast6Ans.checked == true || document.form1.chkLeast7Ans.checked == true || document.form1.chkLeast8Ans.checked == true) {
			bQuestion2LeastAns = true;
		}
		
		if(document.form1.chkLeast9Ans.checked == true || document.form1.chkLeast10Ans.checked == true || document.form1.chkLeast11Ans.checked == true || document.form1.chkLeast12Ans.checked == true) {
			bQuestion3LeastAns = true;
		}
		
		if(document.form1.chkLeast13Ans.checked == true || document.form1.chkLeast14Ans.checked == true || document.form1.chkLeast15Ans.checked == true || document.form1.chkLeast16Ans.checked == true) {
			bQuestion4LeastAns = true;
		}
		
		if(document.form1.chkLeast17Ans.checked == true || document.form1.chkLeast18Ans.checked == true || document.form1.chkLeast19Ans.checked == true || document.form1.chkLeast20Ans.checked == true) {
			bQuestion5LeastAns = true;
		}
		
		if(document.form1.chkLeast21Ans.checked == true || document.form1.chkLeast22Ans.checked == true || document.form1.chkLeast23Ans.checked == true || document.form1.chkLeast24Ans.checked == true) {
			bQuestion6LeastAns = true;
		}
		
		// check if most are checked
		if(document.form1.chkMost1Ans.checked == true || document.form1.chkMost2Ans.checked == true || document.form1.chkMost3Ans.checked == true || document.form1.chkMost4Ans.checked == true) {
			bQuestion1MostAns = true;
		}
		
		if(document.form1.chkMost5Ans.checked == true || document.form1.chkMost6Ans.checked == true || document.form1.chkMost7Ans.checked == true || document.form1.chkMost8Ans.checked == true) {
			bQuestion2MostAns = true;
		}
		
		if(document.form1.chkMost9Ans.checked == true || document.form1.chkMost10Ans.checked == true || document.form1.chkMost11Ans.checked == true || document.form1.chkMost12Ans.checked == true) {
			bQuestion3MostAns = true;
		}
		
		if(document.form1.chkMost13Ans.checked == true || document.form1.chkMost14Ans.checked == true || document.form1.chkMost15Ans.checked == true || document.form1.chkMost16Ans.checked == true) {
			bQuestion4MostAns = true;
		}
		
		if(document.form1.chkMost17Ans.checked == true || document.form1.chkMost18Ans.checked == true || document.form1.chkMost19Ans.checked == true || document.form1.chkMost20Ans.checked == true) {
			bQuestion5MostAns = true;
		}
		
		if(document.form1.chkMost21Ans.checked == true || document.form1.chkMost22Ans.checked == true || document.form1.chkMost23Ans.checked == true || document.form1.chkMost24Ans.checked == true)	{
			bQuestion6MostAns = true;
		}
	}
	<%
		Dim strMost
		Dim strLeast
		strMost = "Most"
		strLeast = "Least"

		Response.Write VbCrLf
		Response.Write "function CheckedMostAns(nItem) {" & VbCrLf
		Dim nItem
		nCount = 1 
		For nItem = 1 to 21 step 4 %>
			if(nItem >=<%=nItem%> && nItem <= <%=nItem+3%>) {
				if(nItem==<%=nItem%>) {
					if(document.form1.chk<%=strLeast%>Ans<%=nItem%>.checked) {
						document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = false;
						return;
					}
				}
			else if(nItem==<%=nItem+1%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+1%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = false;
					return;
				}
			}
			else if(nItem==<%=nItem+2%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+2%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = false;
					return;
				}
			}
			else if(nItem==<%=nItem+3%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+3%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = false;
					return;
				}
			}
			bQuestion<%=nCount%>MostAns = true;

			if(nItem!=<%=nItem%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = true;
			}

			if(nItem!=<%=nItem+1%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = true;
			}
			
			if(nItem!=<%=nItem+2%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = true;
			}
			
			if(nItem!=<%=nItem+3%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = true;
			}
			<% nCount = nCount + 1 %>
		}
		<% Next %>
	}

	<%
		strMost = "Least"
		strLeast = "Most"
	%>

	function CheckedLeastAns(nItem) {
		//alert(nItem);
		<%
		nCount = 1
		For nItem = 1 to 21 step 4 %>

		if(nItem >= <%=nItem%> && nItem <= <%=nItem+3%>) {
			if(nItem==<%=nItem%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = false;
					return;
				}
			}
			else if(nItem==<%=nItem+1%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+1%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = false;
					return;
				}
			}
			else if(nItem==<%=nItem+2%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+2%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = false;
					return;
				}
			}
			else if(nItem==<%=nItem+3%>) {
				if(document.form1.chk<%=strLeast%>Ans<%=nItem+3%>.checked) {
					document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = false;
					return;
				}
			}
			bQuestion<%=nCount%>LeastAns = true;
			if(nItem!=<%=nItem%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem%>.checked = true;
			}
			if(nItem!=<%=nItem+1%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+1%>.checked = true;
			}
			if(nItem!=<%=nItem+2%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+2%>.checked = true;
			}
			if(nItem!=<%=nItem+3%>) {
				document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = false;
			} else {
				document.form1.chk<%=strMost%>Ans<%=nItem+3%>.checked = true;
			}
			<% nCount = nCount + 1 %>
		}
		<% next %>
	}

	function GoToNextPage() {
		if (isLoaded == 1) {
			<% for nItem = 1 to 6 %>
				if(!bQuestion<%=nItem%>MostAns) {
					alert("请回答“最能”这组的第<%=nChineseNumbers(nItem)%>条");
					return;
				}
				if(!bQuestion<%=nItem%>LeastAns) {
					alert("请回答“最不能”这组的第<%=nChineseNumbers(nItem)%>条");
					return;
				}
			<% next %>
			<% nCount = 1 
			for nItem = 1 to 21 step 4 %>
			if(document.form1.chkMostAns<%=nItem%>.checked) {
				document.form1.MostAns<%=nCount%>.value = "<%=DISC(nItem)%>";
			}
			else if(document.form1.chkMostAns<%=nItem+1%>.checked) {
				document.form1.MostAns<%=nCount%>.value = "<%=DISC(nItem+1)%>";
			}
			else if(document.form1.chkMostAns<%=nItem+2%>.checked) {
				document.form1.MostAns<%=nCount%>.value = "<%=DISC(nItem+2)%>";
			}
			else if(document.form1.chkMostAns<%=nItem+3%>.checked) {
				document.form1.MostAns<%=nCount%>.value = "<%=DISC(nItem+3)%>";
			}
			if(document.form1.chkLeastAns<%=nItem%>.checked) {
				document.form1.LeastAns<%=nCount%>.value = "<%=DISC(nItem)%>";
			}
			else if(document.form1.chkLeastAns<%=nItem+1%>.checked) {
				document.form1.LeastAns<%=nCount%>.value = "<%=DISC(nItem+1)%>";
			}
			else if(document.form1.chkLeastAns<%=nItem+2%>.checked) {
				document.form1.LeastAns<%=nCount%>.value = "<%=DISC(nItem+2)%>";
			}
			else if(document.form1.chkLeastAns<%=nItem+3%>.checked) {
				document.form1.LeastAns<%=nCount%>.value = "<%=DISC(nItem+3)%>";
			}
			<% nCount = nCount + 1
			next %>
				document.form1.submit();
		} else {
			alert ("网页正在负载...");
		}
	}

	function initpage() {
		qsubmitted();
		checkAnswers();
		window.status = "完成";
		isLoaded = 1;
		//SeeIfBoxesAreCheckedOnLoad();
		document.statusImage.src = image2.src;
	}

	function qsubmitted() {
		// if the questions are completed Then
		// automatically redirect the user to the
		// scoring summary page
		// this cookie is set on the PDI start page
		var qcompleted = GetCookie("qcompleted");
		if(qcompleted == 1) {
			window.location="PDIProfileQuit.asp?TCID=<%=TestCodeID%>"
		}
	}

	function getCookieVal (offset) {
		var endstr = document.cookie.indexOf (";", offset);
		if (endstr == -1)
		endstr = document.cookie.length;
		return unescape(document.cookie.substring(offset, endstr));
	}

	function GetCookie (name) {
		var arg = name + "=";
		var alen = arg.length;
		var clen = document.cookie.length;
		var i = 0;
		while (i < clen) {
			var j = i + alen;
			if (document.cookie.substring(i, j) == arg)
			return getCookieVal (j);
			i = document.cookie.indexOf(" ", i) + 1;
			if (i == 0)
			break;
		}
		return null;
	}

	-->
	</script>
</head>

<body onload="initpage()">
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="tabgraphic">
	<form name="form1" id="form1" method="post">
	<img src="images/s1Loading.gif" name="statusImage" alt="" width="692" height="82" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="633,53,672,53,680,59,673,65,632,66,617,59,634,53,637,53" href="javascript:GoToNextPage()">
	</map>
</div>
<div id="maincontent_tab">
	<input type="hidden" name="MostAns1" id="MostAns1">
	<input type="hidden" name="MostAns2" id="MostAns2">
	<input type="hidden" name="MostAns3" id="MostAns3">
	<input type="hidden" name="MostAns4" id="MostAns4">
	<input type="hidden" name="MostAns5" id="MostAns5">
	<input type="hidden" name="MostAns6" id="MostAns6">
	<input type="hidden" name="LeastAns1" id="LeastAns1">
	<input type="hidden" name="LeastAns2" id="LeastAns2">
	<input type="hidden" name="LeastAns3" id="LeastAns3">
	<input type="hidden" name="LeastAns4" id="LeastAns4">
	<input type="hidden" name="LeastAns5" id="LeastAns5">
	<input type="hidden" name="LeastAns6" id="LeastAns6">
	<input type="hidden" name="Submitted" id="Submitted" value="1">
	<input type="hidden" name="TCID" id="TCID" value="<%=TestCodeID%>">
	<table border="0" cellspacing="0" cellpadding="4" width="<%=tableWidth%>">
		<tr>
			<td valign="top" width="200">
				<h2><b>指南/b></h2>
				<p>在每一个四词的组合当中，请选择一个最能形容你的词，和一个最不能形容你的词。</p>
				<% If intResellerID = 2 Then %>
					<p></p>
				<% Else %>
					<p>记住把你自己想象成身在工作的环境，以你的第一直觉为准。</p>
				<% End If %>
				<p>当你完成每一页后，点击右上角的“下一步”方框，然后继续。</p>
			</td>
			<td valign="top">
				<table border="0" cellspacing="0" cellpadding="3" width="100%">
					<tr>
						<td valign="middle" align="right"><strong>最能</strong></td>
						<td valign="middle" align="center">|</td>
						<td valign="middle" align="left"><strong>最不能</strong></td>
						<td colspan="2" valign="middle" align="left">&nbsp;</td>
						<td valign="middle" align="right"><strong>最能</strong></td>
						<td valign="middle" align="center">|</td>
						<td valign="middle" align="left"><strong>最不能</strong></td>
						<td valign="middle" align="left">&nbsp;</td>
					</tr>
		<% 	
			nCount = 0
			for nWord = 1 to 12
			if (nWord <= 4) OR (nWord >= 9) Then
		%>
					<tr>
						<td valign="middle" align="right"><input type="radio" name="chkMostAns<%=nWord%>" id="chkMostAns<%=nWord%>" onclick="CheckedMostAns(<%=nWord%>)"></td>
						<td valign="middle" align="center">&nbsp;</td>
						<td valign="middle" align="left"><input type="radio" name="chkLeastAns<%=nWord%>" id="chkLeastAns<%=nWord%>" onclick="CheckedLeastAns(<%=nWord%>)"></td>
						<td valign="middle" align="left"><%=Words(nWord)%></td>
						<td width="1">|</td>
						<td valign="middle" align="right"><input type="radio" name="chkMostAns<%=nWord+12%>" id="chkMostAns<%=nWord+12%>" onclick="CheckedMostAns(<%=nWord+12%>)"></td>
						<td valign="middle" align="center">&nbsp;</td>
						<td valign="middle" align="left"><input type="radio" name="chkLeastAns<%=nWord+12%>" id="chkLeastAns<%=nWord+12%>" onclick="CheckedLeastAns(<%=nWord+12%>)"></td>
						<td valign="middle" align="left"><%=Words(nWord+12)%></td>
					</tr>
		<% else %>
					<tr>
						<td valign="middle" align="right" bgcolor="#cccccc"><input type="radio" name="chkMostAns<%=nWord%>" id="chkMostAns<%=nWord%>" onclick="CheckedMostAns(<%=nWord%>)"></td>
						<td valign="middle" align="center" bgcolor="#cccccc">&nbsp;</td>
						<td valign="middle" align="left" bgcolor="#cccccc"><input type="radio" name="chkLeastAns<%=nWord%>" id="chkLeastAns<%=nWord%>" onclick="CheckedLeastAns(<%=nWord%>)"></td>
						<td valign="middle" align="left" bgcolor="#cccccc"><%=Words(nWord)%></td>
						<td width="1" bgcolor="#cccccc">|</td>
						<td valign="middle" align="right" bgcolor="#cccccc"><input type="radio" name="chkMostAns<%=nWord+12%>" id="chkMostAns<%=nWord+12%>" onclick="CheckedMostAns(<%=nWord+12%>)"></td>
						<td valign="middle" align="center" bgcolor="#cccccc">&nbsp;</td>
						<td valign="middle" align="left" bgcolor="#cccccc"><input type="radio" name="chkLeastAns<%=nWord+12%>" id="chkLeastAns<%=nWord+12%>" onclick="CheckedLeastAns(<%=nWord+12%>)"></td>
						<td valign="middle" align="left" bgcolor="#cccccc"><%=Words(nWord+12)%></td>
					</tr>
		<%	End If
			nCount = nCount + 1
			If nCount = 4 Then
		%>
					<tr>
						<td colspan="9"><img src="images/spacer.gif" alt="" width="1" height="10" /><br><img src="/pdi/images/black_line.jpg" width="100%" height="1"><br></td>
					</tr>
		<%
			nCount = 0
			End If
			next
			if oldButtons = true Then %>
					<tr>
						<td colspan="9" align="right"><input Type="IMAGE" Name="NextPage" SRC="images/PDINextPage_Narrow.gif"></td>
					</tr>
		<%	End If %>
				</table>
			</td>
		</tr>
	</table>
	</form>
</div>
</body>
</html>