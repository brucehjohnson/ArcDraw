/***************************************************************
 YinYang
 **************************************************************

 This generates a picture of a Yin-Yang figure.
 */
/*    VOID  YinYang(HWND  hWnd, HDC hDC)
 {

 var        i: Int
 var        n: Int
 var        highCurveNum: Int
 var nullPoint = CGPoint.zero
 var anglePoint: CGPoint
 RECT      contentRect;
 var        localIndex: Int

 var        numCurves = 3
 var        iAngle[3] = {0, 0, 0}
 var        appleAngle[3] = {0.0, 0.0, 0.0}
 var        numDots[3] = {5, 3, 3}
 var        x[11] = {36+83, 324+83, 38+83, 180+83, 322+83, 90+83,
 126+83, 90+83, 234+83, 270+83, 234+83}
 var        y[11] = {252, 252, 252, 252, 252, 252, 252, 254, 252, 252, 254}

 HPEN      hPen

 highCurveNum = gHighCurveNum

 /*  Initialize some of the globals  */
 gAngleClick = 0
 gAddDotClick = 0
 gOldDotLoc = nullPoint
 gOldAppleAngle = 0.0
 gAppleAngle = 0.0

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
 gStartAngle[i] = 0.0
 gArcAngle[i] = 0.0
 gXc[i] = 0.0
 gYc[i] = 0.0
 gR[i] = 0.0
 gDotLoc[i] = nullPoint

 gIsCW[i] = 0
 }

 gMenuItem     = IDM_YINYANG
 gLastMenuItem   = IDM_YINYANG

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
 EraseLargeDot( hWnd,hDC, 15*n + iAngle[n] )

 /*  Erase angle line  */
 hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
 MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
 LineTo(hDC, anglePoint.x, anglePoint.y)
 hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen

 calcArcs()
 EraseLines(hWnd, hDC)
 drawCurve(hWnd, hDC)
 Sleep(1000)
 }

 redraw(hWnd, hDC)

 ReleaseDC(hWnd, hDC)

 return
 } */
