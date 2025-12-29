//! Extends std.os.windows
//!
//! TODO: Re-export *all* of std.os.windows and organize better.

const std = @import("std");

pub const WINAPI = std.os.windows.WINAPI;
pub const S_OK = std.os.windows.S_OK;
pub const S_FALSE = std.os.windows.S_FALSE;
pub const E_NOTIMPL = std.os.windows.E_NOTIMPL;
pub const E_NOINTERFACE = std.os.windows.E_NOINTERFACE;
pub const E_POINTER = std.os.windows.E_POINTER;
pub const E_ABORT = std.os.windows.E_ABORT;
pub const E_FAIL = std.os.windows.E_FAIL;
pub const E_UNEXPECTED = std.os.windows.E_UNEXPECTED;
pub const E_ACCESSDENIED = std.os.windows.E_ACCESSDENIED;
pub const E_HANDLE = std.os.windows.E_HANDLE;
pub const E_OUTOFMEMORY = std.os.windows.E_OUTOFMEMORY;
pub const E_INVALIDARG = std.os.windows.E_INVALIDARG;
pub const GENERIC_READ = std.os.windows.GENERIC_READ;
pub const GENERIC_WRITE = std.os.windows.GENERIC_WRITE;
pub const GENERIC_EXECUTE = std.os.windows.GENERIC_EXECUTE;
pub const GENERIC_ALL = std.os.windows.GENERIC_ALL;
pub const EVENT_ALL_ACCESS = std.os.windows.EVENT_ALL_ACCESS;
pub const INFINITE = std.os.windows.INFINITE;
pub const TRUE = std.os.windows.TRUE;
pub const FALSE = std.os.windows.FALSE;
pub const BOOL = std.os.windows.BOOL;
pub const BOOLEAN = std.os.windows.BOOLEAN;
pub const BYTE = std.os.windows.BYTE;
pub const CHAR = std.os.windows.CHAR;
pub const UCHAR = std.os.windows.UCHAR;
pub const WCHAR = std.os.windows.WCHAR;
pub const FLOAT = std.os.windows.FLOAT;
pub const HCRYPTPROV = std.os.windows.HCRYPTPROV;
pub const ATOM = std.os.windows.ATOM;
pub const WPARAM = std.os.windows.WPARAM;
pub const LPARAM = std.os.windows.LPARAM;
pub const LRESULT = std.os.windows.LRESULT;
pub const HRESULT = std.os.windows.HRESULT;
pub const HBRUSH = std.os.windows.HBRUSH;
pub const HCURSOR = std.os.windows.HCURSOR;
pub const HICON = std.os.windows.HICON;
pub const HINSTANCE = std.os.windows.HINSTANCE;
pub const HMENU = std.os.windows.HMENU;
pub const HMODULE = std.os.windows.HMODULE;
pub const HWND = std.os.windows.HWND;
pub const HDC = std.os.windows.HDC;
pub const HGLRC = std.os.windows.HGLRC;
pub const FARPROC = std.os.windows.FARPROC;
pub const PROC = std.os.windows.PROC;
pub const INT = std.os.windows.INT;
pub const SIZE_T = std.os.windows.SIZE_T;
pub const UINT = std.os.windows.UINT;
pub const USHORT = std.os.windows.USHORT;
pub const SHORT = std.os.windows.SHORT;
pub const ULONG = std.os.windows.ULONG;
pub const LONG = std.os.windows.LONG;
pub const WORD = std.os.windows.WORD;
pub const DWORD = std.os.windows.DWORD;
pub const ULONGLONG = std.os.windows.ULONGLONG;
pub const LONGLONG = std.os.windows.LONGLONG;
pub const LARGE_INTEGER = std.os.windows.LARGE_INTEGER;
pub const ULARGE_INTEGER = std.os.windows.ULARGE_INTEGER;
pub const ULONG_PTR = std.os.windows.ULONG_PTR;
pub const LONG_PTR = std.os.windows.LONG_PTR;
pub const DWORD_PTR = std.os.windows.DWORD_PTR;
pub const DWORD64 = std.os.windows.DWORD64;
pub const ULONG64 = std.os.windows.ULONG64;
pub const HLOCAL = std.os.windows.HLOCAL;
pub const LPCSTR = std.os.windows.LPCSTR;
pub const LPCVOID = std.os.windows.LPCVOID;
pub const LPSTR = std.os.windows.LPSTR;
pub const LPVOID = std.os.windows.LPVOID;
pub const LPWSTR = std.os.windows.LPWSTR;
pub const LPCWSTR = std.os.windows.LPCWSTR;
pub const PVOID = std.os.windows.PVOID;
pub const PWSTR = std.os.windows.PWSTR;
pub const PCWSTR = std.os.windows.PCWSTR;
pub const HANDLE = std.os.windows.HANDLE;
pub const GUID = std.os.windows.GUID;
pub const NTSTATUS = std.os.windows.NTSTATUS;
pub const CRITICAL_SECTION = std.os.windows.CRITICAL_SECTION;
pub const SECURITY_ATTRIBUTES = std.os.windows.SECURITY_ATTRIBUTES;
pub const RECT = std.os.windows.RECT;
pub const POINT = std.os.windows.POINT;
pub const LANGID = std.os.windows.LANGID;
pub const MAX_PATH = std.os.windows.MAX_PATH;
pub const KNOWNFOLDERID = std.os.windows.KNOWNFOLDERID;
pub const FOLDERID_LocalAppData = std.os.windows.FOLDERID_LocalAppData;
pub const KF_FLAG_DEFAULT = std.os.windows.KF_FLAG_DEFAULT;
pub const KF_FLAG_NO_APPCONTAINER_REDIRECTION = std.os.windows.KF_FLAG_NO_APPCONTAINER_REDIRECTION;
pub const KF_FLAG_CREATE = std.os.windows.KF_FLAG_CREATE;
pub const KF_FLAG_DONT_VERIFY = std.os.windows.KF_FLAG_DONT_VERIFY;
pub const KF_FLAG_DONT_UNEXPAND = std.os.windows.KF_FLAG_DONT_UNEXPAND;
pub const KF_FLAG_NO_ALIAS = std.os.windows.KF_FLAG_NO_ALIAS;
pub const KF_FLAG_INIT = std.os.windows.KF_FLAG_INIT;
pub const KF_FLAG_DEFAULT_PATH = std.os.windows.KF_FLAG_DEFAULT_PATH;
pub const KF_FLAG_NOT_PARENT_RELATIVE = std.os.windows.KF_FLAG_NOT_PARENT_RELATIVE;
pub const KF_FLAG_SIMPLE_IDLIST = std.os.windows.KF_FLAG_SIMPLE_IDLIST;
pub const KF_FLAG_ALIAS_ONLY = std.os.windows.KF_FLAG_ALIAS_ONLY;
pub const PTHREAD_START_ROUTINE = std.os.windows.PTHREAD_START_ROUTINE;
pub const LPTHREAD_START_ROUTINE = std.os.windows.LPTHREAD_START_ROUTINE;
pub const OSVERSIONINFOW = std.os.windows.OSVERSIONINFOW;
pub const CloseHandle = std.os.windows.CloseHandle;
pub const FindClose = std.os.windows.FindClose;
pub const FreeLibrary = std.os.windows.FreeLibrary;
pub const WaitForSingleObject = std.os.windows.WaitForSingleObject;
pub const WaitForSingleObjectEx = std.os.windows.WaitForSingleObjectEx;
pub const WaitForMultipleObjectsEx = std.os.windows.WaitForMultipleObjectsEx;

