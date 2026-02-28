const windows = @import("../windows.zig");
const IUnknown = windows.IUnknown;
const ULONG = windows.ULONG;
const HRESULT = windows.HRESULT;
const WINAPI = windows.WINAPI;
const GUID = windows.GUID;
const UINT = windows.UINT;
const BOOL = windows.BOOL;

pub const GPU_BASED_VALIDATION_FLAGS = packed struct(UINT) {
    DISABLE_STATE_TRACKING: bool = false,
    __unused: u31 = 0,
};

pub const IDebug = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDebug, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDebug) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDebug) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn EnableDebugLayer(self: *IDebug) void {
        self.__v.EnableDebugLayer(self);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        EnableDebugLayer: *const fn (*IDebug) callconv(WINAPI) void,
    };
};

pub const IDebug1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDebug1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDebug1) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDebug1) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn EnableDebugLayer(self: *IDebug1) void {
        self.__v.EnableDebugLayer(self);
    }
    pub inline fn SetEnableGPUBasedValidation(self: *IDebug1, enable: BOOL) void {
        self.__v.SetEnableGPUBasedValidation(self, enable);
    }
    pub inline fn SetEnableSynchronizedCommandQueueValidation(self: *IDebug1, enable: BOOL) void {
        self.__v.SetEnableSynchronizedCommandQueueValidation(self, enable);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        EnableDebugLayer: *const fn (*IDebug1) callconv(WINAPI) void,
        SetEnableGPUBasedValidation: *const fn (*IDebug1, BOOL) callconv(WINAPI) void,
        SetEnableSynchronizedCommandQueueValidation: *const fn (*IDebug1, BOOL) callconv(WINAPI) void,
    };
};

pub const IDebug2 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDebug2, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDebug2) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDebug2) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn SetGPUBasedValidationFlags(self: *IDebug2, flags: GPU_BASED_VALIDATION_FLAGS) void {
        self.__v.SetGPUBasedValidationFlags(self, flags);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        SetGPUBasedValidationFlags: *const fn (*IDebug2, GPU_BASED_VALIDATION_FLAGS) callconv(WINAPI) void,
    };
};

pub const IDebug3 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDebug3, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDebug.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDebug3) ULONG {
        return IDebug.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDebug3) ULONG {
        return IDebug.Release(@ptrCast(self));
    }
    pub inline fn EnableDebugLayer(self: *IDebug3) void {
        IDebug.EnableDebugLayer(@ptrCast(self));
    }
    pub inline fn SetEnableGPUBasedValidation(self: *IDebug3, enable: BOOL) void {
        self.__v.SetEnableGPUBasedValidation(self, enable);
    }
    pub inline fn SetEnableSynchronizedCommandQueueValidation(self: *IDebug3, enable: BOOL) void {
        self.__v.SetEnableSynchronizedCommandQueueValidation(self, enable);
    }
    pub inline fn SetGPUBasedValidationFlags(self: *IDebug3, flags: GPU_BASED_VALIDATION_FLAGS) void {
        self.__v.SetGPUBasedValidationFlags(self, flags);
    }
    pub const VTable = extern struct {
        base: IDebug.VTable,
        SetEnableGPUBasedValidation: *const fn (*IDebug3, BOOL) callconv(WINAPI) void,
        SetEnableSynchronizedCommandQueueValidation: *const fn (*IDebug3, BOOL) callconv(WINAPI) void,
        SetGPUBasedValidationFlags: *const fn (*IDebug3, GPU_BASED_VALIDATION_FLAGS) callconv(WINAPI) void,
    };
};

pub const IDebug4 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDebug4, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDebug3.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDebug4) ULONG {
        return IDebug3.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDebug4) ULONG {
        return IDebug3.Release(@ptrCast(self));
    }
    pub inline fn EnableDebugLayer(self: *IDebug4) void {
        IDebug3.EnableDebugLayer(@ptrCast(self));
    }
    pub inline fn SetEnableGPUBasedValidation(self: *IDebug4, enable: BOOL) void {
        IDebug3.SetEnableGPUBasedValidation(@ptrCast(self), enable);
    }
    pub inline fn SetEnableSynchronizedCommandQueueValidation(self: *IDebug4, enable: BOOL) void {
        IDebug3.SetEnableSynchronizedCommandQueueValidation(@ptrCast(self), enable);
    }
    pub inline fn SetGPUBasedValidationFlags(self: *IDebug4, flags: GPU_BASED_VALIDATION_FLAGS) void {
        IDebug3.SetGPUBasedValidationFlags(@ptrCast(self), flags);
    }
    pub inline fn DisableDebugLayer(self: *IDebug4) void {
        self.__v.DisableDebugLayer(self);
    }
    pub const VTable = extern struct {
        base: IDebug3.VTable,
        DisableDebugLayer: *const fn (*IDebug4) callconv(WINAPI) void,
    };
};

