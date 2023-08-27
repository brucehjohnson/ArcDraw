
/***************************************************************
 ClearCurve
 **************************************************************

 This picks up the mouse click after Clear Curve is selected in the ArcDraw menu. We determine
 the index number of the curve to delete. The click must be in a dot region and the angle must
 be defined. We move curves down, as necessary, and decrement gHighCurveNum by one. We only
 calculate arcs up thru gHighCurveNum, so anything higher in the arrays have no effect.
 */
/*     VOID  ClearCurve(HWND  hWnd, HDC  hDC, LPARAM  lParam)
 {
 var        i: Int
 var        j: Int
 var        n: Int
 var      ptIsInARegion = false
 var        highDotNum: Int
 var        angleIndex: Int
 var nullDotLoc = CGPoint.zero
 HRegion      nullDotRegion    = {0};  //  = {0} only works when nullDotRegion is declared
 var testLocDot: CGPoint
 HRegion      testShapeDot;
 var      posnx: Double
 var      posny: Double

 posnx = LOWORD(lParam);
 posny = HIWORD(lParam);

 for ( i = 0;  i <= 299 && ptIsInARegion == false;  i+= )
 {
 if PtInRegion( gDotRegion[i], posnx, posny )
 {
 ptIsInARegion = true
 DecodeIndex(hWnd, hDC, i)    //  to get gCurveNum
 }
 }

 /*   if the point wasn't in any dot region, we can't do   */
 if !ptIsInARegion
 {
 MessageBox  (hWnd,
 "Click is not in a dot region.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC(hWnd, hDC)

 return;
 }

 /*   if angle flag not set, we can't do   */
 else if !gAngleFlag[gCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC(hWnd, hDC)

 return
 }

 else  /*  point is in a dot region  */
 {
 /*  for arrays with 301 members, move higher dots down, but  we can't reach
  outside the bounds of the arrays or we will pull in garbage  */

 for ( i = 15*gCurveNum;  i <= 15*( gHighCurveNum - 1 ) + 14;  i+= )
 {
 gAlphai[i]       = gAlphai[i + 15]
 gAlphaf[i]       = gAlphaf[i + 15]
 gStartAngle[i]   = gStartAngle[i + 15]
 gArcAngle[i]     = gArcAngle[i + 15]
 gX[i]           = gX[i + 15]
 gY[i]           = gY[i + 15]
 gXc[i]           = gXc[i + 15]
 gYc[i]           = gYc[i + 15]
 gR[i]           = gR[i + 15]
 gDotLoc[i]       = gDotLoc[i + 15]
 gDotRegion[i]       = gDotRegion[i + 15]

 gIsCW[i]         = gIsCW[i + 15]
 }

 for ( j = 15*gHighCurveNum;  j <= 15*gHighCurveNum + 14;  j+= )
 {
 gAlphai[j]       = 0.0
 gAlphaf[j]       = 0.0
 gStartAngle[j]   = 0.0
 gArcAngle[j]     = 0.0
 gX[j]           = 0
 gY[j]           = 0
 gXc[j]           = 0.0
 gYc[j]           = 0.0
 gR[j]           = 0.0
 gDotLoc[j]       = nullDotLoc
 gDotRegion[j]       = nullDotRegion

 gIsCW[j]     = 0
 }

 /*   for arrays with 21 members, move higher dots down, but  we can't reach
  outside the bounds of the arrays or we will pull in garbage   */
 for ( n = gCurveNum;  n <= ( gHighCurveNum - 1 );  n+= )
 {
 gAngleFlag[n]    = gAngleFlag[n + 1]        //  [21]
 gAngleIndex[n]  = gAngleIndex[n + 1] - 15  //  [21]
 gHighDotNum[n]  = gHighDotNum[n + 1]        //  [21]
 }

 gAngleFlag[gHighCurveNum]    = 0              //  [21]
 gAngleIndex[gHighCurveNum]  = 0;             //  [21]
 gHighDotNum[gHighCurveNum]  = -1              //  [21]

 gAngleClick       = 0
 gAddDotClick       = 0
 gCurveNum         = 0
 gOldDotLoc         = nullDotLoc
 gOldAppleAngle     = 0
 gAppleAngle       = 0
 gSecondAngleFlag   = false
 gUndoFlag         = false
 gDeleteDotIndex   = 0
 gDragDotIndex     = 0
 gAddDotIndex       = 0
 gOldAngleIndex     = 0


 gHighCurveNum -=;       //  since we got rid of a curve
 gHighCurveNumFlag = false; //  since we got rid of a curve

 redraw(hWnd, hDC)
 }

 ReleaseDC(hWnd, hDC)

 return
 } */