pub const dwrite = @import("windows/dwrite.zig");
pub const dxgi = @import("windows/dxgi.zig");
pub const d3d11 = @import("windows/d3d11.zig");
pub const d3d11d = @import("windows/d3d11sdklayers.zig");
pub const d3d12 = @import("windows/d3d12.zig");
pub const d3d12d = @import("windows/d3d12sdklayers.zig");
pub const d3d = @import("windows/d3dcommon.zig");
pub const d2d1 = @import("windows/d2d1.zig");
pub const d3d11on12 = @import("windows/d3d11on12.zig");
pub const wic = @import("windows/wincodec.zig");
pub const wasapi = @import("windows/wasapi.zig");
pub const directml = @import("windows/directml.zig");
pub const mf = @import("windows/mf.zig");
pub const xaudio2 = @import("windows/xaudio2.zig");
pub const xaudio2fx = @import("windows/xaudio2fx.zig");
pub const xapo = @import("windows/xapo.zig");
pub const xinput = @import("windows/xinput.zig");
pub const d3dcompiler = @import("windows/d3dcompiler.zig");

pub const FOLDERID_ProgramFiles = GUID.parse("{905e63b6-c1bf-494e-b29c-65b732d3d21a}");

pub const E_FILE_NOT_FOUND = @as(HRESULT, @bitCast(@as(c_ulong, 0x80070002)));

pub extern "ole32" fn CoInitializeEx(pvReserved: ?LPVOID, dwCoInit: DWORD) callconv(WINAPI) HRESULT;
pub extern "ole32" fn CoUninitialize() callconv(WINAPI) void;
pub extern "ole32" fn CoTaskMemAlloc(size: SIZE_T) callconv(WINAPI) ?LPVOID;
pub extern "ole32" fn CoTaskMemFree(pv: LPVOID) callconv(WINAPI) void;

pub const COINIT_APARTMENTTHREADED = 0x2;
pub const COINIT_MULTITHREADED = 0x3;
pub const COINIT_DISABLE_OLE1DDE = 0x4;
pub const COINIT_SPEED_OVER_MEMORY = 0x8;
pub const UINT_MAX: UINT = 4294967295;

/// [DEPRECATED]: Use proc specific errors as in std.os.windows
pub const Error = error{
    UNEXPECTED,
    NOTIMPL,
    OUTOFMEMORY,
    INVALIDARG,
    POINTER,
    HANDLE,
    ABORT,
    FAIL,
    ACCESSDENIED,
};

/// [DEPRECATED]: Use proc specific errors as in std.os.windows
pub const MiscError = error{
    E_FILE_NOT_FOUND,
    S_FALSE,
};

pub const ERROR_SUCCESS = @as(LONG, 0);
pub const ERROR_DEVICE_NOT_CONNECTED = @as(LONG, 1167);
pub const ERROR_EMPTY = @as(LONG, 4306);

pub const SEVERITY_SUCCESS = 0;
pub const SEVERITY_ERROR = 1;

pub fn MAKE_HRESULT(severity: LONG, facility: LONG, value: LONG) HRESULT {
    return @as(HRESULT, (severity << 31) | (facility << 16) | value);
}

pub const CW_USEDEFAULT = @as(i32, @bitCast(@as(u32, 0x80000000)));

pub const MINMAXINFO = extern struct {
    ptReserved: POINT,
    ptMaxSize: POINT,
    ptMaxPosition: POINT,
    ptMinTrackSize: POINT,
    ptMaxTrackSize: POINT,
};

pub extern "user32" fn GetDC(hWnd: HWND) callconv(WINAPI) HDC;

pub extern "user32" fn ReleaseDC(hWnd: HWND, hdc: HDC) callconv(WINAPI) c_int;

pub extern "user32" fn SetProcessDPIAware() callconv(WINAPI) BOOL;

pub extern "user32" fn GetClientRect(HWND, *RECT) callconv(WINAPI) BOOL;

pub extern "user32" fn SetWindowTextA(hWnd: ?HWND, lpString: LPCSTR) callconv(WINAPI) BOOL;

pub extern "user32" fn GetAsyncKeyState(vKey: c_int) callconv(WINAPI) SHORT;

pub extern "user32" fn GetKeyState(vKey: c_int) callconv(WINAPI) SHORT;

pub extern "user32" fn LoadCursorA(hInstance: ?HINSTANCE, lpCursorName: LPCSTR) callconv(WINAPI) ?HCURSOR;

pub const TME_LEAVE = 0x00000002;

pub const TRACKMOUSEEVENT = extern struct {
    cbSize: DWORD,
    dwFlags: DWORD,
    hwndTrack: ?HWND,
    dwHoverTime: DWORD,
};
pub extern "user32" fn TrackMouseEvent(event: *TRACKMOUSEEVENT) callconv(WINAPI) BOOL;

pub extern "user32" fn SetCapture(hWnd: ?HWND) callconv(WINAPI) ?HWND;

pub extern "user32" fn GetCapture() callconv(WINAPI) ?HWND;

pub extern "user32" fn ReleaseCapture() callconv(WINAPI) BOOL;

pub extern "user32" fn GetForegroundWindow() callconv(WINAPI) ?HWND;

pub extern "user32" fn IsChild(hWndParent: ?HWND, hWnd: ?HWND) callconv(WINAPI) BOOL;

pub extern "user32" fn GetCursorPos(point: *POINT) callconv(WINAPI) BOOL;

pub extern "user32" fn ScreenToClient(hWnd: ?HWND, lpPoint: *POINT) callconv(WINAPI) BOOL;

pub extern "user32" fn RegisterClassExA(*const WNDCLASSEXA) callconv(WINAPI) ATOM;

pub extern "user32" fn GetWindowLongPtrA(hWnd: ?HWND, nIndex: INT) callconv(WINAPI) ?*anyopaque;

