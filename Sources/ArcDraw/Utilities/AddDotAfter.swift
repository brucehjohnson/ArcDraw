/***************************************************************
 AddDotAfter
 **************************************************************

 This picks up the mouse clicks (the second click can be a drag) after Add Dot After is
 selected in the ArcDraw menu. We determine gAddDotIndex where the new dot goes and
 move the higher dots of this curve up one step.

 Receives: hDC, CGPoint position in local coordinates
 Changes: loads new dot, defined as a region, in global array
 */
import CoreGraphics

/*

func addDotAfter(HWND  hWnd, HDC  hDC, LPARAM  lParam)
{
  var ii: Int
  var j: Int
  var ptIsInARegion = false
  var refPoint1: CGPoint
  var refPoint2: CGPoint
  var highDotNum: Int
  var posnx: Double
  var posny: Double

  var posn: CGPoint            //  We need for gDotLoc

  posnx = LOWORD(lParam)
  posny = HIWORD(lParam)

  posn.x  =  posnx
  posn.y  =  posny

  if gAddDotClick == 1
  {
/*       for ( i = gDotSelectIndex; i <= 299 && ptIsInARegion == false; i+= )
 {
 if PtInRegion( gDotRegion[i], posnx, posny )
 {
 ptIsInARegion = true
 DecodeIndex(hWnd, hDC, i)    /*   to get the curve number   */
 }

 if ptIsInARegion && gAngleFlag[gCurveNum]
 {
 gAddDotIndex = i    /*   new dot will go one above here   */
 drawLargeDot(ii)
 }

 i+=
 } */

var ii = gDotSelectIndex
while ii <= 299 && ptIsInARegion == false {
  //         if CGRectContainsPoint(gDotRegion[ii], posnx, posny)
  if rectangle.contains(pointToCheck) {
      {
    ptIsInARegion = true
    DecodeIndex(hWnd, hDC, ii)    /*   to get the curve number   */
      }

    if ptIsInARegion && gAngleFlag[gCurveNum]
    {
  gAddDotIndex = ii    /*   new dot will go one above here   */
  drawLargeDot(ii)
    }

    ii = ii+1
  }

  /*   if the point wasn't in any dot region, we can't do   */
  if !ptIsInARegion
  {
gAddDotClick = 0
MessageBox  (hWnd,
             "Click is not in a dot region.",
             "arcDraw",
             MB_ICONEXCLAMATION | MB_OK)

ReleaseDC(hWnd, hDC)

return
  }

  /*   angle flag not set   */
  if !gAngleFlag[gCurveNum]
  {
gAddDotClick = 0
MessageBox  (hWnd,
             "A direction isn't defined yet.",
             "arcDraw",
             MB_ICONEXCLAMATION | MB_OK)
ReleaseDC(hWnd, hDC)
return;
  }

  ReleaseDC(hWnd, hDC)

  return
}            //  End if for first click


if gAddDotClick == 2
{
  highDotNum         = gHighDotNum[gCurveNum]
  gAngleIndexAfter   = gAngleIndex[gCurveNum]
  refPoint1         = gDotLoc[gAddDotIndex]      //  first dot clicked
  refPoint2         = gDotLoc[gAddDotIndex + 1]  //   use only if not at last dot of curve

  /*   start at top dot defined for the curve and move them up a step in the array   */
  for ( j = 15*gCurveNum + highDotNum;  j > gAddDotIndex; j -= )
  {
gAlphai[j + 1]  = gAlphai[j]
gDotLoc[j + 1]  = gDotLoc[j]
gDotRegion[j + 1]  = gDotRegion[j]
  }

  if gAngleIndexAfter > gAddDotIndex
  {
gAngleIndex[gCurveNum] +=
gAngleIndexAfter

gHighDotNum[gCurveNum] +=

  }          //  End if for second click


  if gAddDotClick >= 2
  {

/*   can't superimpose adjacent dots    */
if (posnx != refPoint1.x || posny != refPoint1.y)
{
  if gAddDotIndex < 15*gCurveNum + highDotNum
      || posnx != refPoint2.x
      || posny != refPoint2.y
  {
gDotLoc[gAddDotIndex + 1] = posn
gAppleAngle = 90.0 - gAlphai[gAngleIndexAfter]

if (gAppleAngle < 0.0) {
  gAppleAngle = gAppleAngle + 360.0
}

calcArcs()
DrawCurve(hWnd, hDC)
EraseCurve(hWnd, hDC)

  }
}

else
{
  gAddDotClick = 1  //   disregard that click

  ReleaseDC(hWnd, hDC)
  return
}

  }          //  End if for 2+ click

  if gMouseDown == true
  {
redraw(hWnd, hDC)
ReleaseDC(hWnd, hDC)
return
  }

  /*    define new dot as region    */
  dotAsRegion[gAddDotIndex + 1]

  gAddDotClick  = 1    //   added dot, ready for next time
  gUndoFlag      = true   //   added a dot, so we can undo one
  gLastMenuItem  = IDM_ADDDOTAFTER

  redraw(hWnd, hDC)
  ReleaseDC(hWnd, hDC)

  return
}

*/
