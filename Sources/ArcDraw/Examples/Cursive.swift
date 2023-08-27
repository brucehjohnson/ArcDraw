
/***************************************************************
 Cursive
 **************************************************************

 This generates a picture of cursive handwriting.
 */
/*    VOID  Cursive(HWND  hWnd, HDC hDC)
 {
 var        i: Int
 var        n: Int
 var        highCurveNum: Int
 var nullPoint = CGPoint.zero
 var anglePoint: CGPoint
 RECT      contentRect
 var        localIndex: Int

 var        newWidth: Int
 var        newHeight: Int

 var        numCurves = 13
 var        iAngle[13] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
 var        appleAngle[13] = {200, 215, 62, 42, 30, 232, 224, 220, 219, 218,
 217, 49, 31}
 var        numDots[13] = {4, 2, 4, 5, 5, 4, 3, 4, 8, 4, 6, 6, 3};
 var        x[58] = {91+50, 105+50, 122+50, 155+50,
 154+50, 80+50,  80+50, 146+50, 159+50, 128+50,
 127+50, 157+50, 185+50, 199+50, 170+50,  240+50,
 231+50, 202+50, 207+50, 233+50,
 233+50, 226+50, 236+50, 274+50,  274+50, 272+50,
 284+50,  284+50, 274+50, 283+50, 305+50,
 304+50, 302+50, 314+50, 377+50, 373+50, 335+50,
 342+50, 369+50,  368+50, 358+50, 365+50, 407+50,
 406+50, 363+50, 354+50, 426+50, 431+50, 420+50,
 419+50, 448+50, 460+50, 460+50, 464+50, 512+50,
 338+50, 339+50, 338+50}
 var        y[58] = {13+83, 33+83, 34+83, 17+83,  16+83, 84+83,
 84+83, 30+83, 37+83, 88+83,
 88+83, 59+83, 44+83, 58+83, 105+83,  76+83, 64+83,
 82+83, 93+83, 75+83,
 75+83, 87+83, 96+83, 70+83,  71+83, 77+83, 78+83,
 78+83, 88+83, 101+83, 86+83,
 86+83, 100+83, 105+83, 62+83, 57+83, 96+83, 103+83,
 82+83,  82+83, 95+83, 105+83, 79+83,
 79+83, 132+83, 125+83, 85+83, 95+83, 105+83,  105+83,
 89+83, 94+83, 102+83, 106+83, 71+83,
 6+83, 7+83, 6+83}

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

 gMenuItem     = IDM_CURSIVE
 gLastMenuItem   = IDM_CURSIVE

 gHighCurveNum   = -1
 gCurveNum     = 0;

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
 localIndex+=
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
 EraseLargeDot( hWnd, hDC, 15*n + iAngle[n] )

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

 Sleep(1000)

 ReleaseDC(hWnd, hDC)

 return
 } */
