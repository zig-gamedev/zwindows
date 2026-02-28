const windows = @import("../windows.zig");
const UINT = windows.UINT;
const UINT64 = windows.UINT64;
const DWORD = windows.DWORD;
const FLOAT = windows.FLOAT;
const BOOL = windows.BOOL;
const GUID = windows.GUID;
const WINAPI = windows.WINAPI;
const IUnknown = windows.IUnknown;
const HRESULT = windows.HRESULT;
const ULONG = windows.ULONG;
const WCHAR = windows.WCHAR;
const RECT = windows.RECT;
const INT = windows.INT;
const BYTE = windows.BYTE;
const HMONITOR = windows.HMONITOR;
const LARGE_INTEGER = windows.LARGE_INTEGER;
const HWND = windows.HWND;
const SIZE_T = windows.SIZE_T;
const LUID = windows.LUID;
const HANDLE = windows.HANDLE;
const POINT = windows.POINT;

pub const FORMAT = enum(UINT) {
    UNKNOWN = 0,
    R32G32B32A32_TYPELESS = 1,
    R32G32B32A32_FLOAT = 2,
    R32G32B32A32_UINT = 3,
    R32G32B32A32_SINT = 4,
    R32G32B32_TYPELESS = 5,
    R32G32B32_FLOAT = 6,
    R32G32B32_UINT = 7,
    R32G32B32_SINT = 8,
    R16G16B16A16_TYPELESS = 9,
    R16G16B16A16_FLOAT = 10,
    R16G16B16A16_UNORM = 11,
    R16G16B16A16_UINT = 12,
    R16G16B16A16_SNORM = 13,
    R16G16B16A16_SINT = 14,
    R32G32_TYPELESS = 15,
    R32G32_FLOAT = 16,
    R32G32_UINT = 17,
    R32G32_SINT = 18,
    R32G8X24_TYPELESS = 19,
    D32_FLOAT_S8X24_UINT = 20,
    R32_FLOAT_X8X24_TYPELESS = 21,
    X32_TYPELESS_G8X24_UINT = 22,
    R10G10B10A2_TYPELESS = 23,
    R10G10B10A2_UNORM = 24,
    R10G10B10A2_UINT = 25,
    R11G11B10_FLOAT = 26,
    R8G8B8A8_TYPELESS = 27,
    R8G8B8A8_UNORM = 28,
    R8G8B8A8_UNORM_SRGB = 29,
    R8G8B8A8_UINT = 30,
    R8G8B8A8_SNORM = 31,
    R8G8B8A8_SINT = 32,
    R16G16_TYPELESS = 33,
    R16G16_FLOAT = 34,
    R16G16_UNORM = 35,
    R16G16_UINT = 36,
    R16G16_SNORM = 37,
    R16G16_SINT = 38,
    R32_TYPELESS = 39,
    D32_FLOAT = 40,
    R32_FLOAT = 41,
    R32_UINT = 42,
    R32_SINT = 43,
    R24G8_TYPELESS = 44,
    D24_UNORM_S8_UINT = 45,
    R24_UNORM_X8_TYPELESS = 46,
    X24_TYPELESS_G8_UINT = 47,
    R8G8_TYPELESS = 48,
    R8G8_UNORM = 49,
    R8G8_UINT = 50,
    R8G8_SNORM = 51,
    R8G8_SINT = 52,
    R16_TYPELESS = 53,
    R16_FLOAT = 54,
    D16_UNORM = 55,
    R16_UNORM = 56,
    R16_UINT = 57,
    R16_SNORM = 58,
    R16_SINT = 59,
    R8_TYPELESS = 60,
    R8_UNORM = 61,
    R8_UINT = 62,
    R8_SNORM = 63,
    R8_SINT = 64,
    A8_UNORM = 65,
    R1_UNORM = 66,
    R9G9B9E5_SHAREDEXP = 67,
    R8G8_B8G8_UNORM = 68,
    G8R8_G8B8_UNORM = 69,
    BC1_TYPELESS = 70,
    BC1_UNORM = 71,
    BC1_UNORM_SRGB = 72,
    BC2_TYPELESS = 73,
    BC2_UNORM = 74,
    BC2_UNORM_SRGB = 75,
    BC3_TYPELESS = 76,
    BC3_UNORM = 77,
    BC3_UNORM_SRGB = 78,
    BC4_TYPELESS = 79,
    BC4_UNORM = 80,
    BC4_SNORM = 81,
    BC5_TYPELESS = 82,
    BC5_UNORM = 83,
    BC5_SNORM = 84,
    B5G6R5_UNORM = 85,
    B5G5R5A1_UNORM = 86,
    B8G8R8A8_UNORM = 87,
    B8G8R8X8_UNORM = 88,
    R10G10B10_XR_BIAS_A2_UNORM = 89,
    B8G8R8A8_TYPELESS = 90,
    B8G8R8A8_UNORM_SRGB = 91,
    B8G8R8X8_TYPELESS = 92,
    B8G8R8X8_UNORM_SRGB = 93,
    BC6H_TYPELESS = 94,
    BC6H_UF16 = 95,
    BC6H_SF16 = 96,
    BC7_TYPELESS = 97,
    BC7_UNORM = 98,
    BC7_UNORM_SRGB = 99,
    AYUV = 100,
    Y410 = 101,
    Y416 = 102,
    NV12 = 103,
    P010 = 104,
    P016 = 105,
    @"420_OPAQUE" = 106,
    YUY2 = 107,
    Y210 = 108,
    Y216 = 109,
    NV11 = 110,
    AI44 = 111,
    IA44 = 112,
    P8 = 113,
    A8P8 = 114,
    B4G4R4A4_UNORM = 115,
    P208 = 130,
    V208 = 131,
    V408 = 132,
    SAMPLER_FEEDBACK_MIN_MIP_OPAQUE = 189,
    SAMPLER_FEEDBACK_MIP_REGION_USED_OPAQUE = 190,

    pub fn pixelSizeInBits(format: FORMAT) u32 {
        return switch (format) {
            .R32G32B32A32_TYPELESS,
            .R32G32B32A32_FLOAT,
            .R32G32B32A32_UINT,
            .R32G32B32A32_SINT,
            => 128,

            .R32G32B32_TYPELESS,
            .R32G32B32_FLOAT,
            .R32G32B32_UINT,
            .R32G32B32_SINT,
            => 96,

            .R16G16B16A16_TYPELESS,
            .R16G16B16A16_FLOAT,
            .R16G16B16A16_UNORM,
            .R16G16B16A16_UINT,
            .R16G16B16A16_SNORM,
            .R16G16B16A16_SINT,
            .R32G32_TYPELESS,
            .R32G32_FLOAT,
            .R32G32_UINT,
            .R32G32_SINT,
            .R32G8X24_TYPELESS,
            .D32_FLOAT_S8X24_UINT,
            .R32_FLOAT_X8X24_TYPELESS,
            .X32_TYPELESS_G8X24_UINT,
            .Y416,
            .Y210,
            .Y216,
            => 64,

            .R10G10B10A2_TYPELESS,
            .R10G10B10A2_UNORM,
            .R10G10B10A2_UINT,
            .R11G11B10_FLOAT,
            .R8G8B8A8_TYPELESS,
            .R8G8B8A8_UNORM,
            .R8G8B8A8_UNORM_SRGB,
            .R8G8B8A8_UINT,
            .R8G8B8A8_SNORM,
            .R8G8B8A8_SINT,
            .R16G16_TYPELESS,
            .R16G16_FLOAT,
            .R16G16_UNORM,
            .R16G16_UINT,
            .R16G16_SNORM,
            .R16G16_SINT,
            .R32_TYPELESS,
            .D32_FLOAT,
            .R32_FLOAT,
            .R32_UINT,
            .R32_SINT,
            .R24G8_TYPELESS,
            .D24_UNORM_S8_UINT,
            .R24_UNORM_X8_TYPELESS,
            .X24_TYPELESS_G8_UINT,
            .R9G9B9E5_SHAREDEXP,
            .R8G8_B8G8_UNORM,
            .G8R8_G8B8_UNORM,
            .B8G8R8A8_UNORM,
            .B8G8R8X8_UNORM,
            .R10G10B10_XR_BIAS_A2_UNORM,
            .B8G8R8A8_TYPELESS,
            .B8G8R8A8_UNORM_SRGB,
            .B8G8R8X8_TYPELESS,
            .B8G8R8X8_UNORM_SRGB,
            .AYUV,
            .Y410,
            .YUY2,
            => 32,

            .P010,
            .P016,
            .V408,
            => 24,

            .R8G8_TYPELESS,
            .R8G8_UNORM,
            .R8G8_UINT,
            .R8G8_SNORM,
            .R8G8_SINT,
            .R16_TYPELESS,
            .R16_FLOAT,
            .D16_UNORM,
            .R16_UNORM,
            .R16_UINT,
            .R16_SNORM,
            .R16_SINT,
            .B5G6R5_UNORM,
            .B5G5R5A1_UNORM,
            .A8P8,
            .B4G4R4A4_UNORM,
            => 16,

            .P208,
            .V208,
            => 16,

            .@"420_OPAQUE",
            .NV11,
            .NV12,
            => 12,

            .R8_TYPELESS,
            .R8_UNORM,
            .R8_UINT,
            .R8_SNORM,
            .R8_SINT,
            .A8_UNORM,
            .AI44,
            .IA44,
            .P8,
            => 8,

            .BC2_TYPELESS,
            .BC2_UNORM,
            .BC2_UNORM_SRGB,
            .BC3_TYPELESS,
            .BC3_UNORM,
            .BC3_UNORM_SRGB,
            .BC5_TYPELESS,
            .BC5_UNORM,
            .BC5_SNORM,
            .BC6H_TYPELESS,
            .BC6H_UF16,
            .BC6H_SF16,
            .BC7_TYPELESS,
            .BC7_UNORM,
            .BC7_UNORM_SRGB,
            => 8,

            .R1_UNORM => 1,

            .BC1_TYPELESS,
            .BC1_UNORM,
            .BC1_UNORM_SRGB,
            .BC4_TYPELESS,
            .BC4_UNORM,
            .BC4_SNORM,
            => 4,

            .UNKNOWN,
            .SAMPLER_FEEDBACK_MIP_REGION_USED_OPAQUE,
            .SAMPLER_FEEDBACK_MIN_MIP_OPAQUE,
            => unreachable,
        };
    }

    pub fn isDepthStencil(format: FORMAT) bool {
        return switch (format) {
            .R32G8X24_TYPELESS,
            .D32_FLOAT_S8X24_UINT,
            .R32_FLOAT_X8X24_TYPELESS,
            .X32_TYPELESS_G8X24_UINT,
            .D32_FLOAT,
            .R24G8_TYPELESS,
            .D24_UNORM_S8_UINT,
            .R24_UNORM_X8_TYPELESS,
            .X24_TYPELESS_G8_UINT,
            .D16_UNORM,
            => true,

            else => false,
        };
    }
};

pub const RATIONAL = extern struct {
    Numerator: UINT,
    Denominator: UINT,
};

// The following values are used with SAMPLE_DESC::Quality:
pub const STANDARD_MULTISAMPLE_QUALITY_PATTERN = 0xffffffff;
pub const CENTER_MULTISAMPLE_QUALITY_PATTERN = 0xfffffffe;

pub const SAMPLE_DESC = extern struct {
    Count: UINT,
    Quality: UINT,
};

