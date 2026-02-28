const windows = @import("../windows.zig");
const IUnknown = windows.IUnknown;
const ULONG = windows.ULONG;
const WINAPI = windows.WINAPI;
const HRESULT = windows.HRESULT;
const GUID = windows.GUID;
const LPCWSTR = windows.LPCWSTR;
const DWORD = windows.DWORD;
const UINT = windows.UINT;
const INT = windows.INT;
const BYTE = windows.BYTE;

pub const PixelFormatGUID = windows.GUID;

pub const Rect = extern struct {
    X: INT,
    Y: INT,
    Width: INT,
    Height: INT,
};

pub const DecodeOptions = enum(UINT) {
    MetadataCacheOnDemand = 0,
    MetadataCacheOnLoad = 0x1,
};

pub const BitmapPaletteType = enum(UINT) {
    Custom = 0,
    MedianCut = 0x1,
    FixedBW = 0x2,
    FixedHalftone8 = 0x3,
    FixedHalftone27 = 0x4,
    FixedHalftone64 = 0x5,
    FixedHalftone125 = 0x6,
    FixedHalftone216 = 0x7,
    FixedHalftone252 = 0x8,
    FixedHalftone256 = 0x9,
    FixedGray4 = 0xa,
    FixedGray16 = 0xb,
    FixedGray256 = 0xc,
};

pub const IPalette = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IPalette, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IPalette) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IPalette) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        InitializePredefined: *anyopaque,
        InitializeCustom: *anyopaque,
        InitializeFromBitmap: *anyopaque,
        InitializeFromPalette: *anyopaque,
        GetType: *anyopaque,
        GetColorCount: *anyopaque,
        GetColors: *anyopaque,
        IsBlackWhite: *anyopaque,
        IsGrayscale: *anyopaque,
        HasAlpha: *anyopaque,
    };
};

pub const IBitmapDecoder = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IBitmapDecoder, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IBitmapDecoder) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IBitmapDecoder) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn GetFrame(self: *IBitmapDecoder, index: UINT, frame: ?*?*IBitmapFrameDecode) HRESULT {
        return self.__v.GetFrame(self, index, frame);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        QueryCapability: *anyopaque,
        Initialize: *anyopaque,
        GetContainerFormat: *anyopaque,
        GetDecoderInfo: *anyopaque,
        CopyPalette: *anyopaque,
        GetMetadataQueryReader: *anyopaque,
        GetPreview: *anyopaque,
        GetColorContexts: *anyopaque,
        GetThumbnail: *anyopaque,
        GetFrameCount: *anyopaque,
        GetFrame: *const fn (*IBitmapDecoder, UINT, ?*?*IBitmapFrameDecode) callconv(WINAPI) HRESULT,
    };
};

pub const IBitmapSource = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IBitmapSource, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IBitmapSource) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IBitmapSource) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn GetSize(self: *IBitmapSource, width: *UINT, height: *UINT) HRESULT {
        return self.__v.GetSize(self, width, height);
    }
    pub inline fn GetPixelFormat(self: *IBitmapSource, guid: *PixelFormatGUID) HRESULT {
        return self.__v.GetPixelFormat(self, guid);
    }
    pub inline fn CopyPixels(self: *IBitmapSource, rect: ?*const Rect, stride: UINT, size: UINT, buffer: [*]BYTE) HRESULT {
        return self.__v.CopyPixels(self, rect, stride, size, buffer);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetSize: *const fn (*IBitmapSource, *UINT, *UINT) callconv(WINAPI) HRESULT,
        GetPixelFormat: *const fn (*IBitmapSource, *GUID) callconv(WINAPI) HRESULT,
        GetResolution: *anyopaque,
        CopyPalette: *anyopaque,
        CopyPixels: *const fn (*IBitmapSource, ?*const Rect, UINT, UINT, [*]BYTE) callconv(WINAPI) HRESULT,
    };
};

pub const IBitmapFrameDecode = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IBitmapFrameDecode, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IBitmapSource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IBitmapFrameDecode) ULONG {
        return IBitmapSource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IBitmapFrameDecode) ULONG {
        return IBitmapSource.Release(@ptrCast(self));
    }
    pub inline fn GetSize(self: *IBitmapFrameDecode, width: *UINT, height: *UINT) HRESULT {
        return IBitmapSource.GetSize(@ptrCast(self), width, height);
    }
    pub inline fn GetPixelFormat(self: *IBitmapFrameDecode, guid: *PixelFormatGUID) HRESULT {
        return IBitmapSource.GetPixelFormat(@ptrCast(self), guid);
    }
    pub inline fn CopyPixels(self: *IBitmapFrameDecode, rect: ?*const Rect, stride: UINT, size: UINT, buffer: [*]BYTE) HRESULT {
        return IBitmapSource.CopyPixels(@ptrCast(self), rect, stride, size, buffer);
    }
    pub const VTable = extern struct {
        base: IBitmapSource.VTable,
        GetMetadataQueryReader: *anyopaque,
        GetColorContexts: *anyopaque,
        GetThumbnail: *anyopaque,
    };
};

