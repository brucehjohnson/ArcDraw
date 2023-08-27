

/*****************************************************************************
 *
 *   FUNCTION: About(HWND, UINT, WPARAM, LPARAM)
 *
 *   PURPOSE:  Processes messages for "About" dialog box
 *
 *   MESSAGES:
 *
 *   WM_INITDIALOG - initialize dialog box
 *   WM_COMMAND    - Input received
 *
 *   COMMENTS:
 *
 *   Display version information from the version section of the
 *   application resource.
 *
 *   Wait for user to click on "Ok" button, then close the dialog box.
 *
 ****************************************************************************/

/*     LRESULT CALLBACK About(
 HWND hDlg,           // window handle of the dialog box
 UINT message,        // type of message
 WPARAM wParam,       // message-specific information
 LPARAM lParam)
 {
 switch (message) {
 case WM_INITDIALOG:  // message: initialize dialog box
 return (true);

 case WM_COMMAND:     // message: received a command
 if LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL {
 EndDialog(hDlg, true)        // Exit the dialog
 return (true)
 }
 break
 }
 return (false) // Didn't process the message

 } */





