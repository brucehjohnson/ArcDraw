

/***************************************************************
 defineDot
 **************************************************************

 This picks up the mouse clicks after NewCurve is selected in the ArcDraw menu. NewCurve is
 automatically selected on startup. We set the positions for the dots of a curve.

 The curve number must have been defined somewhere in order to get here. On startup, we depend
 on the global gCurveNum being initialized to zero.

 When drawing and moving arcDraw curves we deal in Windows (local) coordinates.
 */

/*
func defineDot(HWND  hWnd, HDC  hDC, LPARAM  lParam)
{
  var lastPoint: CGPoint
  var    dotIndex: Int
  var    highDotNum: Int
  var posn: CGPoint

  posn.x = LOWORD(lParam)
  posn.y = HIWORD(lParam)

  /*   gHighDotNum[ ] was incremented before coming here, possibly from -1   */
  highDotNum  = gHighDotNum[gCurveNum]
  dotIndex  = 15*gCurveNum + highDotNum

  if highDotNum > 0 {
    lastPoint = gDotLoc[dotIndex - 1] }

  else  /*  we need a dummy lastPoint to test for superimposing  */
  {
lastPoint.y = -20000.0
lastPoint.x = -20000.0
  }

  /*   can't superimpose adjacent dots   */
  if (posn.x != lastPoint.x||posn.y != lastPoint.y)

  {
if !gAngleFlag[gCurveNum]  /*   Angle Flag is not set   */
{
  gDotLoc[dotIndex] = posn
  drawDot[dotIndex]
  dotAsRegion[dotIndex]
}
  }

  else {
    gHighDotNum[gCurveNum] = highDotNum - 1 }  /* disregard that click */
  gUndoFlag     = true    /* added a dot, so we can undo one   */
  gLastMenuItem  = IDM_NEWCURVE

  ReleaseDC(hWnd, hDC)
  return

}

*/