pub const IBitmap = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IBitmap, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IBitmapSource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IBitmap) ULONG {
        return IBitmapSource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IBitmap) ULONG {
        return IBitmapSource.Release(@ptrCast(self));
    }
    pub inline fn GetSize(self: *IBitmap, width: *UINT, height: *UINT) HRESULT {
        return IBitmapSource.GetSize(@ptrCast(self), width, height);
    }
    pub inline fn GetPixelFormat(self: *IBitmap, guid: *PixelFormatGUID) HRESULT {
        return IBitmapSource.GetPixelFormat(@ptrCast(self), guid);
    }
    pub inline fn CopyPixels(self: *IBitmap, rect: ?*const Rect, stride: UINT, size: UINT, buffer: [*]BYTE) HRESULT {
        return IBitmapSource.CopyPixels(@ptrCast(self), rect, stride, size, buffer);
    }
    pub const VTable = extern struct {
        base: IBitmapSource.VTable,
        Lock: *anyopaque,
        SetPalette: *anyopaque,
        SetResolution: *anyopaque,
    };
};

pub const BitmapDitherType = enum(UINT) {
    None = 0,
    Ordered4x4 = 0x1,
    Ordered8x8 = 0x2,
    Ordered16x16 = 0x3,
    Spiral4x4 = 0x4,
    Spiral8x8 = 0x5,
    DualSpiral4x4 = 0x6,
    DualSpiral8x8 = 0x7,
    ErrorDiffusion = 0x8,
};

pub const IFormatConverter = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFormatConverter, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IBitmapSource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFormatConverter) ULONG {
        return IBitmapSource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFormatConverter) ULONG {
        return IBitmapSource.Release(@ptrCast(self));
    }
    pub inline fn GetSize(self: *IFormatConverter, width: *UINT, height: *UINT) HRESULT {
        return IBitmapSource.GetSize(@ptrCast(self), width, height);
    }
    pub inline fn GetPixelFormat(self: *IFormatConverter, guid: *PixelFormatGUID) HRESULT {
        return IBitmapSource.GetPixelFormat(@ptrCast(self), guid);
    }
    pub inline fn CopyPixels(self: *IFormatConverter, rect: ?*const Rect, stride: UINT, size: UINT, buffer: [*]BYTE) HRESULT {
        return IBitmapSource.CopyPixels(@ptrCast(self), rect, stride, size, buffer);
    }
    pub inline fn Initialize(self: *IFormatConverter, source: ?*IBitmapSource, dest_format: *const PixelFormatGUID, dither: BitmapDitherType, palette: ?*IPalette, alpha_threshold_percent: f64, palette_translate: BitmapPaletteType) HRESULT {
        return self.__v.Initialize(self, source, dest_format, dither, palette, alpha_threshold_percent, palette_translate);
    }
    pub const VTable = extern struct {
        base: IBitmapSource.VTable,
        Initialize: *const fn (
            *IFormatConverter,
            ?*IBitmapSource,
            *const PixelFormatGUID,
            BitmapDitherType,
            ?*IPalette,
            f64,
            BitmapPaletteType,
        ) callconv(WINAPI) HRESULT,
        CanConvert: *anyopaque,
    };
};

pub const IImagingFactory = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IImagingFactory, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IImagingFactory) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IImagingFactory) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn CreateDecoderFromFilename(self: *IImagingFactory, filename: LPCWSTR, vendor: ?*const GUID, access: DWORD, metadata: DecodeOptions, decoder: ?*?*IBitmapDecoder) HRESULT {
        return self.__v.CreateDecoderFromFilename(self, filename, vendor, access, metadata, decoder);
    }
    pub inline fn CreateFormatConverter(self: *IImagingFactory, converter: ?*?*IFormatConverter) HRESULT {
        return self.__v.CreateFormatConverter(self, converter);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        CreateDecoderFromFilename: *const fn (
            *IImagingFactory,
            LPCWSTR,
            ?*const GUID,
            DWORD,
            DecodeOptions,
            ?*?*IBitmapDecoder,
        ) callconv(WINAPI) HRESULT,
        CreateDecoderFromStream: *anyopaque,
        CreateDecoderFromFileHandle: *anyopaque,
        CreateComponentInfo: *anyopaque,
        CreateDecoder: *anyopaque,
        CreateEncoder: *anyopaque,
        CreatePalette: *anyopaque,
        CreateFormatConverter: *const fn (*IImagingFactory, ?*?*IFormatConverter) callconv(WINAPI) HRESULT,
        CreateBitmapScaler: *anyopaque,
        CreateBitmapClipper: *anyopaque,
        CreateBitmapFlipRotator: *anyopaque,
        CreateStream: *anyopaque,
        CreateColorContext: *anyopaque,
        CreateColorTransformer: *anyopaque,
        CreateBitmap: *anyopaque,
        CreateBitmapFromSource: *anyopaque,
        CreateBitmapFromSourceRect: *anyopaque,
        CreateBitmapFromMemory: *anyopaque,
        CreateBitmapFromHBITMAP: *anyopaque,
        CreateBitmapFromHICON: *anyopaque,
        CreateComponentEnumerator: *anyopaque,
        CreateFastMetadataEncoderFromDecoder: *anyopaque,
        CreateFastMetadataEncoderFromFrameDecode: *anyopaque,
        CreateQueryWriter: *anyopaque,
        CreateQueryWriterFromReader: *anyopaque,
    };
};

