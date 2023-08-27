

/*****************************************************************************
 *
 *   FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
 *
 *   PURPOSE:  Processes messages
 *
 *   MESSAGES:
 *
 *   WM_COMMAND    - application menu (About dialog box)
 *   WM_DESTROY    - destroy window
 *
 *   COMMENTS:
 *
 *   To process the IDM_ABOUT message, call MakeProcInstance() to get the
 *   current instance address of the About() function.  Then call Dialog
 *   box which will create the box according to the information in your
 *   arcDraw.rc file and turn control over to the About() function.  When
 *   it returns, free the instance address.
 *
 ****************************************************************************/
/*     LRESULT CALLBACK WndProc(
 HWND     hWnd,       // window handle
 UINT     message,    // type of message
 WPARAM   wParam,     // additional information
 LPARAM   lParam)     // additional information
 {
 RECT    rect
 int     wmId, wmEvent

 HDC      hDC = GetDC(hWnd)

 SetLastError(0)   // Set error flag to "no errors"

 switch message {

 case WM_CREATE:
 return 0


 case WM_PAINT:  {
 PAINTSTRUCT  ps
 HDC  hDC = BeginPaint(hWnd, &ps)
 GetClientRect(hWnd, &rect)

 gxClient = rect.right    //  left is always xero
 gyClient = rect.bottom    //  top is always xero

 EndPaint(hWnd, &ps)
 return 0
 }



 case WM_LBUTTONDOWN:  {
 HDC  hDC = GetDC(hWnd)
 gMouseDown = true


 if gMenuItem == IDM_NEWCURVE
 && gHighDotNum[gCurveNum] < 14                //  Define Dot
 {
 gHighDotNum[gCurveNum] +=  /*  Was initialized to -1  */
 defineDot(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_NEWCURVE && gHighDotNum[gCurveNum] == 14
 {
 MessageBox  (hWnd,
 "Too many dots.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)
 return  (0)
 }


 if gMenuItem == IDM_DEFINEDIRECTION
 && gHighDotNum[gCurveNum] <= 14
 && (gAngleClick == 1 || gAngleClick == 2)    //  Define Direction
 {
 defineDirection(hWnd, hDC, lParam)
 gAngleClick +=
 return  (0)
 }


 if gMenuItem == IDM_DELETEDOT                      //   Delete Dot
 {
 DeleteDot(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_CLEARCURVE                    //   Clear Curve
 {
 ClearCurve(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_DRAGDOT                        //   Drag Dot
 {
 gPtIsInARegion = false
 DragDot(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_ADDDOTAFTER
 && gHighDotNum[gCurveNum] < 14
 && gAddDotClick <= 2                           //   Add Dot After
 {
 AddDotAfter(hWnd, hDC, lParam)
 gAddDotClick +=
 return  (0)
 }


 if gMenuItem == IDM_ADDDOTAFTER && gHighDotNum[gCurveNum] == 14
 {
 MessageBox  (hWnd,
 "Too many dots.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)
 return  (0)
 }


 if gMenuItem == IDM_ADDDOTBEFORE
 && gHighDotNum[gCurveNum] < 14
 && gAddDotClick <= 2                           //   Add Dot Before
 {
 AddDotBefore(hWnd, hDC, lParam)
 gAddDotClick +=
 return  (0)
 }


 if gMenuItem == IDM_ADDDOTBEFORE && gHighDotNum[gCurveNum] == 14
 {
 MessageBox  (hWnd,
 "Too many dots.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)
 return  (0)
 }




 if gMenuItem == IDM_NEWSKETCHCURVE
 && gSketchClick == 1                            //   Define Sketch Curve
 {
 if !gHighCurveNumFlag
 {
 gHighDotNum[gCurveNum] +=
 defineSketchCurve(hWnd, hDC, lParam)
 gSketchClick +=
 return  (0)
 }

 else {
 MessageBox  (hWnd,
 "Too many curves.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK);
 return  (0) }
 }


 ReleaseDC(hWnd, hDC)

 break
 }


 case WM_MOUSEMOVE:  {
 HDC  hDC = GetDC(hWnd)
 gMouseMove = true


 if gMouseDown == true
 {
 if gMenuItem == IDM_DEFINEDIRECTION
 && gHighDotNum[gCurveNum] <= 14
 && gAngleClick > 2                      //  Define Direction
 {
 defineDirection(hWnd, hDC, lParam)
 gAngleClick +=
 return  (0)
 }


 if gMenuItem == IDM_DRAGDOT
 && gDragFlag == true                    //   Drag Dot
 {
 DragDot(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_ADDDOTAFTER
 && gHighDotNum[gCurveNum] < 14
 && gAddDotClick >=3                    //   Add Dot After
 {
 AddDotAfter(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_ADDDOTBEFORE
 && gHighDotNum[gCurveNum] < 14
 && gAddDotClick >=3                    //  Add Dot Before
 {
 AddDotBefore(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_NEWSKETCHCURVE
 && gSketchClick > 1                    //   Define Sketch Curve
 {
 defineSketchCurve(hWnd, hDC, lParam)
 gSketchClick +=
 return  (0)
 }


 }        //end if

 ReleaseDC(hWnd, hDC)
 break

 }


 case WM_LBUTTONUP:  //  Means it's up, not that it just came up
 {
 HDC  hDC = GetDC(hWnd)
 var gMouseDown = false


 if gMenuItem == IDM_DEFINEDIRECTION
 && gAngleClick > 2                      //  Define Direction
 {
 defineDirection(hWnd, hDC, lParam)

 gAngleClick +=

 if gAngleFlag[gHighCurveNum] {
 gDotSelectIndex = 0 }

 else {
 gDotSelectIndex    = 15*gHighCurveNum

 return  (0) }
 }


 if gMenuItem == IDM_DRAGDOT                //   Drag Dot
 {
 gMenuItem        = IDM_DRAGDOT
 gLastMenuItem    = IDM_DRAGDOT
 gDotSelectIndex  = 0
 gSketchFlag     = false
 gDragFlag        = false
 return  (0)
 }


 if gMenuItem == IDM_ADDDOTAFTER
 && gHighDotNum[gCurveNum] < 14
 && gAddDotClick >=3                    //   Add Dot After
 {
 AddDotAfter(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_ADDDOTBEFORE
 && gHighDotNum[gCurveNum] < 14
 && gAddDotClick >=3                    //   Add Dot Before
 {
 AddDotBefore(hWnd, hDC, lParam)
 return  (0)
 }


 if gMenuItem == IDM_NEWSKETCHCURVE
 && gSketchClick > 2                    //   Define Sketch Curve
 {
 defineSketchCurve(hWnd, hDC, lParam)
 return  (0)
 }


 ReleaseDC(hWnd, hDC)
 break
 }


 case WM_COMMAND:                              // To handle menu hits
 //  Activated when button comes up

 wmId    = LOWORD(wParam)
 wmEvent = HIWORD(wParam)

 switch (wmId) {

 /*   hit is in client area of window   */

 case IDM_NEWCURVE:    // = 135
 if (gLastMenuItem == IDM_NEWSKETCHCURVE && !gHighCurveNumFlag)
 gHighCurveNum -=

 if gHighCurveNum >= 0
 {
 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gHighCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }
 }

 gMenuItem        = IDM_NEWCURVE
 gLastMenuItem    = IDM_NEWCURVE
 gDotSelectIndex  = 0
 gSketchFlag     = false

 NewCurve (hWnd)
 break


 case IDM_DEFINEDIRECTION:    // = 125
 if gLastMenuItem == IDM_NEWSKETCHCURVE && !gHighCurveNumFlag
 gHighCurveNum -=

 /*   if gHighCurveNum = -1, we can't do   */
 if gHighCurveNum == -1
 {
 MessageBox  (hWnd,
 "Must select one of the last three menu items.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 gMenuItem        = IDM_DEFINEDIRECTION
 gLastMenuItem    = IDM_DEFINEDIRECTION
 gAngleClick      = 1


 if gAngleFlag[gHighCurveNum] {
 gDotSelectIndex    = 0 }

 else {
 gDotSelectIndex    = 15*gHighCurveNum }

 gSketchFlag  = false
 break


 case IDM_ADDDOTBEFORE:    // = 126
 if gLastMenuItem == IDM_NEWSKETCHCURVE && !gHighCurveNumFlag {
 gHighCurveNum -= }

 /*   if gHighCurveNum = -1, we can't do   */
 if gHighCurveNum == -1
 {
 MessageBox  (hWnd,
 "Must select one of the last three menu items.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gHighCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 gMenuItem          = IDM_ADDDOTBEFORE
 gLastMenuItem      = IDM_ADDDOTBEFORE
 gAddDotClick      = 1
 gDotSelectIndex    = 0
 gSketchFlag       = false

 break


 case IDM_ADDDOTAFTER:    // = 127
 if gLastMenuItem == IDM_NEWSKETCHCURVE && !gHighCurveNumFlag {
 gHighCurveNum -+ }

 /*   if gHighCurveNum = -1, we can't do   */
 if gHighCurveNum == -1
 {
 MessageBox  (hWnd,
 "Must select one of the last three menu items.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gHighCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 gMenuItem          = IDM_ADDDOTAFTER
 gLastMenuItem      = IDM_ADDDOTAFTER
 gAddDotClick      = 1
 gDotSelectIndex    = 0
 gSketchFlag       = false

 break


 case IDM_DRAGDOT:    // = 129
 if gLastMenuItem == IDM_NEWSKETCHCURVE && !gHighCurveNumFlag {
 gHighCurveNum -= }

 /*   if gHighCurveNum = -1, we can't do   */
 if gHighCurveNum == -1
 {
 MessageBox  (hWnd,
 "Must select one of the last three menu items.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gHighCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 gMenuItem        = IDM_DRAGDOT
 gLastMenuItem    = IDM_DRAGDOT
 gDotSelectIndex  = 0
 gSketchFlag     = false
 gDragFlag        = false

 break


 case IDM_DELETEDOT:    // = 128
 if gLastMenuItem == IDM_NEWSKETCHCURVE && !gHighCurveNumFlag {
 gHighCurveNum -= }

 /*   if gHighCurveNum = -1, we can't do   */
 if gHighCurveNum == -1
 {
 MessageBox  (hWnd,
 "Must select one of the last three menu items.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gHighCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 gMenuItem          = IDM_DELETEDOT
 gLastMenuItem      = IDM_DELETEDOT
 gDotSelectIndex    = 0
 gSketchFlag       = false

 break


 case IDM_UNDOLAST:    // = 130
 /*   if gHighCurveNum = -1, we can't do   */
 if gHighCurveNum == -1
 {
 MessageBox  (hWnd,
 "Must select one of the last three menu items.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gHighCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 if gLastMenuItem == IDM_NEWCURVE
 || gLastMenuItem == IDM_DEFINEDIRECTION
 || gLastMenuItem == IDM_DRAGDOT
 || gLastMenuItem == IDM_ADDDOTBEFORE
 || gLastMenuItem == IDM_ADDDOTAFTER
 || gLastMenuItem == IDM_DELETEDOT
 || gLastMenuItem == IDM_NEWSKETCHCURVE
 {
 UndoLast(hWnd)
 }
 break


 case IDM_UNDOLASTAND:    // = 131
 /*   if gHighCurveNum = -1, we can't do   */
 if gHighCurveNum == -1
 {
 MessageBox  (hWnd,
 "Must select one of the last three menu items.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gHighCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 if gLastMenuItem == IDM_NEWCURVE
 || gLastMenuItem == IDM_DEFINEDIRECTION
 || gLastMenuItem == IDM_DRAGDOT
 || gLastMenuItem == IDM_ADDDOTBEFORE
 || gLastMenuItem == IDM_ADDDOTAFTER
 || gLastMenuItem == IDM_DELETEDOT
 || gLastMenuItem == IDM_NEWSKETCHCURVE
 {
 UndoLastAndFindHiddenDot(hWnd)
 }

 break


 case IDM_NEWSKETCHCURVE:    // = 136
 gMenuItem          = IDM_NEWSKETCHCURVE
 gDotSelectIndex    = 0
 gSketchFlag       = true
 gSketchClick      = 1
 gAngleFlag2       = false

 NewSketchCurve(hWnd)
 break


 case IDM_CLEARCURVE:    // = 132
 if gLastMenuItem == IDM_NEWSKETCHCURVE && !gHighCurveNumFlag {
 gHighCurveNum -= }

 /*   if gHighCurveNum = -1, we can't do   */
 if gHighCurveNum == -1
 {
 MessageBox  (hWnd,
 "Must select one of the last three menu items.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 /*   if angle flag not set, we can't do   */
 if !gAngleFlag[gHighCurveNum]
 {
 MessageBox  (hWnd,
 "A direction isn't defined yet.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 return (0L)
 }

 gMenuItem        = IDM_CLEARCURVE
 gLastMenuItem    = IDM_CLEARCURVE
 gDotSelectIndex  = 0
 gSketchFlag     = false
 break


 case IDM_SHOWDOTS:    // = 133
 hDC = GetDC(hWnd)
 gShowDots = 1
 redraw(hWnd, hDC)
 break


 case IDM_HIDEDOTS:    // = 134
 hDC = GetDC(hWnd)
 gShowDots = 0
 redraw(hWnd, hDC)
 break


 case IDM_ABOUT:    // = 133
 DialogBox(hInst,          // current instance
 "ABOUTBOX",      // dlg resource to use
 hWnd,            // parent handle
 (DLGPROC)About) // About() instance address
 break

 case IDM_HEARTS:        //  = 138
 Hearts (hWnd, hDC)
 break


 case IDM_SPIRALS:        //  = 139
 Spirals (hWnd, hDC)
 break

 case IDM_MOONS:          //  = 140
 Moons (hWnd, hDC)
 break

 case IDM_YINYANG:        //  = 141
 YinYang (hWnd, hDC)
 break

 case IDM_SHAPES:        //  = 142
 Shapes (hWnd, hDC)
 break

 case IDM_PETALS:        //  = 143
 Petals (hWnd, hDC)
 break

 case IDM_CURSIVE:        //  = 144
 Cursive (hWnd, hDC)
 break


 case IDM_EXIT:          // = 106
 DestroyWindow (hWnd)
 break


 case WM_DESTROY:        // message: window being destroyed
 PostQuitMessage(0)
 break
 }

 default:            // Passes it on if unproccessed
 return DefWindowProc(hWnd, message, wParam, lParam)
 }

 return (0L)
 } */



