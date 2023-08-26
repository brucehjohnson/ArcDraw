//
//  ContentView.swift
//  ArcDraw
//
//  Created by Bruce Johnson on 7/19/23.
//

import SwiftUI
import AppKit
import Foundation
import UniformTypeIdentifiers
import CoreGraphics

struct ContentView: View {
    var body: some View {
      

      
      /*   arcDraw curve globals (automatically set to zero at start unless explicitly initialized) 
       We only need to initialize gHighDotNum[21] and gHighCurveNum  */
      
      var gMenuItem: Int
      var gLastMenuItem: Int
      var gAngleClick: Int
      var gAddDotClick: Int
      var gHighCurveNum = -1
      var gCurveNum: Int
      var gOldDotLoc: CGPoint        /*  Windows coordinates  */
      var gOldAppleAngle: Double    /*  Windows coordinates  */
      var gAppleAngle: Double      /*  Windows coordinates  */
      var gHighDotNum = [Int](repeating: -1, count: 21)
      
      var gSecondAngleFlag: Bool
      var gSketchFlag: Bool
      var gUndoFlag: Bool
      var gHighCurveNumFlag: Bool
      var gAngleFlag = [Bool](repeating: false, count: 21)
      
      var gDragFlag: Bool
      
      var gShowDots = 1
      
      var gDotSelectIndex: Int
      var gDeleteDotIndex: Int
      var gDragDotIndex: Int
      var gAddDotIndex: Int
      var gOldAngleIndex: Int
 //     var gAngleIndex = [Int](repeating: 0, count: 21)
      var gAngleIndex: [Int]
      var gAngleIndexAfter: Int
      var gAngleIndexBefore: Int
      
 //     var gX = [Int](repeating: 0, count: 301)          /*  normal coordinates  */
 //     var gY = [Int](repeating: 0, count: 301)          /*  normal coordinates  */
 //     var gAlphai = [Double](repeating: 0.0, count: 301)      /*  normal coordinates  */
 //     var gAlphaf = [Double](repeating: 0.0, count: 301)      /*  normal coordinates  */
 //     var gStartAngle = [Double](repeating: 0.0, count: 301) /*  Windows coordinates  */
 //     var gArcAngle = [Double](repeating: 0.0, count: 301)    /*  Windows coordinates  */
 //     var gXc = [Double](repeating: 0.0, count: 301)          /*  normal coordinates  */
 //     var gYc = [Double](repeating: 0.0, count: 301)          /*  normal coordinates  */
 //     var gR = [Double](repeating: 0.0, count: 301)
 //     var gDotLoc = [CGPoint](repeating: CGPoint(x:0.0, y:0.0), count: 301)      /*  Windows coordinates  */
      
      var gX: [Int]          /*  normal coordinates  */
      var gY: [Int]        /*  normal coordinates  */
      var gAlphai: [Double]      /*  normal coordinates  */
      var gAlphaf: [Double]      /*  normal coordinates  */
      var gStartAngle: [Double] /*  Windows coordinates  */
      var gArcAngle: [Double]    /*  Windows coordinates  */
      var gXc: [Double]          /*  normal coordinates  */
      var gYc: [Double]          /*  normal coordinates  */
      var gR: [Double]
      var gDotLoc: [CGPoint]      /*  Windows coordinates  */
 //     var gDotRegion[301]
      var gDotRegion: [CGMutablePath]
      
 /*     // Assuming you have a CGPathRef called 'regionPath' representing your region

CGPoint clickPoint = [event locationInWindow]; // Get the mouse click point
clickPoint = [myView convertPoint:clickPoint fromView:nil]; // Convert the point to the view's coordinate system

if (CGPathContainsPoint(regionPath, NULL, clickPoint, NO)) {
    // The click is inside the region
    // Perform your desired action here
} else {
    // The click is outside the region
} */
      
      var gMouseDown = false
      var gMouseMove = false
      
      var gPi: Double
      var gDegToRad: Double
      var gRadToDeg: Double
      
      var gxClient: Int
      var gyClient: Int
      
      var gMousex: Int
      var gMousey: Int
      
      var gPtIsInARegion: Bool
      
      var gSketchClick: Int
      var gArcLength: Int
      var gLastMouse: CGPoint
      var gAngleFlag2: Bool
      var gAnglePoint2: CGPoint
      var gAlpha1: Double
      var gU = [Double](repeating: 0.0, count: 15)
      var gUt0: Double
      var gUt1: Double
      var gUt2: Double
      var gEnergyFlag: Bool
      
      var gIsCW = [Bool](repeating: false, count: 301)
      
      
      /*****************************************************************************
       *                                       
       *                                       
       *   PURPOSE: Template for Windows applications                     
       *                                       
       *   FUNCTIONS:                                 
       *                                       
       *   GetLastErrorBox() - Report GetLastError() values as text                
       *   WinMain() - calls initialization function, processes message loop     
       *   InitApplication() - initializes window data and registers window     
       *   InitInstance() - saves instance handle and creates main window       
       *   WndProc() - processes messages                       
       *   About() - processes messages for "About" dialog box           
       *                                       
       *                                             
       *****************************************************************************/
      
      
//      HINSTANCE hInst       // current instance global
      
//      char szAppName[] = "arcDraw"   // The name of this application
//      char szTitle[]   = "arcDraw Demo" // The title bar text
      
      
      /**********************************************************************
       *                                                                    
       * FUNCTION:  GetLastErrorBox(HWND, LPSTR)                              
       *                                    
       * PURPOSE:   Gets the error status and, if an error is indicated,    
       *            converts the error number into text and displays it     
       *            in a MessageBox.                                        
       *                                                                    
       *********************************************************************/
 /*     double GetLastErrorBox(HWND hWnd, LPSTR lpTitle)
      {
        LPVOID lpv
        var dwRv: Double
        
        if GetLastError() == 0 {
         return 0 }
        
        dwRv = FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
                             FORMAT_MESSAGE_FROM_SYSTEM,
                             NULL,
                             GetLastError(),
                             MAKELANGID(LANG_ENGLISH, SUBLANG_ENGLISH_US),
                             (LPVOID)&lpv,
                             0,
                             NULL)
        
        MessageBox(hWnd, lpv, lpTitle, MB_OK)
        
        if dwRv {
            LocalFree(lpv) }
        
        SetLastError(0)
        return dwRv
      } */
      
      
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
      
      
      /*  arcDraw Functions  */
      
      
      /***************************************************************
       defineDot                           
      **************************************************************
        
       This picks up the mouse clicks after NewCurve is selected in the ArcDraw menu. NewCurve is 
       automatically selected on startup. We set the positions for the dots of a curve.
       
       The curve number must have been defined somewhere in order to get here. On startup, we depend 
       on the global gCurveNum being initialized to zero.
       
       When drawing and moving arcDraw curves we deal in Windows (local) coordinates.
       */
      func defineDot(HWND  hWnd, HDC  hDC, LPARAM  lParam)
      {
        var lastPoint: CGPoint
        var    dotIndex: Int
        var    highDotNum: Int
        var posn: CGPoint
        
        posn.x = LOWORD(lParam)
        posn.y = HIWORD(lParam)
        
        /*   gHighDotNum[ ] was incremented before coming here, possibly from -1   */
        highDotNum  = gHighDotNum[gCurveNum]
        dotIndex  = 15*gCurveNum + highDotNum
        
        if highDotNum > 0 {
          lastPoint = gDotLoc[dotIndex - 1] }
        
        else  /*  we need a dummy lastPoint to test for superimposing  */
        {
          lastPoint.y = -20000.0
          lastPoint.x = -20000.0
        }
        
        /*   can't superimpose adjacent dots   */
        if (posn.x != lastPoint.x||posn.y != lastPoint.y)
            
        {
          if !gAngleFlag[gCurveNum]  /*   Angle Flag is not set   */
          {
            gDotLoc[dotIndex] = posn
            drawDot[dotIndex]
            dotAsRegion[dotIndex]
          }
        }
        
        else {
          gHighDotNum[gCurveNum] = highDotNum - 1 }  /* disregard that click */
        gUndoFlag     = true    /* added a dot, so we can undo one   */
        gLastMenuItem  = IDM_NEWCURVE
        
        ReleaseDC(hWnd, hDC)
        return
        
      }
      
      
      /***************************************************************
       dotAsRegion                            
      **************************************************************
        
       This receives a dot index number and defines a region for the corresponding dot.
       Changes: defines dot as a region, in global array
       */
      
      func dotAsRegion(dotIndex: Int)
      {
        var dotCenter: CGPoint
        var dotRadius: CGFloat = 5.0
        
        let gDotRegion[dotIndex] = CGMutablePath()
        gDotRegion.addArc(center: dotCenter, radius: dotRadius, startAngle: 0.0, endAngle: 2 * .pi, clockwise: false)
        gDotRegion.closeSubpath()
        
//        gDotRgn[dotIndex] = CreateEllipticRgn( rectDot.left, rectDot.top, rectDot.right, rectDot.bottom )

        return
      }
      
      
      /***************************************************************
       drawDot                             *
      **************************************************************
        
       Handle drawing of dots and the straight lines for defineDirection.
       */
      
      func drawDot(dotIndex: Int)
      {
        var dotRadius: CGFloat = 3.0

        // Set fill color
        context.setFillColor(NSColor.black.cgColor)
        
        // Create a circle path
        let circlePath = NSBezierPath(ovalIn: NSRect(x: gDotLoc[dotIndex].x - dotRadius,
                                                     y: gDotLoc[dotIndex].x + dotRadius, 
                                                     width: 2*dotRadius,
                                                     height: 2*dotRadius))
      
        // Fill the circle
        circlePath.fill()
        
        /*  connect two dots with straight line  */
        if gHighDotNum[gCurveNum] >= 1 && !gAngleFlag[gCurveNum]
            
        {
        let path = CGMutablePath()
            
        path.move(to: CGPoint(x: gDotLoc[dotIndex - 1].x, y: gDotLoc[dotIndex - 1].y)) // Move to a point
        path.addLine(to: CGPoint(x: gDotLoc[dotIndex].x, y: gDotLoc[dotIndex].y)) // Add a line to a second point
        }
        
 //       hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH)) // Return to normal brush
        
 //       ReleaseDC(hWnd, hDC)
        
        return
      }  
      
      
      /***************************************************************
       AddDotAfter                           
      **************************************************************
        
       This picks up the mouse clicks (the second click can be a drag) after Add Dot After is 
       selected in the ArcDraw menu. We determine gAddDotIndex where the new dot goes and 
       move the higher dots of this curve up one step.
       
       Receives: hDC, CGPoint position in local coordinates
       Changes: loads new dot, defined as a region, in global array
       */
      
      func addDotAfter(HWND  hWnd, HDC  hDC, LPARAM  lParam)
      {
        var ii: Int
        var j: Int
        var ptIsInARegion = false
        var refPoint1: CGPoint
        var refPoint2: CGPoint
        var highDotNum: Int
        var posnx: Double
        var posny: Double
        
        var posn: CGPoint            //  We need for gDotLoc
        
        posnx = LOWORD(lParam)
        posny = HIWORD(lParam)
        
        posn.x  =  posnx
        posn.y  =  posny
        
        if gAddDotClick == 1
        {
   /*       for ( i = gDotSelectIndex; i <= 299 && ptIsInARegion == false; i+= )
          {
            if PtInRegion( gDotRegion[i], posnx, posny )
            {
              ptIsInARegion = true
              DecodeIndex(hWnd, hDC, i)    /*   to get the curve number   */
            }
            
            if ptIsInARegion && gAngleFlag[gCurveNum]
            {
              gAddDotIndex = i    /*   new dot will go one above here   */
              drawLargeDot(ii)
            }
            
            i+=
          } */
          
          var ii = gDotSelectIndex
          while ii <= 299 && ptIsInARegion == false {
   //         if CGRectContainsPoint(gDotRegion[ii], posnx, posny)
          if rectangle.contains(pointToCheck) {
            {
              ptIsInARegion = true
              DecodeIndex(hWnd, hDC, ii)    /*   to get the curve number   */
            }
            
            if ptIsInARegion && gAngleFlag[gCurveNum]
            {
              gAddDotIndex = ii    /*   new dot will go one above here   */
              drawLargeDot(ii)
            }
            
            ii = ii+1
          }
          
          /*   if the point wasn't in any dot region, we can't do   */
          if !ptIsInARegion
          {
            gAddDotClick = 0
            MessageBox  (hWnd,
                         "Click is not in a dot region.",
                         "arcDraw",
                         MB_ICONEXCLAMATION | MB_OK)
            
            ReleaseDC(hWnd, hDC)
            
            return
          }
          
          /*   angle flag not set   */
          if !gAngleFlag[gCurveNum]
          {
            gAddDotClick = 0
            MessageBox  (hWnd,
                         "A direction isn't defined yet.",
                         "arcDraw",
                         MB_ICONEXCLAMATION | MB_OK)
            ReleaseDC(hWnd, hDC)
            return;
          }  
          
          ReleaseDC(hWnd, hDC)
          
          return
        }            //  End if for first click
        
        
        if gAddDotClick == 2
        {
          highDotNum         = gHighDotNum[gCurveNum]
          gAngleIndexAfter   = gAngleIndex[gCurveNum]
          refPoint1         = gDotLoc[gAddDotIndex]      //  first dot clicked
          refPoint2         = gDotLoc[gAddDotIndex + 1]  //   use only if not at last dot of curve
          
          /*   start at top dot defined for the curve and move them up a step in the array   */
          for ( j = 15*gCurveNum + highDotNum;  j > gAddDotIndex; j -= )  
          {
            gAlphai[j + 1]  = gAlphai[j]
            gDotLoc[j + 1]  = gDotLoc[j]
            gDotRegion[j + 1]  = gDotRegion[j]
          }
          
          if gAngleIndexAfter > gAddDotIndex
          {
            gAngleIndex[gCurveNum] +=
            gAngleIndexAfter 
          
          gHighDotNum[gCurveNum] +=
          
        }          //  End if for second click
        
        
        if gAddDotClick >= 2
        {
          
          /*   can't superimpose adjacent dots    */
          if (posnx != refPoint1.x || posny != refPoint1.y)
          {
            if gAddDotIndex < 15*gCurveNum + highDotNum
                 || posnx != refPoint2.x
                 || posny != refPoint2.y
            {
              gDotLoc[gAddDotIndex + 1] = posn
              gAppleAngle = 90.0 - gAlphai[gAngleIndexAfter]
              
              if (gAppleAngle < 0.0) {
                gAppleAngle = gAppleAngle + 360.0
              }
              
              calcArcs()
              DrawCurve(hWnd, hDC)
              EraseCurve(hWnd, hDC)
              
            }
          }
          
          else
          {
            gAddDotClick = 1  //   disregard that click
            
            ReleaseDC(hWnd, hDC)
            return
          }
          
        }          //  End if for 2+ click
        
        if gMouseDown == true
        {
          redraw(hWnd, hDC)
          ReleaseDC(hWnd, hDC)
          return
        }
        
        /*    define new dot as region    */
        dotAsRegion[gAddDotIndex + 1]
        
        gAddDotClick  = 1    //   added dot, ready for next time
        gUndoFlag      = true   //   added a dot, so we can undo one
        gLastMenuItem  = IDM_ADDDOTAFTER
        
        redraw(hWnd, hDC)
        ReleaseDC(hWnd, hDC)
        
        return
      }
      
      
      /***************************************************************
       AddDotBefore                           
      **************************************************************
        
       This picks up the mouse clicks (the second click can be a drag) after Add Dot Before is 
       selected in the ArcDraw menu. We determine gAddDotIndex where the new dot goes and move 
       the higher dots of this curve up one step in the array.
       
       Receives: hDC, CGPoint position in local coordinates
       Changes: loads new dot, defined as a region, in global array
       */
      
      func addDotBefore(HWND  hWnd, HDC  hDC, LPARAM  lParam)
      {
        var            i: Int
        var            j: Int
        BOOL          ptIsInARegion = false
        var refPoint1: CGPoint
        var refPoint2: CGPoint
        var            highDotNum: Int
        var          posnx: Double
        var          posny: Double
        
        var posn: CGPoint            //  We need for gDotLoc
        
        posnx = LOWORD(lParam)
        posny = HIWORD(lParam)
        
        posn.x  =  posnx
        posn.y  =  posny
        
        if gAddDotClick == 1
        {
          for ( i = gDotSelectIndex; i <= 299 && ptIsInARegion == false; i+= )
          {
            if PtInRegion( gDotRegion[i], posn.x, posn.y )
            {
              ptIsInARegion = true
              DecodeIndex(hWnd, hDC, i)    //   to get gCurveNum
            }
            
            if ptIsInARegion && gAngleFlag[gCurveNum]
            {
              gAddDotIndex = i  //   new dot index is index of dot clicked
              drawLargeDot(ii)
            }
          }
          
          /*   if the point (posn) wasn't in any dot region, we can't do   */
          if !ptIsInARegion
          {
            gAddDotClick = 0
            MessageBox  (hWnd,
                         "Click is not in a dot region.",
                         "arcDraw",
                         MB_ICONEXCLAMATION | MB_OK)
            
            ReleaseDC(hWnd, hDC)
            
            return
          }
          
          /*   angle flag not set   */
          if !gAngleFlag[gCurveNum]
          {
            gAddDotClick = 0
            MessageBox  (hWnd,
                         "A direction isn't defined yet.",
                         "arcDraw",
                         MB_ICONEXCLAMATION | MB_OK)
            
            ReleaseDC(hWnd, hDC)
            
            return
          }
          
          ReleaseDC(hWnd, hDC)
          
          return
        }            //  End if for first click
        
        
        if gAddDotClick == 2
        {
          highDotNum = gHighDotNum[gCurveNum]
          gAngleIndexBefore = gAngleIndex[gCurveNum]
          refPoint1 = gDotLoc[gAddDotIndex]      //  first dot clicked
          refPoint2 = gDotLoc[gAddDotIndex - 1]  //   use only if not at first dot of curve
          
          /*   start at high dot for curve and move them up one step in the array  */
          for ( j = 15*gCurveNum + highDotNum;  j >= gAddDotIndex;  j-= )  
          {
            gAlphai[j + 1]  = gAlphai[j]
            gDotLoc[j + 1]  = gDotLoc[j]
            gDotRegion[j + 1]  = gDotRegion[j]
          }
          
          if gAngleIndexBefore >= gAddDotIndex
          {
            gAngleIndex[gCurveNum] +=
            gAngleIndexBefore +=
          }
          
          gHighDotNum[gCurveNum] +=
          
        }          //  End if for second click
        
        
        if gAddDotClick >= 2
        {
          
          /*   can't superimpose adjacent dots    */
          if posnx != refPoint1.x||posny != refPoint1.y
          {
            if gAddDotIndex > 15*gCurveNum
                 || posn.x != refPoint1.x
                 || posn.y != refPoint1.y
            {
              gDotLoc[gAddDotIndex] = posn
              gAppleAngle = 90.0 - gAlphai[gAngleIndexBefore]
              
              if gAppleAngle < 0.0
                  gAppleAngle = gAppleAngle + 360.0
              
              calcArcs()
              DrawCurve(hWnd, hDC)
              EraseCurve(hWnd, hDC)
              
            }
          }
          
          else
          {
            gAddDotClick = 1  //   disregard that second click
            
            ReleaseDC(hWnd, hDC)
            return
          }
          
        }          //  End if for 2+ click
        
        if gMouseDown == true
        {
          redraw(hWnd, hDC)
          ReleaseDC(hWnd, hDC)
          return
        }
        
        /*  define new dot as region    */
        dotAsRegion (gAddDotIndex)
        
        gAddDotClick  = 1  // added dot, ready for next time
        gUndoFlag     = true  // added a dot, so we can undo one
        gAddDotIndex +=      // since we added a dot in front of the selected dot
        gLastMenuItem  = IDM_ADDDOTBEFORE
        
        redraw(hWnd, hDC)
        ReleaseDC(hWnd, hDC)
        
        return
      }
      
      
      /***************************************************************
       calcArcs                             
      **************************************************************
        
       This fills in the rest of the arrays so we can draw the arcs.
       
       Requires: 
       Receives: nothing
       Changes: global arrays
       Returns: nothing
       */
      func calcArcs()
      {
        var i: Int
        var j: Int
        var k: Int
        var n: Int
        var x1: Double
        var x2: Double
        var y1: Double
        var y2: Double
        var e: Double
        var d: Double
        var f: Double
        var d11: Double
        var d12: Double
        var d21: Double
        var d22: Double
        var thetat: Double
        var y1t: Double
        var yCt: Double
        var xRef: Double
        var yRef: Double
        var isCW: Bool
        var initialAngleIndex: Int
        var highAngleIndex: Int
        var initialDotIndex: Int
        var highDotIndex: Int
        var eNum = 0.0
        var eDenom = 0.0
        var d11Flag: Bool
        var d21Flag: Bool
        var d12Flag: Bool
        var d22Flag: Bool
        var d12Num: Double
        var d12Denom: Double
        var d11Num: Double
        var d11Denom: Double
   //     var dummy: Int
        var alpha12: Double
        var dAlpha12: Double
        var startAngle: Double
        var arcAngle: Double
        var alphaiT: Double
        var r1Deg: Double
        
        var curveNum: Int
        
        curveNum = gCurveNum
        
        /*  Any index must have range of 0 - 299  */
        
        /*  Any number must have range of 0 - 19  */
        
        initialAngleIndex = gAngleIndex[gCurveNum]
        
        /*  We have one less arc than we have dots in a curve  */
        highAngleIndex = 15*gCurveNum + gHighDotNum[gCurveNum] - 1
        
        gAlphai[initialAngleIndex] = 90.0 - gAppleAngle
        
        if gAlphai[initialAngleIndex] < 0 {
          gAlphai[initialAngleIndex] = gAlphai[initialAngleIndex] + 360.0}
          /*  gAlphai[ ] is a double, 0.0 to 360.0, CW from x direction  */
        
        initialDotIndex = 15*gCurveNum
        highDotIndex = initialDotIndex + gHighDotNum[gCurveNum]
        
        /*  find all gX's and gY's for the curve  */
        var ii = initialDotIndex
        while ii <= highDotIndex  {
          gX[ii] = Int(gDotLoc[ii].x)
          gY[ii] = Int(-gDotLoc[ii].y)
          ii = ii+1
        }
        
  /*      for ( i = initialDotIndex;  i <= highDotIndex;  i+= )
        {
          gX[i] = gDotLoc[i].x
          gY[i] = -gDotLoc[i].y
        } */
        
        /*  Find parameters of initial arc  */
        x1 = Double(gX[initialAngleIndex])
        x2 = Double(gX[initialAngleIndex + 1])
        y1 = Double(gY[initialAngleIndex + 0])
        y2 = Double(gY[initialAngleIndex + 1])
        
        alpha12 = gRadToDeg*atan2(y2 - y1, x2 - x1)
        
        if alpha12 < 0.0 {
          alpha12 = alpha12 + 360.0  //  To get in range of 0.0 to 360.0
        }
        
        dAlpha12 = gAlphai[initialAngleIndex] - alpha12;
        
        if dAlpha12 < 0 {
            dAlpha12 = dAlpha12 + 360.0 }  //  To get in range of 0.0 to 360.0
        
          if dAlpha12 == 0.0 {
            gR[initialAngleIndex] = 15000.0 }  //  To get one line
        
            else if dAlpha12 == 180.0 {
                  gR[initialAngleIndex] = 16000.0 }  //  To get two lines
        
        else {
          /*  Determine if initial arc is CW  */
          
          if dAlpha12 < 180.0 {
            gIsCW[ gAngleIndex[gCurveNum] ] = true
            isCW = true
          }
          
          else {
            gIsCW[ gAngleIndex[gCurveNum] ] = false
            isCW = false
          }
          
          /*  Find start angle of initial arc  */
          if isCW {
            startAngle = -gAlphai[initialAngleIndex] }
            
          else
          {
            startAngle = 180.0 - gAlphai[initialAngleIndex]
            
            if startAngle < 0.0 {
              startAngle = startAngle + 360.0 }
          }
          
          gStartAngle[initialAngleIndex] = startAngle
          
          /*  Find a truncated alphai for finding arc angle of initial arc  */
          if isCW {
            alphaiT = -gStartAngle[initialAngleIndex] }
          
          else
          {
            alphaiT = 180.0 - gStartAngle[initialAngleIndex]
            
            if alphaiT < 0.0 {
              alphaiT = alphaiT + 360.0 }
          }
          
          /*  Find gXc, gYc, and gR for initial arc  */
          if gAlphai[initialAngleIndex] == 90.0 {
            d11 = 1000000.0 }
          
          else if gAlphai[initialAngleIndex] == 270.0 {
            d11 = -1000000.0 }
          
          else {
            d11 = tan(gDegToRad*gAlphai[initialAngleIndex]) }
          
          /*  We don't need d11Flag or d21Flag because we know gAlphai  */
          
          e = ( x1*x1 - y1*y1 + x2*x2 + y2*y2 - 2*x1*x2 + 2*d11*y1*(x1 - x2) )
          / ( d11*(x2 - x1) + y1 - y2 )
          d = -2*(x1 + d11*y1) - d11*e
          f = -x1*(d + x1) - y1*(e + y1)
          
          gXc[initialAngleIndex]   = -d/2
          gYc[initialAngleIndex]   = -e/2
          gR[initialAngleIndex]   = sqrt(d*d/4 + e*e/4 - f)
          
          r1Deg = 57.3*sqrt( (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) )
          
          if gR[initialAngleIndex] > r1Deg || gR[initialAngleIndex] > 14999.0
          {
            gXc[initialAngleIndex] = 0.0
            gYc[initialAngleIndex] = 0.0
            
            if fabs(dAlpha12 - 180.0) < 10.0 {
              gR[initialAngleIndex] = 16000.0 }  //  To get two lines
              
            else {
              gR[initialAngleIndex] = 15000.0}  //  To get one line
          }
        }
        
        /*  Find gAlphaf[initialAngleIndex] for initial arc  */
        
          if dAlpha12 == 0.0 || dAlpha12 == 180.0 {
            gAlphaf[initialAngleIndex] = gAlphai[initialAngleIndex] }
        
        else {
          d12Num    = -(2*x2 + d)
          d12Denom  = (2*y2 + e)
          
          if d12Denom == 0 && isCW {
            gAlphaf[initialAngleIndex] = 90.0 }
          
          else if d12Denom == 0 && !isCW {
            gAlphaf[initialAngleIndex] = 270.0 }
          
          else {
            d12 = d12Num/d12Denom
            if d12 > 0 {
              d12Flag = true }
            
            else {
              d12Flag = false }
            
            d22 = d12*(2*x2 + d) - 2*y2 - e
            
              if d22 > 0 {
                d22Flag = true }
            
            else {
              d22Flag = false }
            
            xRef = 1.0
            yRef = fabs(d12)
            
            gAlphaf[initialAngleIndex] = gRadToDeg*atan2(yRef, xRef)  /*  In range of 0.0 - 90.0  */
            
            if d12Flag {
              if d22Flag && !isCW || !d22Flag && isCW {
                gAlphaf[initialAngleIndex] = gAlphaf[initialAngleIndex] }
              
              else {
                gAlphaf[initialAngleIndex] = gAlphaf[initialAngleIndex] + 180.0 }
                
              }
                
              
            
            else
            {
              if (d22Flag && isCW) || (!d22Flag && !isCW) {
              gAlphaf[initialAngleIndex] = 180.0 - gAlphaf[initialAngleIndex] }
              
              else {
                gAlphaf[initialAngleIndex] = 360.0 - gAlphaf[initialAngleIndex] }
                
              }
            
            
            /*  Find arc angle for initial arc  */
            arcAngle = alphaiT - gAlphaf[initialAngleIndex]
            
          if isCW && arcAngle < 0 {
            arcAngle = arcAngle + 360.0 }
            
          if !isCW && arcAngle > 0 {
            arcAngle = arcAngle - 360.0 }
          }
        }
        
        gArcAngle[initialAngleIndex] = arcAngle
        
        
        /*   find parameters above initialAngleIndex   */
        for ( j = initialAngleIndex + 1;  j <= highAngleIndex;  j+= )
        {
          x1 = gX[j]
          x2 = gX[j + 1]
          y1 = gY[j]
          y2 = gY[j + 1]
          
          gAlphai[j] = gAlphaf[j - 1]
          
          alpha12 = gRadToDeg*atan2(y2 - y1, x2 - x1)
          
          if alpha12 < 0 {
            alpha12 = alpha12 + 360.0 }  /*  To get in range of 0 to 359  */
          
          dAlpha12 = gAlphai[j] - alpha12
          
          if dAlpha12 < 0.0 {
            dAlpha12 = dAlpha12 + 360.0 }  /*  To get in range of 0 to 359  */
          
          if dAlpha12 == 0.0 {
            gR[j] = 15000.0 }  /*  To get one line  */
          
          else if dAlpha12 == 180.0 {
            gR[j] = 16000.0 }  /*  To get two lines  */
          
          else {
            /*  Determine if arc is CW  */
            if dAlpha12 < 180.0 {
              gIsCW[j] = 1
              isCW = 1
            }
            
            else {
              gIsCW[j] = 0
              isCW = 0 }
            
            /*  Find start angle  */
            if isCW {
              startAngle = -gAlphai[j] }
            
            else {
              startAngle = 180.0 - gAlphai[j]
              if startAngle < 0.0 {
                startAngle = startAngle + 360.0 }
            }
            
            gStartAngle[j] = startAngle
            
            /*  Find a truncated alphai for finding arc angle  */
            if isCW {
              alphaiT = -gStartAngle[j] }
            
            else {
              alphaiT = 180.0 - gStartAngle[j]
              if alphaiT < 0.0 {
                alphaiT = alphaiT + 360.0 }
            }
            
            /*  Find gXc, gYc, and gR  */
            if gAlphai[j] == 90.0 {
              d11 = 1000000.0 }
            
            else if gAlphai[j] == 270.0 {
              d11 = -1000000.0}
            
            else {
              d11 = tan(gDegToRad*gAlphai[j]) }
            
            /*  We don't need d11Flag or d21Flag because we know gAlphai  */
            
            e = ( x1*x1 - y1*y1 + x2*x2 + y2*y2 - 2*x1*x2 + 2*d11*y1*(x1 - x2) )
            /( d11*(x2 - x1) + y1 - y2 )
            d = -2*(x1 + d11*y1) - d11*e
            f = -x1*(d + x1) - y1*(e + y1)
            
            gXc[j] = -d/2
            gYc[j] = -e/2
            gR[j] = sqrt(d*d/4 + e*e/4 - f)
            
            r1Deg = 57.3*sqrt( (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) )
            
            if gR[j] > r1Deg || gR[j] > 14999.0 {
              gXc[j] = 0.0
              gYc[j] = 0.0
              
              if fabs(dAlpha12 - 180.0) < 10.0 {
              gR[j] = 16000.0 }  /*  To get two lines  */
              
          else {
            gR[j] = 15000.0 }  /*  To get one line  */
            
          }
            
          }    //  End else
          
          /*  Find gAlphaf[ ]  */
          
          if dAlpha12 == 0.0 || dAlpha12 == 180.0 {
            gAlphaf[initialAngleIndex] = gAlphai[initialAngleIndex] }
          
          else {
            d12Num    = -(2*x2 + d)
            d12Denom  = (2*y2 + e)
            
            if d12Denom == 0.0 && isCW {
              gAlphaf[j] = 90.0 }
            
            else if d12Denom == 0 && !isCW {
              gAlphaf[j] = 270.0 }
            
            else {
              d12 = d12Num/d12Denom
            
            if d12 >= 0 {
              d12Flag = true }
            
            else {
              d12Flag = false }
              
              d22 = d12*(2*x2 + d) - 2*y2 - e
            
            if d22 > 0 {
              d22Flag = true }
            
            else {
              d22Flag = false }
              
              xRef = 1.0
              yRef = fabs(d12)
              
              gAlphaf[j] = gRadToDeg*atan2(yRef, xRef)  /*  In range of 0.0 - 90.0  */
              
              if d12Flag {
                if (d22Flag && !isCW) || (!d22Flag && isCW) {
                  
                gAlphaf[j] = gAlphaf[j] }
                
            else {
              gAlphaf[j] = gAlphaf[j] + 180.0 }
              }
              
              else {
                if (d22Flag && isCW) || (!d22Flag && !isCW) {
                    gAlphaf[j] = 180.0 - gAlphaf[j] }
                
                else {
                  gAlphaf[j] = 360.0 - gAlphaf[j] }
              }
              
              /*  Find arc angles  */
              arcAngle = alphaiT - gAlphaf[j]
              
              if isCW && arcAngle < 0 {
                  arcAngle = arcAngle + 360.0 }
              
              if !isCW && arcAngle > 0 {
                  arcAngle = arcAngle - 360.0 }
            }
          }
          
          gArcAngle[j] = arcAngle;
        }    //  End for j
        
        
        /*  Find parameters below initialAngleIndex. We need to work backwards  */
        if initialAngleIndex > 15*gCurveNum  /*  If we didn't start at beginning of curve  */
        {
          for ( k = initialAngleIndex - 1;  k >= 15*gCurveNum;  k-= )
          {
            x1 = gX[k];
            x2 = gX[k + 1];
            y1 = gY[k];
            y2 = gY[k + 1];
            
            gAlphaf[k] = gAlphai[k + 1];
            
            alpha12 = gRadToDeg*atan2(y2 - y1, x2 - x1);
            
            if alpha12 < 0 {
                alpha12 = alpha12 + 360.0 }  /*  To get in range of 0 to 359  */
            
            dAlpha12 = gAlphaf[k] - alpha12
            
            if dAlpha12 < 0.0 {
                dAlpha12 = dAlpha12 + 360.0 }  /*  To get in range of 0 to 359  */
            
            if dAlpha12 == 0.0 {
                gR[k] = 15000.0 }  /*  To get one line  */
            
            else if dAlpha12 == 180.0 {
                      gR[k] = 16000.0 }  /*  To get two lines  */
            
            else {
              /*  Determine if arc is CW  */
              if dAlpha12 > 180.0 {
                gIsCW[k] = 1
                isCW = 1
              }
              
              else {
                gIsCW[k] = 0
                isCW = 0
              }
              
              /*  Find gXc, gYc, and gR  */
              if gAlphaf[k] == 90.0 {
                  d12 = 1000000.0 }
              
              else if gAlphaf[k] == 270.0 {
                      d12 = -1000000.0 }
              
              else {
                d12 = tan(gDegToRad*gAlphaf[k]) }
              
              /*  We don't need d12Flag or d22Flag because we know alphaf  */
              
              e = ( -x1*x1 - y1*y1 - x2*x2 + y2*y2 + 2*x1*x2 + 2*d12*y2*(x1 - x2) )
              /( d12*(x2 - x1) + y1 - y2 )
              
              d = -2*(x2 + d12*y2) - d12*e
              
              f = -x1*(d + x1) - y1*(e + y1)
              
              gXc[k] = -d/2
              gYc[k] = -e/2
              gR[k] = sqrt(d*d/4 + e*e/4 - f)
              r1Deg = 57.3*sqrt( (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) )
              
              if gR[k] > r1Deg) || (gR[k] > 14999.0 {
                gXc[k] = 0.0
                gYc[k] = 0.0
                
                if fabs(dAlpha12 - 180.0) < 10.0 {
                    gR[k] = 16000.0 }  /*  To get two lines  */
                
                else {
                  gR[k] = 15000.0 }  /*  To get one line  */
              }
            }
            
            /*  Find gAlphai[ ]  */
            
            if (dAlpha12 == 0.0) || (dAlpha12 == 180.0) {
                gAlphaf[k] = gAlphai[k] }
            
            else {
              d11Num = -(2*x1 + d)
              d11Denom = (2*y1 + e)
              
              if d11Denom == 0 && isCW {
                  gAlphai[k] = 90.0 }
              
              else if d11Denom == 0 && !isCW {
                        gAlphai[k] = 270.0 }
              
              else {
                d11 = d11Num/d11Denom
                if d11 >= 0 {
                    d11Flag = true }
                    
                else {
                  d11Flag = false }
                
                d21 = d11*(2*x1 + d) - 2*y1 - e
                if d21 > 0 {
                    d21Flag = true }
                
                else {
                  d21Flag = false }
                
                xRef = 1.0
                yRef = fabs(d11)
                
                gAlphai[k] = gRadToDeg*atan2(yRef, xRef)  //  In range of 0.0 - 90.0
                
                if d11Flag {
                  if (d21Flag && !isCW) || (!d21Flag && isCW) {
                      gAlphai[k] = gAlphai[k] }
                  
                  else {
                    gAlphai[k] = gAlphai[k] + 180.0 }
                }
                
                else {
                  if (d21Flag && isCW) || (!d21Flag && !isCW) {
                      gAlphai[k] = 180.0 - gAlphai[k] }
                  
                  else {
                    gAlphai[k] = 360.0 - gAlphai[k] }
                }
              }
            }
            
            /*  Find start angle  */
            if isCW {
                startAngle = -gAlphai[k] }
            
            else {
              startAngle = 180.0 - gAlphai[k]
              
              if startAngle < 0.0 {
                  startAngle = startAngle + 360.0 }
            }
            
            gStartAngle[k] = startAngle
            
            /*  Find a truncated alphai for finding arc angle  */
            if isCW {
                alphaiT = -gStartAngle[k] }
            else {
              alphaiT = 180.0 - gStartAngle[k]
              
              if alphaiT < 0.0 {
                  alphaiT = alphaiT + 360 }
            }
            
            /*  Find arc angle  */
            arcAngle = alphaiT - gAlphaf[k]
            
            if isCW && arcAngle < 0 {
                arcAngle = arcAngle + 360.0 }
            
            if !isCW && arcAngle > 0 {
                arcAngle = arcAngle - 360.0 }
            
            gArcAngle[k] = arcAngle
          }    //  End for k
        }    //  End if
        
        /*  We don't change gAppleAngle  */
        
   /*     dummy = (gHighCurveNum + gHighDotNum[gCurveNum] + gR[initialAngleIndex]) 
        + gAngleFlag[gCurveNum] 
        + (gXc[initialAngleIndex] + gYc[initialAngleIndex] + gStartAngle[gCurveNum]) 
        + (gArcAngle[gCurveNum] + gX[initialAngleIndex] + gY[initialAngleIndex]) 
        + gAlphai[gCurveNum] 
        + (gCurveNum + gAppleAngle + gX[gCurveNum] + gY[gCurveNum] + x1 + x2 + y1 + y2 + d11 + eNum) 
        + (eDenom + e + d + f + isCW + d12 + d22 + gAlphaf[gCurveNum] + initialAngleIndex) 
        + (highAngleIndex + initialDotIndex + highDotIndex + gAngleIndex[gCurveNum]) 
        + (i + j + k) */
        
        return;
      }
      
      
      /***************************************************************
       ClearCurve                              
      **************************************************************
        
       This picks up the mouse click after Clear Curve is selected in the ArcDraw menu. We determine 
       the index number of the curve to delete. The click must be in a dot region and the angle must 
       be defined. We move curves down, as necessary, and decrement gHighCurveNum by one. We only 
       calculate arcs up thru gHighCurveNum, so anything higher in the arrays have no effect.
       */
 /*     VOID  ClearCurve(HWND  hWnd, HDC  hDC, LPARAM  lParam)
      {
        var        i: Int
        var        j: Int
        var        n: Int
        var      ptIsInARegion = false
        var        highDotNum: Int
        var        angleIndex: Int
        var nullDotLoc = CGPoint.zero
        HRegion      nullDotRegion    = {0};  //  = {0} only works when nullDotRegion is declared
        var testLocDot: CGPoint
        HRegion      testShapeDot;
        var      posnx: Double
        var      posny: Double
        
        posnx = LOWORD(lParam);
        posny = HIWORD(lParam);
        
        for ( i = 0;  i <= 299 && ptIsInARegion == false;  i+= )
        {
          if PtInRegion( gDotRegion[i], posnx, posny )
          {
            ptIsInARegion = true
            DecodeIndex(hWnd, hDC, i)    //  to get gCurveNum
          }
        }
        
        /*   if the point wasn't in any dot region, we can't do   */
        if !ptIsInARegion
        {
          MessageBox  (hWnd,
                       "Click is not in a dot region.",
                       "arcDraw",
                       MB_ICONEXCLAMATION | MB_OK)
          
          ReleaseDC(hWnd, hDC)
          
          return;
        }
        
        /*   if angle flag not set, we can't do   */
        else if !gAngleFlag[gCurveNum]
        {
          MessageBox  (hWnd,
                       "A direction isn't defined yet.",
                       "arcDraw",
                       MB_ICONEXCLAMATION | MB_OK)
          
          ReleaseDC(hWnd, hDC)
          
          return
        }
        
        else  /*  point is in a dot region  */
        {
          /*  for arrays with 301 members, move higher dots down, but  we can't reach 
           outside the bounds of the arrays or we will pull in garbage  */
          
          for ( i = 15*gCurveNum;  i <= 15*( gHighCurveNum - 1 ) + 14;  i+= )
          {
            gAlphai[i]       = gAlphai[i + 15]
            gAlphaf[i]       = gAlphaf[i + 15]
            gStartAngle[i]   = gStartAngle[i + 15]
            gArcAngle[i]     = gArcAngle[i + 15]
            gX[i]           = gX[i + 15]
            gY[i]           = gY[i + 15]
            gXc[i]           = gXc[i + 15]
            gYc[i]           = gYc[i + 15]
            gR[i]           = gR[i + 15]
            gDotLoc[i]       = gDotLoc[i + 15]
            gDotRegion[i]       = gDotRegion[i + 15]
            
            gIsCW[i]         = gIsCW[i + 15]
          }
          
          for ( j = 15*gHighCurveNum;  j <= 15*gHighCurveNum + 14;  j+= )
          {
            gAlphai[j]       = 0.0
            gAlphaf[j]       = 0.0
            gStartAngle[j]   = 0.0
            gArcAngle[j]     = 0.0
            gX[j]           = 0
            gY[j]           = 0
            gXc[j]           = 0.0
            gYc[j]           = 0.0
            gR[j]           = 0.0
            gDotLoc[j]       = nullDotLoc
            gDotRegion[j]       = nullDotRegion
          
            gIsCW[j]     = 0
          }
          
          /*   for arrays with 21 members, move higher dots down, but  we can't reach 
           outside the bounds of the arrays or we will pull in garbage   */
          for ( n = gCurveNum;  n <= ( gHighCurveNum - 1 );  n+= )
          {
            gAngleFlag[n]    = gAngleFlag[n + 1]        //  [21]
            gAngleIndex[n]  = gAngleIndex[n + 1] - 15  //  [21]
            gHighDotNum[n]  = gHighDotNum[n + 1]        //  [21]
          }
          
          gAngleFlag[gHighCurveNum]    = 0              //  [21]
          gAngleIndex[gHighCurveNum]  = 0;             //  [21]
          gHighDotNum[gHighCurveNum]  = -1              //  [21]
          
          gAngleClick       = 0
          gAddDotClick       = 0
          gCurveNum         = 0
          gOldDotLoc         = nullDotLoc
          gOldAppleAngle     = 0
          gAppleAngle       = 0
          gSecondAngleFlag   = false
          gUndoFlag         = false
          gDeleteDotIndex   = 0
          gDragDotIndex     = 0
          gAddDotIndex       = 0
          gOldAngleIndex     = 0
          
          
          gHighCurveNum -=;       //  since we got rid of a curve
          gHighCurveNumFlag = false; //  since we got rid of a curve
          
          redraw(hWnd, hDC)
        }
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       Cursive  
      **************************************************************
        
       This generates a picture of cursive handwriting.
       */
  /*    VOID  Cursive(HWND  hWnd, HDC hDC)
      {
        var        i: Int
        var        n: Int
        var        highCurveNum: Int
        var nullPoint = CGPoint.zero
        var anglePoint: CGPoint
        RECT      contentRect
        var        localIndex: Int
        
        var        newWidth: Int
        var        newHeight: Int
        
        var        numCurves = 13
        var        iAngle[13] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        var        appleAngle[13] = {200, 215, 62, 42, 30, 232, 224, 220, 219, 218, 
          217, 49, 31}
        var        numDots[13] = {4, 2, 4, 5, 5, 4, 3, 4, 8, 4, 6, 6, 3};
        var        x[58] = {91+50, 105+50, 122+50, 155+50,
          154+50, 80+50,  80+50, 146+50, 159+50, 128+50,  
          127+50, 157+50, 185+50, 199+50, 170+50,  240+50,
          231+50, 202+50, 207+50, 233+50,  
          233+50, 226+50, 236+50, 274+50,  274+50, 272+50,
          284+50,  284+50, 274+50, 283+50, 305+50,  
          304+50, 302+50, 314+50, 377+50, 373+50, 335+50,
          342+50, 369+50,  368+50, 358+50, 365+50, 407+50,   
          406+50, 363+50, 354+50, 426+50, 431+50, 420+50,
          419+50, 448+50, 460+50, 460+50, 464+50, 512+50,  
          338+50, 339+50, 338+50}
        var        y[58] = {13+83, 33+83, 34+83, 17+83,  16+83, 84+83,
          84+83, 30+83, 37+83, 88+83,  
          88+83, 59+83, 44+83, 58+83, 105+83,  76+83, 64+83,
          82+83, 93+83, 75+83,  
          75+83, 87+83, 96+83, 70+83,  71+83, 77+83, 78+83,  
          78+83, 88+83, 101+83, 86+83,  
          86+83, 100+83, 105+83, 62+83, 57+83, 96+83, 103+83, 
          82+83,  82+83, 95+83, 105+83, 79+83,  
          79+83, 132+83, 125+83, 85+83, 95+83, 105+83,  105+83, 
          89+83, 94+83, 102+83, 106+83, 71+83,  
          6+83, 7+83, 6+83}
        
        HPEN      hPen
        
        highCurveNum = gHighCurveNum
        
        /*  Initialize some of the globals  */
        gAngleClick = 0
        gAddDotClick = 0
        gOldDotLoc = nullPoint
        gOldAppleAngle = 0
        gAppleAngle = 0
        
        gSecondAngleFlag = false
        gSketchFlag = false
        gUndoFlag = false
        gHighCurveNumFlag = false
        
        gDotSelectIndex = 0
        gDeleteDotIndex = 0
        gDragDotIndex = 0
        gAddDotIndex = 0
        gOldAngleIndex = 0
        
        for ( n = 0; n <= highCurveNum; n+= )
        {
          gHighDotNum[n] = -1
          gAngleFlag[n] = false
          gAngleIndex[n] = 0
        }
        
        for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
        {
          gX[i] = 0
          gY[i] = 0
          gAlphai[i] = 0.0
          gAlphaf[i] = 0.0
          gStartAngle[i] = 0
          gArcAngle[i] = 0
          gXc[i] = 0.0
          gYc[i] = 0.0
          gR[i] = 0.0
          gDotLoc[i] = nullPoint
          
          gIsCW[i] = 0
        }
        
        gMenuItem     = IDM_CURSIVE
        gLastMenuItem   = IDM_CURSIVE
        
        gHighCurveNum   = -1
        gCurveNum     = 0;
      
        localIndex = 0
        /*  End initialize some of the globals  */
        
        redraw(hWnd, hDC)
        
        for ( n = 0;  n <= numCurves - 1;  n+= )
        {
          gHighCurveNum   = n
          gCurveNum     = gHighCurveNum
          gAngleIndex[n]   = 15*n + iAngle[n]
          
          for ( i = 0;  i <= numDots[n] - 1;  i+= )
          {
            gDotLoc[15*n + i].x = x[localIndex]
            gDotLoc[15*n + i].y = y[localIndex]
            gHighDotNum[n]   = i
            localIndex+=
            drawDot(hWnd, hDC, 15*n + i)
            dotAsRegion(15*n + i)
            Sleep(500)
          }
          
          drawLargeDot(15*n + iAngle[n])
          Sleep(1000)
          
          gAppleAngle   = appleAngle[n]
          gAngleFlag[n]   = true
          
          /*  Draw angle line  */
          anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x + 
          36*cos( gDegToRad*(90 - gAppleAngle) )
          anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y - 
          36*sin( gDegToRad*(90 - gAppleAngle) )
          
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          
          Sleep(1000)
          EraseLargeDot( hWnd, hDC, 15*n + iAngle[n] )
          
          /*  Erase angle line  */
          hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // Erase lines
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen
          
          calcArcs()
          EraseLines(hWnd, hDC)
          DrawCurve(hWnd, hDC)
          Sleep(1000)
        }
        
        redraw(hWnd, hDC)
        
        Sleep(1000)
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      /***************************************************************
       DecodeIndex                           
      **************************************************************
        
       Decode index to find curve number.
       
       Requires: nothing
       Receives: index number
       Changes: curve number
       Returns: nothing
       */
  /*    VOID  DecodeIndex(HWND  hWnd, HDC  hDC, int  index)
      {
        var      n: Int
        var      test: Int
        var    testIsNeg = false
        
        test = index
        
        for ( n = 0;  n <= 19 && testIsNeg == false;  n+= )
        {
          test = test - 15  //  15 dots per curve
          
          if test < 0
          {
            testIsNeg = true
            gCurveNum = n
          }
        }
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      /***************************************************************
       defineDirection                           
      **************************************************************
        
       This picks up the mouse clicks after Define Direction is selected in the 
       ArcDraw menu. (The first click must be in a dot region and the second 
       click can be a drag.) We determine gAngleIndex[gCurveNum] of the dot we will 
       use to define the direction.
       
       When drawing and moving arcDraw curves we deal in Windows coordinates.
       
       Changes: loads points in global array
       */
 /*     func defineDirection(HWND  hWnd, HDC  hDC, LPARAM  lParam)
      {
        var      i: Int
        RECT    rectDot;
        var      dotRadius = 4
        var      angle: Int
        var    ptIsInARegion = false
        var defPoint: CGPoint
        var      angleIndex: Int
        var    posnx: Double
        var    posny: Double
        var    dx: Double
        var    dy: Double
        var      t: Int
        HPEN    hPen;
        
        posnx = LOWORD(lParam);
        posny = HIWORD(lParam);
        
        //  First click
        if gAngleClick == 1
        {
          for ( i = gDotSelectIndex; i <= 299 && ptIsInARegion == false; i+= )
          {
            if PtInRegion( gDotRegion[i], posnx, posny )
            {
              ptIsInARegion = true
              drawLargeDot(hWnd, hDC, i)
              DecodeIndex(ii)    //   to set gCurveNum
              
              if gAngleFlag[gCurveNum] {
                  gOldAngleIndex = gAngleIndex[gCurveNum] }
              
              gAngleIndex[gCurveNum] = i
            }
          }
          
          /*   if the point wasn't in any dot region, we can't do   */
          if ptIsInARegion == false
          {
            gAngleClick = 0
            MessageBox  (hWnd,
                         "Click is not in a dot region.",
                         "arcDraw",
                         MB_ICONEXCLAMATION | MB_OK)
            
            ReleaseDC(hWnd, hDC)
            return
          }
          
          if gAngleFlag[gCurveNum]
          {
            gOldAppleAngle  = 90 - gAlphai[gOldAngleIndex]
            
            if gOldAppleAngle < 0 {
                gOldAppleAngle = gOldAppleAngle + 360 }
          }
          
          ReleaseDC(hWnd, hDC)
          return
        }  //  End if first click
        
        
        //  second click or drag
        if gAngleClick > 1
        {
          angleIndex  = gAngleIndex[gCurveNum]
          
          //  dot from which we will define angle, in Windows coordinates
          defPoint    = gDotLoc[angleIndex]    
          
          /*   don't allow the two points defining the angle to be closer than 10   */
          if abs(posnx - defPoint.x) > 10 || abs(posny - defPoint.y) > 10
          {
            MoveToEx(hDC, defPoint.x, defPoint.y, NULL);
            LineTo(hDC, posnx, posny)  //to show the drection line
            
            //  Put in a time delay so we can see the direction line
            Sleep(100)
            
            /*  define the direction angle   */
            /*  angle is integer, 0.0 to 360.0, CW from straight up  */
            
            dx = posnx - defPoint.x    //  in Windows coordinates
            dy = posny - defPoint.y    //  in Windows coordinates
            
            angle = gRadToDeg*( atan2( dy, dx) )
            angle = angle + 90.0    // CW from 12 o'clock
            
            if(angle < 0)
                angle = angle + 360.0
            
            gAppleAngle = angle
            
            calcArcs()
            LineTo(hDC, posnx, posny)
            
          }    // End if ( Dots not too close )
          
          else    //  The dots were too close together, maybe by accident
          {
            gAngleClick = 2    //  back to WndProc and try again
            
            ReleaseDC(hWnd, hDC)
            
            return
          }
          
          gSecondAngleFlag = gAngleFlag[gCurveNum]
          gAngleFlag[gCurveNum] = 1
          
        }    //  End if
        
        
        if gMouseDown == false
        {
          
          gAngleClick      = 0  //  defined angle, ready for next time
          gUndoFlag        = true  //  defined an angle, so we can undo one, unless it's the first time
          gLastMenuItem    = IDM_DEFINEDIRECTION
          
        }
        
