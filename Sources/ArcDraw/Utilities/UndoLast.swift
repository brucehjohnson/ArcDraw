/***************************************************************
 UndoLast
 **************************************************************

 Restore to previous condition of curve and reset menu item.
 */
/*    VOID  UndoLast (HWND  hWnd)
 {
 var    i: Int
 var    highDotNum: Int
 var    angleIndex: Int
 var    dotIndex: Int

 HDC  hDC = GetDC(hWnd)

 if !gUndoFlag
 {
 ReleaseDC(hWnd, hDC)
 return
 }

 angleIndex = gAngleIndex[gCurveNum]

 if gLastMenuItem == IDM_DEFINEDIRECTION && gSecondAngleFlag
 {
 highDotNum = gHighDotNum[gCurveNum]

 /*   restore previous angle definition     */
 gAppleAngle  = gOldAppleAngle
 gAngleIndex[gCurveNum] = gOldAngleIndex

 calcArcs()
 redraw(hWnd, hDC)

 gMenuItem        = IDM_DEFINEDIRECTION
 gAngleClick      = 1
 gUndoFlag        = false
 gDotSelectIndex  = 0

 ReleaseDC(hWnd, hDC)

 return
 }

 if gLastMenuItem == IDM_DEFINEDIRECTION && !gSecondAngleFlag
 {
 MessageBox  (hWnd,
 "Can't undo first direction defined for a curve.",
 "arcDraw",
 MB_ICONEXCLAMATION | MB_OK)

 ReleaseDC(hWnd, hDC)

 return
 }


 if gLastMenuItem == IDM_DRAGDOT
 {
 highDotNum = gHighDotNum[gCurveNum]

 /*   restore moved dot   */
 gDotLoc[gDragDotIndex] = gOldDotLoc

 /*    define restored dot as region    */
 dotAsRegion (gDragDotIndex)

 gAppleAngle = 90.0 - gAlphai[angleIndex]

 if gAppleAngle < 0.0 {
 gAppleAngle = gAppleAngle + 360.0 }

 calcArcs()
 redraw(hWnd, hDC)

 gMenuItem        = IDM_DRAGDOT
 gUndoFlag        = false
 gDotSelectIndex  = 0

 ReleaseDC(hWnd, hDC)

 return
 }

 if gLastMenuItem == IDM_ADDDOTBEFORE
 {
 highDotNum = gHighDotNum[gCurveNum]

 /*   restore the dots moved in the array   */
 for ( i = gAddDotIndex - 1;  i <= 15*gCurveNum + highDotNum - 1;  i+= )
 {
 gAlphai[i]  = gAlphai[i + 1]
 gDotLoc[i]  = gDotLoc[i + 1]
 gDotRegion[i]  = gDotRegion[i + 1]
 }

 dotIndex          = 15*gCurveNum + highDotNum
 gAlphai[dotIndex]  = 0.0
 gDotRegion[dotIndex]  = 0

 if gAngleIndex[gCurveNum] >= gAddDotIndex - 1
 {
 gAngleIndex[gCurveNum]
 angleIndex -=
 }

 gHighDotNum[gCurveNum] -=

 gAppleAngle = 90.0 - gAlphai[angleIndex]

 if gAppleAngle < 0 {
 gAppleAngle = gAppleAngle + 360.0 }

 calcArcs()
 redraw(hWnd, hDC)

 gMenuItem        = IDM_ADDDOTBEFORE
 gAddDotClick    = 1
 gUndoFlag        = false
 gDotSelectIndex  = 0

 ReleaseDC(hWnd, hDC)

 return
 }

 if gLastMenuItem == IDM_ADDDOTAFTER
 {
 highDotNum = gHighDotNum[gCurveNum]

 /*   restore dots moved in the array   */
 for ( i = gAddDotIndex + 1;  i <= 15*gCurveNum + highDotNum - 1;  i+= )
 {
 gAlphai[i]  = gAlphai[i + 1]
 gDotLoc[i]  = gDotLoc[i + 1]
 gDotRegion[i]  = gDotRegion[i + 1]
 }

 dotIndex          = 15*gCurveNum + highDotNum
 gAlphai[dotIndex]  = 0.0
 gDotRegion[dotIndex]  = 0

 if gAngleIndex[gCurveNum] > gAddDotIndex
 {
 gAngleIndex[gCurveNum] -=
 angleIndex -=
 }

 gHighDotNum[gCurveNum] -=

 gAppleAngle = 90 - gAlphai[angleIndex]

 if gAppleAngle < 0 {
 gAppleAngle = gAppleAngle + 360.0 }


 calcArcs()
 redraw(hWnd, hDC)

 gMenuItem        = IDM_ADDDOTAFTER
 gAddDotClick    = 1
 gUndoFlag        = false
 gDotSelectIndex  = 0

 ReleaseDC(hWnd, hDC)

 return
 }

 if gLastMenuItem == IDM_DELETEDOT
 {
 highDotNum = gHighDotNum[gCurveNum]

 /*  start at top and move dots as high as, and higher than, gDeleteDotIndex back up  */
 for ( i = 15*gCurveNum + highDotNum;  i >= gDeleteDotIndex;  i-= )
 {
 gAlphai[i + 1]  = gAlphai[i]
 gDotLoc[i + 1]  = gDotLoc[i]
 gDotRegion[i + 1]  = gDotRegion[i]
 }

 if gAngleIndex[gCurveNum] >= gDeleteDotIndex
 {
 gAngleIndex[gCurveNum] +=
 angleIndex +=
 }

 gHighDotNum[gCurveNum] +=

 /*   restore deleted dot   */
 gDotLoc[gDeleteDotIndex] = gOldDotLoc

 /*    define restored dot as region    */
 dotAsRegion (gDeleteDotIndex)

 gAppleAngle = 90.0 - gAlphai[angleIndex]

 if gAppleAngle < 0.0 {
 gAppleAngle = gAppleAngle + 360.0 }

 calcArcs()
 redraw(hWnd, hDC)
 gMenuItem        = IDM_DELETEDOT
 gUndoFlag        = false
 gDotSelectIndex  = 0

 ReleaseDC(hWnd, hDC)

 return
 }

 ReleaseDC(hWnd, hDC)

 return;
 } */
