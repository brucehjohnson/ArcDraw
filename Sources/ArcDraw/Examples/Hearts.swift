

/***************************************************************
 Hearts
 **************************************************************

 This generates a picture of various hearts.
 */
/*     VOID  Hearts(HWND  hWnd, HDC hDC)
 {
 var        i: Int
 var        n: Int
 var        highCurveNum: Int
 var nullPoint = CGPoint.zero
 var anglePoint: CGPoint
 RECT      contentRect
 var        localIndex: Int

 var        numCurves = 8
 var        iAngle[8] = {0, 1, 0, 1, 0, 1, 0, 1};
 var        appleAngle[8] = {20.0, 164.0, 45.0, 133.0, 20.0, 200.0, 7.0, 170.0};
 var        numDots[8] = {3, 3, 3, 3, 4, 4, 4, 4};
 var        x[28] = {90+83, 155+83, 90+83,   90+83, 25+83, 90+83,
 270+83, 320+83, 270+83,   270+83, 220+83, 270+83,
 90+83, 162+83, 133+83, 90+83,   90+83, 18+83, 47+83, 90+83,
 270+83, 336+83, 316+83, 291+83,   270+83, 207+83, 230+83, 291+83};
 var        y[28] = {80, 101, 194,   80, 101, 194,
 80, 132, 194,   80, 132, 194,
 332, 332, 415, 446,   332, 332, 415, 446,
 332, 325, 397, 446,   332, 353, 405, 446};

 HPEN      hPen

 highCurveNum = gHighCurveNum

 /*  Initialize some of the globals  */
 gAngleClick       = 0
 gAddDotClick       = 0
 gOldDotLoc         = nullPoint
 gOldAppleAngle     = 0
 gAppleAngle       = 0

 gSecondAngleFlag   = false
 gSketchFlag       = false
 gUndoFlag         = false
 gHighCurveNumFlag = false

 gDotSelectIndex   = 0
 gDeleteDotIndex   = 0
 gDragDotIndex     = 0
 gAddDotIndex       = 0
 gOldAngleIndex     = 0

 for ( n = 0; n <= highCurveNum; n+= )
 {
 gHighDotNum[n]   = -1
 gAngleFlag[n]   = false
 gAngleIndex[n]   = 0
 }

 for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
 {
 gX[i]           = 0
 gY[i]           = 0
 gAlphai[i]       = 0.0
 gAlphaf[i]       = 0.0
 gStartAngle[i]  = 0
 gArcAngle[i]     = 0
 gXc[i]           = 0.0
 gYc[i]           = 0.0
 gR[i]           = 0.0
 gDotLoc[i]       = nullPoint

 gIsCW[i]         = 0
 }

 gMenuItem       = IDM_HEARTS
 gLastMenuItem   = IDM_HEARTS

 gHighCurveNum   = -1
 gCurveNum       = 0

 localIndex       = 0
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
 hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // Erase lines
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