pub extern "user32" fn SetWindowLongPtrA(hWnd: ?HWND, nIndex: INT, dwNewLong: ?*anyopaque) callconv(WINAPI) LONG_PTR;

pub extern "user32" fn AdjustWindowRectEx(
    lpRect: *RECT,
    dwStyle: DWORD,
    bMenu: BOOL,
    dwExStyle: DWORD,
) callconv(WINAPI) BOOL;

pub extern "user32" fn CreateWindowExA(
    dwExStyle: DWORD,
    lpClassName: ?LPCSTR,
    lpWindowName: ?LPCSTR,
    dwStyle: DWORD,
    X: i32,
    Y: i32,
    nWidth: i32,
    nHeight: i32,
    hWindParent: ?HWND,
    hMenu: ?HMENU,
    hInstance: HINSTANCE,
    lpParam: ?LPVOID,
) callconv(WINAPI) ?HWND;

pub extern "user32" fn ShowWindow(
    hwnd: HWND,
    nCmdShow: i32,
) callconv(WINAPI) bool;

pub extern "user32" fn IsWindow(hwnd: ?HWND) callconv(WINAPI) bool;

pub extern "user32" fn SetWindowPos(
    hWnd: HWND,
    hWndInsertAfter: ?HWND,
    X: i32,
    Y: i32,
    cx: i32,
    cY: i32,
    uFlags: UINT,
) callconv(WINAPI) bool;

pub extern "user32" fn DestroyWindow(hWnd: HWND) BOOL;

pub extern "user32" fn PostQuitMessage(nExitCode: i32) callconv(WINAPI) void;

pub extern "user32" fn DefWindowProcA(
    hWnd: HWND,
    Msg: UINT,
    wParam: WPARAM,
    lParam: LPARAM,
) callconv(WINAPI) LRESULT;

pub const PM_NOREMOVE = 0x0000;
pub const PM_REMOVE = 0x0001;
pub const PM_NOYIELD = 0x0002;

pub extern "user32" fn PeekMessageA(
    lpMsg: *MSG,
    hWnd: ?HWND,
    wMsgFilterMin: UINT,
    wMsgFilterMax: UINT,
    wRemoveMsg: UINT,
) callconv(WINAPI) BOOL;

pub extern "user32" fn DispatchMessageA(lpMsg: *const MSG) callconv(WINAPI) LRESULT;

pub extern "user32" fn TranslateMessage(lpMsg: *const MSG) callconv(WINAPI) BOOL;

pub const MB_OK = 0x00000000;
pub const MB_ICONHAND = 0x00000010;
pub const MB_ICONERROR = MB_ICONHAND;

pub extern "user32" fn MessageBoxA(
    hWnd: ?HWND,
    lpText: LPCSTR,
    lpCaption: LPCSTR,
    uType: UINT,
) callconv(WINAPI) i32;

pub extern "shell32" fn SHGetKnownFolderPath(
    rfid: *const KNOWNFOLDERID,
    dwFlags: DWORD,
    hToken: ?HANDLE,
    ppszPath: *[*:0]WCHAR,
) callconv(WINAPI) HRESULT;

pub const WS_BORDER = 0x00800000;
pub const WS_OVERLAPPED = 0x00000000;
pub const WS_CHILD = 0x40000000;
pub const WS_CHILDWINDOW = WS_CHILD;
pub const WS_CLIPCHILDREN = 0x02000000;
pub const WS_CLIPSIBLINGS = 0x04000000;
pub const WS_DISABLED = 0x08000000;
pub const WS_GROUP = 0x00020000;
pub const WS_SYSMENU = 0x00080000;
pub const WS_DLGFRAME = 0x00400000;
pub const WS_HSCROLL = 0x00100000;
pub const WS_ICONIC = 0x20000000;
pub const WS_CAPTION = WS_BORDER | WS_DLGFRAME;
pub const WS_MINIMIZE = 0x20000000;
pub const WS_MINIMIZEBOX = 0x00020000;
pub const WS_MAXIMIZE = 0x01000000;
pub const WS_MAXIMIZEBOX = 0x00010000;
pub const WS_THICKFRAME = 0x00040000;
pub const WS_OVERLAPPEDWINDOW = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME |
    WS_MINIMIZEBOX | WS_MAXIMIZEBOX;
pub const WS_POPUP = 0x80000000;
pub const WS_POPUPWINDOW = WS_POPUP | WS_BORDER | WS_SYSMENU;
pub const WS_SIZEBOX = 0x00040000;
pub const WS_TABSTOP = 0x00010000;
pub const WS_TILED = 0x00000000;
pub const WS_TILEDWINDOW = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME |
    WS_MINIMIZEBOX | WS_MAXIMIZEBOX;
pub const WS_VISIBLE = 0x10000000;
pub const WS_VSCROLL = 0x00200000;

pub const WM_MOUSEMOVE = 0x0200;
pub const WM_LBUTTONDOWN = 0x0201;
pub const WM_LBUTTONUP = 0x0202;
pub const WM_LBUTTONDBLCLK = 0x0203;
pub const WM_RBUTTONDOWN = 0x0204;
pub const WM_RBUTTONUP = 0x0205;
pub const WM_RBUTTONDBLCLK = 0x0206;
pub const WM_MBUTTONDOWN = 0x0207;
pub const WM_MBUTTONUP = 0x0208;
pub const WM_MBUTTONDBLCLK = 0x0209;
pub const WM_MOUSEWHEEL = 0x020A;
pub const WM_MOUSELEAVE = 0x02A3;
pub const WM_INPUT = 0x00FF;
pub const WM_KEYDOWN = 0x0100;
pub const WM_KEYUP = 0x0101;
pub const WM_CHAR = 0x0102;
pub const WM_SYSKEYDOWN = 0x0104;
pub const WM_SYSKEYUP = 0x0105;
pub const WM_SETFOCUS = 0x0007;
pub const WM_KILLFOCUS = 0x0008;
pub const WM_CREATE = 0x0001;
pub const WM_DESTROY = 0x0002;
pub const WM_MOVE = 0x0003;
pub const WM_SIZE = 0x0005;
pub const WM_ACTIVATE = 0x0006;
pub const WM_ENABLE = 0x000A;
pub const WM_PAINT = 0x000F;
pub const WM_CLOSE = 0x0010;
pub const WM_QUIT = 0x0012;
pub const WM_GETMINMAXINFO = 0x0024;

pub extern "kernel32" fn GetModuleHandleA(lpModuleName: ?LPCSTR) callconv(WINAPI) ?HMODULE;

pub extern "kernel32" fn LoadLibraryA(lpLibFileName: LPCSTR) callconv(WINAPI) ?HMODULE;