pub const COLOR_SPACE_TYPE = enum(UINT) {
    RGB_FULL_G22_NONE_P709 = 0,
    RGB_FULL_G10_NONE_P709 = 1,
    RGB_STUDIO_G22_NONE_P709 = 2,
    RGB_STUDIO_G22_NONE_P2020 = 3,
    RESERVED = 4,
    YCBCR_FULL_G22_NONE_P709_X601 = 5,
    YCBCR_STUDIO_G22_LEFT_P601 = 6,
    YCBCR_FULL_G22_LEFT_P601 = 7,
    YCBCR_STUDIO_G22_LEFT_P709 = 8,
    YCBCR_FULL_G22_LEFT_P709 = 9,
    YCBCR_STUDIO_G22_LEFT_P2020 = 10,
    YCBCR_FULL_G22_LEFT_P2020 = 11,
    RGB_FULL_G2084_NONE_P2020 = 12,
    YCBCR_STUDIO_G2084_LEFT_P2020 = 13,
    RGB_STUDIO_G2084_NONE_P2020 = 14,
    YCBCR_STUDIO_G22_TOPLEFT_P2020 = 15,
    YCBCR_STUDIO_G2084_TOPLEFT_P2020 = 16,
    RGB_FULL_G22_NONE_P2020 = 17,
    YCBCR_STUDIO_GHLG_TOPLEFT_P2020 = 18,
    YCBCR_FULL_GHLG_TOPLEFT_P2020 = 19,
    RGB_STUDIO_G24_NONE_P709 = 20,
    RGB_STUDIO_G24_NONE_P2020 = 21,
    YCBCR_STUDIO_G24_LEFT_P709 = 22,
    YCBCR_STUDIO_G24_LEFT_P2020 = 23,
    YCBCR_STUDIO_G24_TOPLEFT_P2020 = 24,
    CUSTOM = 0xFFFFFFFF,
};

pub const CPU_ACCESS = enum(UINT) {
    NONE = 0,
    DYNAMIC = 1,
    READ_WRITE = 2,
    SCRATCH = 3,
    FIELD = 15,
};

pub const RGB = extern struct {
    Red: FLOAT,
    Green: FLOAT,
    Blue: FLOAT,
};

pub const D3DCOLORVALUE = extern struct {
    r: FLOAT,
    g: FLOAT,
    b: FLOAT,
    a: FLOAT,
};

pub const RGBA = D3DCOLORVALUE;

pub const GAMMA_CONTROL = extern struct {
    Scale: RGB,
    Offset: RGB,
    GammaCurve: [1025]RGB,
};

pub const GAMMA_CONTROL_CAPABILITIES = extern struct {
    ScaleAndOffsetSupported: BOOL,
    MaxConvertedValue: FLOAT,
    MinConvertedValue: FLOAT,
    NumGammaControlPoints: UINT,
    ControlPointPositions: [1025]FLOAT,
};

pub const MODE_SCANLINE_ORDER = enum(UINT) {
    UNSPECIFIED = 0,
    PROGRESSIVE = 1,
    UPPER_FIELD_FIRST = 2,
    LOWER_FIELD_FIRST = 3,
};

pub const MODE_SCALING = enum(UINT) {
    UNSPECIFIED = 0,
    CENTERED = 1,
    STRETCHED = 2,
};

pub const MODE_ROTATION = enum(UINT) {
    UNSPECIFIED = 0,
    IDENTITY = 1,
    ROTATE90 = 2,
    ROTATE180 = 3,
    ROTATE270 = 4,
};

pub const MODE_DESC = extern struct {
    Width: UINT,
    Height: UINT,
    RefreshRate: RATIONAL,
    Format: FORMAT,
    ScanlineOrdering: MODE_SCANLINE_ORDER,
    Scaling: MODE_SCALING,
};

pub const USAGE = packed struct(UINT) {
    __unused0: bool = false,
    __unused1: bool = false,
    __unused2: bool = false,
    __unused3: bool = false,
    SHADER_INPUT: bool = false,
    RENDER_TARGET_OUTPUT: bool = false,
    BACK_BUFFER: bool = false,
    SHARED: bool = false,
    READ_ONLY: bool = false,
    DISCARD_ON_PRESENT: bool = false,
    UNORDERED_ACCESS: bool = false,
    __unused: u21 = 0,
};

pub const FRAME_STATISTICS = extern struct {
    PresentCount: UINT,
    PresentRefreshCount: UINT,
    SyncRefreshCount: UINT,
    SyncQPCTime: LARGE_INTEGER,
    SyncGPUTime: LARGE_INTEGER,
};

pub const MAPPED_RECT = extern struct {
    Pitch: INT,
    pBits: *BYTE,
};

pub const ADAPTER_DESC = extern struct {
    Description: [128]WCHAR,
    VendorId: UINT,
    DeviceId: UINT,
    SubSysId: UINT,
    Revision: UINT,
    DedicatedVideoMemory: SIZE_T,
    DedicatedSystemMemory: SIZE_T,
    SharedSystemMemory: SIZE_T,
    AdapterLuid: LUID,
};

pub const OUTPUT_DESC = extern struct {
    DeviceName: [32]WCHAR,
    DesktopCoordinates: RECT,
    AttachedToDesktop: BOOL,
    Rotation: MODE_ROTATION,
    Monitor: HMONITOR,
};

pub const SHARED_RESOURCE = extern struct {
    Handle: HANDLE,
};

pub const RESOURCE_PRIORITY = enum(UINT) {
    MINIMUM = 0x28000000,
    LOW = 0x50000000,
    NORMAL = 0x78000000,
    HIGH = 0xa0000000,
    MAXIMUM = 0xc8000000,
};

pub const RESIDENCY = enum(UINT) {
    FULLY_RESIDENT = 1,
    RESIDENT_IN_SHARED_MEMORY = 2,
    EVICTED_TO_DISK = 3,
};

pub const SURFACE_DESC = extern struct {
    Width: UINT,
    Height: UINT,
    Format: FORMAT,
    SampleDesc: SAMPLE_DESC,
};

pub const SWAP_EFFECT = enum(UINT) {
    DISCARD = 0,
    SEQUENTIAL = 1,
    FLIP_SEQUENTIAL = 3,
    FLIP_DISCARD = 4,
};

pub const SWAP_CHAIN_FLAG = packed struct(UINT) {
    NONPREROTATED: bool = false,
    ALLOW_MODE_SWITCH: bool = false,
    GDI_COMPATIBLE: bool = false,
    RESTRICTED_CONTENT: bool = false,
    RESTRICT_SHARED_RESOURCE_DRIVER: bool = false,
    DISPLAY_ONLY: bool = false,
    FRAME_LATENCY_WAITABLE_OBJECT: bool = false,
    FOREGROUND_LAYER: bool = false,
    FULLSCREEN_VIDEO: bool = false,
    YUV_VIDEO: bool = false,
    HW_PROTECTED: bool = false,
    ALLOW_TEARING: bool = false,
    RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS: bool = false,
    __unused: u19 = 0,
};

pub const SWAP_CHAIN_DESC = extern struct {
    BufferDesc: MODE_DESC,
    SampleDesc: SAMPLE_DESC,
    BufferUsage: USAGE,
    BufferCount: UINT,
    OutputWindow: HWND,
    Windowed: BOOL,
    SwapEffect: SWAP_EFFECT,
    Flags: SWAP_CHAIN_FLAG,
};

pub const IObject = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IObject, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IObject) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IObject) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IObject, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return self.__v.SetPrivateData(self, guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IObject, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return self.__v.SetPrivateDataInterface(self, guid, data);
    }
    pub inline fn GetPrivateData(self: *IObject, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return self.__v.GetPrivateData(self, guid, data_size, data);
    }
    pub inline fn GetParent(self: *IObject, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return self.__v.GetParent(self, guid, parent);
    }
    pub const VTable = extern struct {
        const T = IObject;
        base: IUnknown.VTable,
        SetPrivateData: *const fn (*T, *const GUID, UINT, *const anyopaque) callconv(WINAPI) HRESULT,
        SetPrivateDataInterface: *const fn (*T, *const GUID, ?*const IUnknown) callconv(WINAPI) HRESULT,
        GetPrivateData: *const fn (*T, *const GUID, *UINT, *anyopaque) callconv(WINAPI) HRESULT,
        GetParent: *const fn (*T, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT,
    };
};

pub const IDeviceSubObject = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceSubObject, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceSubObject) ULONG {
        return IObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceSubObject) ULONG {
        return IObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IDeviceSubObject, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDeviceSubObject, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IDeviceSubObject, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IDeviceSubObject, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDevice(self: *IDeviceSubObject, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return self.__v.GetDevice(self, guid, parent);
    }
    pub const VTable = extern struct {
        base: IObject.VTable,
        GetDevice: *const fn (*IDeviceSubObject, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT,
    };
};

pub const IResource = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IResource, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceSubObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IResource) ULONG {
        return IDeviceSubObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IResource) ULONG {
        return IDeviceSubObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IResource, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IDeviceSubObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IResource, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceSubObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IResource, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IDeviceSubObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IResource, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDeviceSubObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDevice(self: *IResource, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDeviceSubObject.GetDevice(@ptrCast(self), guid, parent);
    }
    pub inline fn GetSharedHandle(self: *IResource, handle: *HANDLE) HRESULT {
        return self.__v.GetSharedHandle(self, handle);
    }
    pub inline fn GetUsage(self: *IResource, usage: *USAGE) HRESULT {
        return self.__v.GetUsage(self, usage);
    }
    pub inline fn SetEvictionPriority(self: *IResource, priority: UINT) HRESULT {
        return self.__v.SetEvictionPriority(self, priority);
    }
    pub inline fn GetEvictionPriority(self: *IResource, priority: *UINT) HRESULT {
        return self.__v.GetEvictionPriority(self, priority);
    }
    pub const VTable = extern struct {
        const T = IResource;
        base: IDeviceSubObject.VTable,
        GetSharedHandle: *const fn (*T, *HANDLE) callconv(WINAPI) HRESULT,
        GetUsage: *const fn (*T, *USAGE) callconv(WINAPI) HRESULT,
        SetEvictionPriority: *const fn (*T, UINT) callconv(WINAPI) HRESULT,
        GetEvictionPriority: *const fn (*T, *UINT) callconv(WINAPI) HRESULT,
    };
};

pub const IKeyedMutex = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IKeyedMutex, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceSubObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IKeyedMutex) ULONG {
        return IDeviceSubObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IKeyedMutex) ULONG {
        return IDeviceSubObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IKeyedMutex, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IDeviceSubObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IKeyedMutex, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceSubObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IKeyedMutex, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IDeviceSubObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IKeyedMutex, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDeviceSubObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDevice(self: *IKeyedMutex, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDeviceSubObject.GetDevice(@ptrCast(self), guid, parent);
    }
    pub inline fn AcquireSync(self: *IKeyedMutex, key: UINT64, milliseconds: DWORD) HRESULT {
        return self.__v.AcquireSync(self, key, milliseconds);
    }
    pub inline fn ReleaseSync(self: *IKeyedMutex, key: UINT64) HRESULT {
        return self.__v.ReleaseSync(self, key);
    }
    pub const VTable = extern struct {
        base: IDeviceSubObject.VTable,
        AcquireSync: *const fn (*IKeyedMutex, UINT64, DWORD) callconv(WINAPI) HRESULT,
        ReleaseSync: *const fn (*IKeyedMutex, UINT64) callconv(WINAPI) HRESULT,
    };
};

