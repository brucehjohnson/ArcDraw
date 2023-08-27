

/*****************************************************************************
 *
 * FUNCTION: WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
 *
 * PURPOSE: calls initialization function, processes message loop
 *
 * COMMENTS:
 *
 *    Windows recognizes this function by name as the initial entry point
 *    for the program.  This function calls the application initialization
 *    routine, if no other instance of the program is running, and always
 *    calls the instance initialization routine.  It then executes a message
 *    retrieval and dispatch loop that is the top-level control structure
 *    for the remainder of execution.  The loop is terminated when a WM_QUIT
 *    message is received, at which time this function exits the application
 *    instance by returning the value passed by PostQuitMessage().
 *
 *    If this function must abort before entering the message loop, it
 *    returns the conventional value NULL.
 *
 ****************************************************************************/
/*     int APIENTRY WinMain(
 HINSTANCE   hInstance,
 HINSTANCE   hPrevInstance,
 LPSTR       lpCmdLine,
 int         nCmdShow)
 {

 MSG msg

 gPi       = 4*atan(1)
 gDegToRad = gPi/180
 gRadToDeg = 180/gPi


 if !hPrevInstance {                       // Other instances of app running?
 if !InitApplication(hInstance) {   // Initialize shared things
 return (false)                     // Exits if unable to initialize
 }
 }

 /* Perform initializations that apply to a specific instance */

 if !InitInstance(hInstance, nCmdShow) {
 return (false)
 }

 /* Acquire and dispatch messages until a WM_QUIT message is received. */

 while GetMessage(&msg,           // message structure
 NULL,         // handle of window receiving the message
 0,            // lowest message to examine
 0)           // highest message to examine
 {
 TranslateMessage(&msg)        // Translates virtual key codes
 DispatchMessage(&msg)        // Dispatches message to window
 }

 return (msg.wParam)               // Returns the value from PostQuitMessage

 } */
