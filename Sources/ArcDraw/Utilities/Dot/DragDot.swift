/***************************************************************
 DragDot
 **************************************************************

 Handle dragging of dots the old-fashioned way. Animate dots by erasing old location and
 redrawing in new location.
 */
/*     VOID  DragDot(HWND  hWnd, HDC  hDC, LPARAM  lParam)
 {
 int      i: Int
 var    posnx: Double
 var    posny: Double
 var posn: CGPoint

 //      var      dummy: Int

 posnx   = LOWORD(lParam)
 posny   = HIWORD(lParam)

 posn.x  =  posnx
 posn.y  =  posny

 if  gDragFlag == false
 {

 for ( i = gDotSelectIndex; i <= 299 && gPtIsInARegion == false; i+= )
 {
 if PtInRegion( gDotRegion[i], posnx, posny )
 {
 gPtIsInARegion = true
 DecodeIndex(hWnd, hDC, i)  //   sets gCurveNum
 }

 if gPtIsInARegion && gAngleFlag[gCurveNum] {
 gDragDotIndex = i }
 }

 /*  point not in a region  */
 if gPtIsInARegion != true
 {
 MessageBox  (hWnd,
 "Click is not in a dot region.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC(hWnd, hDC)
 return
 }

 /*  Angle flag not set  */
 if !gAngleFlag[gCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC(hWnd, hDC)
 return
 }

 gOldDotLoc   = gDotLoc[gDragDotIndex]
 gDragFlag   = true

 }    //  End if gDragFlag is false


 gDotLoc[gDragDotIndex] = posn

 gAppleAngle = 90.0 - gAlphai[gAngleIndex[gCurveNum]]

 if (gAppleAngle < 0.0) {
 gAppleAngle = gAppleAngle + 360.0 }

 calcArcs()

 /*    define moved dot as region     */
 dotAsRegion (gDragDotIndex)

 gUndoFlag = true  // dragged a dot, so we can undo one

 //     dummy = gMenuItem + gLastMenuItem + gDragDotIndex

 redraw(hWnd, hDC)
 ReleaseDC(hWnd, hDC)
 return
 } */