        redraw(hWnd, hDC)
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       defineSketchCurve                           
      **************************************************************
        
       This picks up the mouse movement after New Sketch Curve is selected in the ArcDraw 
       menu and we click in the content region of our window. We set the positions for 
       the dots of a curve.
       
       The curve number must have been defined somewhere in order to get here, normally in 
       NewSketchCurve.
       
       When drawing and moving arcDraw curves we deal in Windows coordinates.
       
       Changes: loads dots in global array
       */
  /*    VOID  defineSketchCurve (HWND  hWnd, HDC  hDC, LPARAM  lParam)
      {
        var firstPoint: CGPoint
        var        x1: Int
        var        x3: Int
        var        y1: Int
        var        y3: Int
  //      var        dummy: Int
        var        i: Int
        
        var      posnx: Double
        var      posny: Double
        var posn: CGPoint
        
        posnx   = LOWORD(lParam)
        posny   = HIWORD(lParam)
        
        posn.x  =  posnx
        posn.y  =  posny
        
        
        /*  For first dot  */
        if gSketchClick == 1
        {
          firstPoint   = posn
          gArcLength   = 0
          gEnergyFlag = false
          
          defineSketchDot(hWnd, hDC, firstPoint)  //  Define first Sketch Dot
          MoveToEx (hDC, firstPoint.x, firstPoint.y, NULL)
          gLastMouse = firstPoint
          ReleaseDC(hWnd, hDC)
          return
        }
        
