
/***************************************************************
 Moons
 **************************************************************

 This generates a picture of various phases of the moon.
 */

import CoreGraphics
/*
func  Moons( hDC:HDC )
 {

 var        i: Int;
 var        n: Int
 var        highCurveNum: Int
 var nullPoint = CGPoint.zero
 var anglePoint: CGPoint
 RECT      contentRect
 var        localIndex: Int

 var        numCurves = 7
 var        iAngle[7] = {0, 0, 0, 0, 1, 0, 0}
 var        appleAngle[7] = {90, 90, 225, 90, 180, 90, 135}
 var        numDots[7] = {3, 2, 2, 2, 2, 2, 2}
 var        x[15] = {90+83, 90+83, 88+83,  270+83, 270+83,  270+83, 270+83,
 90+83, 90+83,  90+83, 90+83,  270+83, 270+83,  270+83, 270+83}
 var        y[15] = {90, 162, 90,  90, 162,  90, 162,
 342, 414,  342, 414,  342, 414,  342, 414}

 HPEN      hPen

 highCurveNum = gHighCurveNum

 /*  Initialize some of the globals  */
 gAngleClick = 0
 gAddDotClick = 0
 gOldDotLoc = nullPoint
 gOldAppleAngle = 0
 gAppleAngle = 0

 gSecondAngleFlag = false
 gSketchFlag = false
 gUndoFlag = false
 gHighCurveNumFlag = false

 gDotSelectIndex = 0
 gDeleteDotIndex = 0
 gDragDotIndex = 0
 gAddDotIndex = 0
 gOldAngleIndex = 0

 for ( n = 0; n <= highCurveNum; n+= )
 {
 gHighDotNum[n] = -1
 gAngleFlag[n] = false
 gAngleIndex[n] = 0
 }

 for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
 {
 gX[i] = 0
 gY[i] = 0
 gAlphai[i] = 0.0
 gAlphaf[i] = 0.0
 gStartAngle[i] = 0
 gArcAngle[i] = 0
 gXc[i] = 0.0
 gYc[i] = 0.0
 gR[i] = 0.0
 gDotLoc[i] = nullPoint

 gIsCW[i] = 0
 }

 gMenuItem     = IDM_MOONS
 gLastMenuItem   = IDM_MOONS

 gHighCurveNum   = -1
 gCurveNum     = 0

 localIndex = 0
 /*  End initialize some of the globals  */

 redraw(hWnd, hDC)

 for ( n = 0;  n <= numCurves - 1;  n+= )
 {
 gHighCurveNum   = n
 gCurveNum     = gHighCurveNum
 gAngleIndex[n]   = 15*n + iAngle[n]

 for ( i = 0;  i <= numDots[n] - 1;  i+= )
 {
 gDotLoc[15*n + i].x = x[localIndex]
 gDotLoc[15*n + i].y = y[localIndex]
 gHighDotNum[n]   = i
 localIndex +=
 drawDot(hWnd, hDC, 15*n + i)
 dotAsRegion(15*n + i)
 Sleep(500)
 }

 drawLargeDot(15*n + iAngle[n])
 Sleep(1000)

 gAppleAngle   = appleAngle[n]
 gAngleFlag[n]   = true

 /*  Draw angle line  */
 anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x +
 36*cos( gDegToRad*(90 - gAppleAngle) )
 anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y -
 36*sin( gDegToRad*(90 - gAppleAngle) )

 MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
 LineTo(hDC, anglePoint.x, anglePoint.y)

 Sleep(1000)
 EraseLargeDot(hWnd, hDC, 15*n + iAngle[n] )

 /*  Erase angle line  */
 hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) //  To erase lines
 MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
 LineTo(hDC, anglePoint.x, anglePoint.y)
 hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen

 calcArcs()
 EraseLines(hWnd, hDC)
 DrawCurve(hWnd, hDC)
 Sleep(1000)
 }

 redraw(hWnd, hDC)

 ReleaseDC(hWnd, hDC)

 return
 }



*/
