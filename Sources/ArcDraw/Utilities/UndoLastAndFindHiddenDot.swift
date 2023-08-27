/***************************************************************
 UndoLastAndFindHiddenDot                     *
 ***************************************************************

 Restore to previous condition of curve, adjust to get at overlapping dots,
 and reset menu item.
 */
/*    VOID  UndoLastAndFindHiddenDot(HWND  hWnd)
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

 /*  Adjust gDotSelectIndex so we can get at overlapping dots  */
 gDotSelectIndex  = angleIndex + 1

 /*   restore previous angle definition     */
 gAppleAngle  = gOldAppleAngle
 gAngleIndex[gCurveNum] = gOldAngleIndex;

 calcArcs()
 redraw(hWnd, hDC)

 gMenuItem    = IDM_DEFINEDIRECTION
 gAngleClick  = 1
 gUndoFlag    = false

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
 highDotNum   = gHighDotNum[gCurveNum]

 /*   adjust gDotSelectIndex so we can get at overlapping dots   */
 if gDragDotIndex == 15*gHighCurveNum + highDotNum {
 gDotSelectIndex  = 0 }

 else {
 gDotSelectIndex  = gDragDotIndex + 1 }

 /*   restore moved dot   */
 gDotLoc[gDragDotIndex] = gOldDotLoc

 /*    define restored dot as region    */
 dotAsRegion (gDragDotIndex)

 gAppleAngle = 90 - gAlphai[angleIndex]

 if gAppleAngle < 0 {
 gAppleAngle = gAppleAngle + 360.0 }


 calcArcs()
 redraw(hWnd, hDC)

 gMenuItem  = IDM_DRAGDOT
 gUndoFlag  = false

 ReleaseDC(hWnd, hDC)

 return
 }

 if gLastMenuItem == IDM_ADDDOTBEFORE
 {
 highDotNum = gHighDotNum[gCurveNum

 /*   adjust gDotSelectIndex so we can get at overlapping dots   */
 /*   gHighDotNum[ ] - 1 is the old dot number   */
 if gAddDotIndex == (15*gHighCurveNum + highDotNum) {
 gDotSelectIndex = 0 }

 else {   //   we already incremented gAddDotIndex in AddDotBefore()
 gDotSelectIndex  = gAddDotIndex }

 /*   restore dots moved in the array   */
 for ( i = gAddDotIndex - 1;  i <= 15*gCurveNum + highDotNum - 1;  i+= )
 {
 gAlphai[i]  = gAlphai[i + 1]
 gDotLoc[i]  = gDotLoc[i + 1]
 gDotRegion[i]  = gDotRegion[i + 1]
 }

 if gAngleIndex[gCurveNum] >= gAddDotIndex - 1
 {
 gAngleIndex[gCurveNum] -=
 angleIndex -=
 }

 dotIndex          = 15*gCurveNum + highDotNum
 gAlphai[dotIndex]  = 0
 gDotRegion[dotIndex]  = 0

 gHighDotNum[gCurveNum] -=

 gAppleAngle = 90.0 - gAlphai[angleIndex]

 if gAppleAngle < 0.0 {
 gAppleAngle = gAppleAngle + 360.0 }

 calcArcs()

 gMenuItem      = IDM_ADDDOTBEFORE
 gAddDotClick  = 1
 gUndoFlag      = false

 ReleaseDC(hWnd, hDC)

 return
 }

 if gLastMenuItem == IDM_ADDDOTAFTER
 {
 highDotNum = gHighDotNum[gCurveNum]

 /*   adjust gDotSelectIndex so we can get at overlapping dots   */
 /*   gHighDotNum - 1 is the old dot number   */
 if gAddDotIndex == 15*gHighCurveNum + highDotNum - 1 {
 gDotSelectIndex  = 0 }

 else {
 gDotSelectIndex  = gAddDotIndex + 1 }

 /*   restore dots moved in the array   */
 for ( i = gAddDotIndex + 1;  i <= 15*gCurveNum + highDotNum - 1;  i+= )
 {
 gAlphai[i]  = gAlphai[i + 1]
 gDotLoc[i]  = gDotLoc[i + 1]
 gDotRegion[i]  = gDotRegion[i + 1]
 }

 if gAngleIndex[gCurveNum] > gAddDotIndex
 {
 gAngleIndex[gCurveNum] -=
 angleIndex -=
 }

 dotIndex          = 15*gCurveNum + highDotNum
 gAlphai[dotIndex]  = 0.0
 gDotRegion[dotIndex]  = 0

 gHighDotNum[gCurveNum] -=

 gAppleAngle = 90.0 - gAlphai[angleIndex]

 if gAppleAngle < 0 {
 gAppleAngle = gAppleAngle + 360.0 }


 calcArcs()

 gMenuItem      = IDM_ADDDOTAFTER
 gAddDotClick  = 1
 gUndoFlag      = false

 ReleaseDC(hWnd, hDC)

 return
 }

 if gLastMenuItem == IDM_DELETEDOT
 {
 highDotNum = gHighDotNum[gCurveNum]

 /*   adjust gDotSelectIndex so we can get at overlapping dots     */
 /*   gHighDotNum + 1 is the old dot number                 */
 if gDeleteDotIndex == 15*gHighCurveNum + highDotNum + 1 {
 gDotSelectIndex  = 0 }

 else {
 gDotSelectIndex  = gDeleteDotIndex + 1 }

 /*  Start at top and move dots as high as, and higher than, gDeleteDotIndex back up  */
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
 gMenuItem  = IDM_DELETEDOT
 gUndoFlag  = false

 ReleaseDC(hWnd, hDC)

 return
 }

 ReleaseDC(hWnd, hDC)

 return
 } */
