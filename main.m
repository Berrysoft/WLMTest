#include <stdio.h>
#include <stdlib.h>

#import <AppKit/AppKit.h>

typedef unsigned int UINT;
typedef unsigned int DWORD;
typedef const char *LPCSTR;
typedef unsigned long LRESULT;
typedef unsigned long WPARAM;
typedef unsigned long LPARAM;
typedef short ATOM;
typedef void *LPVOID;
// typedef int BOOL;
typedef int LONG;
typedef short WORD;

#define DECLARE_HANDLE(name)                                                   \
  struct name##__ {                                                            \
    DWORD unused;                                                              \
  };                                                                           \
  typedef struct name##__ *name

DECLARE_HANDLE(HANDLE);
DECLARE_HANDLE(HINSTANCE);
typedef HINSTANCE HMODULE;
DECLARE_HANDLE(HWND);
DECLARE_HANDLE(HICON);
DECLARE_HANDLE(HCURSOR);
DECLARE_HANDLE(HBRUSH);
DECLARE_HANDLE(HMENU);
DECLARE_HANDLE(HGDIOBJ);

HMODULE GetModuleHandleA(LPCSTR lpModuleName);

typedef LRESULT (*WNDPROC)(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

typedef struct tagWNDCLASSA {
  UINT style;
  WNDPROC lpfnWndProc;
  int cbClsExtra;
  int cbWndExtra;
  HINSTANCE hInstance;
  HICON hIcon;
  HCURSOR hCursor;
  HBRUSH hbrBackground;
  LPCSTR lpszMenuName;
  LPCSTR lpszClassName;
} WNDCLASSA, *PWNDCLASSA, *NPWNDCLASSA, *LPWNDCLASSA;

ATOM RegisterClassA(const WNDCLASSA *lpWndClass);

HWND CreateWindowExA(DWORD dwExStyle, LPCSTR lpClassName, LPCSTR lpWindowName,
                     DWORD dwStyle, int X, int Y, int nWidth, int nHeight,
                     HWND hWndParent, HMENU hMenu, HINSTANCE hInstance,
                     LPVOID lpParam);

/*
 * Window Styles
 */
#define WS_OVERLAPPED 0x00000000L
#define WS_POPUP 0x80000000L
#define WS_CHILD 0x40000000L
#define WS_MINIMIZE 0x20000000L
#define WS_VISIBLE 0x10000000L
#define WS_DISABLED 0x08000000L
#define WS_CLIPSIBLINGS 0x04000000L
#define WS_CLIPCHILDREN 0x02000000L
#define WS_MAXIMIZE 0x01000000L
#define WS_CAPTION 0x00C00000L /* WS_BORDER | WS_DLGFRAME  */
#define WS_BORDER 0x00800000L
#define WS_DLGFRAME 0x00400000L
#define WS_VSCROLL 0x00200000L
#define WS_HSCROLL 0x00100000L
#define WS_SYSMENU 0x00080000L
#define WS_THICKFRAME 0x00040000L
#define WS_GROUP 0x00020000L
#define WS_TABSTOP 0x00010000L

#define WS_MINIMIZEBOX 0x00020000L
#define WS_MAXIMIZEBOX 0x00010000L

#define WS_TILED WS_OVERLAPPED
#define WS_ICONIC WS_MINIMIZE
#define WS_SIZEBOX WS_THICKFRAME
#define WS_TILEDWINDOW WS_OVERLAPPEDWINDOW

/*
 * Common Window Styles
 */
#define WS_OVERLAPPEDWINDOW                                                    \
  (WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX |  \
   WS_MAXIMIZEBOX)

#define WS_POPUPWINDOW (WS_POPUP | WS_BORDER | WS_SYSMENU)

#define WS_CHILDWINDOW (WS_CHILD)

#define CW_USEDEFAULT ((int)0x80000000)

#define ShowWindow AfxShowWindow

BOOL ShowWindow(HWND hWnd, int nCmdShow);

/*
 * ShowWindow() Commands
 */
#define SW_HIDE 0
#define SW_SHOWNORMAL 1
#define SW_NORMAL 1
#define SW_SHOWMINIMIZED 2
#define SW_SHOWMAXIMIZED 3
#define SW_MAXIMIZE 3
#define SW_SHOWNOACTIVATE 4
#define SW_SHOW 5
#define SW_MINIMIZE 6
#define SW_SHOWMINNOACTIVE 7
#define SW_SHOWNA 8
#define SW_RESTORE 9
#define SW_SHOWDEFAULT 10
#define SW_FORCEMINIMIZE 11
#define SW_MAX 11

typedef struct tagPOINT {
  LONG x;
  LONG y;
} POINT, *PPOINT, *NPPOINT, *LPPOINT;

typedef struct tagRECT {
  LONG left;
  LONG top;
  LONG right;
  LONG bottom;
} RECT, *PRECT, *NPRECT, *LPRECT;

typedef struct tagMSG {
  HWND hwnd;
  UINT message;
  WPARAM wParam;
  LPARAM lParam;
  DWORD time;
  POINT pt;
  DWORD lPrivate;
} MSG, *PMSG, *NPMSG, *LPMSG;

BOOL GetMessageA(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin,
                 UINT wMsgFilterMax);

BOOL TranslateMessage(const MSG *lpMsg);
LRESULT DispatchMessageA(const MSG *lpMsg);

LRESULT DefWindowProcA(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
LRESULT WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

#define WM_CREATE 0x0001
#define WM_DESTROY 0x0002
#define WM_COMMAND 0x0111

void PostQuitMessage(int nExitCode);

void WlmKernel_FrameworkInit();

HGDIOBJ GetStockObject(int i);

/* Stock Logical Objects */
#define WHITE_BRUSH 0
#define LTGRAY_BRUSH 1
#define GRAY_BRUSH 2
#define DKGRAY_BRUSH 3
#define BLACK_BRUSH 4
#define NULL_BRUSH 5
#define HOLLOW_BRUSH NULL_BRUSH
#define WHITE_PEN 6
#define BLACK_PEN 7
#define NULL_PEN 8
#define OEM_FIXED_FONT 10
#define ANSI_FIXED_FONT 11
#define ANSI_VAR_FONT 12
#define SYSTEM_FONT 13
#define DEVICE_DEFAULT_FONT 14
#define DEFAULT_PALETTE 15
#define SYSTEM_FIXED_FONT 16

BOOL GetClientRect(HWND hWnd, LPRECT lpRect);

#define LOWORD(v) (WORD)((v)&0xFFFF)

int MessageBoxA(HWND hWnd, LPCSTR lpText, LPCSTR lpCaption, UINT uType);

#define MB_OK 0x00000000L
#define MB_OKCANCEL 0x00000001L
#define MB_ABORTRETRYIGNORE 0x00000002L
#define MB_YESNOCANCEL 0x00000003L
#define MB_YESNO 0x00000004L
#define MB_RETRYCANCEL 0x00000005L

#define MB_ICONHAND 0x00000010L
#define MB_ICONQUESTION 0x00000020L
#define MB_ICONEXCLAMATION 0x00000030L
#define MB_ICONASTERISK 0x00000040L

/*
 * Button Control Styles
 */
#define BS_PUSHBUTTON 0x00000000L
#define BS_DEFPUSHBUTTON 0x00000001L
#define BS_CHECKBOX 0x00000002L
#define BS_AUTOCHECKBOX 0x00000003L
#define BS_RADIOBUTTON 0x00000004L
#define BS_3STATE 0x00000005L
#define BS_AUTO3STATE 0x00000006L
#define BS_GROUPBOX 0x00000007L
#define BS_USERBUTTON 0x00000008L
#define BS_AUTORADIOBUTTON 0x00000009L
#define BS_PUSHBOX 0x0000000AL
#define BS_OWNERDRAW 0x0000000BL
#define BS_TYPEMASK 0x0000000FL
#define BS_LEFTTEXT 0x00000020L

int main() {
  WlmKernel_FrameworkInit();

  [NSApplication sharedApplication];

  HINSTANCE hInstance = GetModuleHandleA(NULL);

  // Register the window class.
  const char CLASS_NAME[] = "Sample Window Class";

  WNDCLASSA wc = {};

  wc.lpfnWndProc = WindowProc;
  wc.hInstance = hInstance;
  wc.lpszClassName = CLASS_NAME;
  wc.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);

  RegisterClassA(&wc);

  // Create the window.

  HWND hwnd = CreateWindowExA(0,          // Optional window styles.
                              CLASS_NAME, // Window class
                              "Learn to Program Windows", // Window text
                              WS_OVERLAPPEDWINDOW,        // Window style

                              // Size and position
                              CW_USEDEFAULT, CW_USEDEFAULT, 400, 300,

                              NULL,      // Parent window
                              NULL,      // Menu
                              hInstance, // Instance handle
                              NULL       // Additional application data
  );

  if (hwnd == NULL) {
    return 0;
  }

  ShowWindow(hwnd, SW_SHOWNORMAL);

  MSG msg = {};
  while (GetMessageA(&msg, NULL, 0, 0) > 0) {
    TranslateMessage(&msg);
    DispatchMessageA(&msg);
  }
}

#define BUTTON_ID 1001

LRESULT WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
  printf("%p, %d, %ld, %ld\n", hwnd, uMsg, wParam, lParam);
  switch (uMsg) {
  case WM_CREATE: {
    // 获取窗口客户区的大小
    RECT rect;
    GetClientRect(hwnd, &rect);

    // 计算按钮的位置和大小
    int buttonWidth = 100;
    int buttonHeight = 30;
    int x = (rect.right - buttonWidth) / 2;
    int y = (rect.bottom - buttonHeight) / 2;

    // 创建按钮
    CreateWindowExA(0, "BUTTON", "Click Me",
                    WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON, x, y,
                    buttonWidth, buttonHeight, hwnd, (HMENU)BUTTON_ID,
                    GetModuleHandleA(NULL), NULL);
    break;
  }

  case WM_COMMAND:
    if (LOWORD(wParam) == BUTTON_ID) {
      MessageBoxA(hwnd, "You clicked the button!", "Button Clicked",
                  MB_OK | MB_ICONASTERISK);
    }
    break;
  case WM_DESTROY:
    PostQuitMessage(0);
    break;
  }
  return DefWindowProcA(hwnd, uMsg, wParam, lParam);
}
