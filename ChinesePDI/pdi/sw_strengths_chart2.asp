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

   objChart.AddData  ArrDataSeries0(ctr), 0 'Add data to Data Series 0 
                                            'and assign a label to this data
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

'Keep graphs off of words - Round up or down
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Dim nDataArray(3)
Dim Comp1, Comp2, Comp3, Comp4, Result1, Result2
nDataArray(1) = nData1
nDataArray(2) = nData2
nDataArray(3) = nData3
for nDatac = 1 to 3
	Comp1=33
	Comp2=40
	Comp3=41
	Comp4=48
	Result1=32
	Result2=49
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"
	If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 40
	Comp2=Comp2 + 40
	Comp3=Comp3 + 40 
	Comp4=Comp4 + 40
	Result1=Result1 + 40
	Result2=Result2 + 40
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 40
	Comp2=Comp2 + 40
	Comp3=Comp3 + 40 
	Comp4=Comp4 + 40
	Result1=Result1 + 40
	Result2=Result2 + 40 + 3
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 40
	Comp2=Comp2 + 40
	Comp3=Comp3 + 40 
	Comp4=Comp4 + 40
	Result1=Result1 + 40
	Result2=Result2 + 40
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 40
	Comp2=Comp2 + 40
	Comp3=Comp3 + 40 
	Comp4=Comp4 + 40
	Result1=Result1 + 40
	Result2=Result2 + 40
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 40
	Comp2=Comp2 + 40
	Comp3=Comp3 + 40 
	Comp4=Comp4 + 40
	Result1=Result1 + 40
	Result2=Result2 + 40
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 40
	Comp2=Comp2 + 40
	Comp3=Comp3 + 40 
	Comp4=Comp4 + 40
	Result1=Result1 + 40
	Result2=Result2 + 40
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 35
	Comp2=Comp2 + 35
	Comp3=Comp3 + 35
	Comp4=Comp4 + 35
	Result1=Result1 + 35
	Result2=Result2 + 35
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 35
	Comp2=Comp2 + 35
	Comp3=Comp3 + 35
	Comp4=Comp4 + 35
	Result1=Result1 + 35
	Result2=Result2 + 35
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

	If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 35
	Comp2=Comp2 + 35
	Comp3=Comp3 + 35
	Comp4=Comp4 + 35
	Result1=Result1 + 35
	Result2=Result2 + 35
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

	If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 35
	Comp2=Comp2 + 35
	Comp3=Comp3 + 35
	Comp4=Comp4 + 35
	Result1=Result1 + 35
	Result2=Result2 + 35
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

	If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
	Comp1=Comp1 + 35
	Comp2=Comp2 + 35
	Comp3=Comp3 + 35
	Comp4=Comp4 + 35
	Result1=Result1 + 35
	Result2=Result2 + 35
response.write comp1 & ":" & comp2 & ":" & comp3 & ":" & comp4 & ":" & Result1 & ":" & Result2 & "<br>"

If nDataArray(nDatac)=>Comp1 AND nDataArray(nDatac)<=Comp2 then
		nDataArray(nDatac) = Result1
	End If
	If nDataArray(nDatac)=>Comp3 AND nDataArray(nDatac)<=Comp4 then
		nDataArray(nDatac) = Result2
	End If
Next
	
nData1 = nDataArray(1)
nData2 = nDataArray(2)
nData3 = nDataArray(3)

'response.write "<BR>"& nData1 & ":" & nData2 & ":" & nData3 & ":" & nData4
response.end




CreatePoint 1,112 'nData1
CreatePoint 2,129'nData2
CreatePoint 3,nData3
CreatePoint 4,nData4

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