<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5" ID="Table1">
	<tr>
		<td ALIGN="MIDDLE" class="grid"><font size="2">&nbsp;</td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "D" Then %>style="background-color:#bbb"<%End If%>><font size="3"><b>D</b></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "I" Then %>style="background-color:#bbb"<%End If%>><font size="3"><b>I</b></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "S" Then %>style="background-color:#bbb"<%End If%>><font size="3"><b>S</b></td>
		<td ALIGN="MIDDLE" class="gridRC" <% If HighType1 = "C" Then %>style="background-color:#bbb"<%End If%>><font size="3"><b>C</b></td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "D" Then %>style="background-color:#bbb"<%End If%>><font size="3"><b>D</b></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "D" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextFair %><!--Fair--></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "D" Or HighType1 = "I" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextFair %><!--Fair--></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "D" Or HighType1 = "S" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextExcellent %><!--Excellent--></td>
		<td ALIGN="MIDDLE" class="gridRC" <% If HighType1 = "D" Or HighType1 = "C" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextFair %><!--Fair--></td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "I" Then %>style="background-color:#bbb"<%End If%>><font size="3"><b>I</b></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "I" Or HighType1 = "D" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextFair %><!--Fair--></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "I" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextPoor %><!--Poor--></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "I" Or HighType1 = "S" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextExcellent %><!--Excellent--></td>
		<td ALIGN="MIDDLE" class="gridRC" <% If HighType1 = "I" Or HighType1 = "C" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextFair %><!--Good--></td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "S" Then %>style="background-color:#bbb"<%End If%>><font size="3"><b>S</b></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "S" Or HighType1 = "D" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextExcellent %><!--Excellent--></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "S" Or HighType1 = "I" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextExcellent %><!--Excellent--></td>
		<td ALIGN="MIDDLE" class="grid" <% If HighType1 = "S" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextGood %><!--Good--></td>
		<td ALIGN="MIDDLE" class="gridRC" <% If HighType1 = "S" Or HighType1 = "C" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextExcellent %><!--Excellent--></td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE" class="gridBR" <% If HighType1 = "C" Then %>style="background-color:#bbb"<%End If%>><font size="3"><b>C</b></td>
		<td ALIGN="MIDDLE" class="gridBR" <% If HighType1 = "C" Or HighType1 = "D" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextFair %><!--Fair--></td>
		<td ALIGN="MIDDLE" class="gridBR" <% If HighType1 = "C" Or HighType1 = "I" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextFair %><!--Fair--></td>
		<td ALIGN="MIDDLE" class="gridBR" <% If HighType1 = "C" Or HighType1 = "S" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextExcellent %><!--Excellent--></td>
		<td ALIGN="MIDDLE" <% If HighType1 = "C" Then %>style="background-color:#bbb"<%End If%>><font size="2"><%= strTextGood %><!--Good--></td>
	</tr>
</table>