/***************************************************************
 drawDot                             *
 **************************************************************

 Handle drawing of dots and the straight lines for defineDirection.
 */
import CoreGraphics

func drawDot(dotIndex: Int) {
  var dotRadius: CGFloat = 3.0

  /*

  // Set fill color
  context.setFillColor(NSColor.black.cgColor)

  // Create a circle path
  let circlePath = NSBezierPath(ovalIn: NSRect(x: gDotLoc[dotIndex].x - dotRadius,
                                               y: gDotLoc[dotIndex].x + dotRadius,
                                               width: 2*dotRadius,
                                               height: 2*dotRadius))

  // Fill the circle
  circlePath.fill()

  /*  connect two dots with straight line  */
  if gHighDotNum[gCurveNum] >= 1 && !gAngleFlag[gCurveNum]

  {
let path = CGMutablePath()

path.move(to: CGPoint(x: gDotLoc[dotIndex - 1].x, y: gDotLoc[dotIndex - 1].y)) // Move to a point
path.addLine(to: CGPoint(x: gDotLoc[dotIndex].x, y: gDotLoc[dotIndex].y)) // Add a line to a second point
  }

  //       hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH)) // Return to normal brush

  //       ReleaseDC(hWnd, hDC)



   */

  return
}
