/***************************************************************
 EraseLargeDot
 **************************************************************

 Handle erasing of large dot.

 Receives: pointer to window containing curve and index of dot
 Changes: erases dot by making it white
 */
/*   VOID  EraseLargeDot(HWND  hWnd, HDC hDC, int  dotIndex)
 {
 RECT  rectDot
 var    dotRadius = 5

 HPEN    hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines

 /*  draw the large dot in white  */
 rectDot.left  = gDotLoc[dotIndex].x - dotRadius
 rectDot.top    = gDotLoc[dotIndex].y - dotRadius
 rectDot.right   = gDotLoc[dotIndex].x + dotRadius
 rectDot.bottom  = gDotLoc[dotIndex].y + dotRadius

 Ellipse( hDC, rectDot.left, rectDot.top, rectDot.right, rectDot.bottom )

 hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // To restore normal pen

 ReleaseDC(hWnd, hDC)

 return
 } */
