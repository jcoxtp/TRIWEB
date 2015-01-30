<%@language = "vbscript"%>
<%
Option Explicit
Response.Expires = 0
Response.Buffer = True	
'************************************************************************************
'
' Name:		chooseColor.asp
' Purpose:	choose a color for an input field
'
'
' Author:	    Ultimate Software Designs
' Date Written:	12/10/2002
' Modified:		
'
' Changes:
'************************************************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<%
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim strHex
	Dim strFormField
	Dim strFormName
	Dim intCounter
	
%>
	<%=header_htmlTop("white","")%>
		<p class="pageTitle">Choose a Color:</p>
<%	
	
	strFormField = Request.QueryString("formField")
	strFormName = Request.QueryString("formName")
	

%>
		<table class="normal">
				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#000000';window.close();">#000000</a>
					</td>
					<td bgcolor="#000000" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#000033';window.close();">#000033</a>
					</td>
					<td bgcolor="#000033" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#000066';window.close();">#000066</a>
					</td>
					<td bgcolor="#000066" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#000099';window.close();">#000099</a>
					</td>
					<td bgcolor="#000099" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#0000CC';window.close();">#0000CC</a>
					</td>
					<td bgcolor="#0000CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#0000FF';window.close();">#0000FF</a>
					</td>
					<td bgcolor="#0000FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#003300';window.close();">#003300</a>
					</td>
					<td bgcolor="#003300" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#003333';window.close();">#003333</a>
					</td>
					<td bgcolor="#003333" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#003366';window.close();">#003366</a>
					</td>
					<td bgcolor="#003366" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#003399';window.close();">#003399</a>
					</td>
					<td bgcolor="#003399" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#0033CC';window.close();">#0033CC</a>
					</td>
					<td bgcolor="#0033CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#0033FF';window.close();">#0033FF</a>
					</td>
					<td bgcolor="#0033FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#006600';window.close();">#006600</a>
					</td>
					<td bgcolor="#006600" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#006633';window.close();">#006633</a>
					</td>
					<td bgcolor="#006633" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#006666';window.close();">#006666</a>
					</td>
					<td bgcolor="#006666" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#006699';window.close();">#006699</a>
					</td>
					<td bgcolor="#006699" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#0066CC';window.close();">#0066CC</a>
					</td>
					<td bgcolor="#0066CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#0066FF';window.close();">#0066FF</a>
					</td>
					<td bgcolor="#0066FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#009900';window.close();">#009900</a>
					</td>
					<td bgcolor="#009900" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#009933';window.close();">#009933</a>
					</td>
					<td bgcolor="#009933" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#009966';window.close();">#009966</a>
					</td>
					<td bgcolor="#009966" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#009999';window.close();">#009999</a>
					</td>
					<td bgcolor="#009999" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#0099CC';window.close();">#0099CC</a>
					</td>
					<td bgcolor="#0099CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#0099FF';window.close();">#0099FF</a>
					</td>
					<td bgcolor="#0099FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00CC00';window.close();">#00CC00</a>
					</td>
					<td bgcolor="#00CC00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00CC33';window.close();">#00CC33</a>
					</td>
					<td bgcolor="#00CC33" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00CC66';window.close();">#00CC66</a>
					</td>
					<td bgcolor="#00CC66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00CC99';window.close();">#00CC99</a>
					</td>
					<td bgcolor="#00CC99" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00CCCC';window.close();">#00CCCC</a>
					</td>
					<td bgcolor="#00CCCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00CCFF';window.close();">#00CCFF</a>
					</td>
					<td bgcolor="#00CCFF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00FF00';window.close();">#00FF00</a>
					</td>
					<td bgcolor="#00FF00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00FF33';window.close();">#00FF33</a>
					</td>
					<td bgcolor="#00FF33" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00FF66';window.close();">#00FF66</a>
					</td>
					<td bgcolor="#00FF66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00FF99';window.close();">#00FF99</a>
					</td>
					<td bgcolor="#00FF99" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00FFCC';window.close();">#00FFCC</a>
					</td>
					<td bgcolor="#00FFCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#00FFFF';window.close();">#00FFFF</a>
					</td>
					<td bgcolor="#00FFFF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#330000';window.close();">#330000</a>
					</td>
					<td bgcolor="#330000" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#330033';window.close();">#330033</a>
					</td>
					<td bgcolor="#330033" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#330066';window.close();">#330066</a>
					</td>
					<td bgcolor="#330066" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#330099';window.close();">#330099</a>
					</td>
					<td bgcolor="#330099" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#3300CC';window.close();">#3300CC</a>
					</td>
					<td bgcolor="#3300CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#3300FF';window.close();">#3300FF</a>
					</td>
					<td bgcolor="#3300FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#333300';window.close();">#333300</a>
					</td>
					<td bgcolor="#333300" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#333333';window.close();">#333333</a>
					</td>
					<td bgcolor="#333333" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#333366';window.close();">#333366</a>
					</td>
					<td bgcolor="#333366" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#333399';window.close();">#333399</a>
					</td>
					<td bgcolor="#333399" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#3333CC';window.close();">#3333CC</a>
					</td>
					<td bgcolor="#3333CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#3333FF';window.close();">#3333FF</a>
					</td>
					<td bgcolor="#3333FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#336600';window.close();">#336600</a>
					</td>
					<td bgcolor="#336600" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#336633';window.close();">#336633</a>
					</td>
					<td bgcolor="#336633" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#336666';window.close();">#336666</a>
					</td>
					<td bgcolor="#336666" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#336699';window.close();">#336699</a>
					</td>
					<td bgcolor="#336699" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#3366CC';window.close();">#3366CC</a>
					</td>
					<td bgcolor="#3366CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#3366FF';window.close();">#3366FF</a>
					</td>
					<td bgcolor="#3366FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#339900';window.close();">#339900</a>
					</td>
					<td bgcolor="#339900" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#339933';window.close();">#339933</a>
					</td>
					<td bgcolor="#339933" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#339966';window.close();">#339966</a>
					</td>
					<td bgcolor="#339966" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#339999';window.close();">#339999</a>
					</td>
					<td bgcolor="#339999" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#3399CC';window.close();">#3399CC</a>
					</td>
					<td bgcolor="#3399CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#3399FF';window.close();">#3399FF</a>
					</td>
					<td bgcolor="#3399FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33CC00';window.close();">#33CC00</a>
					</td>
					<td bgcolor="#33CC00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33CC33';window.close();">#33CC33</a>
					</td>
					<td bgcolor="#33CC33" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33CC66';window.close();">#33CC66</a>
					</td>
					<td bgcolor="#33CC66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33CC99';window.close();">#33CC99</a>
					</td>
					<td bgcolor="#33CC99" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33CCCC';window.close();">#33CCCC</a>
					</td>
					<td bgcolor="#33CCCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33CCFF';window.close();">#33CCFF</a>
					</td>
					<td bgcolor="#33CCFF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33FF00';window.close();">#33FF00</a>
					</td>
					<td bgcolor="#33FF00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33FF33';window.close();">#33FF33</a>
					</td>
					<td bgcolor="#33FF33" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33FF66';window.close();">#33FF66</a>
					</td>
					<td bgcolor="#33FF66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33FF99';window.close();">#33FF99</a>
					</td>
					<td bgcolor="#33FF99" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33FFCC';window.close();">#33FFCC</a>
					</td>
					<td bgcolor="#33FFCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#33FFFF';window.close();">#33FFFF</a>
					</td>
					<td bgcolor="#33FFFF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#660000';window.close();">#660000</a>
					</td>
					<td bgcolor="#660000" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#660033';window.close();">#660033</a>
					</td>
					<td bgcolor="#660033" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#660066';window.close();">#660066</a>
					</td>
					<td bgcolor="#660066" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#660099';window.close();">#660099</a>
					</td>
					<td bgcolor="#660099" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#6600CC';window.close();">#6600CC</a>
					</td>
					<td bgcolor="#6600CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#6600FF';window.close();">#6600FF</a>
					</td>
					<td bgcolor="#6600FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#663300';window.close();">#663300</a>
					</td>
					<td bgcolor="#663300" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#663333';window.close();">#663333</a>
					</td>
					<td bgcolor="#663333" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#663366';window.close();">#663366</a>
					</td>
					<td bgcolor="#663366" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#663399';window.close();">#663399</a>
					</td>
					<td bgcolor="#663399" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#6633CC';window.close();">#6633CC</a>
					</td>
					<td bgcolor="#6633CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#6633FF';window.close();">#6633FF</a>
					</td>
					<td bgcolor="#6633FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#666600';window.close();">#666600</a>
					</td>
					<td bgcolor="#666600" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#666633';window.close();">#666633</a>
					</td>
					<td bgcolor="#666633" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#666666';window.close();">#666666</a>
					</td>
					<td bgcolor="#666666" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#666699';window.close();">#666699</a>
					</td>
					<td bgcolor="#666699" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#6666CC';window.close();">#6666CC</a>
					</td>
					<td bgcolor="#6666CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#6666FF';window.close();">#6666FF</a>
					</td>
					<td bgcolor="#6666FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#669900';window.close();">#669900</a>
					</td>
					<td bgcolor="#669900" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#669933';window.close();">#669933</a>
					</td>
					<td bgcolor="#669933" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#669966';window.close();">#669966</a>
					</td>
					<td bgcolor="#669966" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#669999';window.close();">#669999</a>
					</td>
					<td bgcolor="#669999" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#6699CC';window.close();">#6699CC</a>
					</td>
					<td bgcolor="#6699CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#6699FF';window.close();">#6699FF</a>
					</td>
					<td bgcolor="#6699FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66CC00';window.close();">#66CC00</a>
					</td>
					<td bgcolor="#66CC00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66CC33';window.close();">#66CC33</a>
					</td>
					<td bgcolor="#66CC33" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66CC66';window.close();">#66CC66</a>
					</td>
					<td bgcolor="#66CC66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66CC99';window.close();">#66CC99</a>
					</td>
					<td bgcolor="#66CC99" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66CCCC';window.close();">#66CCCC</a>
					</td>
					<td bgcolor="#66CCCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66CCFF';window.close();">#66CCFF</a>
					</td>
					<td bgcolor="#66CCFF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66FF00';window.close();">#66FF00</a>
					</td>
					<td bgcolor="#66FF00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66FF33';window.close();">#66FF33</a>
					</td>
					<td bgcolor="#66FF33" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66FF66';window.close();">#66FF66</a>
					</td>
					<td bgcolor="#66FF66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66FF99';window.close();">#66FF99</a>
					</td>
					<td bgcolor="#66FF99" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66FFCC';window.close();">#66FFCC</a>
					</td>
					<td bgcolor="#66FFCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#66FFFF';window.close();">#66FFFF</a>
					</td>
					<td bgcolor="#66FFFF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#990000';window.close();">#990000</a>
					</td>
					<td bgcolor="#990000" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#990033';window.close();">#990033</a>
					</td>
					<td bgcolor="#990033" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#990066';window.close();">#990066</a>
					</td>
					<td bgcolor="#990066" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#990099';window.close();">#990099</a>
					</td>
					<td bgcolor="#990099" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#9900CC';window.close();">#9900CC</a>
					</td>
					<td bgcolor="#9900CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#9900FF';window.close();">#9900FF</a>
					</td>
					<td bgcolor="#9900FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#993300';window.close();">#993300</a>
					</td>
					<td bgcolor="#993300" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#993333';window.close();">#993333</a>
					</td>
					<td bgcolor="#993333" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#993366';window.close();">#993366</a>
					</td>
					<td bgcolor="#993366" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#993399';window.close();">#993399</a>
					</td>
					<td bgcolor="#993399" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#9933CC';window.close();">#9933CC</a>
					</td>
					<td bgcolor="#9933CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#9933FF';window.close();">#9933FF</a>
					</td>
					<td bgcolor="#9933FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#996600';window.close();">#996600</a>
					</td>
					<td bgcolor="#996600" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#996633';window.close();">#996633</a>
					</td>
					<td bgcolor="#996633" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#996666';window.close();">#996666</a>
					</td>
					<td bgcolor="#996666" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#996699';window.close();">#996699</a>
					</td>
					<td bgcolor="#996699" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#9966CC';window.close();">#9966CC</a>
					</td>
					<td bgcolor="#9966CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#9966FF';window.close();">#9966FF</a>
					</td>
					<td bgcolor="#9966FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#999900';window.close();">#999900</a>
					</td>
					<td bgcolor="#999900" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#999933';window.close();">#999933</a>
					</td>
					<td bgcolor="#999933" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#999966';window.close();">#999966</a>
					</td>
					<td bgcolor="#999966" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#999999';window.close();">#999999</a>
					</td>
					<td bgcolor="#999999" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#9999CC';window.close();">#9999CC</a>
					</td>
					<td bgcolor="#9999CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#9999FF';window.close();">#9999FF</a>
					</td>
					<td bgcolor="#9999FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99CC00';window.close();">#99CC00</a>
					</td>
					<td bgcolor="#99CC00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99CC33';window.close();">#99CC33</a>
					</td>
					<td bgcolor="#99CC33" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99CC66';window.close();">#99CC66</a>
					</td>
					<td bgcolor="#99CC66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99CC99';window.close();">#99CC99</a>
					</td>
					<td bgcolor="#99CC99" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99CCCC';window.close();">#99CCCC</a>
					</td>
					<td bgcolor="#99CCCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99CCFF';window.close();">#99CCFF</a>
					</td>
					<td bgcolor="#99CCFF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99FF00';window.close();">#99FF00</a>
					</td>
					<td bgcolor="#99FF00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99FF33';window.close();">#99FF33</a>
					</td>
					<td bgcolor="#99FF33" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99FF66';window.close();">#99FF66</a>
					</td>
					<td bgcolor="#99FF66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99FF99';window.close();">#99FF99</a>
					</td>
					<td bgcolor="#99FF99" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99FFCC';window.close();">#99FFCC</a>
					</td>
					<td bgcolor="#99FFCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#99FFFF';window.close();">#99FFFF</a>
					</td>
					<td bgcolor="#99FFFF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC0000';window.close();">#CC0000</a>
					</td>
					<td bgcolor="#CC0000" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC0033';window.close();">#CC0033</a>
					</td>
					<td bgcolor="#CC0033" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC0066';window.close();">#CC0066</a>
					</td>
					<td bgcolor="#CC0066" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC0099';window.close();">#CC0099</a>
					</td>
					<td bgcolor="#CC0099" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC00CC';window.close();">#CC00CC</a>
					</td>
					<td bgcolor="#CC00CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC00FF';window.close();">#CC00FF</a>
					</td>
					<td bgcolor="#CC00FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC3300';window.close();">#CC3300</a>
					</td>
					<td bgcolor="#CC3300" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC3333';window.close();">#CC3333</a>
					</td>
					<td bgcolor="#CC3333" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC3366';window.close();">#CC3366</a>
					</td>
					<td bgcolor="#CC3366" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC3399';window.close();">#CC3399</a>
					</td>
					<td bgcolor="#CC3399" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC33CC';window.close();">#CC33CC</a>
					</td>
					<td bgcolor="#CC33CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC33FF';window.close();">#CC33FF</a>
					</td>
					<td bgcolor="#CC33FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC6600';window.close();">#CC6600</a>
					</td>
					<td bgcolor="#CC6600" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC6633';window.close();">#CC6633</a>
					</td>
					<td bgcolor="#CC6633" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC6666';window.close();">#CC6666</a>
					</td>
					<td bgcolor="#CC6666" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC6699';window.close();">#CC6699</a>
					</td>
					<td bgcolor="#CC6699" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC66CC';window.close();">#CC66CC</a>
					</td>
					<td bgcolor="#CC66CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC66FF';window.close();">#CC66FF</a>
					</td>
					<td bgcolor="#CC66FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC9900';window.close();">#CC9900</a>
					</td>
					<td bgcolor="#CC9900" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC9933';window.close();">#CC9933</a>
					</td>
					<td bgcolor="#CC9933" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC9966';window.close();">#CC9966</a>
					</td>
					<td bgcolor="#CC9966" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC9999';window.close();">#CC9999</a>
					</td>
					<td bgcolor="#CC9999" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC99CC';window.close();">#CC99CC</a>
					</td>
					<td bgcolor="#CC99CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CC99FF';window.close();">#CC99FF</a>
					</td>
					<td bgcolor="#CC99FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCCC00';window.close();">#CCCC00</a>
					</td>
					<td bgcolor="#CCCC00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCCC33';window.close();">#CCCC33</a>
					</td>
					<td bgcolor="#CCCC33" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCCC66';window.close();">#CCCC66</a>
					</td>
					<td bgcolor="#CCCC66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCCC99';window.close();">#CCCC99</a>
					</td>
					<td bgcolor="#CCCC99" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCCCCC';window.close();">#CCCCCC</a>
					</td>
					<td bgcolor="#CCCCCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCCCFF';window.close();">#CCCCFF</a>
					</td>
					<td bgcolor="#CCCCFF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCFF00';window.close();">#CCFF00</a>
					</td>
					<td bgcolor="#CCFF00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCFF33';window.close();">#CCFF33</a>
					</td>
					<td bgcolor="#CCFF33" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCFF66';window.close();">#CCFF66</a>
					</td>
					<td bgcolor="#CCFF66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCFF99';window.close();">#CCFF99</a>
					</td>
					<td bgcolor="#CCFF99" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCFFCC';window.close();">#CCFFCC</a>
					</td>
					<td bgcolor="#CCFFCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#CCFFFF';window.close();">#CCFFFF</a>
					</td>
					<td bgcolor="#CCFFFF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF0000';window.close();">#FF0000</a>
					</td>
					<td bgcolor="#FF0000" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF0033';window.close();">#FF0033</a>
					</td>
					<td bgcolor="#FF0033" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF0066';window.close();">#FF0066</a>
					</td>
					<td bgcolor="#FF0066" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF0099';window.close();">#FF0099</a>
					</td>
					<td bgcolor="#FF0099" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF00CC';window.close();">#FF00CC</a>
					</td>
					<td bgcolor="#FF00CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF00FF';window.close();">#FF00FF</a>
					</td>
					<td bgcolor="#FF00FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF3300';window.close();">#FF3300</a>
					</td>
					<td bgcolor="#FF3300" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF3333';window.close();">#FF3333</a>
					</td>
					<td bgcolor="#FF3333" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF3366';window.close();">#FF3366</a>
					</td>
					<td bgcolor="#FF3366" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF3399';window.close();">#FF3399</a>
					</td>
					<td bgcolor="#FF3399" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF33CC';window.close();">#FF33CC</a>
					</td>
					<td bgcolor="#FF33CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF33FF';window.close();">#FF33FF</a>
					</td>
					<td bgcolor="#FF33FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF6600';window.close();">#FF6600</a>
					</td>
					<td bgcolor="#FF6600" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF6633';window.close();">#FF6633</a>
					</td>
					<td bgcolor="#FF6633" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF6666';window.close();">#FF6666</a>
					</td>
					<td bgcolor="#FF6666" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF6699';window.close();">#FF6699</a>
					</td>
					<td bgcolor="#FF6699" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF66CC';window.close();">#FF66CC</a>
					</td>
					<td bgcolor="#FF66CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF66FF';window.close();">#FF66FF</a>
					</td>
					<td bgcolor="#FF66FF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF9900';window.close();">#FF9900</a>
					</td>
					<td bgcolor="#FF9900" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF9933';window.close();">#FF9933</a>
					</td>
					<td bgcolor="#FF9933" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF9966';window.close();">#FF9966</a>
					</td>
					<td bgcolor="#FF9966" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF9999';window.close();">#FF9999</a>
					</td>
					<td bgcolor="#FF9999" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF99CC';window.close();">#FF99CC</a>
					</td>
					<td bgcolor="#FF99CC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FF99FF';window.close();">#FF99FF</a>
					</td>
					<td bgcolor="#FF99FF" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFCC00';window.close();">#FFCC00</a>
					</td>
					<td bgcolor="#FFCC00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFCC33';window.close();">#FFCC33</a>
					</td>
					<td bgcolor="#FFCC33" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFCC66';window.close();">#FFCC66</a>
					</td>
					<td bgcolor="#FFCC66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFCC99';window.close();">#FFCC99</a>
					</td>
					<td bgcolor="#FFCC99" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFCCCC';window.close();">#FFCCCC</a>
					</td>
					<td bgcolor="#FFCCCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFCCFF';window.close();">#FFCCFF</a>
					</td>
					<td bgcolor="#FFCCFF" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFFF00';window.close();">#FFFF00</a>
					</td>
					<td bgcolor="#FFFF00" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFFF33';window.close();">#FFFF33</a>
					</td>
					<td bgcolor="#FFFF33" width="60">
						&nbsp
					</td>

				</tr>

				<tr>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFFF66';window.close();">#FFFF66</a>
					</td>
					<td bgcolor="#FFFF66" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFFF99';window.close();">#FFFF99</a>
					</td>
					<td bgcolor="#FFFF99" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFFFCC';window.close();">#FFFFCC</a>
					</td>
					<td bgcolor="#FFFFCC" width="60">
						&nbsp
					</td>

					<td>
						<a class="normal" 
							href="#" onclick="javascript:self.opener.document.forms.<%=strFormName%>.<%=strFormField%>.value='#FFFFFF';window.close();">#FFFFFF</a>
					</td>
					<td bgcolor="#FFFFFF" width="60">
						&nbsp
					</td>

				</tr>

	</table>

	</body>
	</html>