        /*  For later dots  */
        if gMouseDown == true && gSketchClick > 1 && gEnergyFlag == false
        {
          if posn.x != gLastMouse.x || posn.y != gLastMouse.y
          {
            LineTo(hDC, posnx, posny)
            gArcLength = gArcLength + sqrt 
            ( (posn.x - gLastMouse.x)*(posn.x - gLastMouse.x)
              + (posn.y - gLastMouse.y)*(posn.y - gLastMouse.y) )
            gLastMouse = posn
            
            if (gArcLength >= 40) && (gAngleFlag2 == false)  //  Minimum length of curve
            {
              gAnglePoint2 = posn
              gAngleFlag2 = true
            }
            
            if gArcLength >= 80
            {
              if gHighDotNum[gCurveNum] < 13    //  Define Sketch Dots
              {
                gHighDotNum[gCurveNum] +=
                defineSketchDot(hWnd, hDC, gLastMouse)  // Calls DrawSketchDot
              }
              gArcLength = 0
            }
            
          }  //End if (unequal positions)
          
          ReleaseDC(hWnd, hDC)
          return
          
        }  //  End if(gMouseDown == true)
        
        if gAngleFlag2 == true && gEnergyFlag == false
        {
          /*   Define last sketch dot if gArcLength is great enough    */
          if gArcLength >= 60
          {
            gHighDotNum[gCurveNum] +=
            defineSketchDot(hWnd, hDC, posn)
          }
          
          x1 = gDotLoc[15*gCurveNum].x
          x3 = gAnglePoint2.x
          
          y1 = -gDotLoc[15*gCurveNum].y
          y3 = -gAnglePoint2.y
          
          gAlpha1 = gRadToDeg*atan2(y3 - y1, x3 - x1)
          
          if gAlpha1 < 0.0 {
              gAlpha1 = gAlpha1 + 360.0 }  //  To get initially in range of 0.0 to 360.0
          
          gAppleAngle = 90.0 - gAlpha1
          
          if gAppleAngle < 0 {
              gAppleAngle = gAppleAngle + 360.0 }
          
          gSecondAngleFlag = false
          gAngleFlag[gCurveNum] = true
          gAngleIndex[gCurveNum] = 15*gCurveNum
          
          calcArcs()
          
          //  First, find gUt0 with original gAppleAngle
          gUt0 = 0.0
          for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
          {
            gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
            gUt0 = gUt0 + gU[i]
          }
          
          //  Then, find gUt1 with smaller gAppleAngle
          gAlpha1 = gAlpha1 + 1
          
          gAppleAngle = 90.0 - gAlpha1
          
          if gAppleAngle < 0 {
              gAppleAngle = gAppleAngle + 360.0 }
          
          calcArcs()
        
          gUt1 = 0.0
          for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
          {
            gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
            gUt1 = gUt1 + gU[i]
          }
          
          //  Then, find gUt2 with larger gAppleAngle
          gAlpha1 = gAlpha1 - 2
          
          gAppleAngle = 90.0 - gAlpha1
          
          if gAppleAngle < 0.0 {
              gAppleAngle = gAppleAngle + 360.0 }
          
          calcArcs()
          
          gUt2 = 0.0
          for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
          {
            gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
            gUt2 = gUt2 + gU[i]
          }
          
        }    //  End if (angleFlag2)
        
