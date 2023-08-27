/***************************************************************
 AddDotBefore
 **************************************************************

 This picks up the mouse clicks (the second click can be a drag) after Add Dot Before is
 selected in the ArcDraw menu. We determine gAddDotIndex where the new dot goes and move
 the higher dots of this curve up one step in the array.

 Receives: hDC, CGPoint position in local coordinates
 Changes: loads new dot, defined as a region, in global array
 */

import CoreGraphics

/*
func addDotBefore(HWND  hWnd, HDC  hDC, LPARAM  lParam)
{
  var            i: Int
  var            j: Int
  BOOL          ptIsInARegion = false
  var refPoint1: CGPoint
  var refPoint2: CGPoint
  var            highDotNum: Int
  var          posnx: Double
  var          posny: Double

  var posn: CGPoint            //  We need for gDotLoc

  posnx = LOWORD(lParam)
  posny = HIWORD(lParam)

  posn.x  =  posnx
  posn.y  =  posny

  if gAddDotClick == 1
  {
for ( i = gDotSelectIndex; i <= 299 && ptIsInARegion == false; i+= )
{
  if PtInRegion( gDotRegion[i], posn.x, posn.y )
  {
ptIsInARegion = true
DecodeIndex(hWnd, hDC, i)    //   to get gCurveNum
  }

  if ptIsInARegion && gAngleFlag[gCurveNum]
  {
gAddDotIndex = i  //   new dot index is index of dot clicked
drawLargeDot(ii)
  }
}

/*   if the point (posn) wasn't in any dot region, we can't do   */
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

  return
}

ReleaseDC(hWnd, hDC)

return
  }            //  End if for first click


  if gAddDotClick == 2
  {
highDotNum = gHighDotNum[gCurveNum]
gAngleIndexBefore = gAngleIndex[gCurveNum]
refPoint1 = gDotLoc[gAddDotIndex]      //  first dot clicked
refPoint2 = gDotLoc[gAddDotIndex - 1]  //   use only if not at first dot of curve

/*   start at high dot for curve and move them up one step in the array  */
for ( j = 15*gCurveNum + highDotNum;  j >= gAddDotIndex;  j-= )
{
  gAlphai[j + 1]  = gAlphai[j]
  gDotLoc[j + 1]  = gDotLoc[j]
  gDotRegion[j + 1]  = gDotRegion[j]
}

if gAngleIndexBefore >= gAddDotIndex
{
  gAngleIndex[gCurveNum] +=
  gAngleIndexBefore +=
}

gHighDotNum[gCurveNum] +=

  }          //  End if for second click


  if gAddDotClick >= 2
  {

/*   can't superimpose adjacent dots    */
if posnx != refPoint1.x||posny != refPoint1.y
{
  if gAddDotIndex > 15*gCurveNum
      || posn.x != refPoint1.x
      || posn.y != refPoint1.y
  {
gDotLoc[gAddDotIndex] = posn
gAppleAngle = 90.0 - gAlphai[gAngleIndexBefore]

if gAppleAngle < 0.0
    gAppleAngle = gAppleAngle + 360.0

    calcArcs()
    DrawCurve(hWnd, hDC)
    EraseCurve(hWnd, hDC)

  }
}

else
{
  gAddDotClick = 1  //   disregard that second click

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

  /*  define new dot as region    */
  dotAsRegion (gAddDotIndex)

  gAddDotClick  = 1  // added dot, ready for next time
  gUndoFlag     = true  // added a dot, so we can undo one
  gAddDotIndex +=      // since we added a dot in front of the selected dot
  gLastMenuItem  = IDM_ADDDOTBEFORE

  redraw(hWnd, hDC)
  ReleaseDC(hWnd, hDC)

  return
}
*/
