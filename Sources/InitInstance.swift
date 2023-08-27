

/*****************************************************************************
 *
 *   FUNCTION:  InitInstance(HINSTANCE, int)
 *
 *   PURPOSE:  Saves instance handle and creates main window
 *
 *   COMMENTS:
 *
 *      This function is called at initialization time for every instance of
 *      this application.  This function performs initialization tasks that
 *      cannot be shared by multiple instances.
 *
 *      In this case, we save the instance handle in a static variable and
 *      create and display the main program window.
 *
 ****************************************************************************/
/*     {
 HWND  hWnd         // Main window handle.

 hInst = hInstance   // Store instance handle in our global variable

 // Create a main window for this application instance.
 hWnd = CreateWindow(
 szAppName,                           // See RegisterClass() call.
 szTitle,                             // Text for window title bar.
 WS_OVERLAPPEDWINDOW,                // Window style.
 83,                                  // Horizontal position (1")
 83,                                  // Vertical position (1")
 664,                                // Width (8")
 581,                                // Height (7")
 NULL,                                // Overlapped windows have no parent.
 NULL,                                // Use the window class menu.
 hInstance,                           // This instance owns this window.
 NULL                                 // We don't use any data in our WM_CREATE
 )

 // If window could not be created, return "failure"
 if !hWnd {
 return (false)
 }

 // Make the window visible; update its client area; and return "success"
 ShowWindow(hWnd, nCmdShow)   // Show the window
 UpdateWindow(hWnd)           // Sends WM_PAINT message

 MessageBox(hWnd, "    US Patent Number 6,441,822     ",
 szAppName, MB_OK | MB_ICONWARNING)

 gLastMenuItem = IDM_NEWCURVE

 gMenuItem  = IDM_NEWCURVE

 gHighCurveNum +=  //  Was initialized to -1

 return (true)              // We succeeded...

 } */