pub const MAP_FLAG = packed struct(UINT) {
    READ: bool = false,
    WRITE: bool = false,
    DISCARD: bool = false,
    __unused: u29 = 0,
};

pub const ISurface = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ISurface, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceSubObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ISurface) ULONG {
        return IDeviceSubObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ISurface) ULONG {
        return IDeviceSubObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *ISurface, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IDeviceSubObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ISurface, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceSubObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *ISurface, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IDeviceSubObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *ISurface, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDeviceSubObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDevice(self: *ISurface, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDeviceSubObject.GetDevice(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDesc(self: *ISurface, desc: *SURFACE_DESC) HRESULT {
        return self.__v.GetDesc(self, desc);
    }
    pub inline fn Map(self: *ISurface, locked_rect: *MAPPED_RECT, flags: MAP_FLAG) HRESULT {
        return self.__v.Map(self, locked_rect, flags);
    }
    pub inline fn Unmap(self: *ISurface) HRESULT {
        return self.__v.Unmap(self);
    }
    pub const VTable = extern struct {
        base: IDeviceSubObject.VTable,
        GetDesc: *const fn (*ISurface, *SURFACE_DESC) callconv(WINAPI) HRESULT,
        Map: *const fn (*ISurface, *MAPPED_RECT, MAP_FLAG) callconv(WINAPI) HRESULT,
        Unmap: *const fn (*ISurface) callconv(WINAPI) HRESULT,
    };
};

pub const IAdapter = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IAdapter, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IAdapter) ULONG {
        return IObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IAdapter) ULONG {
        return IObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IAdapter, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IAdapter, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IAdapter, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IAdapter, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumOutputs(self: *IAdapter, index: UINT, output: *?*IOutput) HRESULT {
        return self.__v.EnumOutputs(self, index, output);
    }
    pub inline fn GetDesc(self: *IAdapter, desc: *ADAPTER_DESC) HRESULT {
        return self.__v.GetDesc(self, desc);
    }
    pub inline fn CheckInterfaceSupport(self: *IAdapter, guid: *const GUID, umd_ver: *LARGE_INTEGER) HRESULT {
        return self.__v.CheckInterfaceSupport(self, guid, umd_ver);
    }
    pub const VTable = extern struct {
        base: IObject.VTable,
        EnumOutputs: *const fn (*IAdapter, UINT, *?*IOutput) callconv(WINAPI) HRESULT,
        GetDesc: *const fn (*IAdapter, *ADAPTER_DESC) callconv(WINAPI) HRESULT,
        CheckInterfaceSupport: *const fn (*IAdapter, *const GUID, *LARGE_INTEGER) callconv(WINAPI) HRESULT,
    };
};

pub const ENUM_MODES = packed struct(UINT) {
    INTERLACED: bool = false,
    SCALING: bool = false,
    STEREO: bool = false,
    DISABLED_STEREO: bool = false,
    __unused: u28 = 0,
};

pub const IOutput = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IOutput, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IOutput) ULONG {
        return IObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IOutput) ULONG {
        return IObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IOutput, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IOutput, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IOutput, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IOutput, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDesc(self: *IOutput, desc: *OUTPUT_DESC) HRESULT {
        return self.__v.GetDesc(self, desc);
    }
    pub inline fn GetDisplayModeList(self: *IOutput, enum_format: FORMAT, flags: ENUM_MODES, num_nodes: *UINT, desc: ?*MODE_DESC) HRESULT {
        return self.__v.GetDisplayModeList(self, enum_format, flags, num_nodes, desc);
    }
    pub inline fn FindClosestMatchingMode(self: *IOutput, mode_to_match: *const MODE_DESC, closest_match: *MODE_DESC, concerned_device: ?*IUnknown) HRESULT {
        return self.__v.FindClosestMatchingMode(self, mode_to_match, closest_match, concerned_device);
    }
    pub inline fn WaitForVBlank(self: *IOutput) HRESULT {
        return self.__v.WaitForVBlank(self);
    }
    pub inline fn TakeOwnership(self: *IOutput, device: *IUnknown, exclusive: BOOL) HRESULT {
        return self.__v.TakeOwnership(self, device, exclusive);
    }
    pub inline fn ReleaseOwnership(self: *IOutput) void {
        self.__v.ReleaseOwnership(self);
    }
    pub inline fn GetGammaControlCapabilities(self: *IOutput, gamma_caps: *GAMMA_CONTROL_CAPABILITIES) HRESULT {
        return self.__v.GetGammaControlCapabilities(self, gamma_caps);
    }
    pub inline fn SetGammaControl(self: *IOutput, array: *const GAMMA_CONTROL) HRESULT {
        return self.__v.SetGammaControl(self, array);
    }
    pub inline fn GetGammaControl(self: *IOutput, array: *GAMMA_CONTROL) HRESULT {
        return self.__v.GetGammaControl(self, array);
    }
    pub inline fn SetDisplaySurface(self: *IOutput, scanout_surface: *ISurface) HRESULT {
        return self.__v.SetDisplaySurface(self, scanout_surface);
    }
    pub inline fn GetDisplaySurfaceData(self: *IOutput, destination: *ISurface) HRESULT {
        return self.__v.GetDisplaySurfaceData(self, destination);
    }
    pub inline fn GetFrameStatistics(self: *IOutput, stats: *FRAME_STATISTICS) HRESULT {
        return self.__v.GetFrameStatistics(self, stats);
    }
    pub const VTable = extern struct {
        const T = IOutput;
        base: IObject.VTable,
        GetDesc: *const fn (self: *T, desc: *OUTPUT_DESC) callconv(WINAPI) HRESULT,
        GetDisplayModeList: *const fn (*T, FORMAT, ENUM_MODES, *UINT, ?*MODE_DESC) callconv(WINAPI) HRESULT,
        FindClosestMatchingMode: *const fn (
            *T,
            *const MODE_DESC,
            *MODE_DESC,
            ?*IUnknown,
        ) callconv(WINAPI) HRESULT,
        WaitForVBlank: *const fn (*T) callconv(WINAPI) HRESULT,
        TakeOwnership: *const fn (*T, *IUnknown, BOOL) callconv(WINAPI) HRESULT,
        ReleaseOwnership: *const fn (*T) callconv(WINAPI) void,
        GetGammaControlCapabilities: *const fn (*T, *GAMMA_CONTROL_CAPABILITIES) callconv(WINAPI) HRESULT,
        SetGammaControl: *const fn (*T, *const GAMMA_CONTROL) callconv(WINAPI) HRESULT,
        GetGammaControl: *const fn (*T, *GAMMA_CONTROL) callconv(WINAPI) HRESULT,
        SetDisplaySurface: *const fn (*T, *ISurface) callconv(WINAPI) HRESULT,
        GetDisplaySurfaceData: *const fn (*T, *ISurface) callconv(WINAPI) HRESULT,
        GetFrameStatistics: *const fn (*T, *FRAME_STATISTICS) callconv(WINAPI) HRESULT,
    };
};

pub const MAX_SWAP_CHAIN_BUFFERS = 16;

pub const PRESENT_FLAG = packed struct(UINT) {
    TEST: bool = false,
    DO_NOT_SEQUENCE: bool = false,
    RESTART: bool = false,
    DO_NOT_WAIT: bool = false,
    STEREO_PREFER_RIGHT: bool = false,
    STEREO_TEMPORARY_MONO: bool = false,
    RESTRICT_TO_OUTPUT: bool = false,
    __unused7: bool = false,
    USE_DURATION: bool = false,
    ALLOW_TEARING: bool = false,
    __unused: u22 = 0,
};

pub const ISwapChain = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ISwapChain, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceSubObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ISwapChain) ULONG {
        return IDeviceSubObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ISwapChain) ULONG {
        return IDeviceSubObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *ISwapChain, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IDeviceSubObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ISwapChain, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceSubObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *ISwapChain, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IDeviceSubObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *ISwapChain, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDeviceSubObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDevice(self: *ISwapChain, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDeviceSubObject.GetDevice(@ptrCast(self), guid, parent);
    }
    pub inline fn Present(self: *ISwapChain, sync_interval: UINT, flags: PRESENT_FLAG) HRESULT {
        return self.__v.Present(self, sync_interval, flags);
    }
    pub inline fn GetBuffer(self: *ISwapChain, index: u32, guid: *const GUID, surface: *?*anyopaque) HRESULT {
        return self.__v.GetBuffer(self, index, guid, surface);
    }
    pub inline fn SetFullscreenState(self: *ISwapChain, target: ?*IOutput) HRESULT {
        return self.__v.SetFullscreenState(self, target);
    }
    pub inline fn GetFullscreenState(self: *ISwapChain, fullscreen: ?*BOOL, target: ?*?*IOutput) HRESULT {
        return self.__v.GetFullscreenState(self, fullscreen, target);
    }
    pub inline fn GetDesc(self: *ISwapChain, desc: *SWAP_CHAIN_DESC) HRESULT {
        return self.__v.GetDesc(self, desc);
    }
    pub inline fn ResizeBuffers(self: *ISwapChain, count: UINT, width: UINT, height: UINT, format: FORMAT, flags: SWAP_CHAIN_FLAG) HRESULT {
        return self.__v.ResizeBuffers(self, count, width, height, format, flags);
    }
    pub inline fn ResizeTarget(self: *ISwapChain, params: *const MODE_DESC) HRESULT {
        return self.__v.ResizeTarget(self, params);
    }
    pub inline fn GetContainingOutput(self: *ISwapChain, output: *?*IOutput) HRESULT {
        return self.__v.GetContainingOutput(self, output);
    }
    pub inline fn GetFrameStatistics(self: *ISwapChain, stats: *FRAME_STATISTICS) HRESULT {
        return self.__v.GetFrameStatistics(self, stats);
    }
    pub inline fn GetLastPresentCount(self: *ISwapChain, count: *UINT) HRESULT {
        return self.__v.GetLastPresentCount(self, count);
    }
    pub const VTable = extern struct {
        const T = ISwapChain;
        base: IDeviceSubObject.VTable,
        Present: *const fn (*T, UINT, PRESENT_FLAG) callconv(WINAPI) HRESULT,
        GetBuffer: *const fn (*T, u32, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT,
        SetFullscreenState: *const fn (*T, ?*IOutput) callconv(WINAPI) HRESULT,
        GetFullscreenState: *const fn (*T, ?*BOOL, ?*?*IOutput) callconv(WINAPI) HRESULT,
        GetDesc: *const fn (*T, *SWAP_CHAIN_DESC) callconv(WINAPI) HRESULT,
        ResizeBuffers: *const fn (*T, UINT, UINT, UINT, FORMAT, SWAP_CHAIN_FLAG) callconv(WINAPI) HRESULT,
        ResizeTarget: *const fn (*T, *const MODE_DESC) callconv(WINAPI) HRESULT,
        GetContainingOutput: *const fn (*T, *?*IOutput) callconv(WINAPI) HRESULT,
        GetFrameStatistics: *const fn (*T, *FRAME_STATISTICS) callconv(WINAPI) HRESULT,
        GetLastPresentCount: *const fn (*T, *UINT) callconv(WINAPI) HRESULT,
    };
};

pub const MWA_FLAGS = packed struct(UINT) {
    NO_WINDOW_CHANGES: bool = false,
    NO_ALT_ENTER: bool = false,
    NO_PRINT_SCREEN: bool = false,
    __unused: u29 = 0,
};

pub const IFactory = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory) ULONG {
        return IObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory) ULONG {
        return IObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IFactory, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFactory, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IFactory, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IFactory, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumAdapters(self: *IFactory, index: UINT, adapter: *?*IAdapter) HRESULT {
        return self.__v.EnumAdapters(self, index, adapter);
    }
    pub inline fn MakeWindowAssociation(self: *IFactory, window: HWND, flags: MWA_FLAGS) HRESULT {
        return self.__v.MakeWindowAssociation(self, window, flags);
    }
    pub inline fn GetWindowAssociation(self: *IFactory, window: *HWND) HRESULT {
        return self.__v.GetWindowAssociation(self, window);
    }
    pub inline fn CreateSwapChain(self: *IFactory, device: *IUnknown, desc: *SWAP_CHAIN_DESC, swapchain: *?*ISwapChain) HRESULT {
        return self.__v.CreateSwapChain(self, device, desc, swapchain);
    }
    pub inline fn CreateSoftwareAdapter(self: *IFactory, adapter: *?*IAdapter) HRESULT {
        return self.__v.CreateSoftwareAdapter(self, adapter);
    }
    pub const VTable = extern struct {
        const T = IFactory;
        base: IObject.VTable,
        EnumAdapters: *const fn (*T, UINT, *?*IAdapter) callconv(WINAPI) HRESULT,
        MakeWindowAssociation: *const fn (*T, HWND, MWA_FLAGS) callconv(WINAPI) HRESULT,
        GetWindowAssociation: *const fn (*T, *HWND) callconv(WINAPI) HRESULT,
        CreateSwapChain: *const fn (*T, *IUnknown, *SWAP_CHAIN_DESC, *?*ISwapChain) callconv(WINAPI) HRESULT,
        CreateSoftwareAdapter: *const fn (*T, *?*IAdapter) callconv(WINAPI) HRESULT,
    };
};