pub extern "kernel32" fn GetProcAddress(hModule: HMODULE, lpProcName: LPCSTR) callconv(WINAPI) ?FARPROC;

pub extern "kernel32" fn ExitProcess(exit_code: UINT) callconv(WINAPI) noreturn;

pub extern "kernel32" fn CreateThread(
    lpThreadAttributes: ?*SECURITY_ATTRIBUTES,
    dwStackSize: SIZE_T,
    lpStartAddress: LPTHREAD_START_ROUTINE,
    lpParameter: ?LPVOID,
    dwCreationFlags: DWORD,
    lpThreadId: ?*DWORD,
) callconv(WINAPI) ?HANDLE;

pub extern "kernel32" fn CreateEventExA(
    lpEventAttributes: ?*SECURITY_ATTRIBUTES,
    lpName: LPCSTR,
    dwFlags: DWORD,
    dwDesiredAccess: DWORD,
) callconv(WINAPI) ?HANDLE;

pub extern "kernel32" fn InitializeCriticalSection(lpCriticalSection: *CRITICAL_SECTION) callconv(WINAPI) void;
pub extern "kernel32" fn EnterCriticalSection(lpCriticalSection: *CRITICAL_SECTION) callconv(WINAPI) void;
pub extern "kernel32" fn LeaveCriticalSection(lpCriticalSection: *CRITICAL_SECTION) callconv(WINAPI) void;
pub extern "kernel32" fn DeleteCriticalSection(lpCriticalSection: *CRITICAL_SECTION) callconv(WINAPI) void;

pub extern "kernel32" fn Sleep(dwMilliseconds: DWORD) void;

pub extern "ntdll" fn RtlGetVersion(lpVersionInformation: *OSVERSIONINFOW) callconv(WINAPI) NTSTATUS;

pub const WNDPROC = *const fn (hwnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM) callconv(WINAPI) LRESULT;

pub const MSG = extern struct {
    hWnd: ?HWND,
    message: UINT,
    wParam: WPARAM,
    lParam: LPARAM,
    time: DWORD,
    pt: POINT,
    lPrivate: DWORD,
};

pub const WNDCLASSEXA = extern struct {
    cbSize: UINT = @sizeOf(WNDCLASSEXA),
    style: UINT,
    lpfnWndProc: WNDPROC,
    cbClsExtra: i32 = 0,
    cbWndExtra: i32 = 0,
    hInstance: HINSTANCE,
    hIcon: ?HICON,
    hCursor: ?HCURSOR,
    hbrBackground: ?HBRUSH,
    lpszMenuName: ?LPCSTR,
    lpszClassName: LPCSTR,
    hIconSm: ?HICON,
};

pub const CS_BYTEALIGNCLIENT: comptime_int = 0x1000;
pub const CS_BYTEALIGNWINDOW: comptime_int = 0x2000;
pub const CS_CLASSDC: comptime_int = 0x0040;
pub const CS_DBLCLKS: comptime_int = 0x0008;
pub const CS_DROPSHADOW: comptime_int = 0x00020000;
pub const CS_GLOBALCLASS: comptime_int = 0x4000;
pub const CS_HREDRAW: comptime_int = 0x0002;
pub const CS_NOCLOSE: comptime_int = 0x0200;
pub const CS_OWNDC: comptime_int = 0x0020;
pub const CS_PARENTDC: comptime_int = 0x0080;
pub const CS_SAVEBITS: comptime_int = 0x0800;
pub const CS_VREDRAW: comptime_int = 0x0001;

pub const INT8 = i8;
pub const UINT8 = u8;
pub const UINT16 = c_ushort;
pub const UINT32 = c_uint;
pub const UINT64 = c_ulonglong;
pub const HMONITOR = HANDLE;
pub const REFERENCE_TIME = c_longlong;
pub const LUID = extern struct {
    LowPart: DWORD,
    HighPart: LONG,
};

pub const VT_UI4 = 19;
pub const VT_I8 = 20;
pub const VT_UI8 = 21;
pub const VT_INT = 22;
pub const VT_UINT = 23;

pub const VARTYPE = u16;

pub const PROPVARIANT = extern struct {
    vt: VARTYPE,
    wReserved1: WORD = 0,
    wReserved2: WORD = 0,
    wReserved3: WORD = 0,
    u: extern union {
        intVal: i32,
        uintVal: u32,
        hVal: i64,
    },
    decVal: u64 = 0,
};
comptime {
    std.debug.assert(@sizeOf(PROPVARIANT) == 24);
}

pub const WHEEL_DELTA = 120;

pub inline fn GET_WHEEL_DELTA_WPARAM(wparam: WPARAM) i16 {
    return @as(i16, @bitCast(@as(u16, @intCast((wparam >> 16) & 0xffff))));
}

pub inline fn GET_X_LPARAM(lparam: LPARAM) i32 {
    return @as(i32, @intCast(@as(i16, @bitCast(@as(u16, @intCast(lparam & 0xffff))))));
}

pub inline fn GET_Y_LPARAM(lparam: LPARAM) i32 {
    return @as(i32, @intCast(@as(i16, @bitCast(@as(u16, @intCast((lparam >> 16) & 0xffff))))));
}

pub inline fn LOWORD(dword: DWORD) WORD {
    return @as(WORD, @bitCast(@as(u16, @intCast(dword & 0xffff))));
}

pub inline fn HIWORD(dword: DWORD) WORD {
    return @as(WORD, @bitCast(@as(u16, @intCast((dword >> 16) & 0xffff))));
}

pub const IID_IUnknown = GUID.parse("{00000000-0000-0000-C000-000000000046}");
pub const IUnknown = extern struct {
    __v: *const VTable,

    pub usingnamespace Methods(@This());

    pub fn Methods(comptime T: type) type {
        return extern struct {
            pub inline fn QueryInterface(self: *T, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
                return @as(*const IUnknown.VTable, @ptrCast(self.__v))
                    .QueryInterface(@as(*IUnknown, @ptrCast(self)), guid, outobj);
            }
            pub inline fn AddRef(self: *T) ULONG {
                return @as(*const IUnknown.VTable, @ptrCast(self.__v)).AddRef(@as(*IUnknown, @ptrCast(self)));
            }
            pub inline fn Release(self: *T) ULONG {
                return @as(*const IUnknown.VTable, @ptrCast(self.__v)).Release(@as(*IUnknown, @ptrCast(self)));
            }
        };
    }

    pub const VTable = extern struct {
        QueryInterface: *const fn (*IUnknown, *const GUID, ?*?*anyopaque) callconv(WINAPI) HRESULT,
        AddRef: *const fn (*IUnknown) callconv(WINAPI) ULONG,
        Release: *const fn (*IUnknown) callconv(WINAPI) ULONG,
    };
};