        else if gEnergyFlag == false
        {
          gHighDotNum[gCurveNum] = -1
          MessageBox  (hWnd,
                       "Curve is too short.",
                       "arcDraw",
                       MB_ICONEXCLAMATION | MB_OK)
          
          ReleaseDC(hWnd, hDC)
          return
        }
        
        // Now iterate to minimize energy in the curve
        // We have one less arc than points in the curve
        
        if gUt0 < gUt1 && gUt0 < gUt2 {  //  Must reduce gAppleAngle by 1 degree
            gAlpha1 = gAlpha1 + 1 }
        
        else if gUt1 < gUt0  //  Must reduce gAppleAngle by 2 degrees
        {
          gAlpha1 = gAlpha1 + 2  //  To get gAppleAngle back to where it was for gUt1
          
          while gUt1 < gUt0
          {
            gUt0 = gUt1
            
            gAlpha1 = gAlpha1 + 1
            
            gAppleAngle = 90.0 - gAlpha1
            
            if gAppleAngle < 0 {
                gAppleAngle = gAppleAngle + 360.0 }
            
            calcArcs()
            
            gUt1 = 0.0
            for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
            {
              gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
              gUt1 = gUt1 + gU[i]
            }
            
          }  //  end while
          
          gAlpha1 = gAlpha1 - 1
          
        }  //  End else if
        