pub const IDevice = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice) ULONG {
        return IObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice) ULONG {
        return IObject.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IDevice, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IDevice, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IDevice, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IObject.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetAdapter(self: *IDevice, adapter: *?*IAdapter) HRESULT {
        return self.__v.GetAdapter(self, adapter);
    }
    pub inline fn CreateSurface(self: *IDevice, desc: *const SURFACE_DESC, num_surfaces: UINT, usage: USAGE, shared_resource: ?*const SHARED_RESOURCE, surface: *?*ISurface) HRESULT {
        return self.__v.CreateSurface(self, desc, num_surfaces, usage, shared_resource, surface);
    }
    pub inline fn QueryResourceResidency(self: *IDevice, resources: *const *IUnknown, status: [*]RESIDENCY, num_resources: UINT) HRESULT {
        return self.__v.QueryResourceResidency(self, resources, status, num_resources);
    }
    pub inline fn SetGPUThreadPriority(self: *IDevice, priority: INT) HRESULT {
        return self.__v.SetGPUThreadPriority(self, priority);
    }
    pub inline fn GetGPUThreadPriority(self: *IDevice, priority: *INT) HRESULT {
        return self.__v.GetGPUThreadPriority(self, priority);
    }
    pub const VTable = extern struct {
        const T = IDevice;
        base: IObject.VTable,
        GetAdapter: *const fn (self: *T, adapter: *?*IAdapter) callconv(WINAPI) HRESULT,
        CreateSurface: *const fn (
            *T,
            *const SURFACE_DESC,
            UINT,
            USAGE,
            ?*const SHARED_RESOURCE,
            *?*ISurface,
        ) callconv(WINAPI) HRESULT,
        QueryResourceResidency: *const fn (
            *T,
            *const *IUnknown,
            [*]RESIDENCY,
            UINT,
        ) callconv(WINAPI) HRESULT,
        SetGPUThreadPriority: *const fn (self: *T, priority: INT) callconv(WINAPI) HRESULT,
        GetGPUThreadPriority: *const fn (self: *T, priority: *INT) callconv(WINAPI) HRESULT,
    };
};

pub const ADAPTER_FLAGS = packed struct(UINT) {
    REMOTE: bool = false,
    SOFTWARE: bool = false,
    __unused: u30 = 0,
};

pub const ADAPTER_DESC1 = extern struct {
    Description: [128]WCHAR,
    VendorId: UINT,
    DeviceId: UINT,
    SubSysId: UINT,
    Revision: UINT,
    DedicatedVideoMemory: SIZE_T,
    DedicatedSystemMemory: SIZE_T,
    SharedSystemMemory: SIZE_T,
    AdapterLuid: LUID,
    Flags: ADAPTER_FLAGS,
};

pub const GRAPHICS_PREEMPTION_GRANULARITY = enum(UINT) {
    DMA_BUFFER_BOUNDARY = 0,
    PRIMITIVE_BOUNDARY = 1,
    TRIANGLE_BOUNDARY = 2,
    PIXEL_BOUNDARY = 3,
    INSTRUCTION_BOUNDARY = 4,
};

pub const COMPUTE_PREEMPTION_GRANULARITY = enum(UINT) {
    DMA_BUFFER_BOUNDARY = 0,
    PRIMITIVE_BOUNDARY = 1,
    TRIANGLE_BOUNDARY = 2,
    PIXEL_BOUNDARY = 3,
    INSTRUCTION_BOUNDARY = 4,
};

pub const ADAPTER_DESC2 = extern struct {
    Description: [128]WCHAR,
    VendorId: UINT,
    DeviceId: UINT,
    SubSysId: UINT,
    Revision: UINT,
    DedicatedVideoMemory: SIZE_T,
    DedicatedSystemMemory: SIZE_T,
    SharedSystemMemory: SIZE_T,
    AdapterLuid: LUID,
    Flags: ADAPTER_FLAGS,
    GraphicsPreemptionGranularity: GRAPHICS_PREEMPTION_GRANULARITY,
    ComputePreemptionGranularity: COMPUTE_PREEMPTION_GRANULARITY,
};

pub const IFactory1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IFactory.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory1) ULONG {
        return IFactory.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory1) ULONG {
        return IFactory.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IFactory1, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IFactory.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFactory1, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IFactory.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IFactory1, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IFactory.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IFactory1, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IFactory.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumAdapters(self: *IFactory1, index: UINT, adapter: *?*IAdapter) HRESULT {
        return IFactory.EnumAdapters(@ptrCast(self), index, adapter);
    }
    pub inline fn MakeWindowAssociation(self: *IFactory1, window: HWND, flags: MWA_FLAGS) HRESULT {
        return IFactory.MakeWindowAssociation(@ptrCast(self), window, flags);
    }
    pub inline fn GetWindowAssociation(self: *IFactory1, window: *HWND) HRESULT {
        return IFactory.GetWindowAssociation(@ptrCast(self), window);
    }
    pub inline fn CreateSwapChain(self: *IFactory1, device: *IUnknown, desc: *SWAP_CHAIN_DESC, swapchain: *?*ISwapChain) HRESULT {
        return IFactory.CreateSwapChain(@ptrCast(self), device, desc, swapchain);
    }
    pub inline fn CreateSoftwareAdapter(self: *IFactory1, adapter: *?*IAdapter) HRESULT {
        return IFactory.CreateSoftwareAdapter(@ptrCast(self), adapter);
    }
    pub inline fn EnumAdapters1(self: *IFactory1, index: UINT, adapter: *?*IAdapter1) HRESULT {
        return self.__v.EnumAdapters1(self, index, adapter);
    }
    pub inline fn IsCurrent(self: *IFactory1) BOOL {
        return self.__v.IsCurrent(self);
    }
    pub const VTable = extern struct {
        base: IFactory.VTable,
        EnumAdapters1: *const fn (*IFactory1, UINT, *?*IAdapter1) callconv(WINAPI) HRESULT,
        IsCurrent: *const fn (*IFactory1) callconv(WINAPI) BOOL,
    };
};