pub extern "kernel32" fn ExitThread(DWORD) callconv(WINAPI) void;
pub extern "kernel32" fn TerminateThread(HANDLE, DWORD) callconv(WINAPI) BOOL;

pub const CLSCTX_INPROC_SERVER = 0x1;

pub extern "ole32" fn CoCreateInstance(
    rclsid: *const GUID,
    pUnkOuter: ?*IUnknown,
    dwClsContext: DWORD,
    riid: *const GUID,
    ppv: *?*anyopaque,
) callconv(WINAPI) HRESULT;

pub const VK_LBUTTON = 0x01;
pub const VK_RBUTTON = 0x02;
pub const VK_TAB = 0x09;
pub const VK_ESCAPE = 0x1B;
pub const VK_LEFT = 0x25;
pub const VK_UP = 0x26;
pub const VK_RIGHT = 0x27;
pub const VK_DOWN = 0x28;
pub const VK_PRIOR = 0x21;
pub const VK_NEXT = 0x22;
pub const VK_END = 0x23;
pub const VK_HOME = 0x24;
pub const VK_DELETE = 0x2E;
pub const VK_BACK = 0x08;
pub const VK_RETURN = 0x0D;
pub const VK_CONTROL = 0x11;
pub const VK_SHIFT = 0x10;
pub const VK_MENU = 0x12;
pub const VK_SPACE = 0x20;
pub const VK_INSERT = 0x2D;
pub const VK_LSHIFT = 0xA0;
pub const VK_RSHIFT = 0xA1;
pub const VK_LCONTROL = 0xA2;
pub const VK_RCONTROL = 0xA3;
pub const VK_LMENU = 0xA4;
pub const VK_RMENU = 0xA5;
pub const VK_LWIN = 0x5B;
pub const VK_RWIN = 0x5C;
pub const VK_APPS = 0x5D;
pub const VK_OEM_1 = 0xBA;
pub const VK_OEM_PLUS = 0xBB;
pub const VK_OEM_COMMA = 0xBC;
pub const VK_OEM_MINUS = 0xBD;
pub const VK_OEM_PERIOD = 0xBE;
pub const VK_OEM_2 = 0xBF;
pub const VK_OEM_3 = 0xC0;
pub const VK_OEM_4 = 0xDB;
pub const VK_OEM_5 = 0xDC;
pub const VK_OEM_6 = 0xDD;
pub const VK_OEM_7 = 0xDE;
pub const VK_CAPITAL = 0x14;
pub const VK_SCROLL = 0x91;
pub const VK_NUMLOCK = 0x90;
pub const VK_SNAPSHOT = 0x2C;
pub const VK_PAUSE = 0x13;
pub const VK_NUMPAD0 = 0x60;
pub const VK_NUMPAD1 = 0x61;
pub const VK_NUMPAD2 = 0x62;
pub const VK_NUMPAD3 = 0x63;
pub const VK_NUMPAD4 = 0x64;
pub const VK_NUMPAD5 = 0x65;
pub const VK_NUMPAD6 = 0x66;
pub const VK_NUMPAD7 = 0x67;
pub const VK_NUMPAD8 = 0x68;
pub const VK_NUMPAD9 = 0x69;
pub const VK_MULTIPLY = 0x6A;
pub const VK_ADD = 0x6B;
pub const VK_SEPARATOR = 0x6C;
pub const VK_SUBTRACT = 0x6D;
pub const VK_DECIMAL = 0x6E;
pub const VK_DIVIDE = 0x6F;
pub const VK_F1 = 0x70;
pub const VK_F2 = 0x71;
pub const VK_F3 = 0x72;
pub const VK_F4 = 0x73;
pub const VK_F5 = 0x74;
pub const VK_F6 = 0x75;
pub const VK_F7 = 0x76;
pub const VK_F8 = 0x77;
pub const VK_F9 = 0x78;
pub const VK_F10 = 0x79;
pub const VK_F11 = 0x7A;
pub const VK_F12 = 0x7B;

pub const IM_VK_KEYPAD_ENTER = VK_RETURN + 256;

pub const KF_EXTENDED = 0x0100;

pub const GUID_NULL = GUID.parse("{00000000-0000-0000-0000-000000000000}");

pub const PIXELFORMATDESCRIPTOR = extern struct {
    nSize: WORD,
    nVersion: WORD,
    dwFlags: DWORD,
    iPixelType: BYTE,
    cColorBits: BYTE,
    cRedBits: BYTE,
    cRedShift: BYTE,
    cGreenBits: BYTE,
    cGreenShift: BYTE,
    cBlueBits: BYTE,
    cBlueShift: BYTE,
    cAlphaBits: BYTE,
    cAlphaShift: BYTE,
    cAccumBits: BYTE,
    cAccumRedBits: BYTE,
    cAccumGreenBits: BYTE,
    cAccumBlueBits: BYTE,
    cAccumAlphaBits: BYTE,
    cDepthBits: BYTE,
    cStencilBits: BYTE,
    cAuxBuffers: BYTE,
    iLayerType: BYTE,
    bReserved: BYTE,
    dwLayerMask: DWORD,
    dwVisibleMask: DWORD,
    dwDamageMask: DWORD,
};

pub const PFD_DRAW_TO_WINDOW: comptime_int = 0x00000004;
pub const PFD_DRAW_TO_BITMAP: comptime_int = 0x00000008;
pub const PFD_SUPPORT_GDI: comptime_int = 0x00000010;
pub const PFD_SUPPORT_OPENGL: comptime_int = 0x00000020;
pub const PFD_GENERIC_ACCELERATED: comptime_int = 0x00001000;
pub const PFD_GENERIC_FORMAT: comptime_int = 0x00000040;
pub const PFD_NEED_PALETTE: comptime_int = 0x00000080;
pub const PFD_NEED_SYSTEM_PALETTE: comptime_int = 0x00000100;
pub const PFD_DOUBLEBUFFER: comptime_int = 0x00000002;
pub const PFD_STEREO: comptime_int = 0x00000001;
pub const PFD_SWAP_LAYER_BUFFERS: comptime_int = 0x00000800;

pub const PFD_DEPTH_DONTCARE: comptime_int = 0x20000000;
pub const PFD_DOUBLEBUFFER_DONTCARE: comptime_int = 0x40000000;
pub const PFD_STEREO_DONTCARE: comptime_int = 0x80000000;

pub const PFD_SWAP_COPY: comptime_int = 0x00000400;
pub const PFD_SWAP_EXCHANGE: comptime_int = 0x00000200;

