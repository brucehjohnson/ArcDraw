
/***************************************************************
 defineDirection
 **************************************************************

 This picks up the mouse clicks after Define Direction is selected in the
 ArcDraw menu. (The first click must be in a dot region and the second
 click can be a drag.) We determine gAngleIndex[gCurveNum] of the dot we will
 use to define the direction.

 When drawing and moving arcDraw curves we deal in Windows coordinates.

 Changes: loads points in global array
 */
/*     func defineDirection(HWND  hWnd, HDC  hDC, LPARAM  lParam)
 {
 var      i: Int
 RECT    rectDot;
 var      dotRadius = 4
 var      angle: Int
 var    ptIsInARegion = false
 var defPoint: CGPoint
 var      angleIndex: Int
 var    posnx: Double
 var    posny: Double
 var    dx: Double
 var    dy: Double
 var      t: Int
 HPEN    hPen;

 posnx = LOWORD(lParam);
 posny = HIWORD(lParam);

 //  First click
 if gAngleClick == 1
 {
 for ( i = gDotSelectIndex; i <= 299 && ptIsInARegion == false; i+= )
 {
 if PtInRegion( gDotRegion[i], posnx, posny )
 {
 ptIsInARegion = true
 drawLargeDot(hWnd, hDC, i)
 DecodeIndex(ii)    //   to set gCurveNum

 if gAngleFlag[gCurveNum] {
 gOldAngleIndex = gAngleIndex[gCurveNum] }

 gAngleIndex[gCurveNum] = i
 }
 }

 /*   if the point wasn't in any dot region, we can't do   */
 if ptIsInARegion == false
 {
 gAngleClick = 0
 MessageBox  (hWnd,
 "Click is not in a dot region.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC(hWnd, hDC)
 return
 }

 if gAngleFlag[gCurveNum]
 {
 gOldAppleAngle  = 90 - gAlphai[gOldAngleIndex]

 if gOldAppleAngle < 0 {
 gOldAppleAngle = gOldAppleAngle + 360 }
 }

 ReleaseDC(hWnd, hDC)
 return
 }  //  End if first click


 //  second click or drag
 if gAngleClick > 1
 {
 angleIndex  = gAngleIndex[gCurveNum]

 //  dot from which we will define angle, in Windows coordinates
 defPoint    = gDotLoc[angleIndex]

 /*   don't allow the two points defining the angle to be closer than 10   */
 if abs(posnx - defPoint.x) > 10 || abs(posny - defPoint.y) > 10
 {
 MoveToEx(hDC, defPoint.x, defPoint.y, NULL);
 LineTo(hDC, posnx, posny)  //to show the drection line

 //  Put in a time delay so we can see the direction line
 Sleep(100)

 /*  define the direction angle   */
 /*  angle is integer, 0.0 to 360.0, CW from straight up  */

 dx = posnx - defPoint.x    //  in Windows coordinates
 dy = posny - defPoint.y    //  in Windows coordinates

 angle = gRadToDeg*( atan2( dy, dx) )
 angle = angle + 90.0    // CW from 12 o'clock

 if(angle < 0)
 angle = angle + 360.0

 gAppleAngle = angle

 calcArcs()
 LineTo(hDC, posnx, posny)

 }    // End if ( Dots not too close )

 else    //  The dots were too close together, maybe by accident
 {
 gAngleClick = 2    //  back to WndProc and try again

 ReleaseDC(hWnd, hDC)

 return
 }

 gSecondAngleFlag = gAngleFlag[gCurveNum]
 gAngleFlag[gCurveNum] = 1

 }    //  End if


 if gMouseDown == false
 {

 gAngleClick      = 0  //  defined angle, ready for next time
 gUndoFlag        = true  //  defined an angle, so we can undo one, unless it's the first time
 gLastMenuItem    = IDM_DEFINEDIRECTION

 }

 redraw(hWnd, hDC)

 ReleaseDC(hWnd, hDC)

 return
 } */