pub const IFactory2 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory2, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IFactory1.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory2) ULONG {
        return IFactory1.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory2) ULONG {
        return IFactory1.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IFactory2, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IFactory1.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFactory2, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IFactory1.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IFactory2, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IFactory1.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IFactory2, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IFactory1.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumAdapters(self: *IFactory2, index: UINT, adapter: *?*IAdapter) HRESULT {
        return IFactory1.EnumAdapters(@ptrCast(self), index, adapter);
    }
    pub inline fn MakeWindowAssociation(self: *IFactory2, window: HWND, flags: MWA_FLAGS) HRESULT {
        return IFactory1.MakeWindowAssociation(@ptrCast(self), window, flags);
    }
    pub inline fn GetWindowAssociation(self: *IFactory2, window: *HWND) HRESULT {
        return IFactory1.GetWindowAssociation(@ptrCast(self), window);
    }
    pub inline fn CreateSwapChain(self: *IFactory2, device: *IUnknown, desc: *SWAP_CHAIN_DESC, swapchain: *?*ISwapChain) HRESULT {
        return IFactory1.CreateSwapChain(@ptrCast(self), device, desc, swapchain);
    }
    pub inline fn CreateSoftwareAdapter(self: *IFactory2, adapter: *?*IAdapter) HRESULT {
        return IFactory1.CreateSoftwareAdapter(@ptrCast(self), adapter);
    }
    pub inline fn EnumAdapters1(self: *IFactory2, index: UINT, adapter: *?*IAdapter1) HRESULT {
        return IFactory1.EnumAdapters1(@ptrCast(self), index, adapter);
    }
    pub inline fn IsCurrent(self: *IFactory2) BOOL {
        return IFactory1.IsCurrent(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IFactory1.VTable,
        IsWindowedStereoEnabled: *anyopaque,
        CreateSwapChainForHwnd: *anyopaque,
        CreateSwapChainForCoreWindow: *anyopaque,
        GetSharedResourceAdapterLuid: *anyopaque,
        RegisterStereoStatusWindow: *anyopaque,
        RegisterStereoStatusEvent: *anyopaque,
        UnregisterStereoStatus: *anyopaque,
        RegisterOcclusionStatusWindow: *anyopaque,
        RegisterOcclusionStatusEvent: *anyopaque,
        UnregisterOcclusionStatus: *anyopaque,
        CreateSwapChainForComposition: *anyopaque,
    };
};

pub const IFactory3 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory3, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IFactory2.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory3) ULONG {
        return IFactory2.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory3) ULONG {
        return IFactory2.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IFactory3, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IFactory2.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFactory3, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IFactory2.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IFactory3, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IFactory2.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IFactory3, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IFactory2.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumAdapters(self: *IFactory3, index: UINT, adapter: *?*IAdapter) HRESULT {
        return IFactory2.EnumAdapters(@ptrCast(self), index, adapter);
    }
    pub inline fn MakeWindowAssociation(self: *IFactory3, window: HWND, flags: MWA_FLAGS) HRESULT {
        return IFactory2.MakeWindowAssociation(@ptrCast(self), window, flags);
    }
    pub inline fn GetWindowAssociation(self: *IFactory3, window: *HWND) HRESULT {
        return IFactory2.GetWindowAssociation(@ptrCast(self), window);
    }
    pub inline fn CreateSwapChain(self: *IFactory3, device: *IUnknown, desc: *SWAP_CHAIN_DESC, swapchain: *?*ISwapChain) HRESULT {
        return IFactory2.CreateSwapChain(@ptrCast(self), device, desc, swapchain);
    }
    pub inline fn CreateSoftwareAdapter(self: *IFactory3, adapter: *?*IAdapter) HRESULT {
        return IFactory2.CreateSoftwareAdapter(@ptrCast(self), adapter);
    }
    pub inline fn EnumAdapters1(self: *IFactory3, index: UINT, adapter: *?*IAdapter1) HRESULT {
        return IFactory2.EnumAdapters1(@ptrCast(self), index, adapter);
    }
    pub inline fn IsCurrent(self: *IFactory3) BOOL {
        return IFactory2.IsCurrent(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IFactory2.VTable,
        GetCreationFlags: *anyopaque,
    };
};

pub const IFactory4 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory4, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IFactory3.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory4) ULONG {
        return IFactory3.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory4) ULONG {
        return IFactory3.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IFactory4, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IFactory3.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFactory4, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IFactory3.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IFactory4, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IFactory3.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IFactory4, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IFactory3.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumAdapters(self: *IFactory4, index: UINT, adapter: *?*IAdapter) HRESULT {
        return IFactory3.EnumAdapters(@ptrCast(self), index, adapter);
    }
    pub inline fn MakeWindowAssociation(self: *IFactory4, window: HWND, flags: MWA_FLAGS) HRESULT {
        return IFactory3.MakeWindowAssociation(@ptrCast(self), window, flags);
    }
    pub inline fn GetWindowAssociation(self: *IFactory4, window: *HWND) HRESULT {
        return IFactory3.GetWindowAssociation(@ptrCast(self), window);
    }
    pub inline fn CreateSwapChain(self: *IFactory4, device: *IUnknown, desc: *SWAP_CHAIN_DESC, swapchain: *?*ISwapChain) HRESULT {
        return IFactory3.CreateSwapChain(@ptrCast(self), device, desc, swapchain);
    }
    pub inline fn CreateSoftwareAdapter(self: *IFactory4, adapter: *?*IAdapter) HRESULT {
        return IFactory3.CreateSoftwareAdapter(@ptrCast(self), adapter);
    }
    pub inline fn EnumAdapters1(self: *IFactory4, index: UINT, adapter: *?*IAdapter1) HRESULT {
        return IFactory3.EnumAdapters1(@ptrCast(self), index, adapter);
    }
    pub inline fn IsCurrent(self: *IFactory4) BOOL {
        return IFactory3.IsCurrent(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IFactory3.VTable,
        EnumAdapterByLuid: *anyopaque,
        EnumWarpAdapter: *anyopaque,
    };
};

pub const FEATURE = enum(UINT) {
    PRESENT_ALLOW_TEARING = 0,
};

pub const IID_IFactory5 = GUID.parse("{7632e1f5-ee65-4dca-87fd-84cd75f8838d}");
pub const IFactory5 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory5, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IFactory4.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory5) ULONG {
        return IFactory4.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory5) ULONG {
        return IFactory4.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IFactory5, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IFactory4.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFactory5, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IFactory4.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IFactory5, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IFactory4.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IFactory5, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IFactory4.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumAdapters(self: *IFactory5, index: UINT, adapter: *?*IAdapter) HRESULT {
        return IFactory4.EnumAdapters(@ptrCast(self), index, adapter);
    }
    pub inline fn MakeWindowAssociation(self: *IFactory5, window: HWND, flags: MWA_FLAGS) HRESULT {
        return IFactory4.MakeWindowAssociation(@ptrCast(self), window, flags);
    }
    pub inline fn GetWindowAssociation(self: *IFactory5, window: *HWND) HRESULT {
        return IFactory4.GetWindowAssociation(@ptrCast(self), window);
    }
    pub inline fn CreateSwapChain(self: *IFactory5, device: *IUnknown, desc: *SWAP_CHAIN_DESC, swapchain: *?*ISwapChain) HRESULT {
        return IFactory4.CreateSwapChain(@ptrCast(self), device, desc, swapchain);
    }
    pub inline fn CreateSoftwareAdapter(self: *IFactory5, adapter: *?*IAdapter) HRESULT {
        return IFactory4.CreateSoftwareAdapter(@ptrCast(self), adapter);
    }
    pub inline fn EnumAdapters1(self: *IFactory5, index: UINT, adapter: *?*IAdapter1) HRESULT {
        return IFactory4.EnumAdapters1(@ptrCast(self), index, adapter);
    }
    pub inline fn IsCurrent(self: *IFactory5) BOOL {
        return IFactory4.IsCurrent(@ptrCast(self));
    }
    pub inline fn CheckFeatureSupport(self: *IFactory5, feature: FEATURE, support_data: *anyopaque, support_data_size: UINT) HRESULT {
        return self.__v.CheckFeatureSupport(self, feature, support_data, support_data_size);
    }
    pub const VTable = extern struct {
        base: IFactory4.VTable,
        CheckFeatureSupport: *const fn (*IFactory5, FEATURE, *anyopaque, UINT) callconv(WINAPI) HRESULT,
    };
};

pub const GPU_PREFERENCE = enum(UINT) {
    UNSPECIFIED,
    MINIMUM,
    HIGH_PERFORMANCE,
};

pub const IID_IFactory6 = GUID.parse("{c1b6694f-ff09-44a9-b03c-77900a0a1d17}");
pub const IFactory6 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory6, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IFactory5.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory6) ULONG {
        return IFactory5.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory6) ULONG {
        return IFactory5.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IFactory6, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IFactory5.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFactory6, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IFactory5.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IFactory6, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IFactory5.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IFactory6, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IFactory5.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumAdapters(self: *IFactory6, index: UINT, adapter: *?*IAdapter) HRESULT {
        return IFactory5.EnumAdapters(@ptrCast(self), index, adapter);
    }
    pub inline fn MakeWindowAssociation(self: *IFactory6, window: HWND, flags: MWA_FLAGS) HRESULT {
        return IFactory5.MakeWindowAssociation(@ptrCast(self), window, flags);
    }
    pub inline fn GetWindowAssociation(self: *IFactory6, window: *HWND) HRESULT {
        return IFactory5.GetWindowAssociation(@ptrCast(self), window);
    }
    pub inline fn CreateSwapChain(self: *IFactory6, device: *IUnknown, desc: *SWAP_CHAIN_DESC, swapchain: *?*ISwapChain) HRESULT {
        return IFactory5.CreateSwapChain(@ptrCast(self), device, desc, swapchain);
    }
    pub inline fn CreateSoftwareAdapter(self: *IFactory6, adapter: *?*IAdapter) HRESULT {
        return IFactory5.CreateSoftwareAdapter(@ptrCast(self), adapter);
    }
    pub inline fn EnumAdapters1(self: *IFactory6, index: UINT, adapter: *?*IAdapter1) HRESULT {
        return IFactory5.EnumAdapters1(@ptrCast(self), index, adapter);
    }
    pub inline fn IsCurrent(self: *IFactory6) BOOL {
        return IFactory5.IsCurrent(@ptrCast(self));
    }
    pub inline fn CheckFeatureSupport(self: *IFactory6, feature: FEATURE, support_data: *anyopaque, support_data_size: UINT) HRESULT {
        return IFactory5.CheckFeatureSupport(@ptrCast(self), feature, support_data, support_data_size);
    }
    pub inline fn EnumAdapterByGpuPreference(self: *IFactory6, adapter_index: UINT, gpu_preference: GPU_PREFERENCE, riid: *const GUID, adapter: *?*IAdapter3) HRESULT {
        return self.__v.EnumAdapterByGpuPreference(self, adapter_index, gpu_preference, riid, adapter);
    }
    pub const VTable = extern struct {
        base: IFactory5.VTable,
        EnumAdapterByGpuPreference: *const fn (
            *IFactory6,
            UINT,
            GPU_PREFERENCE,
            *const GUID,
            *?*IAdapter3,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const IID_IAdapter1 = GUID.parse("{29038f61-3839-4626-91fd-086879011a05}");
pub const IAdapter1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IAdapter1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IAdapter.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IAdapter1) ULONG {
        return IAdapter.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IAdapter1) ULONG {
        return IAdapter.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IAdapter1, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IAdapter.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IAdapter1, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IAdapter.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IAdapter1, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IAdapter.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IAdapter1, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IAdapter.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumOutputs(self: *IAdapter1, index: UINT, output: *?*IOutput) HRESULT {
        return IAdapter.EnumOutputs(@ptrCast(self), index, output);
    }
    pub inline fn GetDesc(self: *IAdapter1, desc: *ADAPTER_DESC) HRESULT {
        return IAdapter.GetDesc(@ptrCast(self), desc);
    }
    pub inline fn CheckInterfaceSupport(self: *IAdapter1, guid: *const GUID, umd_ver: *LARGE_INTEGER) HRESULT {
        return IAdapter.CheckInterfaceSupport(@ptrCast(self), guid, umd_ver);
    }
    pub inline fn GetDesc1(self: *IAdapter1, desc: *ADAPTER_DESC1) HRESULT {
        return self.__v.GetDesc1(self, desc);
    }
    pub const VTable = extern struct {
        base: IAdapter.VTable,
        GetDesc1: *const fn (*IAdapter1, *ADAPTER_DESC1) callconv(WINAPI) HRESULT,
    };
};

pub const IID_IAdapter2 = GUID.parse("{0AA1AE0A-FA0E-4B84-8644-E05FF8E5ACB5}");
pub const IAdapter2 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IAdapter2, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IAdapter1.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IAdapter2) ULONG {
        return IAdapter1.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IAdapter2) ULONG {
        return IAdapter1.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IAdapter2, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IAdapter1.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IAdapter2, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IAdapter1.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IAdapter2, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IAdapter1.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IAdapter2, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IAdapter1.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumOutputs(self: *IAdapter2, index: UINT, output: *?*IOutput) HRESULT {
        return IAdapter1.EnumOutputs(@ptrCast(self), index, output);
    }
    pub inline fn GetDesc(self: *IAdapter2, desc: *ADAPTER_DESC) HRESULT {
        return IAdapter1.GetDesc(@ptrCast(self), desc);
    }
    pub inline fn CheckInterfaceSupport(self: *IAdapter2, guid: *const GUID, umd_ver: *LARGE_INTEGER) HRESULT {
        return IAdapter1.CheckInterfaceSupport(@ptrCast(self), guid, umd_ver);
    }
    pub inline fn GetDesc1(self: *IAdapter2, desc: *ADAPTER_DESC1) HRESULT {
        return IAdapter1.GetDesc1(@ptrCast(self), desc);
    }
    pub inline fn GetDesc2(self: *IAdapter2, desc: *ADAPTER_DESC2) HRESULT {
        return self.__v.GetDesc2(self, desc);
    }
    pub const VTable = extern struct {
        base: IAdapter1.VTable,
        GetDesc2: *const fn (*IAdapter2, *ADAPTER_DESC2) callconv(WINAPI) HRESULT,
    };
};

pub const MEMORY_SEGMENT_GROUP = enum(UINT) {
    LOCAL = 0,
    NON_LOCAL = 1,
};

pub const QUERY_VIDEO_MEMORY_INFO = extern struct {
    Budget: UINT64,
    CurrentUsage: UINT64,
    AvailableForReservation: UINT64,
    CurrentReservation: UINT64,
};

pub const IID_IAdapter3 = GUID.parse("{645967A4-1392-4310-A798-8053CE3E93FD}");
pub const IAdapter3 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IAdapter3, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IAdapter2.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IAdapter3) ULONG {
        return IAdapter2.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IAdapter3) ULONG {
        return IAdapter2.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IAdapter3, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IAdapter2.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IAdapter3, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IAdapter2.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IAdapter3, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IAdapter2.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IAdapter3, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IAdapter2.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn EnumOutputs(self: *IAdapter3, index: UINT, output: *?*IOutput) HRESULT {
        return IAdapter2.EnumOutputs(@ptrCast(self), index, output);
    }
    pub inline fn GetDesc(self: *IAdapter3, desc: *ADAPTER_DESC) HRESULT {
        return IAdapter2.GetDesc(@ptrCast(self), desc);
    }
    pub inline fn CheckInterfaceSupport(self: *IAdapter3, guid: *const GUID, umd_ver: *LARGE_INTEGER) HRESULT {
        return IAdapter2.CheckInterfaceSupport(@ptrCast(self), guid, umd_ver);
    }
    pub inline fn GetDesc1(self: *IAdapter3, desc: *ADAPTER_DESC1) HRESULT {
        return IAdapter2.GetDesc1(@ptrCast(self), desc);
    }
    pub inline fn GetDesc2(self: *IAdapter3, desc: *ADAPTER_DESC2) HRESULT {
        return IAdapter2.GetDesc2(@ptrCast(self), desc);
    }
    pub inline fn RegisterHardwareContentProtectionTeardownStatusEvent(self: *IAdapter3, event: HANDLE, cookie: *DWORD) HRESULT {
        return self.__v.RegisterHardwareContentProtectionTeardownStatusEvent(self, event, cookie);
    }
    pub inline fn UnregisterHardwareContentProtectionTeardownStatus(self: *IAdapter3, cookie: DWORD) void {
        self.__v.UnregisterHardwareContentProtectionTeardownStatus(self, cookie);
    }
    pub inline fn QueryVideoMemoryInfo(self: *IAdapter3, node_index: UINT, memory_segment_group: MEMORY_SEGMENT_GROUP, video_memory_info: *QUERY_VIDEO_MEMORY_INFO) HRESULT {
        return self.__v.QueryVideoMemoryInfo(self, node_index, memory_segment_group, video_memory_info);
    }
    pub inline fn SetVideoMemoryReservation(self: *IAdapter3, node_index: UINT, memory_segment_group: MEMORY_SEGMENT_GROUP, reservation: UINT64) HRESULT {
        return self.__v.SetVideoMemoryReservation(self, node_index, memory_segment_group, reservation);
    }
    pub inline fn RegisterVideoMemoryBudgetChangeNotificationEvent(self: *IAdapter3, event: HANDLE, cookie: *DWORD) HRESULT {
        return self.__v.RegisterVideoMemoryBudgetChangeNotificationEvent(self, event, cookie);
    }
    pub inline fn UnregisterVideoMemoryBudgetChangeNotification(self: *IAdapter3, cookie: DWORD) void {
        self.__v.UnregisterVideoMemoryBudgetChangeNotification(self, cookie);
    }
    pub const VTable = extern struct {
        base: IAdapter2.VTable,
        RegisterHardwareContentProtectionTeardownStatusEvent: *const fn (*IAdapter3, HANDLE, *DWORD) callconv(WINAPI) HRESULT,
        UnregisterHardwareContentProtectionTeardownStatus: *const fn (*IAdapter3, DWORD) callconv(WINAPI) void,
        QueryVideoMemoryInfo: *const fn (*IAdapter3, UINT, MEMORY_SEGMENT_GROUP, *QUERY_VIDEO_MEMORY_INFO) callconv(WINAPI) HRESULT,
        SetVideoMemoryReservation: *const fn (*IAdapter3, UINT, MEMORY_SEGMENT_GROUP, UINT64) callconv(WINAPI) HRESULT,
        RegisterVideoMemoryBudgetChangeNotificationEvent: *const fn (*IAdapter3, HANDLE, *DWORD) callconv(WINAPI) HRESULT,
        UnregisterVideoMemoryBudgetChangeNotification: *const fn (*IAdapter3, DWORD) callconv(WINAPI) void,
    };
};

