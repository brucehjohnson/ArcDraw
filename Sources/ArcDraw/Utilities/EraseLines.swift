
/***************************************************************
 EraseLines
 **************************************************************

 Handle erasing of lines connecting dots for one curve.*/

/*   VOID  EraseLines(HWND  hWnd, HDC hDC)
 {
 var    i: Int
 var    n: Int
 RECT  rectDot;
 var    dotRadius = 3
 var    x1: Int
 var    x2: Int
 var    x3: Int
 var    x4: Int
 var    y1: Int
 var    y2: Int
 var    y3: Int
 var    y4: Int

 HPEN    hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines

 HBRUSH   hBrush = SelectObject(hDC, GetStockObject(LTGRAY_BRUSH)) // To paint dots light gray

 n = gCurveNum;

 for i = 15*n;  i < 15*n + gHighDotNum[n];  i+=
 {
 /*  x's and y's in Windows coordinates  */
 x1 = gDotLoc[i].x
 x2 = gDotLoc[i + 1].x
 y1 = gDotLoc[i].y
 y2 = gDotLoc[i + 1].y

 MoveToEx(hDC, x1, y1, NULL)  // Windows coordinates
 LineTo(hDC, x2, y2);          // Windows coordinates
 }

 /*  draw the dots in gray since we erased part of them  */
 /*  we have one more dot than we have arcs in a curve    */
 for ( i = 15*n;  i <= 15*n + gHighDotNum[n];  i+= )
 {
 rectDot.left     = gDotLoc[i].x - dotRadius
 rectDot.top     = gDotLoc[i].y - dotRadius
 rectDot.right   = gDotLoc[i].x + dotRadius
 rectDot.bottom   = gDotLoc[i].y + dotRadius
 }

 hPen = SelectObject(hDC, GetStockObject(BLACK_PEN))       // Return to normal pen

 hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH))   // Return to normal brush

 ReleaseDC(hWnd, hDC)

 return
 } */
