<% intPageID = 56	' Possible Weaknesses Page %>
<!-- #Include File = "Include/Common.asp" -->
<!-- #Include File = "ChartConst.inc" -->
<%
Sub CreatePoint(xPos, yPos)
	Dim nPad
	nPad = 15
	nLineWidth = 1
	
	'objChart.AddStaticLine xPos-nPad,yPos-nPad,xPos+nPad,yPos-nPad,nColor,nLineWidth,0
	'objChart.AddStaticLine xPos+nPad,yPos-nPad,xPos+nPad,yPos+nPad,nColor,nLineWidth,0
	'objChart.AddStaticLine xPos+nPad,yPos+nPad,xPos-nPad,yPos+nPad,nColor,nLineWidth,0
	'objChart.AddStaticLine xPos-nPad,yPos+nPad,xPos-nPad,yPos-nPad,nColor,nLineWidth,0
	'objChart.AddStaticLine xPos-nPad,yPos-nPad,xPos+nPad,yPos+nPad,nColor,nLineWidth,0
	'objChart.AddStaticLine xPos+nPad,yPos-nPad,xPos-nPad,yPos+nPad,nColor,nLineWidth,0
	
	Dim nLine
	Dim bFirstTime
	Dim  nChartW, nChartH
	nChartW = 76
	nChartH = 2
	bFirstTime = True
	If yPos > 500 Then
		' yPos is above 500
		For nLine = 500 To yPos
			If nLine = yPos Then
				objChart.ChartArea(0).AddStaticBitmap xPos,nLine,nChartW,nChartH,Application("ChartBackgroundDir") & "SW_GreyBox_Top.bmp", 0, 0, True
			Else
				objChart.ChartArea(0).AddStaticBitmap xPos,nLine,nChartW,nChartH,Application("ChartBackgroundDir") & "SW_GreyBox.bmp", 0, 0, True
			End If
			bFirstTime = False
		Next
	Else
		' yPos is below 500
		For nLine = yPos To 500
			If bFirstTime = True Then
				objChart.ChartArea(0).AddStaticBitmap xPos,nLine,nChartW,nChartH,Application("ChartBackgroundDir") & "SW_GreyBox_Bottom.bmp", 0, 0, True
			Else
				objChart.ChartArea(0).AddStaticBitmap xPos,nLine,nChartW,nChartH,Application("ChartBackgroundDir") & "SW_GreyBox.bmp", 0, 0, True
			End If
			bFirstTime = False
		Next
	End If
End Sub

Dim nData1, nData2, nData3, nData4
Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
strLanguageCode = Request.QueryString("LC")
Dim oConn
Dim oCmd
Dim oRs
Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
     .CommandText = "sel_ChartTranslation_TCID"
     .CommandType = 4
     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1
If oConn.Errors.Count < 1 Then
	If oRs.EOF = False Then
		nData1 = oRs("ChartPoint1")
		nData2 = oRs("ChartPoint2")
		nData3 = oRs("ChartPoint3")
		nData4 = oRs("ChartPoint4")
	End If
End If

'Response.Buffer = true 'enable buffering so that ALL browsers will save
                       ' image as a JPEG when a user right-clicks over it and saves it to disk
Dim objChart        'Dundas Chart 2D object
Dim ArrDataSeries0  'Array of first set of Data 
Dim ArrDataSeries1  'Array of second set ofData
Dim ctr             'loop counter

ArrDataSeries0 = Array(0, 0, 0, 0)

'ArrDataSeries1= Array(12, 15, 20, 9)
'Step 1: Create Dundas Chart 2D object
Set objChart = Server.CreateObject("Dundas.ChartServer2D.1")

'Step 2: Add data into the built-in Data Source

For ctr = 0 To ubound(ArrDataSeries0)
   objChart.AddData  ArrDataSeries0(ctr), 0 'Add data to Data Series 0 
                                            'and assign a label to this data
Next

objChart.ChartArea(0).AddChart COLUMN_CHART, 0, 0

Dim yPos
Dim xPos
Dim nLineWidth
Dim nColor

' nData1 = 40
nLineWidth = 3
nColor = 200