pub const PFD_TYPE_RGBA: comptime_int = 0;
pub const PFD_TYPE_COLORINDEX: comptime_int = 1;

pub extern "Gdi32" fn DescribePixelFormat(
    hdc: HDC,
    iPixelFormat: c_int,
    nBytes: UINT,
    ppfd: *const PIXELFORMATDESCRIPTOR,
) callconv(WINAPI) c_int;

pub extern "Gdi32" fn ChoosePixelFormat(
    hdc: HDC,
    ppfd: *const PIXELFORMATDESCRIPTOR,
) callconv(WINAPI) c_int;

pub extern "Gdi32" fn SetPixelFormat(
    hdc: HDC,
    format: c_int,
    ppfd: *const PIXELFORMATDESCRIPTOR,
) callconv(WINAPI) bool;

pub extern "Gdi32" fn SwapBuffers(hdc: HDC) callconv(WINAPI) BOOL;

pub extern "Opengl32" fn wglCreateContext(hdc: HDC) callconv(WINAPI) HGLRC;

pub extern "Opengl32" fn wglDeleteContext(unnamedParam1: HGLRC) callconv(WINAPI) BOOL;

pub extern "Opengl32" fn wglMakeCurrent(
    hdc: HDC,
    glContext: HGLRC,
) callconv(WINAPI) BOOL;

pub extern "Opengl32" fn wglGetProcAddress(unnamedParam1: LPCSTR) callconv(WINAPI) ?PROC;

/// https://docs.microsoft.com/en-us/windows/win32/com/com-error-codes-10
///
/// [DEPRECATED]: Use proc specific errors as in std.os.windows
pub const HResultError =
    MiscError || Error || dxgi.Error || d3d12.Error || d3d11.Error ||
    wasapi.Error || dwrite.Error || xapo.Error || xinput.Error;

pub fn hrPanic(err: HResultError) noreturn {
    std.debug.panic(
        "HRESULT error detected (0x{x}, {}).",
        .{ @as(c_ulong, @bitCast(errorToHRESULT(err))), err },
    );
}

pub inline fn hrPanicOnFail(hr: HRESULT) void {
    if (hr != S_OK) {
        hrPanic(hrToError(hr));
    }
}

/// [DEPRECATED]: Use proc specific errors as in std.os.windows
pub inline fn hrErrorOnFail(hr: HRESULT) HResultError!void {
    if (hr != S_OK) {
        return hrToError(hr);
    }
}

