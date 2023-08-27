/***************************************************************
 drawCurve
 **************************************************************
 /
 Handle drawing of arcs for one curve.

 */
/*     VOID  drawCurve(HWND  hWnd, HDC hDC)
 {
 var      xL: Int
 var      yT: Int
 var      xR: Int
 var      yB: Int
 var      i: Int
 var      j: Int
 var      n: Int
 RECT    rectDot
 var      dotRadius = 3
 var      x1: Int
 var      x2: Int
 var      y1: Int
 var      y2: Int
 var      dummy: Int
 var  alpha12: Double
 var      x3: Int
 var      x4: Int
 var      y3: Int
 var      y4: Int
 var      r: Int

 HBRUSH   hBrush = SelectObject(hDC, GetStockObject(LTGRAY_BRUSH)) // To paint dots light gray

 n = gCurveNum
 r = 2000

 /*  draw lines and arcs  */
 for ( i = 15*n;  i < 15*n + gHighDotNum[n];  i+= )
 {
 /*  x's and y's in Windows coordinates  */
 /*  gDotLoc[]'s in Windows coordinates  */
 x1 = gDotLoc[i].x
 x2 = gDotLoc[i + 1].x
 y1 = gDotLoc[i].y
 y2 = gDotLoc[i + 1].y

 if fabs(gR[i] - 15000.0) <= 0.001 || fabs(gR[i] - 16000.0) <= 0.001
 {
 alpha12 = gRadToDeg*atan2(-(y2 - y1), x2 - x1)  //  Since we need normal coordinates

 if alpha12 < 0.0 {
 alpha12 = alpha12 + 360.0 }  //  To get in range of 0 to 359

 if fabs(gR[i] - 15000.0) <= 0.001
 {
 MoveToEx(hDC, x1, y1, NULL)  //  x's and y's in Windows coordinates
 LineTo(hDC, x2, y2)          //  x's and y's in Windows coordinates
 }

 else
 {
 x3 = x1 - r*cos(gDegToRad*alpha12)  // Windows coordinates
 x4 = x2 + r*cos(gDegToRad*alpha12)  // Windows coordinates
 y3 = y1 - r*sin(gDegToRad*alpha12)  // Windows coordinates
 y4 = y2 + r*sin(gDegToRad*alpha12)  // Windows coordinates

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

 }    //  End of for i


 /* draw the dots in gray */
 /*  we have one more dot than we have arcs in a curve   */
 for ( j = 15*n;  j <= 15*n + gHighDotNum[n];  j+= )
 {
 rectDot.left     = gDotLoc[i].x - dotRadius
 rectDot.top     = gDotLoc[i].y - dotRadius
 rectDot.right   = gDotLoc[i].x + dotRadius
 rectDot.bottom   = gDotLoc[i].y + dotRadius

 Ellipse( hDC, rectDot.left, rectDot.top, rectDot.right, rectDot.bottom )
 }  //  End of for j

 //      dummy = x1+x2+y1+y2+xL+yT+xR+yB+n+r+i+j

 hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH)) // Return to normal brush

 ReleaseDC(hWnd, hDC)

 return
 } */
