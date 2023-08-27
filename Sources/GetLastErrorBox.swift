
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