Dim bShowLines 
Dim nAxisWeight 
'Keep graphs off of words - Round up or down
Dim nDataArray(4)
Dim Comp1, Comp2, Comp3, Comp4, Result1, Result2
nDataArray(1) = nData1
nDataArray(2) = nData2
nDataArray(3) = nData3
nDataArray(4) = nData4
For nDatac = 1 To 4
	If nDataArray(nDatac) => 535 And nDataArray(nDatac) <= 695 Then
		nDataArray(nDatac) = nDataArray(nDatac) + 25
	End If
	If nDataArray(nDatac) => 696 And nDataArray(nDatac) <= 905 Then
		nDataArray(nDatac) = nDataArray(nDatac) + 45
	End If
	If nDataArray(nDatac) => 20 And nDataArray(nDatac) <= 38 Then
		nDataArray(nDatac) = 19
	End If
	If nDataArray(nDatac) =>85 And nDataArray(nDatac) <= 104 Then
		nDataArray(nDatac) = 84
	End If
	If nDataArray(nDatac) => 142 And nDataArray(nDatac) <= 160 Then
		nDataArray(nDatac) = 141
	End If
	If nDataArray(nDatac) => 209 And nDataArray(nDatac) <= 230 Then
		nDataArray(nDatac) = 208
	End If
	If nDataArray(nDatac) => 277 And nDataArray(nDatac) <= 297 Then
		nDataArray(nDatac) = 276
	End If
	
	' Same as Strengths -------------------------------------------
	If nDataArray(nDatac) => 330 And nDataArray(nDatac) <= 355 Then
		nDataArray(nDatac) = 329
	End If
	If nDataArray(nDatac) => 374 And nDataArray(nDatac) <= 402 Then
		nDataArray(nDatac) = 373
	End If
	If nDataArray(nDatac) => 420 And nDataArray(nDatac) <= 447 Then
		nDataArray(nDatac) = 419
	End If
	If nDataArray(nDatac) => 465 And nDataArray(nDatac) <= 486 Then
		nDataArray(nDatac) = 464
	End If
	If nDataArray(nDatac) => 513 And nDataArray(nDatac) <= 534 Then
		nDataArray(nDatac) = 535
	End If
	If nDataArray(nDatac) => 551 And nDataArray(nDatac) <= 570 Then
		nDataArray(nDatac) = 571
	End If
	If nDataArray(nDatac) => 591 And nDataArray(nDatac) <= 612 Then
		nDataArray(nDatac) = 613
	End If
	' End Same ----------------------------------------------------
	
	If nDataArray(nDatac) => 643 And nDataArray(nDatac) <= 664 Then
		nDataArray(nDatac) = 665
	End If
	If nDataArray(nDatac) => 696 And nDataArray(nDatac) <= 716 Then
		nDataArray(nDatac) = 717
	End If
	If nDataArray(nDatac) => 750 And nDataArray(nDatac) <= 772 Then
		nDataArray(nDatac) = 773
	End If
	If nDataArray(nDatac) => 812 And nDataArray(nDatac) <= 834 Then
		nDataArray(nDatac) = 835
	End If
	If nDataArray(nDatac) => 881 And nDataArray(nDatac) <= 903 Then
		nDataArray(nDatac) = 904
	End If
	
	' Same as Strengths -------------------------------------------
	If nDataArray(nDatac) => 946 And nDataArray(nDatac) <= 971 Then
		nDataArray(nDatac) = 972
	End If
	' End Same ----------------------------------------------------
	
	'	 If nDataArray(nDatac) => 691 And nDataArray(nDatac) <= 708 Then
	'	 	nDataArray(nDatac) = 709
	'	End If
	'	If nDataArray(nDatac) => 721 And nDataArray(nDatac) <= 738 Then
	'	 	nDataArray(nDatac) = 739
	'	End If
	'	If nDataArray(nDatac) => 749 And nDataArray(nDatac) <= 768 Then
	'		nDataArray(nDatac) = 769
	'	End If
	'	If nDataArray(nDatac) => 779 And nDataArray(nDatac) <= 796 Then
	'		nDataArray(nDatac) = 797
	'	End If
	'	If nDataArray(nDatac) => 809 And nDataArray(nDatac) <= 826 Then
	'		nDataArray(nDatac) = 827
	'	End If
	'	If nDataArray(nDatac) => 837 And nDataArray(nDatac) <= 855 Then
	'		nDataArray(nDatac) = 856
	'	End If
	'	If nDataArray(nDatac) => 870 And nDataArray(nDatac) <= 887 Then
	'		nDataArray(nDatac) = 888
	'	End If
	'	If nDataArray(nDatac) => 896 And nDataArray(nDatac) <= 916 Then
	'		nDataArray(nDatac) = 917
	'	End If
	'	If nDataArray(nDatac) => 928 And nDataArray(nDatac) <= 946 Then
	'		nDataArray(nDatac) = 947
	'	End If
	'	If nDataArray(nDatac) => 958 And nDataArray(nDatac) <= 976 Then
	'		nDataArray(nDatac) = 977
	'	End If
Next

nData1 = nDataArray(1)
nData2 = nDataArray(2)
nData3 = nDataArray(3)
nData4 = nDataArray(4)

'nData1 = 32
'nData2 = 72
'nData3 = 902
'nData4 = 151

'response.write "<BR>"& nData1 & ":" & nData2 & ":" & nData3 & ":" & nData4
'response.end
CreatePoint 1,nData1
CreatePoint 2,nData2
CreatePoint 3,nData3
CreatePoint 4,nData4

bShowLines = False
nAxisWeight = 0

objChart.ChartArea(0).Axis(0).Maximum = 1000
objChart.ChartArea(0).Axis(0).enabled = bShowLines
objChart.ChartArea(0).Axis(1).enabled = bShowLines

objChart.ChartArea(0).GridHEnabled = bShowLines
objChart.ChartArea(0).GridVEnabled = bShowLines

objChart.ChartArea(0).Axis(0).Weight = nAxisWeight
objChart.ChartArea(0).Axis(1).Weight = nAxisWeight
objChart.ChartArea(0).Axis(2).Weight = nAxisWeight
objChart.ChartArea(0).Axis(3).Weight = nAxisWeight

objChart.ChartArea(0).Transparent = True
objChart.ChartArea(0).LineWidth = 1
objChart.ChartArea(0).SetPosition 19,24,393,519
'Response.Write Err.description
objChart.SetBackgroundPicture(Application("ChartBackgroundDir") & "SWWeaknessesChart" & strLanguageCode & ".bmp")

'Step 4: Apply antialiasing
'objChart.AntiAlias

'Step 5: Send a 400 x 400 pixels JPEG
objChart.SendJpeg 414, 522

Set objChart = Nothing
%> 