pub const CLSID_ImagingFactory = GUID{
    .Data1 = 0xcacaf262,
    .Data2 = 0x9370,
    .Data3 = 0x4615,
    .Data4 = .{ 0xa1, 0x3b, 0x9f, 0x55, 0x39, 0xda, 0x4c, 0xa },
};

pub const IID_IImagingFactory = GUID{
    .Data1 = 0xec5ec8a9,
    .Data2 = 0xc395,
    .Data3 = 0x4314,
    .Data4 = .{ 0x9c, 0x77, 0x54, 0xd7, 0xa9, 0x35, 0xff, 0x70 },
};

pub const GUID_PixelFormat2bppIndexed = PixelFormatGUID{
    .Data1 = 0x6fddc324,
    .Data2 = 0x4e03,
    .Data3 = 0x4bfe,
    .Data4 = .{ 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x02 },
};

pub const GUID_PixelFormat24bppRGB = PixelFormatGUID{
    .Data1 = 0x6fddc324,
    .Data2 = 0x4e03,
    .Data3 = 0x4bfe,
    .Data4 = .{ 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0d },
};
pub const GUID_PixelFormat32bppRGB = PixelFormatGUID{
    .Data1 = 0xd98c6b95,
    .Data2 = 0x3efe,
    .Data3 = 0x47d6,
    .Data4 = .{ 0xbb, 0x25, 0xeb, 0x17, 0x48, 0xab, 0x0c, 0xf1 },
};
pub const GUID_PixelFormat32bppRGBA = PixelFormatGUID{
    .Data1 = 0xf5c7ad2d,
    .Data2 = 0x6a8d,
    .Data3 = 0x43dd,
    .Data4 = .{ 0xa7, 0xa8, 0xa2, 0x99, 0x35, 0x26, 0x1a, 0xe9 },
};
pub const GUID_PixelFormat32bppPRGBA = PixelFormatGUID{
    .Data1 = 0x3cc4a650,
    .Data2 = 0xa527,
    .Data3 = 0x4d37,
    .Data4 = .{ 0xa9, 0x16, 0x31, 0x42, 0xc7, 0xeb, 0xed, 0xba },
};

pub const GUID_PixelFormat24bppBGR = PixelFormatGUID{
    .Data1 = 0x6fddc324,
    .Data2 = 0x4e03,
    .Data3 = 0x4bfe,
    .Data4 = .{ 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0c },
};
pub const GUID_PixelFormat32bppBGR = PixelFormatGUID{
    .Data1 = 0x6fddc324,
    .Data2 = 0x4e03,
    .Data3 = 0x4bfe,
    .Data4 = .{ 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0e },
};
pub const GUID_PixelFormat32bppBGRA = PixelFormatGUID{
    .Data1 = 0x6fddc324,
    .Data2 = 0x4e03,
    .Data3 = 0x4bfe,
    .Data4 = .{ 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0f },
};
pub const GUID_PixelFormat32bppPBGRA = PixelFormatGUID{
    .Data1 = 0x6fddc324,
    .Data2 = 0x4e03,
    .Data3 = 0x4bfe,
    .Data4 = .{ 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x10 },
};

pub const GUID_PixelFormat64bppRGBA = PixelFormatGUID{
    .Data1 = 0x6fddc324,
    .Data2 = 0x4e03,
    .Data3 = 0x4bfe,
    .Data4 = .{ 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x16 },
};

pub const GUID_PixelFormat8bppGray = PixelFormatGUID{
    .Data1 = 0x6fddc324,
    .Data2 = 0x4e03,
    .Data3 = 0x4bfe,
    .Data4 = .{ 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x08 },
};
pub const GUID_PixelFormat8bppAlpha = PixelFormatGUID{
    .Data1 = 0xe6cd0116,
    .Data2 = 0xeeba,
    .Data3 = 0x4161,
    .Data4 = .{ 0xaa, 0x85, 0x27, 0xdd, 0x9f, 0xb3, 0xa8, 0x95 },
};
