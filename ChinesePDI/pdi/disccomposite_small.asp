<!--#INCLUDE FILE="include/common.asp" -->
<% 

sub CreatePoint(xPos, yPos)

	objChart.AddStaticLine xPos+1,yPos,xPos+4,yPos,nColor,nLineWidth,0
	objChart.AddStaticLine xPos+1,yPos+1,xPos+4,yPos+1,nColor,nLineWidth,0
	objChart.AddStaticLine xPos+1,yPos+2,xPos+4,yPos+2,nColor,nLineWidth,0

end sub

Function CalcYLocation(yPos)

	CalcYLocation = (-.202082 * yPos) + 214
	
End Function

'Response.Buffer = true 'enable buffering so that ALL browsers will save
                       ' image as a JPEG when a user right-clicks over it and saves it to disk
%>

<!-- #INCLUDE FILE ="ChartConst.inc" -->
<%
dim objChart        'Dundas Chart 2D object
dim ArrDataSeries0  'Array of first set of Data 
dim ArrDataSeries1  'Array of second set ofData
dim ctr             'loop counter



Dim MDPoint1
Dim MDPoint2
Dim MDPoint3
Dim MDPoint4


MDPoint1 = Request.QueryString("nD1")
MDPoint2 = Request.QueryString("nD2")
MDPoint3 = Request.QueryString("nD3")
MDPoint4 = Request.QueryString("nD4")

MDPoint1 = Trim(MDPoint1)
MDPoint2 = Trim(MDPoint2)
MDPoint3 = Trim(MDPoint3)
MDPoint4 = Trim(MDPoint4)


Dim oConn
Dim oCmd
Dim oRs


Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")



With oCmd

     .CommandText = "sel_DISCChart_Translation"
     .CommandType = 4


     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@ChartTypeID",3, 1,4, 3)
				           
     .Parameters.Append .CreateParameter("@TestScore1",3, 1,4, MDPoint1)

     .Parameters.Append .CreateParameter("@TestScore2",3, 1,4, MDPoint2)

     .Parameters.Append .CreateParameter("@TestScore3",3, 1,4, MDPoint3)

     .Parameters.Append .CreateParameter("@TestScore4",3, 1,4, MDPoint4)
                

End With


oConn.Open strDBaseConnString

oCmd.ActiveConnection = oConn

oRs.CursorLocation = 3

oRs.Open oCmd, , 0, 1

Dim nData1, nData2, nData3, nData4
'Dim nData5, nData6, nData7, nData8
'Dim nData9, nData10, nData11, nData12


If oConn.Errors.Count < 1 then

	if oRs.EOF = FALSE then

		oRs.MoveFirst

		nData1 = Cint(oRs("ChartPoint1"))
		nData2 = Cint(oRs("ChartPoint2"))
		nData3 = Cint(oRs("ChartPoint3"))
		nData4 = Cint(oRs("ChartPoint4"))

	ELSE

		Response.Write "Report Error: Chart Generation Failed. Please contact Team Resources"
		Response.End
		
	END IF
	
else

	Response.Write Err.Description
	Response.End
	

End If

Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing

'nData1 = 100
'nData2 = 100
'nData3 = 100
'nData4 = 100

'Response.Write "Data1: " & nData1
'Response.Write "<br>"
'Response.Write "Data2: " & nData1
'Response.Write "<br>"
'Response.Write "Data3: " & nData1
'Response.Write "<br>"
'Response.Write "Data4: " & nData1
'Response.Write "<br>"

'nData1 = oRs("1")
'nData2 = oRs("2")
'nData3 = oRs("3")
'nData4 = oRs("4")

'nData1 = oRs("1")
'nData2 = oRs("2")
'nData3 = oRs("3")
'nData4 = oRs("4")


ArrDataSeries0= Array(nData1, nData2, nData3, nData4)
'ArrDataSeries1= Array(12, 15, 20, 9)

'Step 1: Create Dundas Chart 2D object
set objChart = Server.CreateObject("Dundas.ChartServer2D.1")

'Step 2: Add data into the built-in Data Source 

'objChart.AddData 40,0,,0
'objChart.AddData 20,0,,255
'objChart.AddData 30,0,,16777216
'objChart.AddData 50,0,,16777216

for ctr = 0 to ubound(ArrDataSeries0)

   objChart.AddData  ArrDataSeries0(ctr), 0 'Add data to Data Series 0 
                                            'and assign a label to this data
   'objChart.AddData ArrDataSeries1(ctr), 1 'Add data to Data Series 1

next

'Step 3: Use data in Data Series 0 and 1 to make a Column chart, then
'add this chart to ChartArea 0. The constant "LINE_CHART" has been
'defined in ChartConst.inc file. 
objChart.ChartArea(0).AddChart LINE_CHART, 0, 0

'objChart.SetColorFromPoint 0
'objChart.SetSeriesColor 0, 200

Dim yPos
Dim xPos
Dim nLineWidth
Dim nColor
Dim nXIncrement

nXIncrement = 15

xPos = 25
yPos = CalcYLocation(nData1)
' nData1 = 40
nLineWidth = 3
nColor = 200

CreatePoint xPos+1,yPos

xPos = xPos + nXIncrement +1
yPos = CalcYLocation(nData2)
'yPos = 315
' nData2 = 20

CreatePoint xPos,yPos

xPos = xPos + nXIncrement 
yPos = CalcYLocation(nData3)
'yPos = 290
' nData2 = 30

CreatePoint xPos,yPos

xPos = xPos + nXIncrement 
yPos = CalcYLocation(nData4)
' nData2 = 50

CreatePoint xPos,yPos
'objChart.AddStaticLine xPos+10,yPos,xPos+10,yPos+10,nColor,nLineWidth,0
'objChart.AddStaticLine xPos,yPos,xPos,yPos+10,nColor,nLineWidth,0
'objChart.AddStaticLine xPos,yPos+10,xPos+10,yPos+10,nColor,nLineWidth,0

Dim bShowLines 
Dim nAxisWeight 

bShowLines = FALSE
nAxisWeight = 0 


' do this so the chart won't recalibrate the Y axis and 
' show the datapoints in different locations depending on 
' max and min values
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

objChart.ChartArea(0).LineWidth = 2

objChart.ChartArea(0).SetPosition 13,14,89,214

objChart.SetBackgroundPicture(Application("ChartBackgroundDir") & "composite_small.bmp")

'Step 4: Apply antialiasing
'objChart.AntiAlias

'Step 5: Send a 400 x 400 pixels JPEG
objChart.SendJpeg 89,218

set objChart = nothing

%> 