pub const IDebug5 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDebug5, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDebug4.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDebug5) ULONG {
        return IDebug4.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDebug5) ULONG {
        return IDebug4.Release(@ptrCast(self));
    }
    pub inline fn EnableDebugLayer(self: *IDebug5) void {
        IDebug4.EnableDebugLayer(@ptrCast(self));
    }
    pub inline fn SetEnableGPUBasedValidation(self: *IDebug5, enable: BOOL) void {
        IDebug4.SetEnableGPUBasedValidation(@ptrCast(self), enable);
    }
    pub inline fn SetEnableSynchronizedCommandQueueValidation(self: *IDebug5, enable: BOOL) void {
        IDebug4.SetEnableSynchronizedCommandQueueValidation(@ptrCast(self), enable);
    }
    pub inline fn SetGPUBasedValidationFlags(self: *IDebug5, flags: GPU_BASED_VALIDATION_FLAGS) void {
        IDebug4.SetGPUBasedValidationFlags(@ptrCast(self), flags);
    }
    pub inline fn DisableDebugLayer(self: *IDebug5) void {
        IDebug4.DisableDebugLayer(@ptrCast(self));
    }
    pub inline fn SetEnableAutoName(self: *IDebug5, enable: BOOL) void {
        self.__v.SetEnableAutoName(self, enable);
    }
    pub const VTable = extern struct {
        base: IDebug4.VTable,
        SetEnableAutoName: *const fn (*IDebug5, BOOL) callconv(WINAPI) void,
    };
};

pub const MESSAGE_CATEGORY = enum(UINT) {
    APPLICATION_DEFINED = 0,
    MISCELLANEOUS = 1,
    INITIALIZATION = 2,
    CLEANUP = 3,
    COMPILATION = 4,
    STATE_CREATION = 5,
    STATE_SETTING = 6,
    STATE_GETTING = 7,
    RESOURCE_MANIPULATION = 8,
    EXECUTION = 9,
    SHADER = 10,
};

pub const MESSAGE_SEVERITY = enum(UINT) {
    CORRUPTION = 0,
    ERROR = 1,
    WARNING = 2,
    INFO = 3,
    MESSAGE = 4,
};

pub const MESSAGE_ID = enum(UINT) {
    CLEARRENDERTARGETVIEW_MISMATCHINGCLEARVALUE = 820,
    COMMAND_LIST_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL = 209,
    CREATEGRAPHICSPIPELINESTATE_DEPTHSTENCILVIEW_NOT_SET = 680,
};

pub const INFO_QUEUE_FILTER_DESC = extern struct {
    NumCategories: u32,
    pCategoryList: ?[*]MESSAGE_CATEGORY,
    NumSeverities: u32,
    pSeverityList: ?[*]MESSAGE_SEVERITY,
    NumIDs: u32,
    pIDList: ?[*]MESSAGE_ID,
};

pub const INFO_QUEUE_FILTER = extern struct {
    AllowList: INFO_QUEUE_FILTER_DESC,
    DenyList: INFO_QUEUE_FILTER_DESC,
};