/// [DEPRECATED]: Use proc specific errors as in std.os.windows
pub fn hrToError(hr: HRESULT) HResultError {
    std.debug.assert(hr != S_OK);
    return switch (hr) {
        //
        E_UNEXPECTED => Error.UNEXPECTED,
        E_NOTIMPL => Error.NOTIMPL,
        E_OUTOFMEMORY => Error.OUTOFMEMORY,
        E_INVALIDARG => Error.INVALIDARG,
        E_POINTER => Error.POINTER,
        E_HANDLE => Error.HANDLE,
        E_ABORT => Error.ABORT,
        E_FAIL => Error.FAIL,
        E_ACCESSDENIED => Error.ACCESSDENIED,
        //
        dxgi.ERROR_ACCESS_DENIED => dxgi.Error.ACCESS_DENIED,
        dxgi.ERROR_ACCESS_LOST => dxgi.Error.ACCESS_LOST,
        dxgi.ERROR_ALREADY_EXISTS => dxgi.Error.ALREADY_EXISTS,
        dxgi.ERROR_CANNOT_PROTECT_CONTENT => dxgi.Error.CANNOT_PROTECT_CONTENT,
        dxgi.ERROR_DEVICE_HUNG => dxgi.Error.DEVICE_HUNG,
        dxgi.ERROR_DEVICE_REMOVED => dxgi.Error.DEVICE_REMOVED,
        dxgi.ERROR_DEVICE_RESET => dxgi.Error.DEVICE_RESET,
        dxgi.ERROR_DRIVER_INTERNAL_ERROR => dxgi.Error.DRIVER_INTERNAL_ERROR,
        dxgi.ERROR_FRAME_STATISTICS_DISJOINT => dxgi.Error.FRAME_STATISTICS_DISJOINT,
        dxgi.ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE => dxgi.Error.GRAPHICS_VIDPN_SOURCE_IN_USE,
        dxgi.ERROR_INVALID_CALL => dxgi.Error.INVALID_CALL,
        dxgi.ERROR_MORE_DATA => dxgi.Error.MORE_DATA,
        dxgi.ERROR_NAME_ALREADY_EXISTS => dxgi.Error.NAME_ALREADY_EXISTS,
        dxgi.ERROR_NONEXCLUSIVE => dxgi.Error.NONEXCLUSIVE,
        dxgi.ERROR_NOT_CURRENTLY_AVAILABLE => dxgi.Error.NOT_CURRENTLY_AVAILABLE,
        dxgi.ERROR_NOT_FOUND => dxgi.Error.NOT_FOUND,
        dxgi.ERROR_REMOTE_CLIENT_DISCONNECTED => dxgi.Error.REMOTE_CLIENT_DISCONNECTED,
        dxgi.ERROR_REMOTE_OUTOFMEMORY => dxgi.Error.REMOTE_OUTOFMEMORY,
        dxgi.ERROR_RESTRICT_TO_OUTPUT_STALE => dxgi.Error.RESTRICT_TO_OUTPUT_STALE,
        dxgi.ERROR_SDK_COMPONENT_MISSING => dxgi.Error.SDK_COMPONENT_MISSING,
        dxgi.ERROR_SESSION_DISCONNECTED => dxgi.Error.SESSION_DISCONNECTED,
        dxgi.ERROR_UNSUPPORTED => dxgi.Error.UNSUPPORTED,
        dxgi.ERROR_WAIT_TIMEOUT => dxgi.Error.WAIT_TIMEOUT,
        dxgi.ERROR_WAS_STILL_DRAWING => dxgi.Error.WAS_STILL_DRAWING,
        //
        d3d12.ERROR_ADAPTER_NOT_FOUND => d3d12.Error.ADAPTER_NOT_FOUND,
        d3d12.ERROR_DRIVER_VERSION_MISMATCH => d3d12.Error.DRIVER_VERSION_MISMATCH,
        //
        d3d11.ERROR_FILE_NOT_FOUND => d3d11.Error.FILE_NOT_FOUND,
        d3d11.ERROR_TOO_MANY_UNIQUE_STATE_OBJECTS => d3d11.Error.TOO_MANY_UNIQUE_STATE_OBJECTS,
        d3d11.ERROR_TOO_MANY_UNIQUE_VIEW_OBJECTS => d3d11.Error.TOO_MANY_UNIQUE_VIEW_OBJECTS,
        d3d11.ERROR_DEFERRED_CONTEXT_MAP_WITHOUT_INITIAL_DISCARD => d3d11.Error.DEFERRED_CONTEXT_MAP_WITHOUT_INITIAL_DISCARD,
        //
        wasapi.AUDCLNT_E_NOT_INITIALIZED => wasapi.Error.NOT_INITIALIZED,
        wasapi.AUDCLNT_E_ALREADY_INITIALIZED => wasapi.Error.ALREADY_INITIALIZED,
        wasapi.AUDCLNT_E_WRONG_ENDPOINT_TYPE => wasapi.Error.WRONG_ENDPOINT_TYPE,
        wasapi.AUDCLNT_E_DEVICE_INVALIDATED => wasapi.Error.DEVICE_INVALIDATED,
        wasapi.AUDCLNT_E_NOT_STOPPED => wasapi.Error.NOT_STOPPED,
        wasapi.AUDCLNT_E_BUFFER_TOO_LARGE => wasapi.Error.BUFFER_TOO_LARGE,
        wasapi.AUDCLNT_E_OUT_OF_ORDER => wasapi.Error.OUT_OF_ORDER,
        wasapi.AUDCLNT_E_UNSUPPORTED_FORMAT => wasapi.Error.UNSUPPORTED_FORMAT,
        wasapi.AUDCLNT_E_INVALID_SIZE => wasapi.Error.INVALID_SIZE,
        wasapi.AUDCLNT_E_DEVICE_IN_USE => wasapi.Error.DEVICE_IN_USE,
        wasapi.AUDCLNT_E_BUFFER_OPERATION_PENDING => wasapi.Error.BUFFER_OPERATION_PENDING,
        wasapi.AUDCLNT_E_THREAD_NOT_REGISTERED => wasapi.Error.THREAD_NOT_REGISTERED,
        wasapi.AUDCLNT_E_EXCLUSIVE_MODE_NOT_ALLOWED => wasapi.Error.EXCLUSIVE_MODE_NOT_ALLOWED,
        wasapi.AUDCLNT_E_ENDPOINT_CREATE_FAILED => wasapi.Error.ENDPOINT_CREATE_FAILED,
        wasapi.AUDCLNT_E_SERVICE_NOT_RUNNING => wasapi.Error.SERVICE_NOT_RUNNING,
        wasapi.AUDCLNT_E_EVENTHANDLE_NOT_EXPECTED => wasapi.Error.EVENTHANDLE_NOT_EXPECTED,
        wasapi.AUDCLNT_E_EXCLUSIVE_MODE_ONLY => wasapi.Error.EXCLUSIVE_MODE_ONLY,
        wasapi.AUDCLNT_E_BUFDURATION_PERIOD_NOT_EQUAL => wasapi.Error.BUFDURATION_PERIOD_NOT_EQUAL,
        wasapi.AUDCLNT_E_EVENTHANDLE_NOT_SET => wasapi.Error.EVENTHANDLE_NOT_SET,
        wasapi.AUDCLNT_E_INCORRECT_BUFFER_SIZE => wasapi.Error.INCORRECT_BUFFER_SIZE,
        wasapi.AUDCLNT_E_BUFFER_SIZE_ERROR => wasapi.Error.BUFFER_SIZE_ERROR,
        wasapi.AUDCLNT_E_CPUUSAGE_EXCEEDED => wasapi.Error.CPUUSAGE_EXCEEDED,
        wasapi.AUDCLNT_E_BUFFER_ERROR => wasapi.Error.BUFFER_ERROR,
        wasapi.AUDCLNT_E_BUFFER_SIZE_NOT_ALIGNED => wasapi.Error.BUFFER_SIZE_NOT_ALIGNED,
        wasapi.AUDCLNT_E_INVALID_DEVICE_PERIOD => wasapi.Error.INVALID_DEVICE_PERIOD,
        //
        dwrite.E_FILEFORMAT => dwrite.Error.E_FILEFORMAT,
        //
        xapo.E_FORMAT_UNSUPPORTED => xapo.Error.E_FORMAT_UNSUPPORTED,
        //
        xinput.ERROR_EMPTY => xinput.Error.EMPTY,
        xinput.ERROR_DEVICE_NOT_CONNECTED => xinput.Error.DEVICE_NOT_CONNECTED,
        //
        E_FILE_NOT_FOUND => MiscError.E_FILE_NOT_FOUND,
        S_FALSE => MiscError.S_FALSE,
        // treat unknown error return codes as E_FAIL
        else => blk: {
            std.log.debug("HRESULT error 0x{x} not recognized treating as E_FAIL.", .{@as(c_ulong, @bitCast(hr))});
            break :blk Error.FAIL;
        },
    };
}

