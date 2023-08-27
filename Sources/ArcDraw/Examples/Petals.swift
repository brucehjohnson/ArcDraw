
/***************************************************************
 Petals
 **************************************************************

 This generates a picture of various petals.
 */
/*    VOID  Petals(HWND  hWnd, HDC hDC)
 {

 var        i: Int
 var        n: Int
 var        highCurveNum: Int
 var nullPoint = CGPoint.zero
 var anglePoint: CGPoint
 RECT      contentRect
 var        localIndex: Int

 var        numCurves = 18
 var        iAngle[18] = {0,  0, 0, 0, 0,  0, 0, 0, 0, 0, 0,  0, 3, 0, 1, 1, 1, 0}
 var        appleAngle[18] = {30.0,  0.0, 90.0, 180.0, 270.0,  330.0, 30.0, 90.0, 150.0, 210.0, 270.0, 5.0, 358.0, 34.0, 278.0, 0.0, 0.0, 270.0}
 var        numDots[18] = {9,  6, 6, 6, 6,  4, 4, 4, 4, 4, 4,  12, 13, 5, 2, 2, 2, 2}

 var        x[95] = {63+83, 117+83, 24+83, 24+83, 117+83,
 63+83, 156+83, 156+83, 63+83,
 270+83, 284+83, 315+83, 343+83,
 343+83, 270+83, 270+83, 343+83, 343+83, 315+83, 284+83, 270+83,
 270+83, 256+83, 225+83, 197+83,
 197+83, 270+83, 270+83, 197+83, 197+83, 225+83, 256+83, 270+83,
 90+83, 65+83, 115+83, 90+83,  90+83, 128+83, 153+83,
 90+83, 90+83, 153+83, 128+83, 90+83,
 90+83, 115+83, 65+83, 90+83, 90+83, 52+83, 27+83, 90+83,
 90+83, 27+83, 52+83, 90+83,
 202+83, 211+83, 230+83, 256+83, 271+83, 269+83, 257+83,
 254+83, 233+83, 224+83, 204+83, 202+83,
 267+83, 282+83, 290+83, 295+83, 302+83, 314+83, 322+83,
 325+83, 319+83, 318+83, 302+83, 288+83, 267+83,
 244+83, 260+83, 278+83, 299+83, 309+83, 267+83, 245+83,
 250+83, 250+83, 263+83, 263+83,  263+83, 250+83}

 var        y[95] = {60, 60, 153, 99, 192, 192, 99, 153, 60,
 126, 53, 53, 81, 112, 126,  126, 140, 171, 199, 199, 126,
 126, 199, 199, 171, 140, 126, 126, 112, 81, 53, 53, 126,
 378, 319, 319, 378, 378, 327, 371, 378, 378, 385, 429, 378,
 378, 437, 437, 378, 378, 429, 385, 378, 378, 371, 327, 378,
 324, 295, 283, 294, 324, 356, 389, 402, 407, 398, 364, 324,
 410, 400, 391, 367, 333, 299, 297, 325, 348, 368, 396, 406, 410,
 283, 277, 273, 280, 308, 410, 410, 450, 411, 450, 411, 450, 450}

 HPEN      hPen;
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
 gStartAngle[i] = 0.0
 gArcAngle[i] = 0.0
 gXc[i] = 0.0
 gYc[i] = 0.0
 gR[i] = 0.0
 gDotLoc[i] = nullPoint

 gIsCW[i] = 0
 }

 gMenuItem     = IDM_PETALS
 gLastMenuItem   = IDM_PETALS

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

 drawLargeDot15*n + iAngle[n])
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
 EraseLargeDot( hWnd, hDC, 15*n + iAngle[n] )

 /*  Erase angle line  */
 hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
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
 } */