pub const IInfoQueue = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IInfoQueue, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IInfoQueue) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IInfoQueue) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn AddStorageFilterEntries(self: *IInfoQueue, filter: *INFO_QUEUE_FILTER) HRESULT {
        return self.__v.AddStorageFilterEntries(self, filter);
    }
    pub inline fn PushStorageFilter(self: *IInfoQueue, filter: *INFO_QUEUE_FILTER) HRESULT {
        return self.__v.PushStorageFilter(self, filter);
    }
    pub inline fn PopStorageFilter(self: *IInfoQueue) void {
        self.__v.PopStorageFilter(self);
    }
    pub inline fn SetMuteDebugOutput(self: *IInfoQueue, mute: BOOL) void {
        self.__v.SetMuteDebugOutput(self, mute);
    }
    pub const VTable = extern struct {
        const T = IInfoQueue;
        base: IUnknown.VTable,
        SetMessageCountLimit: *anyopaque,
        ClearStoredMessages: *anyopaque,
        GetMessage: *anyopaque,
        GetNumMessagesAllowedByStorageFilter: *anyopaque,
        GetNumMessagesDeniedByStorageFilter: *anyopaque,
        GetNumStoredMessages: *anyopaque,
        GetNumStoredMessagesAllowedByRetrievalFilter: *anyopaque,
        GetNumMessagesDiscardedByMessageCountLimit: *anyopaque,
        GetMessageCountLimit: *anyopaque,
        AddStorageFilterEntries: *const fn (*T, *INFO_QUEUE_FILTER) callconv(WINAPI) HRESULT,
        GetStorageFilter: *anyopaque,
        ClearStorageFilter: *anyopaque,
        PushEmptyStorageFilter: *anyopaque,
        PushCopyOfStorageFilter: *anyopaque,
        PushStorageFilter: *const fn (*T, *INFO_QUEUE_FILTER) callconv(WINAPI) HRESULT,
        PopStorageFilter: *const fn (*T) callconv(WINAPI) void,
        GetStorageFilterStackSize: *anyopaque,
        AddRetrievalFilterEntries: *anyopaque,
        GetRetrievalFilter: *anyopaque,
        ClearRetrievalFilter: *anyopaque,
        PushEmptyRetrievalFilter: *anyopaque,
        PushCopyOfRetrievalFilter: *anyopaque,
        PushRetrievalFilter: *anyopaque,
        PopRetrievalFilter: *anyopaque,
        GetRetrievalFilterStackSize: *anyopaque,
        AddMessage: *anyopaque,
        AddApplicationMessage: *anyopaque,
        SetBreakOnCategory: *anyopaque,
        SetBreakOnSeverity: *anyopaque,
        SetBreakOnID: *anyopaque,
        GetBreakOnCategory: *anyopaque,
        GetBreakOnSeverity: *anyopaque,
        GetBreakOnID: *anyopaque,
        SetMuteDebugOutput: *const fn (*T, BOOL) callconv(WINAPI) void,
        GetMuteDebugOutput: *anyopaque,
    };
};

pub const IID_IDebug = GUID{
    .Data1 = 0x344488b7,
    .Data2 = 0x6846,
    .Data3 = 0x474b,
    .Data4 = .{ 0xb9, 0x89, 0xf0, 0x27, 0x44, 0x82, 0x45, 0xe0 },
};
pub const IID_IDebug1 = GUID{
    .Data1 = 0xaffaa4ca,
    .Data2 = 0x63fe,
    .Data3 = 0x4d8e,
    .Data4 = .{ 0xb8, 0xad, 0x15, 0x90, 0x00, 0xaf, 0x43, 0x04 },
};
pub const IID_IDebug2 = GUID{
    .Data1 = 0x93a665c4,
    .Data2 = 0xa3b2,
    .Data3 = 0x4e5d,
    .Data4 = .{ 0xb6, 0x92, 0xa2, 0x6a, 0xe1, 0x4e, 0x33, 0x74 },
};
pub const IID_IDebug3 = GUID{
    .Data1 = 0x5cf4e58f,
    .Data2 = 0xf671,
    .Data3 = 0x4ff0,
    .Data4 = .{ 0xa5, 0x42, 0x36, 0x86, 0xe3, 0xd1, 0x53, 0xd1 },
};
pub const IID_IDebug4 = GUID{
    .Data1 = 0x014b816e,
    .Data2 = 0x9ec5,
    .Data3 = 0x4a2f,
    .Data4 = .{ 0xa8, 0x45, 0xff, 0xbe, 0x44, 0x1c, 0xe1, 0x3a },
};
pub const IID_IDebug5 = GUID{
    .Data1 = 0x548d6b12,
    .Data2 = 0x09fa,
    .Data3 = 0x40e0,
    .Data4 = .{ 0x90, 0x69, 0x5d, 0xcd, 0x58, 0x9a, 0x52, 0xc9 },
};
pub const IID_IInfoQueue = GUID{
    .Data1 = 0x0742a90b,
    .Data2 = 0xc387,
    .Data3 = 0x483f,
    .Data4 = .{ 0xb9, 0x46, 0x30, 0xa7, 0xe4, 0xe6, 0x14, 0x58 },
};
