<!--#INCLUDE FILE="include/common.asp" -->
<!-- #INCLUDE FILE ="ChartConst.inc" -->
<% 
sub CreatePoint(xPos, yPos)
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
	bFirstTime = TRUE
	if yPos > 500 then
		' yPos is above 500
		for nLine = 500 to yPos 
			if nLine = yPos then 
				objChart.ChartArea(0).AddStaticBitmap xPos,nLine,nChartW,nChartH,Application("ChartBackgroundDir") & "SW_GreyBox_Top.bmp",0,0,TRUE
			else 
				objChart.ChartArea(0).AddStaticBitmap xPos,nLine,nChartW,nChartH,Application("ChartBackgroundDir") & "SW_GreyBox.bmp",0,0,TRUE
			end if 		
			bFirstTime = FALSE
		next
	else 
		' yPos is below 500
		for nLine = yPos to 500 
			if bFirstTime = TRUE then
				objChart.ChartArea(0).AddStaticBitmap xPos,nLine,nChartW,nChartH,Application("ChartBackgroundDir") & "SW_GreyBox_Bottom.bmp",0,0,TRUE
			else 
				objChart.ChartArea(0).AddStaticBitmap xPos,nLine,nChartW,nChartH,Application("ChartBackgroundDir") & "SW_GreyBox.bmp",0,0,TRUE
			end if 		
			bFirstTime = FALSE
		next
	end if 
end sub


Dim nData1, nData2, nData3, nData4
Dim TestCodeID 
TestCodeID = Request.QueryString("TCID")

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

oConn.Open strDBaseConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1
If oConn.Errors.Count < 1 then
	if oRs.EOF = FALSE then
		nData1 = oRs("ChartPoint1")
		nData2 = oRs("ChartPoint2")
		nData3 = oRs("ChartPoint3")
		nData4 = oRs("ChartPoint4")
	end if
end if 

'Response.Buffer = true 'enable buffering so that ALL browsers will save
                       ' image as a JPEG when a user right-clicks over it and saves it to disk

dim objChart        'Dundas Chart 2D object
dim ArrDataSeries0  'Array of first set of Data 
dim ArrDataSeries1  'Array of second set ofData
dim ctr             'loop counter



ArrDataSeries0 = Array(0, 0, 0, 0)
'ArrDataSeries1= Array(12, 15, 20, 9)

'Step 1: Create Dundas Chart 2D object
set objChart = Server.CreateObject("Dundas.ChartServer2D.1")

'Step 2: Add data into the built-in Data Source 
for ctr = 0 to ubound(ArrDataSeries0)
   objChart.AddData  ArrDataSeries0(ctr), 0 'Add data to Data Series 0 and assign a label to this data
next

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
'response.write nData1 & ":" & nData2 & ":" & nData3 & ":" & nData4 & "<BR>"
'response.end
'Keep graphs off of words - Round up or down
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Dim nDataArray(4)
Dim Comp1, Comp2, Comp3, Comp4, Result1, Result2
nDataArray(1) = nData1
nDataArray(2) = nData2
nDataArray(3) = nData3
nDataArray(4) = nData4
for nDatac = 1 to 4

If nDataArray(nDatac)=>696 then
		nDataArray(nDatac) = nDataArray(nDatac) + 45
	End If

If nDataArray(nDatac)=>535 AND nDataArray(nDatac)<=695 then
		nDataArray(nDatac) = nDataArray(nDatac) + 25
	End If

If nDataArray(nDatac)=>33 AND nDataArray(nDatac)<=48 then
		nDataArray(nDatac) = 32
	End If
	

If nDataArray(nDatac)=>107  AND nDataArray(nDatac)<=125 then
		nDataArray(nDatac) = 106
	End If
If nDataArray(nDatac)=>163  AND nDataArray(nDatac)<=188 then
		nDataArray(nDatac) = 162
	End If

	

If nDataArray(nDatac)=>230  AND nDataArray(nDatac)<=255 then
		nDataArray(nDatac) = 229
	End If
	

If nDataArray(nDatac)=>288 AND nDataArray(nDatac)<=308 then
		nDataArray(nDatac) = 287
	End If
	

If nDataArray(nDatac)=>330 AND nDataArray(nDatac)<=355 then
		nDataArray(nDatac) = 329
	End If	
	