        else  //  gAppleAngle OK as is
        {
          while gUt2 < gUt0
          {
            gUt0 = gUt2
            
            gAlpha1 = gAlpha1 - 1
            
            gAppleAngle = 90.0 - gAlpha1
            
            if gAppleAngle < 0 {
                gAppleAngle = gAppleAngle + 360.0 }
            
            calcArcs()
            
            gUt2 = 0.0
            for ( i = 0;  i <= gHighDotNum[gCurveNum] - 1;  i+= )
            {
              gU[i] = abs( gArcAngle[i + 15*gCurveNum] )/gR[i + 15*gCurveNum]
              gUt2 = gUt2 + gU[i]
            }
          }  //  End while
          
          gAlpha1 = gAlpha1 + 1
          
        }  //  End else
        
        gAppleAngle = 90.0 - gAlpha1
        
        if gAppleAngle < 0 {
            gAppleAngle = gAppleAngle + 360.0 }
        
        calcArcs()
        redraw(hWnd, hDC)
        gEnergyFlag = true
        
  //      dummy = x1 + x3 + y1 + y3 + gMenuItem + gAlpha1 + i
        
        gLastMenuItem  = IDM_NEWSKETCHCURVE
        
        gAngleFlag[gHighCurveNum] = true
        gDotSelectIndex            = 0
        gSketchClick              = 1
        gAngleFlag2               = false
        
        
        if gHighCurveNum < 19  //  gHighCurveNum starts at -1
        {
          gHighCurveNum +=
          gCurveNum    = gHighCurveNum
          gMenuItem    = IDM_NEWSKETCHCURVE
          gSketchFlag = true
          
        }
        
        else {
          gHighCurveNumFlag = true }
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       defineSketchDot                          *
      **************************************************************
        
       This picks up the mouse positions in defineSketchCurve. We set the positions 
       for the dots of a curve.
       
       The curve number must have been defined somewhere in order to get here.
       
       When drawing and moving arcDraw curves we deal in Windows coordinates.
       
       Changes: loads dots in global array
       */
 /*     VOID  defineSketchDot(HWND  hWnd, HDC  hDC, CGPoint  posn)
      {
        var      dotIndex: Int
        
        /*   gHighDotNum[ ] was incremented before coming here, possibly from -1   */
        dotIndex  = 15*gCurveNum + gHighDotNum[gCurveNum]
        
        gDotLoc[dotIndex] = posn
        DrawSketchDot(hWnd, hDC)
        dotAsRegion (dotIndex)
        
        gLastMenuItem  = IDM_NEWSKETCHCURVE
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       DeleteDot                              
      ***************************************************************
        
       This picks up the mouse click after Delete Dot is selected in the ArcDraw menu. We determine 
       gAddDotIndex of the dot to delete and move the higher dots of this curve down one step. 
       We can't delete the dot the angle was defined from.
       */
  /*    VOID  DeleteDot(HWND  hWnd, HDC  hDC, LPARAM  lParam)
      {
        var      i: Int
        var    ptIsInARegion = false
        var      highDotNum: Int
        var      angleIndex: Int
        var      dotIndex: Int
        var    posnx: Double
        var    posny: Double
        
        posnx = LOWORD(lParam)
        posny = HIWORD(lParam)
        
        for ( i = gDotSelectIndex; i <= 299 && ptIsInARegion == false; i+= )
        {
          if PtInRegion( gDotRegion[i], posnx, posny )
          {
            ptIsInARegion     = true
            DecodeIndex(hWnd, hDC, i)          //   to get gCurveNum
            angleIndex       = gAngleIndex[gCurveNum]
            gDeleteDotIndex   = i
          }
        }
        
        /*   if the point wasn't in any dot region, we can't do   */
        if !ptIsInARegion
        {
          MessageBox  (hWnd,
                       "Click is not in a dot region.",
                       "arcDraw",
                       MB_ICONEXCLAMATION | MB_OK)
          
          ReleaseDC(hWnd, hDC)
          
          return
        }
        
        /*   if angle flag not set, we can't do   */
        if !gAngleFlag[gCurveNum]
        {
          MessageBox  (hWnd,
                       "A direction isn't defined yet.",
                       "arcDraw",
                       MB_ICONEXCLAMATION | MB_OK)
          
          ReleaseDC(hWnd, hDC)
          
          return
        }
        
        /*   if dot is reference for angle, we can't do   */
        angleIndex = gAngleIndex[gCurveNum]
        if gDeleteDotIndex == angleIndex
        {
          MessageBox  (hWnd,
                       "The dot is a direction reference.",
                       "arcDraw",
                       MB_ICONEXCLAMATION | MB_OK)
          
          ReleaseDC(hWnd, hDC)
          
          return
        }
        
        else
        {
          highDotNum  = gHighDotNum[gCurveNum]
          
          /*   save dot in case we want to Undo   */
          gOldDotLoc = gDotLoc[gDeleteDotIndex]
          
          /*   move higher dots down   */
          for ( i = gDeleteDotIndex; i <= 15*gCurveNum + highDotNum - 1; i+= )
          {
            gAlphai[i]  = gAlphai[i + 1]
            gDotLoc[i]  = gDotLoc[i + 1]
            gDotRegion[i]  = gDotRegion[i + 1]
          }
          
          dotIndex           = 15*gCurveNum + highDotNum
          gAlphai[dotIndex]  = 0
          gDotRegion[dotIndex]  = 0
          
          if angleIndex > gDeleteDotIndex
          {
            gAngleIndex[gCurveNum] -=
            angleIndex -=
          }
          
          gHighDotNum[gCurveNum] -=
          
          gAppleAngle = 90 - gAlphai[angleIndex]
          
          if gAppleAngle < 0.0 {
              gAppleAngle = gAppleAngle + 360.0 }
          
          
          calcArcs()
        }
        
