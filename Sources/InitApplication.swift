

/*****************************************************************************
 *
 *  FUNCTION: InitApplication(HINSTANCE)
 *
 *  PURPOSE: Initializes window data and registers window class
 *
 *  COMMENTS:
 *
 *    This function is called at initialization time only if no other
 *    instances of the application are running.  This function performs
 *    initialization tasks that can be done once for any number of running
 *    instances.
 *
 *    In this case, we initialize a window class by filling out a data
 *    structure of type WNDCLASS and calling the Windows RegisterClass()
 *    function.  Since all instances of this application use the same window
 *    class, we only need to do this when the first instance is initialized.
 *
 *****************************************************************************/
/*      BOOL InitApplication(HINSTANCE hInstance)
 {
 WNDCLASS  wc;

 // Fill in window class structure with parameters that describe the
 // main window.

 wc.style         = CS_OWNDC                         // Class style(s).
 wc.lpfnWndProc   = WndProc                         // Window Procedure
 wc.cbClsExtra    = 0                                // No per-class extra data.
 wc.cbWndExtra    = 0                                // No per-window extra data.
 wc.hInstance     = hInstance                        // Owner of this class
 wc.hIcon         = LoadIcon (hInstance, szAppName) // Icon name from .RC
 wc.hbrBackground = (HBRUSH)(COLOR_WINDOW+1)        // Default color
 wc.lpszMenuName  = "ARCDRAWMENU"                   // Menu name from .RC
 wc.lpszClassName = szAppName                        // Name to register as

 // Register the window class and return success/failure code.
 return (RegisterClass(&wc))
 } */