pub fn errorToHRESULT(err: HResultError) HRESULT {
    return switch (err) {
        Error.UNEXPECTED => E_UNEXPECTED,
        Error.NOTIMPL => E_NOTIMPL,
        Error.OUTOFMEMORY => E_OUTOFMEMORY,
        Error.INVALIDARG => E_INVALIDARG,
        Error.POINTER => E_POINTER,
        Error.HANDLE => E_HANDLE,
        Error.ABORT => E_ABORT,
        Error.FAIL => E_FAIL,
        Error.ACCESSDENIED => E_ACCESSDENIED,
        //
        dxgi.Error.ACCESS_DENIED => dxgi.ERROR_ACCESS_DENIED,
        dxgi.Error.ACCESS_LOST => dxgi.ERROR_ACCESS_LOST,
        dxgi.Error.ALREADY_EXISTS => dxgi.ERROR_ALREADY_EXISTS,
        dxgi.Error.CANNOT_PROTECT_CONTENT => dxgi.ERROR_CANNOT_PROTECT_CONTENT,
        dxgi.Error.DEVICE_HUNG => dxgi.ERROR_DEVICE_HUNG,
        dxgi.Error.DEVICE_REMOVED => dxgi.ERROR_DEVICE_REMOVED,
        dxgi.Error.DEVICE_RESET => dxgi.ERROR_DEVICE_RESET,
        dxgi.Error.DRIVER_INTERNAL_ERROR => dxgi.ERROR_DRIVER_INTERNAL_ERROR,
        dxgi.Error.FRAME_STATISTICS_DISJOINT => dxgi.ERROR_FRAME_STATISTICS_DISJOINT,
        dxgi.Error.GRAPHICS_VIDPN_SOURCE_IN_USE => dxgi.ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE,
        dxgi.Error.INVALID_CALL => dxgi.ERROR_INVALID_CALL,
        dxgi.Error.MORE_DATA => dxgi.ERROR_MORE_DATA,
        dxgi.Error.NAME_ALREADY_EXISTS => dxgi.ERROR_NAME_ALREADY_EXISTS,
        dxgi.Error.NONEXCLUSIVE => dxgi.ERROR_NONEXCLUSIVE,
        dxgi.Error.NOT_CURRENTLY_AVAILABLE => dxgi.ERROR_NOT_CURRENTLY_AVAILABLE,
        dxgi.Error.NOT_FOUND => dxgi.ERROR_NOT_FOUND,
        dxgi.Error.REMOTE_CLIENT_DISCONNECTED => dxgi.ERROR_REMOTE_CLIENT_DISCONNECTED,
        dxgi.Error.REMOTE_OUTOFMEMORY => dxgi.ERROR_REMOTE_OUTOFMEMORY,
        dxgi.Error.RESTRICT_TO_OUTPUT_STALE => dxgi.ERROR_RESTRICT_TO_OUTPUT_STALE,
        dxgi.Error.SDK_COMPONENT_MISSING => dxgi.ERROR_SDK_COMPONENT_MISSING,
        dxgi.Error.SESSION_DISCONNECTED => dxgi.ERROR_SESSION_DISCONNECTED,
        dxgi.Error.UNSUPPORTED => dxgi.ERROR_UNSUPPORTED,
        dxgi.Error.WAIT_TIMEOUT => dxgi.ERROR_WAIT_TIMEOUT,
        dxgi.Error.WAS_STILL_DRAWING => dxgi.ERROR_WAS_STILL_DRAWING,
        //
        d3d12.Error.ADAPTER_NOT_FOUND => d3d12.ERROR_ADAPTER_NOT_FOUND,
        d3d12.Error.DRIVER_VERSION_MISMATCH => d3d12.ERROR_DRIVER_VERSION_MISMATCH,
        d3d11.Error.FILE_NOT_FOUND => d3d11.ERROR_FILE_NOT_FOUND,
        d3d11.Error.TOO_MANY_UNIQUE_STATE_OBJECTS => d3d11.ERROR_TOO_MANY_UNIQUE_STATE_OBJECTS,
        d3d11.Error.TOO_MANY_UNIQUE_VIEW_OBJECTS => d3d11.ERROR_TOO_MANY_UNIQUE_VIEW_OBJECTS,
        d3d11.Error.DEFERRED_CONTEXT_MAP_WITHOUT_INITIAL_DISCARD => d3d11.ERROR_DEFERRED_CONTEXT_MAP_WITHOUT_INITIAL_DISCARD,
        //
        wasapi.Error.NOT_INITIALIZED => wasapi.AUDCLNT_E_NOT_INITIALIZED,
        wasapi.Error.ALREADY_INITIALIZED => wasapi.AUDCLNT_E_ALREADY_INITIALIZED,
        wasapi.Error.WRONG_ENDPOINT_TYPE => wasapi.AUDCLNT_E_WRONG_ENDPOINT_TYPE,
        wasapi.Error.DEVICE_INVALIDATED => wasapi.AUDCLNT_E_DEVICE_INVALIDATED,
        wasapi.Error.NOT_STOPPED => wasapi.AUDCLNT_E_NOT_STOPPED,
        wasapi.Error.BUFFER_TOO_LARGE => wasapi.AUDCLNT_E_BUFFER_TOO_LARGE,
        wasapi.Error.OUT_OF_ORDER => wasapi.AUDCLNT_E_OUT_OF_ORDER,
        wasapi.Error.UNSUPPORTED_FORMAT => wasapi.AUDCLNT_E_UNSUPPORTED_FORMAT,
        wasapi.Error.INVALID_SIZE => wasapi.AUDCLNT_E_INVALID_SIZE,
        wasapi.Error.DEVICE_IN_USE => wasapi.AUDCLNT_E_DEVICE_IN_USE,
        wasapi.Error.BUFFER_OPERATION_PENDING => wasapi.AUDCLNT_E_BUFFER_OPERATION_PENDING,
        wasapi.Error.THREAD_NOT_REGISTERED => wasapi.AUDCLNT_E_THREAD_NOT_REGISTERED,
        wasapi.Error.EXCLUSIVE_MODE_NOT_ALLOWED => wasapi.AUDCLNT_E_EXCLUSIVE_MODE_NOT_ALLOWED,
        wasapi.Error.ENDPOINT_CREATE_FAILED => wasapi.AUDCLNT_E_ENDPOINT_CREATE_FAILED,
        wasapi.Error.SERVICE_NOT_RUNNING => wasapi.AUDCLNT_E_SERVICE_NOT_RUNNING,
        wasapi.Error.EVENTHANDLE_NOT_EXPECTED => wasapi.AUDCLNT_E_EVENTHANDLE_NOT_EXPECTED,
        wasapi.Error.EXCLUSIVE_MODE_ONLY => wasapi.AUDCLNT_E_EXCLUSIVE_MODE_ONLY,
        wasapi.Error.BUFDURATION_PERIOD_NOT_EQUAL => wasapi.AUDCLNT_E_BUFDURATION_PERIOD_NOT_EQUAL,
        wasapi.Error.EVENTHANDLE_NOT_SET => wasapi.AUDCLNT_E_EVENTHANDLE_NOT_SET,
        wasapi.Error.INCORRECT_BUFFER_SIZE => wasapi.AUDCLNT_E_INCORRECT_BUFFER_SIZE,
        wasapi.Error.BUFFER_SIZE_ERROR => wasapi.AUDCLNT_E_BUFFER_SIZE_ERROR,
        wasapi.Error.CPUUSAGE_EXCEEDED => wasapi.AUDCLNT_E_CPUUSAGE_EXCEEDED,
        wasapi.Error.BUFFER_ERROR => wasapi.AUDCLNT_E_BUFFER_ERROR,
        wasapi.Error.BUFFER_SIZE_NOT_ALIGNED => wasapi.AUDCLNT_E_BUFFER_SIZE_NOT_ALIGNED,
        wasapi.Error.INVALID_DEVICE_PERIOD => wasapi.AUDCLNT_E_INVALID_DEVICE_PERIOD,
        //
        dwrite.Error.E_FILEFORMAT => dwrite.E_FILEFORMAT,
        //
        xapo.Error.E_FORMAT_UNSUPPORTED => xapo.E_FORMAT_UNSUPPORTED,
        //
        xinput.Error.EMPTY => xinput.ERROR_EMPTY,
        xinput.Error.DEVICE_NOT_CONNECTED => xinput.ERROR_DEVICE_NOT_CONNECTED,
        //
        MiscError.E_FILE_NOT_FOUND => E_FILE_NOT_FOUND,
        MiscError.S_FALSE => S_FALSE,
    };
}
