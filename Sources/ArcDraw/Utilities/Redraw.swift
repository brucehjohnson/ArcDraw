
/***************************************************************
 redraw                             *
 **************************************************************

 Handle redrawing of all the curves when updating.
 */

/*    VOID  redraw(HWND  hWnd, HDC hDC)
 {
 var      xL Int
 var      yT: Int
 var      xR: Int
 var      yB: Int
 var      i: Int
 var      n: Int
 RECT    rectDot
 var      dotRadius = 3
 var      highDotNum: Int
 //     var  dummy: Double
 var      x1: Int
 var      x2: Int
 var      y1: Int
 var      y2: Int
 int      xCL;
 int      yCT;
 int      xCR;
 int      yCB;
 double  alpha12;
 var      x3: Int
 var      x4: Int
 var      y3: Int
 var      y4: Int
 var      r: Int

 HPEN    hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines

 HBRUSH   hBrush // to erase area with normal brush

 r = 2000

 //    Erase the client area
 xCL   = 0
 yCT   = 0
 xCR   = gxClient
 yCB   = gyClient

 Rectangle(hDC, xCL, yCT, xCR, yCB)

 hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Return to normal pen

 /*  draw lines and arcs  */
 for ( n = 0; n <= gHighCurveNum; n+= )
 {
 highDotNum = gHighDotNum[n]

 for ( i = 15*n;  i < 15*n + gHighDotNum[n];  i+= )
 {
 /*  x's and y's in Windows coordinates  */
 x1 = gDotLoc[i].x
 x2 = gDotLoc[i + 1].x
 y1 = gDotLoc[i].y
 y2 = gDotLoc[i + 1].;

 if fabs(gR[i] - 15000.0) <= 0.001 || fabs(gR[i] - 16000.0) <= 0.001
 {
 //  We need normal coordinates for atan2, so put minus sign in front of y's
 alpha12 = gRadToDeg*atan2(-(y2 - y1), x2 - x1)

 if alpha12 < 0.0 {
 alpha12 = alpha12 + 360.0 }  //  To get in range of 0 to 359

 if fabs(gR[i] - 15000.0) <= 0.001
 {
 MoveToEx(hDC, x1, y1, NULL)  // Windows coordinates
 LineTo(hDC, x2, y2)          // Windows coordinates
 }

 else
 {
 x3 = x1 - r*cos(gDegToRad*alpha12)  // Windows coordinates
 x4 = x2 + r*cos(gDegToRad*alpha12)  // Windows coordinates
 y3 = y1 + r*sin(gDegToRad*alpha12)  // Windows coordinates
 y4 = y2 - r*sin(gDegToRad*alpha12)  // Windows coordinates

 MoveToEx(hDC, x1, y1, NULL)        // Windows coordinates
 LineTo(hDC, x3, y3)                // Windows coordinates

 MoveToEx(hDC, x2, y2, NULL)        // Windows coordinates
 LineTo(hDC, x4, y4)                // Windows coordinates
 }
 }

 else
 {
 /*  draw the arc  */
 xL   = RoundToInt(gXc[i] - gR[i])
 yT   = RoundToInt(-gYc[i] - gR[i])
 xR   = RoundToInt(gXc[i] + gR[i])
 yB   = RoundToInt(-gYc[i] + gR[i])

 if gIsCW[i] == 0 {
 Arc(hDC, xL, yT, xR, yB, x1, y1, x2, y2) }  // "forwards" if CCW

 else {
 Arc(hDC, xL, yT, xR, yB, x2, y2, x1, y1) }  //  "backwards" if CW
 }

 }

 if gShowDots == 1
 {
 /*  draw the dots in light gray   */
 /*  we have one more dot than we have arcs in a curve  */
 for ( i = 15*n;  i <= 15*n + highDotNum;  i+= )
 {
 rectDot.left   = gDotLoc[i].x - dotRadius
 rectDot.top   = gDotLoc[i].y - dotRadius
 rectDot.right   = gDotLoc[i].x + dotRadius
 rectDot.bottom   = gDotLoc[i].y + dotRadius

 hBrush = SelectObject(hDC, GetStockObject(LTGRAY_BRUSH)) // Light gray brush

 Ellipse( hDC, rectDot.left, rectDot.top, rectDot.right, rectDot.bottom )
 }
 }
 }

 /*     dummy = gHighCurveNum + gHighDotNum[0] + gR[0] + gAngleFlag[0] + gXc[0]
  + gYc[0]
  + gAlphai[0] + gCurveNum + gAppleAngle
  + x1 + x2 + x3 + x4+ y1 + y2 + y3 + y4 + alpha12  */

 hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH)) // Return to normal brush

 ReleaseDC(hWnd, hDC)

 return
 } */