pub const IDevice1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice1) ULONG {
        return IDevice.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice1) ULONG {
        return IDevice.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *IDevice1, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return IDevice.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice1, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *IDevice1, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return IDevice.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *IDevice1, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return IDevice.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetAdapter(self: *IDevice1, adapter: *?*IAdapter) HRESULT {
        return IDevice.GetAdapter(@ptrCast(self), adapter);
    }
    pub inline fn CreateSurface(self: *IDevice1, desc: *const SURFACE_DESC, num_surfaces: UINT, usage: USAGE, shared_resource: ?*const SHARED_RESOURCE, surface: *?*ISurface) HRESULT {
        return IDevice.CreateSurface(@ptrCast(self), desc, num_surfaces, usage, shared_resource, surface);
    }
    pub inline fn QueryResourceResidency(self: *IDevice1, resources: *const *IUnknown, status: [*]RESIDENCY, num_resources: UINT) HRESULT {
        return IDevice.QueryResourceResidency(@ptrCast(self), resources, status, num_resources);
    }
    pub inline fn SetGPUThreadPriority(self: *IDevice1, priority: INT) HRESULT {
        return IDevice.SetGPUThreadPriority(@ptrCast(self), priority);
    }
    pub inline fn GetGPUThreadPriority(self: *IDevice1, priority: *INT) HRESULT {
        return IDevice.GetGPUThreadPriority(@ptrCast(self), priority);
    }
    pub inline fn SetMaximumFrameLatency(self: *IDevice1, max_latency: UINT) HRESULT {
        return self.__v.SetMaximumFrameLatency(self, max_latency);
    }
    pub inline fn GetMaximumFrameLatency(self: *IDevice1, max_latency: *UINT) HRESULT {
        return self.__v.GetMaximumFrameLatency(self, max_latency);
    }
    pub const VTable = extern struct {
        base: IDevice.VTable,
        SetMaximumFrameLatency: *const fn (self: *IDevice1, max_latency: UINT) callconv(WINAPI) HRESULT,
        GetMaximumFrameLatency: *const fn (self: *IDevice1, max_latency: *UINT) callconv(WINAPI) HRESULT,
    };
};

pub const IID_IFactory1 = GUID{
    .Data1 = 0x770aae78,
    .Data2 = 0xf26f,
    .Data3 = 0x4dba,
    .Data4 = .{ 0xa8, 0x29, 0x25, 0x3c, 0x83, 0xd1, 0xb3, 0x87 },
};

pub const IID_IDevice = GUID{
    .Data1 = 0x54ec77fa,
    .Data2 = 0x1377,
    .Data3 = 0x44e6,
    .Data4 = .{ 0x8c, 0x32, 0x88, 0xfd, 0x5f, 0x44, 0xc8, 0x4c },
};

pub const IID_ISurface = GUID{
    .Data1 = 0xcafcb56c,
    .Data2 = 0x6ac3,
    .Data3 = 0x4889,
    .Data4 = .{ 0xbf, 0x47, 0x9e, 0x23, 0xbb, 0xd2, 0x60, 0xec },
};

