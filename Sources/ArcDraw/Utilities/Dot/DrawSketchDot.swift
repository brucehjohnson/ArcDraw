
/***************************************************************
 drawSketchDot
 **************************************************************

 Handle drawing of sketch dots. We don't send index as a parameter
 because we also need highDotNum.
 */
/*    VOID  drawSketchDot(HWND  hWnd, HDC hDC)
 {
 RECT  rectDot
 var    dotRadius = 3
 var    highDotNum: Int
 var    index: Int

 HBRUSH   hBrush = SelectObject(hDC, GetStockObject(BLACK_BRUSH)) // Paint It Black

 highDotNum  = gHighDotNum[gCurveNum]
 index        = 15*gCurveNum + highDotNum

 /*  draw a dot  */
 rectDot.left  = gDotLoc[index].x - dotRadius
 rectDot.top    = gDotLoc[index].y - dotRadius
 rectDot.right   = gDotLoc[index].x + dotRadius
 rectDot.bottom   = gDotLoc[index].y + dotRadius

 Ellipse( hDC, rectDot.left, rectDot.top, rectDot.right, rectDot.bottom )

 hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH)) // Return to normal brush

 ReleaseDC(hWnd, hDC)

 return
 } */
