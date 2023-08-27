
/***************************************************************
 DeleteDot
 ***************************************************************

 This picks up the mouse click after Delete Dot is selected in the ArcDraw menu. We determine
 gAddDotIndex of the dot to delete and move the higher dots of this curve down one step.
 We can't delete the dot the angle was defined from.
 */
/*    VOID  DeleteDot(HWND  hWnd, HDC  hDC, LPARAM  lParam)
 {
 var      i: Int
 var    ptIsInARegion = false
 var      highDotNum: Int
 var      angleIndex: Int
 var      dotIndex: Int
 var    posnx: Double
 var    posny: Double

 posnx = LOWORD(lParam)
 posny = HIWORD(lParam)

 for ( i = gDotSelectIndex; i <= 299 && ptIsInARegion == false; i+= )
 {
 if PtInRegion( gDotRegion[i], posnx, posny )
 {
 ptIsInARegion     = true
 DecodeIndex(hWnd, hDC, i)          //   to get gCurveNum
 angleIndex       = gAngleIndex[gCurveNum]
 gDeleteDotIndex   = i
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

 return
 }

 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC(hWnd, hDC)

 return
 }

 /*   if dot is reference for angle, we can't do   */
 angleIndex = gAngleIndex[gCurveNum]
 if gDeleteDotIndex == angleIndex
 {
 MessageBox  (hWnd,
 "The dot is a direction reference.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC(hWnd, hDC)

 return
 }

 else
 {
 highDotNum  = gHighDotNum[gCurveNum]

 /*   save dot in case we want to Undo   */
 gOldDotLoc = gDotLoc[gDeleteDotIndex]

 /*   move higher dots down   */
 for ( i = gDeleteDotIndex; i <= 15*gCurveNum + highDotNum - 1; i+= )
 {
 gAlphai[i]  = gAlphai[i + 1]
 gDotLoc[i]  = gDotLoc[i + 1]
 gDotRegion[i]  = gDotRegion[i + 1]
 }

 dotIndex           = 15*gCurveNum + highDotNum
 gAlphai[dotIndex]  = 0
 gDotRegion[dotIndex]  = 0

 if angleIndex > gDeleteDotIndex
 {
 gAngleIndex[gCurveNum] -=
 angleIndex -=
 }

 gHighDotNum[gCurveNum] -=

 gAppleAngle = 90 - gAlphai[angleIndex]

 if gAppleAngle < 0.0 {
 gAppleAngle = gAppleAngle + 360.0 }


 calcArcs()
 }

 gUndoFlag = true    //   deleted a dot, so we can undo one
 redraw(hWnd, hDC)
 ReleaseDC(hWnd, hDC)
 return

 } */