        gUndoFlag = true    //   deleted a dot, so we can undo one
        redraw(hWnd, hDC)
        ReleaseDC(hWnd, hDC)
        return
        
      } */
      
      
      /***************************************************************
       DragDot                              
      **************************************************************
        
       Handle dragging of dots the old-fashioned way. Animate dots by erasing old location and 
       redrawing in new location.
       */
 /*     VOID  DragDot(HWND  hWnd, HDC  hDC, LPARAM  lParam)
      {
        int      i: Int
        var    posnx: Double
        var    posny: Double
        var posn: CGPoint
        
  //      var      dummy: Int
        
        posnx   = LOWORD(lParam)
        posny   = HIWORD(lParam)
        
        posn.x  =  posnx
        posn.y  =  posny
        
        if  gDragFlag == false
        {
          
          for ( i = gDotSelectIndex; i <= 299 && gPtIsInARegion == false; i+= )
          {
            if PtInRegion( gDotRegion[i], posnx, posny )
            {
              gPtIsInARegion = true
              DecodeIndex(hWnd, hDC, i)  //   sets gCurveNum
            }
            
            if gPtIsInARegion && gAngleFlag[gCurveNum] {
                gDragDotIndex = i }
          }
          
          /*  point not in a region  */
          if gPtIsInARegion != true
          {
            MessageBox  (hWnd,
                         "Click is not in a dot region.",
                         "arcDraw",
                         MB_ICONEXCLAMATION | MB_OK)
            
            ReleaseDC(hWnd, hDC)
            return
          }
          
          /*  Angle flag not set  */
          if !gAngleFlag[gCurveNum]
          {
            MessageBox  (hWnd,
                         "A direction isn't defined yet.",
                         "arcDraw",
                         MB_ICONEXCLAMATION | MB_OK)
            
            ReleaseDC(hWnd, hDC)
            return
          }
          
          gOldDotLoc   = gDotLoc[gDragDotIndex]
          gDragFlag   = true
          
        }    //  End if gDragFlag is false
        
        
        gDotLoc[gDragDotIndex] = posn
        
        gAppleAngle = 90.0 - gAlphai[gAngleIndex[gCurveNum]]
        
        if (gAppleAngle < 0.0) {
            gAppleAngle = gAppleAngle + 360.0 }
        
        calcArcs()
        
        /*    define moved dot as region     */
        dotAsRegion (gDragDotIndex)
        
        gUndoFlag = true  // dragged a dot, so we can undo one
        
   //     dummy = gMenuItem + gLastMenuItem + gDragDotIndex
        
        redraw(hWnd, hDC)
        ReleaseDC(hWnd, hDC)
        return
      } */
      
      
      /***************************************************************
       drawCurve                             
      **************************************************************
      / 
       Handle drawing of arcs for one curve.
       
       */
 /*     VOID  drawCurve(HWND  hWnd, HDC hDC)
      {
        var      xL: Int
        var      yT: Int
        var      xR: Int
        var      yB: Int
        var      i: Int
        var      j: Int
        var      n: Int
        RECT    rectDot
        var      dotRadius = 3
        var      x1: Int
        var      x2: Int
        var      y1: Int
        var      y2: Int
        var      dummy: Int
        var  alpha12: Double
        var      x3: Int
        var      x4: Int
        var      y3: Int
        var      y4: Int
        var      r: Int
        
        HBRUSH   hBrush = SelectObject(hDC, GetStockObject(LTGRAY_BRUSH)) // To paint dots light gray
        
        n = gCurveNum
        r = 2000
        
        /*  draw lines and arcs  */
        for ( i = 15*n;  i < 15*n + gHighDotNum[n];  i+= )
        {
          /*  x's and y's in Windows coordinates  */
          /*  gDotLoc[]'s in Windows coordinates  */
          x1 = gDotLoc[i].x
          x2 = gDotLoc[i + 1].x
          y1 = gDotLoc[i].y
          y2 = gDotLoc[i + 1].y
          
          if fabs(gR[i] - 15000.0) <= 0.001 || fabs(gR[i] - 16000.0) <= 0.001
          {
            alpha12 = gRadToDeg*atan2(-(y2 - y1), x2 - x1)  //  Since we need normal coordinates
            
            if alpha12 < 0.0 {
                alpha12 = alpha12 + 360.0 }  //  To get in range of 0 to 359
            
            if fabs(gR[i] - 15000.0) <= 0.001
            {
              MoveToEx(hDC, x1, y1, NULL)  //  x's and y's in Windows coordinates
              LineTo(hDC, x2, y2)          //  x's and y's in Windows coordinates
            }
            
            else
            {
              x3 = x1 - r*cos(gDegToRad*alpha12)  // Windows coordinates
              x4 = x2 + r*cos(gDegToRad*alpha12)  // Windows coordinates
              y3 = y1 - r*sin(gDegToRad*alpha12)  // Windows coordinates
              y4 = y2 + r*sin(gDegToRad*alpha12)  // Windows coordinates
              
              MoveToEx(hDC, x1, y1, NULL)        // Windows coordinates
              LineTo(hDC, x3, y3)                // Windows coordinates
              
              MoveToEx(hDC, x2, y2, NULL)        // Windows coordinates
              LineTo(hDC, x4, y4)                // Windows coordinates
            }
          }
          
          else
          {
            /*  draw the arc  */
            xL   = RoundToInt(gXc[i] - gR[i])
            yT   = RoundToInt(-gYc[i] - gR[i])
            xR   = RoundToInt(gXc[i] + gR[i])
            yB   = RoundToInt(-gYc[i] + gR[i])
            
            if gIsCW[i] == 0 {
                Arc(hDC, xL, yT, xR, yB, x1, y1, x2, y2) }  // "forwards" if CCW
            
            else {
              Arc(hDC, xL, yT, xR, yB, x2, y2, x1, y1) }  //  "backwards" if CW
          }
          
        }    //  End of for i
        
        
        /* draw the dots in gray */
        /*  we have one more dot than we have arcs in a curve   */
        for ( j = 15*n;  j <= 15*n + gHighDotNum[n];  j+= )  
        {
          rectDot.left     = gDotLoc[i].x - dotRadius
          rectDot.top     = gDotLoc[i].y - dotRadius
          rectDot.right   = gDotLoc[i].x + dotRadius
          rectDot.bottom   = gDotLoc[i].y + dotRadius
          
          Ellipse( hDC, rectDot.left, rectDot.top, rectDot.right, rectDot.bottom )
        }  //  End of for j
        
  //      dummy = x1+x2+y1+y2+xL+yT+xR+yB+n+r+i+j
        
        hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH)) // Return to normal brush
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /****************************************************************/
      /* drawLargeDot                         */ 
      /****************************************************************/
      /*  
       Handle drawing of large dot.
       
       Receives: pointer to window containing curve and index of dot
       Changes: increases size of dot and makes it black
       */
      func drawLargeDot(dotIndex: Int)
      {
        var dotRadius: CGFloat = 5.0

        // Set fill color
        context.setFillColor(NSColor.black.cgColor)
        
        // Create a circle path
        let circlePath = NSBezierPath(ovalIn: NSRect(x: gDotLoc[dotIndex].x - dotRadius,
                                                     y: gDotLoc[dotIndex].x + dotRadius, 
                                                     width: 2*dotRadius,
                                                     height: 2*dotRadius))
      
        // Fill the circle
        circlePath.fill()
        
        hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH)) // Return to normal brush
        
        ReleaseDC(hWnd, hDC)
        
        return
      }  
      
      
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
      
      
      /***************************************************************
       EraseCurve                              
      **************************************************************
        
       Handle erasing of arcs for one curve.*/
       
 /*     VOID  EraseCurve(HWND  hWnd, HDC hDC)
      {
        
        var      xL: Int
        var      yT: Int
        var      xR: Int
        var      yB: Int
        var      i: Int
        var      j: Int
        var      n: Int
        RECT    rectDot;
        var      dotRadius = 3
        var      x1: Int
        var      x2: Int
        var      y1: Int
        var      y2: Int
   //     var      dummy: Int
        var  alpha12: Double
        var      x3: Int
        var      x4: Int
        var      y3: Int
        var      y4: Int
        var      r: Int
        
        HPEN    hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
        
        n = gCurveNum
        r = 2000
        
        /*  erase lines and arcs  */
        for ( i = 15*n;  i < 15*n + gHighDotNum[n];  i+= )
        {
          /*  x's and y's in Windows coordinates  */
          x1 = gDotLoc[i].x
          x2 = gDotLoc[i + 1].x
          y1 = gDotLoc[i].y
          y2 = gDotLoc[i + 1].y
          
          if fabs(gR[i] - 15000.0) <= 0.001 || fabs(gR[i] - 16000.0) <= 0.001
          {
            alpha12 = gRadToDeg*atan2(-(y2 - y1), x2 - x1)  //  Since we need normal coordinates
            
            if alpha12 < 0.0 {
                alpha12 = alpha12 + 360.0 }  /*  To get in range of 0 to 359  */
            
            if ( fabs(gR[i] - 15000.0) <= 0.001) 
            {
              MoveToEx(hDC, x1, y1, NULL)        // Windows coordinates
              LineTo(hDC, x2, y2)                // Windows coordinates
            }
            
            else
            {
              x3 = x1 - r*cos(gDegToRad*alpha12)  // Windows coordinates
              x4 = x2 + r*cos(gDegToRad*alpha12)  // Windows coordinates
              y3 = y1 - r*sin(gDegToRad*alpha12)  // Windows coordinates
              y4 = y2 + r*sin(gDegToRad*alpha12)  // Windows coordinates
              
              MoveToEx(hDC, x1, y1, NULL)        // Windows coordinates
              LineTo(hDC, x3, y3)                // Windows coordinates
              
              MoveToEx(hDC, x2, y2, NULL)        // Windows coordinates
              LineTo(hDC, x4, y4)                // Windows coordinates
            }
          }
          
          else
          {
            /*  erase the arc  */
            xL   = RoundToInt(gXc[i] - gR[i])
            yT   = RoundToInt(-gYc[i] - gR[i])
            xR   = RoundToInt(gXc[i] + gR[i])
            yB   = RoundToInt(-gYc[i] + gR[i])
            
            if gIsCW[i] == 0 {
                Arc(hDC, xL, yT, xR, yB, x1, y1, x2, y2) }  // "forwards" if CCW
            
            else {
              Arc(hDC, xL, yT, xR, yB, x2, y2, x1, y1) }  //  "backwards" if CW
          }
          
        }    //  End of for i
        
        /*  erase the gray dots  */
        /*  we have one more dot than we have arcs in a curve  */
        for ( j = 15*n;  j <= 15*n + gHighDotNum[n];  j+= )  
        {
          rectDot.left     = gDotLoc[i].x - dotRadius
          rectDot.top     = gDotLoc[i].y - dotRadius
          rectDot.right   = gDotLoc[i].x + dotRadius
          rectDot.bottom   = gDotLoc[i].y + dotRadius
          
          Ellipse( hDC, rectDot.left, rectDot.top, rectDot.right, rectDot.bottom )
        }  //  End of for j
        
    //    dummy = x1+x2+y1+y2+xL+yT+xR+yB+n+r+i+j
        
        hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Return to normal pen
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
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
      
      
      /***************************************************************
       Hearts   
      **************************************************************
        
       This generates a picture of various hearts.
       */
 /*     VOID  Hearts(HWND  hWnd, HDC hDC)
      {
        var        i: Int
        var        n: Int
        var        highCurveNum: Int
        var nullPoint = CGPoint.zero
        var anglePoint: CGPoint
        RECT      contentRect
        var        localIndex: Int
        
        var        numCurves = 8
        var        iAngle[8] = {0, 1, 0, 1, 0, 1, 0, 1};
        var        appleAngle[8] = {20.0, 164.0, 45.0, 133.0, 20.0, 200.0, 7.0, 170.0};
        var        numDots[8] = {3, 3, 3, 3, 4, 4, 4, 4};
        var        x[28] = {90+83, 155+83, 90+83,   90+83, 25+83, 90+83, 
          270+83, 320+83, 270+83,   270+83, 220+83, 270+83, 
          90+83, 162+83, 133+83, 90+83,   90+83, 18+83, 47+83, 90+83, 
          270+83, 336+83, 316+83, 291+83,   270+83, 207+83, 230+83, 291+83};
        var        y[28] = {80, 101, 194,   80, 101, 194, 
          80, 132, 194,   80, 132, 194, 
          332, 332, 415, 446,   332, 332, 415, 446, 
          332, 325, 397, 446,   332, 353, 405, 446};
        
        HPEN      hPen
        
        highCurveNum = gHighCurveNum
        
        /*  Initialize some of the globals  */
        gAngleClick       = 0
        gAddDotClick       = 0
        gOldDotLoc         = nullPoint
        gOldAppleAngle     = 0
        gAppleAngle       = 0
        
        gSecondAngleFlag   = false
        gSketchFlag       = false
        gUndoFlag         = false
        gHighCurveNumFlag = false
        
        gDotSelectIndex   = 0
        gDeleteDotIndex   = 0
        gDragDotIndex     = 0
        gAddDotIndex       = 0
        gOldAngleIndex     = 0
        
        for ( n = 0; n <= highCurveNum; n+= )
        {
          gHighDotNum[n]   = -1
          gAngleFlag[n]   = false
          gAngleIndex[n]   = 0
        }
        
        for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
        {
          gX[i]           = 0
          gY[i]           = 0
          gAlphai[i]       = 0.0
          gAlphaf[i]       = 0.0
          gStartAngle[i]  = 0
          gArcAngle[i]     = 0
          gXc[i]           = 0.0
          gYc[i]           = 0.0
          gR[i]           = 0.0
          gDotLoc[i]       = nullPoint
          
          gIsCW[i]         = 0
        }
        
        gMenuItem       = IDM_HEARTS
        gLastMenuItem   = IDM_HEARTS
        
        gHighCurveNum   = -1
        gCurveNum       = 0
        
        localIndex       = 0
        /*  End initialize some of the globals  */
        
        redraw(hWnd, hDC)
        
        for ( n = 0;  n <= numCurves - 1;  n+= )
        {
          gHighCurveNum   = n
          gCurveNum     = gHighCurveNum
          gAngleIndex[n]   = 15*n + iAngle[n]
          
          for ( i = 0;  i <= numDots[n] - 1;  i+= )
          {
            gDotLoc[15*n + i].x = x[localIndex]
            gDotLoc[15*n + i].y = y[localIndex]
            gHighDotNum[n]   = i
            localIndex +=
            drawDot(hWnd, hDC, 15*n + i)
            dotAsRegion(15*n + i)
            Sleep(500)
          }
          
          drawLargeDot(15*n + iAngle[n])
          Sleep(1000)
          
          gAppleAngle   = appleAngle[n]
          gAngleFlag[n]   = true
          
          /*  Draw angle line  */
          anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x + 
          36*cos( gDegToRad*(90 - gAppleAngle) )
          anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y - 
          36*sin( gDegToRad*(90 - gAppleAngle) )
          
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          
          Sleep(1000)
          EraseLargeDot(hWnd, hDC, 15*n + iAngle[n] )
          
          /*  Erase angle line  */
          hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // Erase lines
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          
          hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen
          
          
          calcArcs()
          EraseLines(hWnd, hDC)
          DrawCurve(hWnd, hDC)
          Sleep(1000)
        }
        
        redraw(hWnd, hDC)
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       Moons   
      **************************************************************
        
       This generates a picture of various phases of the moon.
       */
  /*    VOID  Moons(HWND  hWnd, HDC hDC)
      {
        
        var        i: Int;
        var        n: Int
        var        highCurveNum: Int
        var nullPoint = CGPoint.zero
        var anglePoint: CGPoint
        RECT      contentRect
        var        localIndex: Int
        
        var        numCurves = 7
        var        iAngle[7] = {0, 0, 0, 0, 1, 0, 0}
        var        appleAngle[7] = {90, 90, 225, 90, 180, 90, 135}
        var        numDots[7] = {3, 2, 2, 2, 2, 2, 2}
        var        x[15] = {90+83, 90+83, 88+83,  270+83, 270+83,  270+83, 270+83,  
          90+83, 90+83,  90+83, 90+83,  270+83, 270+83,  270+83, 270+83}
        var        y[15] = {90, 162, 90,  90, 162,  90, 162,  
          342, 414,  342, 414,  342, 414,  342, 414}
        
        HPEN      hPen
        
        highCurveNum = gHighCurveNum
        
        /*  Initialize some of the globals  */
        gAngleClick = 0
        gAddDotClick = 0
        gOldDotLoc = nullPoint
        gOldAppleAngle = 0
        gAppleAngle = 0
        
        gSecondAngleFlag = false
        gSketchFlag = false
        gUndoFlag = false
        gHighCurveNumFlag = false
        
        gDotSelectIndex = 0
        gDeleteDotIndex = 0
        gDragDotIndex = 0
        gAddDotIndex = 0
        gOldAngleIndex = 0
        
        for ( n = 0; n <= highCurveNum; n+= )
        {
          gHighDotNum[n] = -1
          gAngleFlag[n] = false
          gAngleIndex[n] = 0
        }
        
        for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
        {
          gX[i] = 0
          gY[i] = 0
          gAlphai[i] = 0.0
          gAlphaf[i] = 0.0
          gStartAngle[i] = 0
          gArcAngle[i] = 0
          gXc[i] = 0.0
          gYc[i] = 0.0
          gR[i] = 0.0
          gDotLoc[i] = nullPoint
          
          gIsCW[i] = 0
        }
        
        gMenuItem     = IDM_MOONS
        gLastMenuItem   = IDM_MOONS
        
        gHighCurveNum   = -1
        gCurveNum     = 0
        
        localIndex = 0
        /*  End initialize some of the globals  */
        
        redraw(hWnd, hDC)
        
        for ( n = 0;  n <= numCurves - 1;  n+= )
        {
          gHighCurveNum   = n
          gCurveNum     = gHighCurveNum
          gAngleIndex[n]   = 15*n + iAngle[n]
          
          for ( i = 0;  i <= numDots[n] - 1;  i+= )
          {
            gDotLoc[15*n + i].x = x[localIndex]
            gDotLoc[15*n + i].y = y[localIndex]
            gHighDotNum[n]   = i
            localIndex +=
            drawDot(hWnd, hDC, 15*n + i)
            dotAsRegion(15*n + i)
            Sleep(500)
          }
          
          drawLargeDot(15*n + iAngle[n])
          Sleep(1000)
          
          gAppleAngle   = appleAngle[n]
          gAngleFlag[n]   = true
          
          /*  Draw angle line  */
          anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x + 
          36*cos( gDegToRad*(90 - gAppleAngle) )
          anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y - 
          36*sin( gDegToRad*(90 - gAppleAngle) )
          
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          
          Sleep(1000)
          EraseLargeDot(hWnd, hDC, 15*n + iAngle[n] )
          
          /*  Erase angle line  */
          hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) //  To erase lines
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen
          
          calcArcs()
          EraseLines(hWnd, hDC)
          DrawCurve(hWnd, hDC)
          Sleep(1000)
        }
        
        redraw(hWnd, hDC)
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       NewCurve                           
      **************************************************************
        
       This starts a new curve.
       
       Changes: curve number
       */
  /*    VOID  NewCurve(HWND  hWnd)
      {
        if gHighCurveNum < 19   //  gHighCurveNum starts at zero
        {
          gHighCurveNum +=          //  Initialized to -1
          gCurveNum = gHighCurveNum
          gMenuItem = IDM_NEWCURVE
        }
        
        else {
          MessageBox  (hWnd,
                       "Too many curves.",
                       "arcDraw",
                       MB_ICONEXCLAMATION | MB_OK) }
        
        return
      } */
      
      
      /***************************************************************
       NewSketchCurve                           
      **************************************************************
        
       This starts a new curve, in the sketch mode.
       
       Changes: curve number
       */
  /*    VOID  NewSketchCurve(HWND  hWnd)
      {
        if gHighCurveNum < 19  //  gHighCurveNum starts at -1
        {
          gHighCurveNum +=
          gCurveNum    = gHighCurveNum
          gMenuItem    = IDM_NEWSKETCHCURVE
          gSketchFlag = true
          gAngleFlag2 = false
        }
        
        else {
          gHighCurveNumFlag = true }
        
        return
      } */
      
      
      /***************************************************************
       Petals   
      **************************************************************
        
       This generates a picture of various petals.
       */
  /*    VOID  Petals(HWND  hWnd, HDC hDC)
      {
        
        var        i: Int
        var        n: Int
        var        highCurveNum: Int
        var nullPoint = CGPoint.zero
        var anglePoint: CGPoint
        RECT      contentRect
        var        localIndex: Int
        
        var        numCurves = 18
        var        iAngle[18] = {0,  0, 0, 0, 0,  0, 0, 0, 0, 0, 0,  0, 3, 0, 1, 1, 1, 0}
        var        appleAngle[18] = {30.0,  0.0, 90.0, 180.0, 270.0,  330.0, 30.0, 90.0, 150.0, 210.0, 270.0, 5.0, 358.0, 34.0, 278.0, 0.0, 0.0, 270.0}
        var        numDots[18] = {9,  6, 6, 6, 6,  4, 4, 4, 4, 4, 4,  12, 13, 5, 2, 2, 2, 2}
      
        var        x[95] = {63+83, 117+83, 24+83, 24+83, 117+83, 
          63+83, 156+83, 156+83, 63+83,
          270+83, 284+83, 315+83, 343+83, 
          343+83, 270+83, 270+83, 343+83, 343+83, 315+83, 284+83, 270+83,
          270+83, 256+83, 225+83, 197+83, 
          197+83, 270+83, 270+83, 197+83, 197+83, 225+83, 256+83, 270+83,
          90+83, 65+83, 115+83, 90+83,  90+83, 128+83, 153+83, 
          90+83, 90+83, 153+83, 128+83, 90+83,
          90+83, 115+83, 65+83, 90+83, 90+83, 52+83, 27+83, 90+83,  
          90+83, 27+83, 52+83, 90+83,
          202+83, 211+83, 230+83, 256+83, 271+83, 269+83, 257+83, 
          254+83, 233+83, 224+83, 204+83, 202+83,
          267+83, 282+83, 290+83, 295+83, 302+83, 314+83, 322+83, 
          325+83, 319+83, 318+83, 302+83, 288+83, 267+83,
          244+83, 260+83, 278+83, 299+83, 309+83, 267+83, 245+83,  
          250+83, 250+83, 263+83, 263+83,  263+83, 250+83}
        
        var        y[95] = {60, 60, 153, 99, 192, 192, 99, 153, 60,
          126, 53, 53, 81, 112, 126,  126, 140, 171, 199, 199, 126,
          126, 199, 199, 171, 140, 126, 126, 112, 81, 53, 53, 126,
          378, 319, 319, 378, 378, 327, 371, 378, 378, 385, 429, 378,
          378, 437, 437, 378, 378, 429, 385, 378, 378, 371, 327, 378,
          324, 295, 283, 294, 324, 356, 389, 402, 407, 398, 364, 324,
          410, 400, 391, 367, 333, 299, 297, 325, 348, 368, 396, 406, 410,
          283, 277, 273, 280, 308, 410, 410, 450, 411, 450, 411, 450, 450}
        
        HPEN      hPen;
        highCurveNum = gHighCurveNum
        
        /*  Initialize some of the globals  */
        gAngleClick = 0
        gAddDotClick = 0
        gOldDotLoc = nullPoint
        gOldAppleAngle = 0
        gAppleAngle = 0
        
        gSecondAngleFlag = false
        gSketchFlag = false
        gUndoFlag = false
        gHighCurveNumFlag = false
        
        gDotSelectIndex = 0
        gDeleteDotIndex = 0
        gDragDotIndex = 0
        gAddDotIndex = 0
        gOldAngleIndex = 0
        
        for ( n = 0; n <= highCurveNum; n+= )
        {
          gHighDotNum[n] = -1
          gAngleFlag[n] = false
          gAngleIndex[n] = 0
        }
        
        for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
        {
          gX[i] = 0
          gY[i] = 0
          gAlphai[i] = 0.0
          gAlphaf[i] = 0.0
          gStartAngle[i] = 0.0
          gArcAngle[i] = 0.0
          gXc[i] = 0.0
          gYc[i] = 0.0
          gR[i] = 0.0
          gDotLoc[i] = nullPoint
          
          gIsCW[i] = 0
        }
        
        gMenuItem     = IDM_PETALS
        gLastMenuItem   = IDM_PETALS
        
        gHighCurveNum   = -1
        gCurveNum     = 0
        
        localIndex = 0
        /*  End initialize some of the globals  */
        
        redraw(hWnd, hDC)
        
        for ( n = 0;  n <= numCurves - 1;  n+= )
        {
          gHighCurveNum   = n
          gCurveNum     = gHighCurveNum
          gAngleIndex[n]   = 15*n + iAngle[n]
          
          for ( i = 0;  i <= numDots[n] - 1;  i+= )
          {
            gDotLoc[15*n + i].x = x[localIndex]
            gDotLoc[15*n + i].y = y[localIndex]
            gHighDotNum[n]   = i
            localIndex +=
            drawDot(hWnd, hDC, 15*n + i)
            dotAsRegion(15*n + i)
            Sleep(500)
          }
          
          drawLargeDot15*n + iAngle[n])
          Sleep(1000)
          
          gAppleAngle   = appleAngle[n]
          gAngleFlag[n]   = true
          
          /*  Draw angle line  */
          anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x + 
          36*cos( gDegToRad*(90 - gAppleAngle) )
          anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y - 
          36*sin( gDegToRad*(90 - gAppleAngle) )
          
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          
          Sleep(1000)
          EraseLargeDot( hWnd, hDC, 15*n + iAngle[n] )
          
          /*  Erase angle line  */
          hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen
          
          calcArcs()
          EraseLines(hWnd, hDC)
          DrawCurve(hWnd, hDC)
          Sleep(1000)
        }
        
        redraw(hWnd, hDC)
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
      redraw                             *
      **************************************************************
        
       Handle redrawing of all the curves when updating.
       */
      
  /*    VOID  redraw(HWND  hWnd, HDC hDC)
      {
        var      xL Int
        var      yT: Int
        var      xR: Int
        var      yB: Int
        var      i: Int
        var      n: Int
        RECT    rectDot
        var      dotRadius = 3
        var      highDotNum: Int
   //     var  dummy: Double
        var      x1: Int
        var      x2: Int
        var      y1: Int
        var      y2: Int
        int      xCL;
        int      yCT;
        int      xCR;
        int      yCB;
        double  alpha12;
        var      x3: Int
        var      x4: Int
        var      y3: Int
        var      y4: Int
        var      r: Int
        
        HPEN    hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
        
        HBRUSH   hBrush // to erase area with normal brush
        
        r = 2000
        
        //    Erase the client area
        xCL   = 0
        yCT   = 0
        xCR   = gxClient
        yCB   = gyClient
        
        Rectangle(hDC, xCL, yCT, xCR, yCB)
        
        hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Return to normal pen
        
        /*  draw lines and arcs  */
        for ( n = 0; n <= gHighCurveNum; n+= )
        {
          highDotNum = gHighDotNum[n]
          
          for ( i = 15*n;  i < 15*n + gHighDotNum[n];  i+= )
          {
            /*  x's and y's in Windows coordinates  */
            x1 = gDotLoc[i].x
            x2 = gDotLoc[i + 1].x
            y1 = gDotLoc[i].y
            y2 = gDotLoc[i + 1].;
            
            if fabs(gR[i] - 15000.0) <= 0.001 || fabs(gR[i] - 16000.0) <= 0.001
            {
              //  We need normal coordinates for atan2, so put minus sign in front of y's
              alpha12 = gRadToDeg*atan2(-(y2 - y1), x2 - x1)
              
              if alpha12 < 0.0 {
                  alpha12 = alpha12 + 360.0 }  //  To get in range of 0 to 359
              
              if fabs(gR[i] - 15000.0) <= 0.001
              {
                MoveToEx(hDC, x1, y1, NULL)  // Windows coordinates
                LineTo(hDC, x2, y2)          // Windows coordinates
              }
              
              else
              {
                x3 = x1 - r*cos(gDegToRad*alpha12)  // Windows coordinates
                x4 = x2 + r*cos(gDegToRad*alpha12)  // Windows coordinates
                y3 = y1 + r*sin(gDegToRad*alpha12)  // Windows coordinates
                y4 = y2 - r*sin(gDegToRad*alpha12)  // Windows coordinates
                
                MoveToEx(hDC, x1, y1, NULL)        // Windows coordinates
                LineTo(hDC, x3, y3)                // Windows coordinates
                
                MoveToEx(hDC, x2, y2, NULL)        // Windows coordinates
                LineTo(hDC, x4, y4)                // Windows coordinates
              }
            }
            
            else
            {
              /*  draw the arc  */
              xL   = RoundToInt(gXc[i] - gR[i])
              yT   = RoundToInt(-gYc[i] - gR[i])
              xR   = RoundToInt(gXc[i] + gR[i])
              yB   = RoundToInt(-gYc[i] + gR[i])
              
              if gIsCW[i] == 0 {
                  Arc(hDC, xL, yT, xR, yB, x1, y1, x2, y2) }  // "forwards" if CCW
              
              else {
                Arc(hDC, xL, yT, xR, yB, x2, y2, x1, y1) }  //  "backwards" if CW
            }
            
          }
          
          if gShowDots == 1
          {
            /*  draw the dots in light gray   */
            /*  we have one more dot than we have arcs in a curve  */
            for ( i = 15*n;  i <= 15*n + highDotNum;  i+= )  
            {
              rectDot.left   = gDotLoc[i].x - dotRadius
              rectDot.top   = gDotLoc[i].y - dotRadius
              rectDot.right   = gDotLoc[i].x + dotRadius
              rectDot.bottom   = gDotLoc[i].y + dotRadius
              
              hBrush = SelectObject(hDC, GetStockObject(LTGRAY_BRUSH)) // Light gray brush
              
              Ellipse( hDC, rectDot.left, rectDot.top, rectDot.right, rectDot.bottom )
            }
          }
        }
        
   /*     dummy = gHighCurveNum + gHighDotNum[0] + gR[0] + gAngleFlag[0] + gXc[0]
        + gYc[0] 
        + gAlphai[0] + gCurveNum + gAppleAngle
        + x1 + x2 + x3 + x4+ y1 + y2 + y3 + y4 + alpha12  */
        
        hBrush = SelectObject(hDC, GetStockObject(WHITE_BRUSH)) // Return to normal brush
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       Shapes   
      **************************************************************
        
       This generates a picture of various shapes.
       */
 /*     VOID  Shapes(HWND  hWnd, HDC hDC)
      {
        
        var        i: Int
        var        n: Int
        var        highCurveNum: Int
        var nullPoint = CGPoint.zero
        var anglePoint: CGPoint
        RECT      contentRect;
        var        localIndex: Int
        
        var        numCurves = 5
        var        iAngle[5] = {0, 0, 0, 0, 0}
        var        appleAngle[5] = {45.0, 0.0, 35.0, 50.0, 140.0}
        var        numDots[5] = {5, 5, 5, 4, 4}
        var        x[23] = {63+83, 117+83, 153+83, 27+83, 63+83, 216+83, 
          324+83, 324+83, 216+83, 216+83, 
          54+83, 126+83, 126+83, 54+83, 54+83, 270+83, 318+83, 
          222+83, 270+83, 270+83, 318+83, 222+83, 270+83}
        var        y[23] = {54, 54, 198, 198, 54, 63, 63, 162, 162, 63, 
          292, 341, 415, 464, 292, 236, 311, 311, 236,
          344, 419, 419, 344}
        
        HPEN      hPen
        
        highCurveNum = gHighCurveNum
        
        /*  Initialize some of the globals  */
        gAngleClick = 0
        gAddDotClick = 0
        gOldDotLoc = nullPoint
        gOldAppleAngle = 0.0
        gAppleAngle = 0.0
        
        gSecondAngleFlag = false
        gSketchFlag = false
        gUndoFlag = false
        gHighCurveNumFlag = false
        
        gDotSelectIndex = 0
        gDeleteDotIndex = 0
        gDragDotIndex = 0
        gAddDotIndex = 0
        gOldAngleIndex = 0
        
        for ( n = 0; n <= highCurveNum; n+= )
        {
          gHighDotNum[n] = -1
          gAngleFlag[n] = false
          gAngleIndex[n] = 0
        }
        
        for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
        {
          gX[i] = 0
          gY[i] = 0
          gAlphai[i] = 0.0
          gAlphaf[i] = 0.0
          gStartAngle[i] = 0.0
          gArcAngle[i] = 0.0
          gXc[i] = 0.0
          gYc[i] = 0.0
          gR[i] = 0.0
          gDotLoc[i] = nullPoint
          
          gIsCW[i] = 0
        }
        
        gMenuItem     = IDM_SHAPES
        gLastMenuItem  = IDM_SHAPES
        
        gHighCurveNum  = -1
        gCurveNum     = 0
        
        localIndex     = 0
        /*  End initialize some of the globals  */
        
        redraw(hWnd, hDC)  //  To start clean
        
        for ( n = 0;  n <= numCurves - 1;  n+= )
        {
          gHighCurveNum   = n
          gCurveNum       = gHighCurveNum
          gAngleIndex[n]   = 15*n + iAngle[n]
          
          for ( i = 0;  i <= numDots[n] - 1;  i+= )
          {
            gDotLoc[15*n + i].x = x[localIndex]
            gDotLoc[15*n + i].y = y[localIndex]
            gHighDotNum[n]   = i
            localIndex +=
            drawDot(hWnd, hDC, 15*n + i)
            dotAsRegion(15*n + i)
            Sleep(500)
          }
          
          drawLargeDot(15*n + iAngle[n])
          Sleep(1000)
          
          gAppleAngle   = appleAngle[n]
          gAngleFlag[n]   = true
          
          /*  Draw angle line  */
          anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x + 
          36*cos( gDegToRad*(90 - gAppleAngle) )
          anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y - 
          36*sin( gDegToRad*(90 - gAppleAngle) )
          
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          
          Sleep(1000)
          EraseLargeDot( hWnd, hDC, 15*n + iAngle[n] )
          
          /*  Erase angle line  */
          hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen
          
          calcArcs()
          EraseLines(hWnd, hDC)
          DrawCurve(hWnd, hDC)
          Sleep(1000)
        }
        
        redraw(hWnd, hDC)
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       Spirals   
      **************************************************************
        
       This generates a picture of various spirals.
       */
 /*     VOID  Spirals(HWND  hWnd, HDC hDC)
      {
        
        var        i: Int
        var        n: Int
        var        highCurveNum: Int
        var nullPoint = CGPoint.zero
        var anglePoint: CGPoint
        RECT      contentRect;
        var        localIndex: Int
        
        var        numCurves = 2
        var        iAngle[2] = {0, 5}
        var        appleAngle[2] = {0.0, 180.0}
        var        numDots[2] = {12, 11}
        var        x[23] = {198+83, 162+83, 216+83, 144+83, 234+83, 126+83, 
          252+83, 108+83, 270+83, 90+83, 288+83, 72+83, 
          126+83, 144+83, 108+83, 162+83, 90+83, 180+83, 
          270+83, 198+83, 252+83, 216+83, 234+83}
        var        y[23] = {126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 
          378, 378, 378, 378, 378, 378, 378, 378, 378, 378, 378}
        
        HPEN      hPen
        
        highCurveNum = gHighCurveNum;
        
        /*  Initialize some of the globals  */
        gAngleClick = 0
        gAddDotClick = 0
        gOldDotLoc = nullPoint
        gOldAppleAngle = 0.0
        gAppleAngle = 0.0
        
        gSecondAngleFlag = false
        gSketchFlag = false
        gUndoFlag = false
        gHighCurveNumFlag = false
        
        gDotSelectIndex = 0
        gDeleteDotIndex = 0
        gDragDotIndex = 0
        gAddDotIndex = 0
        gOldAngleIndex = 0
        
        for ( n = 0; n <= highCurveNum; n+= )
        {
          gHighDotNum[n] = -1
          gAngleFlag[n] = false
          gAngleIndex[n] = 0
        }
        
        for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
        {
          gX[i] = 0
          gY[i] = 0
          gAlphai[i] = 0.0
          gAlphaf[i] = 0.0
          gStartAngle[i] = 0
          gArcAngle[i] = 0.0
          gXc[i] = 0.0
          gYc[i] = 0.0
          gR[i] = 0.0
          gDotLoc[i] = nullPoint
          
          gIsCW[i] = 0
        }
        
        gMenuItem     = IDM_SPIRALS
        gLastMenuItem   = IDM_SPIRALS
        
        gHighCurveNum   = -1
        gCurveNum     = 0
        
        localIndex = 0
        /*  End initialize some of the globals  */
        
        redraw(hWnd, hDC)
        
        for ( n = 0;  n <= numCurves - 1;  n+= )
        {
          gHighCurveNum   = n
          gCurveNum     = gHighCurveNum
          gAngleIndex[n]   = 15*n + iAngle[n]
          
          for ( i = 0;  i <= numDots[n] - 1;  i+= )
          {
            gDotLoc[15*n + i].x = x[localIndex]
            gDotLoc[15*n + i].y = y[localIndex]
            gHighDotNum[n]   = i
            localIndex +=
            drawDot(hWnd, hDC, 15*n + i)
            dotAsRegion(15*n + i)
            Sleep(500)
          }
          
          drawLargeDot(15*n + iAngle[n])
          Sleep(1000)
          
          gAppleAngle   = appleAngle[n]
          gAngleFlag[n]   = true
          
          /*  Draw angle line  */
          anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x + 
          36*cos( gDegToRad*(90 - gAppleAngle) )
          anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y - 
          36*sin( gDegToRad*(90 - gAppleAngle) )
          
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          
          Sleep(1000)
          EraseLargeDot(hWnd, hDC, 15*n + iAngle[n] )
          
          /*  Erase angle line  */
          hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen
          
          calcArcs()
          EraseLines(hWnd, hDC)
          drawCurve(hWnd, hDC)
          Sleep(1000)
        }
        
        redraw(hWnd, hDC)
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
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
      
      
      /***************************************************************
       YinYang   
      **************************************************************
        
       This generates a picture of a Yin-Yang figure.
       */
  /*    VOID  YinYang(HWND  hWnd, HDC hDC)
      {
        
        var        i: Int
        var        n: Int
        var        highCurveNum: Int
        var nullPoint = CGPoint.zero
        var anglePoint: CGPoint
        RECT      contentRect;
        var        localIndex: Int
        
        var        numCurves = 3
        var        iAngle[3] = {0, 0, 0}
        var        appleAngle[3] = {0.0, 0.0, 0.0}
        var        numDots[3] = {5, 3, 3}
        var        x[11] = {36+83, 324+83, 38+83, 180+83, 322+83, 90+83, 
          126+83, 90+83, 234+83, 270+83, 234+83}
        var        y[11] = {252, 252, 252, 252, 252, 252, 252, 254, 252, 252, 254}
        
        HPEN      hPen
        
        highCurveNum = gHighCurveNum
        
        /*  Initialize some of the globals  */
        gAngleClick = 0
        gAddDotClick = 0
        gOldDotLoc = nullPoint
        gOldAppleAngle = 0.0
        gAppleAngle = 0.0
        
        gSecondAngleFlag = false
        gSketchFlag = false
        gUndoFlag = false
        gHighCurveNumFlag = false
        
        gDotSelectIndex = 0
        gDeleteDotIndex = 0
        gDragDotIndex = 0
        gAddDotIndex = 0
        gOldAngleIndex = 0
        
        for ( n = 0; n <= highCurveNum; n+= )
        {
          gHighDotNum[n] = -1
          gAngleFlag[n] = false
          gAngleIndex[n] = 0
        }
        
        for ( i = 0; i <= 15*(highCurveNum + 1); i+= )
        {
          gX[i] = 0
          gY[i] = 0
          gAlphai[i] = 0.0
          gAlphaf[i] = 0.0
          gStartAngle[i] = 0.0
          gArcAngle[i] = 0.0
          gXc[i] = 0.0
          gYc[i] = 0.0
          gR[i] = 0.0
          gDotLoc[i] = nullPoint
          
          gIsCW[i] = 0
        }
        
        gMenuItem     = IDM_YINYANG
        gLastMenuItem   = IDM_YINYANG
        
        gHighCurveNum   = -1
        gCurveNum     = 0
        
        localIndex = 0
        /*  End initialize some of the globals  */
        
        redraw(hWnd, hDC)
        
        for ( n = 0;  n <= numCurves - 1;  n+= )
        {
          gHighCurveNum   = n
          gCurveNum     = gHighCurveNum
          gAngleIndex[n]   = 15*n + iAngle[n]
          
          for ( i = 0;  i <= numDots[n] - 1;  i+= )
          {
            gDotLoc[15*n + i].x = x[localIndex]
            gDotLoc[15*n + i].y = y[localIndex]
            gHighDotNum[n]   = i
            localIndex +=
            drawDot(hWnd, hDC, 15*n + i)
            dotAsRegion(15*n + i)
            Sleep(500)
          }
          
          drawLargeDot(15*n + iAngle[n])
          Sleep(1000)
          
          gAppleAngle   = appleAngle[n]
          gAngleFlag[n]   = true
          
          /*  Draw angle line  */
          anglePoint.x = gDotLoc[ 15*n + iAngle[n] ].x + 
          36*cos( gDegToRad*(90 - gAppleAngle) )
          anglePoint.y = gDotLoc[ 15*n + iAngle[n] ].y - 
          36*sin( gDegToRad*(90 - gAppleAngle) )
          
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          
          Sleep(1000)
          EraseLargeDot( hWnd,hDC, 15*n + iAngle[n] )
          
          /*  Erase angle line  */
          hPen = SelectObject(hDC, GetStockObject(WHITE_PEN)) // To erase lines
          MoveToEx(hDC, gDotLoc[ 15*n + iAngle[n] ].x, gDotLoc[ 15*n + iAngle[n] ].y, NULL)
          LineTo(hDC, anglePoint.x, anglePoint.y)
          hPen = SelectObject(hDC, GetStockObject(BLACK_PEN)) // Normal pen
          
          calcArcs()
          EraseLines(hWnd, hDC)
          drawCurve(hWnd, hDC)
          Sleep(1000)
        }
        
        redraw(hWnd, hDC)
        
        ReleaseDC(hWnd, hDC)
        
        return
      } */
      
      
      /***************************************************************
       RoundToInt                           
      **************************************************************
        
       Round Double number to integer.
       
       Receives: Double number
       Changes: number into best integer approximation
       Returns: integer number
       */
  /*    int  RoundToInt(Double  number)
      {
        var        intNumber: Int    /*   resulting integer   */
        var    absNumber: Double
        var        ceilNumber: Int    /*   ceil() returns a double; we convert to int   */
        var    delta: Double
        
        absNumber    = fabs( number )
        ceilNumber  = ceil( absNumber )
        delta        = ceilNumber - absNumber
        
        if delta < 0.5 {
            intNumber = ceilNumber }
        
        if delta > 0.5 {
            intNumber = ceilNumber - 1.0 }
        
        if delta == 0.5
        {
          if ( ceilNumber - 1 )%2 > 0 {  //  % means modulus
              intNumber = ceilNumber }
          else {
            intNumber =  ceilNumber - 1 }
        }
        
        if number < 0 {
            intNumber = -intNumber }
        
        return  intNumber
      } */
      
      

    }
}