If nDataArray(nDatac)=>374 AND nDataArray(nDatac)<=402 then
		nDataArray(nDatac) = 373
	End If
	

If nDataArray(nDatac)=>420 AND nDataArray(nDatac)<=447 then
		nDataArray(nDatac) = 419
	End If
	

If nDataArray(nDatac)=>465  AND nDataArray(nDatac)<=486 then
		nDataArray(nDatac) = 464
	End If
	

If nDataArray(nDatac)=>513  AND nDataArray(nDatac)<=534 then
		nDataArray(nDatac) = 535
	End If
	

If nDataArray(nDatac)=>551  AND nDataArray(nDatac)<=570 then
		nDataArray(nDatac) = 571
	End If
	

If nDataArray(nDatac)=>591 AND nDataArray(nDatac)<=612 then
		nDataArray(nDatac) = 613
	End If
	

If nDataArray(nDatac)=>625  AND nDataArray(nDatac)<=653 then
		nDataArray(nDatac) = 654
	End If
	

If nDataArray(nDatac)=>671 AND nDataArray(nDatac)<=694 then
		nDataArray(nDatac) = 695
	End If
	

If nDataArray(nDatac)=>715 AND nDataArray(nDatac)<=743 then
		nDataArray(nDatac) = 744
	End If
	

If nDataArray(nDatac)=>771 AND nDataArray(nDatac)<=794 then
		nDataArray(nDatac) = 795
	End If
	

If nDataArray(nDatac)=>823 AND nDataArray(nDatac)<=846 then
		nDataArray(nDatac) = 847
	End If
	

If nDataArray(nDatac)=>891 AND nDataArray(nDatac)<=915 then
		nDataArray(nDatac) = 916
	End If
	

If nDataArray(nDatac)=>946 AND nDataArray(nDatac)<=971 then
		nDataArray(nDatac) = 972
	End If
	

'If nDataArray(nDatac)=>691 AND nDataArray(nDatac)<=708 then
'		nDataArray(nDatac) = 709
'	End If
	

'If nDataArray(nDatac)=>721 AND nDataArray(nDatac)<=738 then
'		nDataArray(nDatac) = 739
'	End If
	

'If nDataArray(nDatac)=>749 AND nDataArray(nDatac)<=768 then
'		nDataArray(nDatac) = 769
'	End If
	

'If nDataArray(nDatac)=>779 AND nDataArray(nDatac)<=796 then
'		nDataArray(nDatac) = 797
'	End If
	

'If nDataArray(nDatac)=>809 AND nDataArray(nDatac)<=826 then
'		nDataArray(nDatac) = 827
'	End If
	

'If nDataArray(nDatac)=>837 AND nDataArray(nDatac)<=855 then
'		nDataArray(nDatac) = 856
'	End If
	

'If nDataArray(nDatac)=>870 AND nDataArray(nDatac)<=887 then
'		nDataArray(nDatac) = 888
'	End If
	

'If nDataArray(nDatac)=>896 AND nDataArray(nDatac)<=916 then
'		nDataArray(nDatac) = 917
'	End If
	

'If nDataArray(nDatac)=>928 AND nDataArray(nDatac)<=946 then
'		nDataArray(nDatac) = 947
'	End If
	

'If nDataArray(nDatac)=>958  AND nDataArray(nDatac)<=976 then
'		nDataArray(nDatac) = 977
'	End If

Next
	
nData1 = nDataArray(1)
nData2 = nDataArray(2)
nData3 = nDataArray(3)
nData4 = nDataArray(4)

'nData1 = 159
'nData2 = 283
'nData3 = 852
'nData4 = 751

	




'response.write "<BR>"& nData1 & ":" & nData2 & ":" & nData3 & ":" & nData4
'response.end

CreatePoint 1,nData1
CreatePoint 2,nData2
CreatePoint 3,nData3
CreatePoint 4,ndata4

bShowLines = FALSE
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

objChart.ChartArea(0).Transparent = TRUE

objChart.ChartArea(0).LineWidth = 1

objChart.ChartArea(0).SetPosition 19,24,393,519

'Response.Write Err.description

objChart.SetBackgroundPicture(Application("ChartBackgroundDir") & "SW_strength_chart.bmp")

'Step 4: Apply antialiasing
'objChart.AntiAlias

'Step 5: Send a 400 x 400 pixels JPEG
objChart.SendJpeg 415, 522

set objChart = nothing
%> 