pub const CREATE_FACTORY_DEBUG = 0x1;
pub extern "dxgi" fn CreateDXGIFactory2(UINT, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT;
extern "dxgi" fn DXGIGetDebugInterface1(UINT, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT;
pub const GetDebugInterface1 = DXGIGetDebugInterface1;

pub const SCALING = enum(UINT) {
    STRETCH = 0,
    NONE = 1,
    ASPECT_RATIO_STRETCH = 2,
};

pub const ALPHA_MODE = enum(UINT) {
    UNSPECIFIED = 0,
    PREMULTIPLIED = 1,
    STRAIGHT = 2,
    IGNORE = 3,
};

pub const SWAP_CHAIN_DESC1 = extern struct {
    Width: UINT,
    Height: UINT,
    Format: FORMAT,
    Stereo: BOOL,
    SampleDesc: SAMPLE_DESC,
    BufferUsage: USAGE,
    BufferCount: UINT,
    Scaling: SCALING,
    SwapEffect: SWAP_EFFECT,
    AlphaMode: ALPHA_MODE,
    Flags: SWAP_CHAIN_FLAG,
};

pub const SWAP_CHAIN_FULLSCREEN_DESC = extern struct {
    RefreshRate: RATIONAL,
    ScanlineOrdering: MODE_SCANLINE_ORDER,
    Scaling: MODE_SCALING,
    Windowed: BOOL,
};

pub const PRESENT_PARAMETERS = extern struct {
    DirtyRectsCount: UINT,
    pDirtyRects: ?*RECT,
    pScrollRect: *RECT,
    pScrollOffset: *POINT,
};

pub const ISwapChain1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ISwapChain1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return ISwapChain.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ISwapChain1) ULONG {
        return ISwapChain.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ISwapChain1) ULONG {
        return ISwapChain.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *ISwapChain1, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return ISwapChain.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ISwapChain1, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return ISwapChain.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *ISwapChain1, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return ISwapChain.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *ISwapChain1, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return ISwapChain.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDevice(self: *ISwapChain1, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return ISwapChain.GetDevice(@ptrCast(self), guid, parent);
    }
    pub inline fn Present(self: *ISwapChain1, sync_interval: UINT, flags: PRESENT_FLAG) HRESULT {
        return ISwapChain.Present(@ptrCast(self), sync_interval, flags);
    }
    pub inline fn GetBuffer(self: *ISwapChain1, index: u32, guid: *const GUID, surface: *?*anyopaque) HRESULT {
        return ISwapChain.GetBuffer(@ptrCast(self), index, guid, surface);
    }
    pub inline fn SetFullscreenState(self: *ISwapChain1, target: ?*IOutput) HRESULT {
        return ISwapChain.SetFullscreenState(@ptrCast(self), target);
    }
    pub inline fn GetFullscreenState(self: *ISwapChain1, fullscreen: ?*BOOL, target: ?*?*IOutput) HRESULT {
        return ISwapChain.GetFullscreenState(@ptrCast(self), fullscreen, target);
    }
    pub inline fn GetDesc(self: *ISwapChain1, desc: *SWAP_CHAIN_DESC) HRESULT {
        return ISwapChain.GetDesc(@ptrCast(self), desc);
    }
    pub inline fn ResizeBuffers(self: *ISwapChain1, count: UINT, width: UINT, height: UINT, format: FORMAT, flags: SWAP_CHAIN_FLAG) HRESULT {
        return ISwapChain.ResizeBuffers(@ptrCast(self), count, width, height, format, flags);
    }
    pub inline fn ResizeTarget(self: *ISwapChain1, params: *const MODE_DESC) HRESULT {
        return ISwapChain.ResizeTarget(@ptrCast(self), params);
    }
    pub inline fn GetContainingOutput(self: *ISwapChain1, output: *?*IOutput) HRESULT {
        return ISwapChain.GetContainingOutput(@ptrCast(self), output);
    }
    pub inline fn GetFrameStatistics(self: *ISwapChain1, stats: *FRAME_STATISTICS) HRESULT {
        return ISwapChain.GetFrameStatistics(@ptrCast(self), stats);
    }
    pub inline fn GetLastPresentCount(self: *ISwapChain1, count: *UINT) HRESULT {
        return ISwapChain.GetLastPresentCount(@ptrCast(self), count);
    }
    pub inline fn GetDesc1(self: *ISwapChain1, desc: *SWAP_CHAIN_DESC1) HRESULT {
        return self.__v.GetDesc1(self, desc);
    }
    pub inline fn GetFullscreenDesc(self: *ISwapChain1, desc: *SWAP_CHAIN_FULLSCREEN_DESC) HRESULT {
        return self.__v.GetFullscreenDesc(self, desc);
    }
    pub inline fn GetHwnd(self: *ISwapChain1, hwnd: *HWND) HRESULT {
        return self.__v.GetHwnd(self, hwnd);
    }
    pub inline fn GetCoreWindow(self: *ISwapChain1, guid: *const GUID, unknown: *?*anyopaque) HRESULT {
        return self.__v.GetCoreWindow(self, guid, unknown);
    }
    pub inline fn Present1(self: *ISwapChain1, sync_interval: UINT, flags: PRESENT_FLAG, params: *const PRESENT_PARAMETERS) HRESULT {
        return self.__v.Present1(self, sync_interval, flags, params);
    }
    pub inline fn IsTemporaryMonoSupported(self: *ISwapChain1) BOOL {
        return self.__v.IsTemporaryMonoSupported(self);
    }
    pub inline fn GetRestrictToOutput(self: *ISwapChain1, output: *?*IOutput) HRESULT {
        return self.__v.GetRestrictToOutput(self, output);
    }
    pub inline fn SetBackgroundColor(self: *ISwapChain1, color: *const RGBA) HRESULT {
        return self.__v.SetBackgroundColor(self, color);
    }
    pub inline fn GetBackgroundColor(self: *ISwapChain1, color: *RGBA) HRESULT {
        return self.__v.GetBackgroundColor(self, color);
    }
    pub inline fn SetRotation(self: *ISwapChain1, rotation: MODE_ROTATION) HRESULT {
        return self.__v.SetRotation(self, rotation);
    }
    pub inline fn GetRotation(self: *ISwapChain1, rotation: *MODE_ROTATION) HRESULT {
        return self.__v.GetRotation(self, rotation);
    }
    pub const VTable = extern struct {
        const T = ISwapChain1;
        base: ISwapChain.VTable,
        GetDesc1: *const fn (*T, *SWAP_CHAIN_DESC1) callconv(WINAPI) HRESULT,
        GetFullscreenDesc: *const fn (*T, *SWAP_CHAIN_FULLSCREEN_DESC) callconv(WINAPI) HRESULT,
        GetHwnd: *const fn (*T, *HWND) callconv(WINAPI) HRESULT,
        GetCoreWindow: *const fn (*T, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT,
        Present1: *const fn (*T, UINT, PRESENT_FLAG, *const PRESENT_PARAMETERS) callconv(WINAPI) HRESULT,
        IsTemporaryMonoSupported: *const fn (*T) callconv(WINAPI) BOOL,
        GetRestrictToOutput: *const fn (*T, *?*IOutput) callconv(WINAPI) HRESULT,
        SetBackgroundColor: *const fn (*T, *const RGBA) callconv(WINAPI) HRESULT,
        GetBackgroundColor: *const fn (*T, *RGBA) callconv(WINAPI) HRESULT,
        SetRotation: *const fn (*T, MODE_ROTATION) callconv(WINAPI) HRESULT,
        GetRotation: *const fn (*T, *MODE_ROTATION) callconv(WINAPI) HRESULT,
    };
};

pub const IID_ISwapChain1 = GUID{
    .Data1 = 0x790a45f7,
    .Data2 = 0x0d41,
    .Data3 = 0x4876,
    .Data4 = .{ 0x98, 0x3a, 0x0a, 0x55, 0xcf, 0xe6, 0xf4, 0xaa },
};

pub const MATRIX_3X2_F = extern struct {
    _11: FLOAT,
    _12: FLOAT,
    _21: FLOAT,
    _22: FLOAT,
    _31: FLOAT,
    _32: FLOAT,
};

pub const ISwapChain2 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ISwapChain2, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return ISwapChain1.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ISwapChain2) ULONG {
        return ISwapChain1.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ISwapChain2) ULONG {
        return ISwapChain1.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *ISwapChain2, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return ISwapChain1.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ISwapChain2, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return ISwapChain1.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *ISwapChain2, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return ISwapChain1.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *ISwapChain2, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return ISwapChain1.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDevice(self: *ISwapChain2, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return ISwapChain1.GetDevice(@ptrCast(self), guid, parent);
    }
    pub inline fn Present(self: *ISwapChain2, sync_interval: UINT, flags: PRESENT_FLAG) HRESULT {
        return ISwapChain1.Present(@ptrCast(self), sync_interval, flags);
    }
    pub inline fn GetBuffer(self: *ISwapChain2, index: u32, guid: *const GUID, surface: *?*anyopaque) HRESULT {
        return ISwapChain1.GetBuffer(@ptrCast(self), index, guid, surface);
    }
    pub inline fn SetFullscreenState(self: *ISwapChain2, target: ?*IOutput) HRESULT {
        return ISwapChain1.SetFullscreenState(@ptrCast(self), target);
    }
    pub inline fn GetFullscreenState(self: *ISwapChain2, fullscreen: ?*BOOL, target: ?*?*IOutput) HRESULT {
        return ISwapChain1.GetFullscreenState(@ptrCast(self), fullscreen, target);
    }
    pub inline fn GetDesc(self: *ISwapChain2, desc: *SWAP_CHAIN_DESC) HRESULT {
        return ISwapChain1.GetDesc(@ptrCast(self), desc);
    }
    pub inline fn ResizeBuffers(self: *ISwapChain2, count: UINT, width: UINT, height: UINT, format: FORMAT, flags: SWAP_CHAIN_FLAG) HRESULT {
        return ISwapChain1.ResizeBuffers(@ptrCast(self), count, width, height, format, flags);
    }
    pub inline fn ResizeTarget(self: *ISwapChain2, params: *const MODE_DESC) HRESULT {
        return ISwapChain1.ResizeTarget(@ptrCast(self), params);
    }
    pub inline fn GetContainingOutput(self: *ISwapChain2, output: *?*IOutput) HRESULT {
        return ISwapChain1.GetContainingOutput(@ptrCast(self), output);
    }
    pub inline fn GetFrameStatistics(self: *ISwapChain2, stats: *FRAME_STATISTICS) HRESULT {
        return ISwapChain1.GetFrameStatistics(@ptrCast(self), stats);
    }
    pub inline fn GetLastPresentCount(self: *ISwapChain2, count: *UINT) HRESULT {
        return ISwapChain1.GetLastPresentCount(@ptrCast(self), count);
    }
    pub inline fn GetDesc1(self: *ISwapChain2, desc: *SWAP_CHAIN_DESC1) HRESULT {
        return ISwapChain1.GetDesc1(@ptrCast(self), desc);
    }
    pub inline fn GetFullscreenDesc(self: *ISwapChain2, desc: *SWAP_CHAIN_FULLSCREEN_DESC) HRESULT {
        return ISwapChain1.GetFullscreenDesc(@ptrCast(self), desc);
    }
    pub inline fn GetHwnd(self: *ISwapChain2, hwnd: *HWND) HRESULT {
        return ISwapChain1.GetHwnd(@ptrCast(self), hwnd);
    }
    pub inline fn GetCoreWindow(self: *ISwapChain2, guid: *const GUID, unknown: *?*anyopaque) HRESULT {
        return ISwapChain1.GetCoreWindow(@ptrCast(self), guid, unknown);
    }
    pub inline fn Present1(self: *ISwapChain2, sync_interval: UINT, flags: PRESENT_FLAG, params: *const PRESENT_PARAMETERS) HRESULT {
        return ISwapChain1.Present1(@ptrCast(self), sync_interval, flags, params);
    }
    pub inline fn IsTemporaryMonoSupported(self: *ISwapChain2) BOOL {
        return ISwapChain1.IsTemporaryMonoSupported(@ptrCast(self));
    }
    pub inline fn GetRestrictToOutput(self: *ISwapChain2, output: *?*IOutput) HRESULT {
        return ISwapChain1.GetRestrictToOutput(@ptrCast(self), output);
    }
    pub inline fn SetBackgroundColor(self: *ISwapChain2, color: *const RGBA) HRESULT {
        return ISwapChain1.SetBackgroundColor(@ptrCast(self), color);
    }
    pub inline fn GetBackgroundColor(self: *ISwapChain2, color: *RGBA) HRESULT {
        return ISwapChain1.GetBackgroundColor(@ptrCast(self), color);
    }
    pub inline fn SetRotation(self: *ISwapChain2, rotation: MODE_ROTATION) HRESULT {
        return ISwapChain1.SetRotation(@ptrCast(self), rotation);
    }
    pub inline fn GetRotation(self: *ISwapChain2, rotation: *MODE_ROTATION) HRESULT {
        return ISwapChain1.GetRotation(@ptrCast(self), rotation);
    }
    pub inline fn SetSourceSize(self: *ISwapChain2, width: UINT, height: UINT) HRESULT {
        return self.__v.SetSourceSize(self, width, height);
    }
    pub inline fn GetSourceSize(self: *ISwapChain2, width: *UINT, height: *UINT) HRESULT {
        return self.__v.GetSourceSize(self, width, height);
    }
    pub inline fn SetMaximumFrameLatency(self: *ISwapChain2, max_latency: UINT) HRESULT {
        return self.__v.SetMaximumFrameLatency(self, max_latency);
    }
    pub inline fn GetMaximumFrameLatency(self: *ISwapChain2, max_latency: *UINT) HRESULT {
        return self.__v.GetMaximumFrameLatency(self, max_latency);
    }
    pub inline fn GetFrameLatencyWaitableObject(self: *ISwapChain2) HANDLE {
        return self.__v.GetFrameLatencyWaitableObject(self);
    }
    pub inline fn SetMatrixTransform(self: *ISwapChain2, matrix: *const MATRIX_3X2_F) HRESULT {
        return self.__v.SetMatrixTransform(self, matrix);
    }
    pub inline fn GetMatrixTransform(self: *ISwapChain2, matrix: *MATRIX_3X2_F) HRESULT {
        return self.__v.GetMatrixTransform(self, matrix);
    }
    pub const VTable = extern struct {
        const T = ISwapChain2;
        base: ISwapChain1.VTable,
        SetSourceSize: *const fn (*T, UINT, UINT) callconv(WINAPI) HRESULT,
        GetSourceSize: *const fn (*T, *UINT, *UINT) callconv(WINAPI) HRESULT,
        SetMaximumFrameLatency: *const fn (*T, UINT) callconv(WINAPI) HRESULT,
        GetMaximumFrameLatency: *const fn (*T, *UINT) callconv(WINAPI) HRESULT,
        GetFrameLatencyWaitableObject: *const fn (*T) callconv(WINAPI) HANDLE,
        SetMatrixTransform: *const fn (*T, *const MATRIX_3X2_F) callconv(WINAPI) HRESULT,
        GetMatrixTransform: *const fn (*T, *MATRIX_3X2_F) callconv(WINAPI) HRESULT,
    };
};

pub const IID_ISwapChain2 = GUID{
    .Data1 = 0xa8be2ac4,
    .Data2 = 0x199f,
    .Data3 = 0x4946,
    .Data4 = .{ 0xb3, 0x31, 0x79, 0x59, 0x9f, 0xb9, 0x8d, 0xe7 },
};

pub const ISwapChain3 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ISwapChain3, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return ISwapChain2.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ISwapChain3) ULONG {
        return ISwapChain2.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ISwapChain3) ULONG {
        return ISwapChain2.Release(@ptrCast(self));
    }
    pub inline fn SetPrivateData(self: *ISwapChain3, guid: *const GUID, data_size: UINT, data: *const anyopaque) HRESULT {
        return ISwapChain2.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ISwapChain3, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return ISwapChain2.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn GetPrivateData(self: *ISwapChain3, guid: *const GUID, data_size: *UINT, data: *anyopaque) HRESULT {
        return ISwapChain2.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn GetParent(self: *ISwapChain3, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return ISwapChain2.GetParent(@ptrCast(self), guid, parent);
    }
    pub inline fn GetDevice(self: *ISwapChain3, guid: *const GUID, parent: *?*anyopaque) HRESULT {
        return ISwapChain2.GetDevice(@ptrCast(self), guid, parent);
    }
    pub inline fn Present(self: *ISwapChain3, sync_interval: UINT, flags: PRESENT_FLAG) HRESULT {
        return ISwapChain2.Present(@ptrCast(self), sync_interval, flags);
    }
    pub inline fn GetBuffer(self: *ISwapChain3, index: u32, guid: *const GUID, surface: *?*anyopaque) HRESULT {
        return ISwapChain2.GetBuffer(@ptrCast(self), index, guid, surface);
    }
    pub inline fn SetFullscreenState(self: *ISwapChain3, target: ?*IOutput) HRESULT {
        return ISwapChain2.SetFullscreenState(@ptrCast(self), target);
    }
    pub inline fn GetFullscreenState(self: *ISwapChain3, fullscreen: ?*BOOL, target: ?*?*IOutput) HRESULT {
        return ISwapChain2.GetFullscreenState(@ptrCast(self), fullscreen, target);
    }
    pub inline fn GetDesc(self: *ISwapChain3, desc: *SWAP_CHAIN_DESC) HRESULT {
        return ISwapChain2.GetDesc(@ptrCast(self), desc);
    }
    pub inline fn ResizeBuffers(self: *ISwapChain3, count: UINT, width: UINT, height: UINT, format: FORMAT, flags: SWAP_CHAIN_FLAG) HRESULT {
        return ISwapChain2.ResizeBuffers(@ptrCast(self), count, width, height, format, flags);
    }
    pub inline fn ResizeTarget(self: *ISwapChain3, params: *const MODE_DESC) HRESULT {
        return ISwapChain2.ResizeTarget(@ptrCast(self), params);
    }
    pub inline fn GetContainingOutput(self: *ISwapChain3, output: *?*IOutput) HRESULT {
        return ISwapChain2.GetContainingOutput(@ptrCast(self), output);
    }
    pub inline fn GetFrameStatistics(self: *ISwapChain3, stats: *FRAME_STATISTICS) HRESULT {
        return ISwapChain2.GetFrameStatistics(@ptrCast(self), stats);
    }
    pub inline fn GetLastPresentCount(self: *ISwapChain3, count: *UINT) HRESULT {
        return ISwapChain2.GetLastPresentCount(@ptrCast(self), count);
    }
    pub inline fn GetDesc1(self: *ISwapChain3, desc: *SWAP_CHAIN_DESC1) HRESULT {
        return ISwapChain2.GetDesc1(@ptrCast(self), desc);
    }
    pub inline fn GetFullscreenDesc(self: *ISwapChain3, desc: *SWAP_CHAIN_FULLSCREEN_DESC) HRESULT {
        return ISwapChain2.GetFullscreenDesc(@ptrCast(self), desc);
    }
    pub inline fn GetHwnd(self: *ISwapChain3, hwnd: *HWND) HRESULT {
        return ISwapChain2.GetHwnd(@ptrCast(self), hwnd);
    }
    pub inline fn GetCoreWindow(self: *ISwapChain3, guid: *const GUID, unknown: *?*anyopaque) HRESULT {
        return ISwapChain2.GetCoreWindow(@ptrCast(self), guid, unknown);
    }
    pub inline fn Present1(self: *ISwapChain3, sync_interval: UINT, flags: PRESENT_FLAG, params: *const PRESENT_PARAMETERS) HRESULT {
        return ISwapChain2.Present1(@ptrCast(self), sync_interval, flags, params);
    }
    pub inline fn IsTemporaryMonoSupported(self: *ISwapChain3) BOOL {
        return ISwapChain2.IsTemporaryMonoSupported(@ptrCast(self));
    }
    pub inline fn GetRestrictToOutput(self: *ISwapChain3, output: *?*IOutput) HRESULT {
        return ISwapChain2.GetRestrictToOutput(@ptrCast(self), output);
    }
    pub inline fn SetBackgroundColor(self: *ISwapChain3, color: *const RGBA) HRESULT {
        return ISwapChain2.SetBackgroundColor(@ptrCast(self), color);
    }
    pub inline fn GetBackgroundColor(self: *ISwapChain3, color: *RGBA) HRESULT {
        return ISwapChain2.GetBackgroundColor(@ptrCast(self), color);
    }
    pub inline fn SetRotation(self: *ISwapChain3, rotation: MODE_ROTATION) HRESULT {
        return ISwapChain2.SetRotation(@ptrCast(self), rotation);
    }
    pub inline fn GetRotation(self: *ISwapChain3, rotation: *MODE_ROTATION) HRESULT {
        return ISwapChain2.GetRotation(@ptrCast(self), rotation);
    }
    pub inline fn SetSourceSize(self: *ISwapChain3, width: UINT, height: UINT) HRESULT {
        return ISwapChain2.SetSourceSize(@ptrCast(self), width, height);
    }
    pub inline fn GetSourceSize(self: *ISwapChain3, width: *UINT, height: *UINT) HRESULT {
        return ISwapChain2.GetSourceSize(@ptrCast(self), width, height);
    }
    pub inline fn SetMaximumFrameLatency(self: *ISwapChain3, max_latency: UINT) HRESULT {
        return ISwapChain2.SetMaximumFrameLatency(@ptrCast(self), max_latency);
    }
    pub inline fn GetMaximumFrameLatency(self: *ISwapChain3, max_latency: *UINT) HRESULT {
        return ISwapChain2.GetMaximumFrameLatency(@ptrCast(self), max_latency);
    }
    pub inline fn GetFrameLatencyWaitableObject(self: *ISwapChain3) HANDLE {
        return ISwapChain2.GetFrameLatencyWaitableObject(@ptrCast(self));
    }
    pub inline fn SetMatrixTransform(self: *ISwapChain3, matrix: *const MATRIX_3X2_F) HRESULT {
        return ISwapChain2.SetMatrixTransform(@ptrCast(self), matrix);
    }
    pub inline fn GetMatrixTransform(self: *ISwapChain3, matrix: *MATRIX_3X2_F) HRESULT {
        return ISwapChain2.GetMatrixTransform(@ptrCast(self), matrix);
    }
    pub inline fn GetCurrentBackBufferIndex(self: *ISwapChain3) UINT {
        return self.__v.GetCurrentBackBufferIndex(self);
    }
    pub inline fn CheckColorSpaceSupport(self: *ISwapChain3, space: COLOR_SPACE_TYPE, support: *UINT) HRESULT {
        return self.__v.CheckColorSpaceSupport(self, space, support);
    }
    pub inline fn SetColorSpace1(self: *ISwapChain3, space: COLOR_SPACE_TYPE) HRESULT {
        return self.__v.SetColorSpace1(self, space);
    }
    pub inline fn ResizeBuffers1(self: *ISwapChain3, buffer_count: UINT, width: UINT, height: UINT, format: FORMAT, swap_chain_flags: UINT, creation_node_mask: [*]const UINT, present_queue: [*]const *IUnknown) HRESULT {
        return self.__v.ResizeBuffers1(self, buffer_count, width, height, format, swap_chain_flags, creation_node_mask, present_queue);
    }
    pub const VTable = extern struct {
        const T = ISwapChain3;
        base: ISwapChain2.VTable,
        GetCurrentBackBufferIndex: *const fn (*T) callconv(WINAPI) UINT,
        CheckColorSpaceSupport: *const fn (*T, COLOR_SPACE_TYPE, *UINT) callconv(WINAPI) HRESULT,
        SetColorSpace1: *const fn (*T, COLOR_SPACE_TYPE) callconv(WINAPI) HRESULT,
        ResizeBuffers1: *const fn (
            *T,
            UINT,
            UINT,
            UINT,
            FORMAT,
            UINT,
            [*]const UINT,
            [*]const *IUnknown,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const IID_ISwapChain3 = GUID{
    .Data1 = 0x94d99bdb,
    .Data2 = 0xf1f8,
    .Data3 = 0x4ab0,
    .Data4 = .{ 0xb2, 0x36, 0x7d, 0xa0, 0x17, 0x0e, 0xda, 0xb1 },
};

// Status return codes as defined here: https://docs.microsoft.com/en-us/windows/win32/direct3ddxgi/dxgi-status
pub const STATUS_OCCLUDED = @as(HRESULT, @bitCast(@as(c_ulong, 0x087A0001)));
pub const STATUS_MODE_CHANGED = @as(HRESULT, @bitCast(@as(c_ulong, 0x087A0007)));
pub const STATUS_MODE_CHANGE_IN_PROGRESS = @as(HRESULT, @bitCast(@as(c_ulong, 0x087A0008)));

// Return codes as defined here: https://docs.microsoft.com/en-us/windows/win32/direct3ddxgi/dxgi-error
pub const ERROR_ACCESS_DENIED = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A002B)));
pub const ERROR_ACCESS_LOST = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0026)));
pub const ERROR_ALREADY_EXISTS = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0036)));
pub const ERROR_CANNOT_PROTECT_CONTENT = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A002A)));
pub const ERROR_DEVICE_HUNG = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0006)));
pub const ERROR_DEVICE_REMOVED = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0005)));
pub const ERROR_DEVICE_RESET = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0007)));
pub const ERROR_DRIVER_INTERNAL_ERROR = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0020)));
pub const ERROR_FRAME_STATISTICS_DISJOINT = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A000B)));
pub const ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A000C)));
pub const ERROR_INVALID_CALL = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0001)));
pub const ERROR_MORE_DATA = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0003)));
pub const ERROR_NAME_ALREADY_EXISTS = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A002C)));
pub const ERROR_NONEXCLUSIVE = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0021)));
pub const ERROR_NOT_CURRENTLY_AVAILABLE = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0022)));
pub const ERROR_NOT_FOUND = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0002)));
pub const ERROR_REMOTE_CLIENT_DISCONNECTED = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0023)));
pub const ERROR_REMOTE_OUTOFMEMORY = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0024)));
pub const ERROR_RESTRICT_TO_OUTPUT_STALE = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0029)));
pub const ERROR_SDK_COMPONENT_MISSING = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A002D)));
pub const ERROR_SESSION_DISCONNECTED = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0028)));
pub const ERROR_UNSUPPORTED = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0004)));
pub const ERROR_WAIT_TIMEOUT = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A0027)));
pub const ERROR_WAS_STILL_DRAWING = @as(HRESULT, @bitCast(@as(c_ulong, 0x887A000A)));

// Error set corresponding to the above error return codes
pub const Error = error{
    ACCESS_DENIED,
    ACCESS_LOST,
    ALREADY_EXISTS,
    CANNOT_PROTECT_CONTENT,
    DEVICE_HUNG,
    DEVICE_REMOVED,
    DEVICE_RESET,
    DRIVER_INTERNAL_ERROR,
    FRAME_STATISTICS_DISJOINT,
    GRAPHICS_VIDPN_SOURCE_IN_USE,
    INVALID_CALL,
    MORE_DATA,
    NAME_ALREADY_EXISTS,
    NONEXCLUSIVE,
    NOT_CURRENTLY_AVAILABLE,
    NOT_FOUND,
    REMOTE_CLIENT_DISCONNECTED,
    REMOTE_OUTOFMEMORY,
    RESTRICT_TO_OUTPUT_STALE,
    SDK_COMPONENT_MISSING,
    SESSION_DISCONNECTED,
    UNSUPPORTED,
    WAIT_TIMEOUT,
    WAS_STILL_DRAWING,
};
