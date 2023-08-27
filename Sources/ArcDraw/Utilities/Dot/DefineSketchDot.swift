/***************************************************************
 defineSketchDot                          *
 **************************************************************

 This picks up the mouse positions in defineSketchCurve. We set the positions
 for the dots of a curve.

 The curve number must have been defined somewhere in order to get here.

 When drawing and moving arcDraw curves we deal in Windows coordinates.

 Changes: loads dots in global array
 */
/*     VOID  defineSketchDot(HWND  hWnd, HDC  hDC, CGPoint  posn)
 {
 var      dotIndex: Int

 /*   gHighDotNum[ ] was incremented before coming here, possibly from -1   */
 dotIndex  = 15*gCurveNum + gHighDotNum[gCurveNum]

 gDotLoc[dotIndex] = posn
 DrawSketchDot(hWnd, hDC)
 dotAsRegion (dotIndex)

 gLastMenuItem  = IDM_NEWSKETCHCURVE

 ReleaseDC(hWnd, hDC)

 return
 } */
