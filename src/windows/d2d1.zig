const std = @import("std");
const assert = std.debug.assert;
const windows = @import("../windows.zig");
const UINT = windows.UINT;
const IUnknown = windows.IUnknown;
const ULONG = windows.ULONG;
const HRESULT = windows.HRESULT;
const GUID = windows.GUID;
const WINAPI = windows.WINAPI;
const FLOAT = windows.FLOAT;
const LPCWSTR = windows.LPCWSTR;
const UINT32 = windows.UINT32;
const UINT64 = windows.UINT64;
const POINT = windows.POINT;
const RECT = windows.RECT;
const dwrite = @import("dwrite.zig");
const dxgi = @import("dxgi.zig");

pub const POINT_2F = D2D_POINT_2F;
pub const POINT_2U = D2D_POINT_2U;
pub const POINT_2L = D2D_POINT_2L;
pub const RECT_F = D2D_RECT_F;
pub const RECT_U = D2D_RECT_U;
pub const RECT_L = D2D_RECT_L;
pub const SIZE_F = D2D_SIZE_F;
pub const SIZE_U = D2D_SIZE_U;
pub const MATRIX_3X2_F = D2D_MATRIX_3X2_F;

pub const colorf = struct {
    pub const OliveDrab = COLOR_F{ .r = 0.419607878, .g = 0.556862772, .b = 0.137254909, .a = 1.0 };
    pub const Black = COLOR_F{ .r = 0.0, .g = 0.0, .b = 0.0, .a = 1.0 };
    pub const White = COLOR_F{ .r = 1.0, .g = 1.0, .b = 1.0, .a = 1.0 };
    pub const YellowGreen = COLOR_F{ .r = 0.603921592, .g = 0.803921640, .b = 0.196078449, .a = 1.0 };
    pub const Yellow = COLOR_F{ .r = 1.0, .g = 1.0, .b = 0.0, .a = 1.0 };
    pub const LightSkyBlue = COLOR_F{ .r = 0.529411793, .g = 0.807843208, .b = 0.980392218, .a = 1.000000000 };
    pub const DarkOrange = COLOR_F{ .r = 1.000000000, .g = 0.549019635, .b = 0.000000000, .a = 1.000000000 };
};

pub const COLOR_F = extern struct {
    r: FLOAT,
    g: FLOAT,
    b: FLOAT,
    a: FLOAT,

    pub const Black = COLOR_F{ .r = 0.0, .g = 0.0, .b = 0.0, .a = 1.0 };

    fn toSrgb(s: FLOAT) FLOAT {
        var l: FLOAT = undefined;
        if (s > 0.0031308) {
            l = 1.055 * (std.math.pow(FLOAT, s, (1.0 / 2.4))) - 0.055;
        } else {
            l = 12.92 * s;
        }
        return l;
    }

    pub fn linearToSrgb(r: FLOAT, g: FLOAT, b: FLOAT, a: FLOAT) COLOR_F {
        return COLOR_F{
            .r = toSrgb(r),
            .g = toSrgb(g),
            .b = toSrgb(b),
            .a = a,
        };
    }
};

pub const ALPHA_MODE = enum(UINT) {
    UNKNOWN = 0,
    PREMULTIPLIED = 1,
    STRAIGHT = 2,
    IGNORE = 3,
};

pub const PIXEL_FORMAT = extern struct {
    format: dxgi.FORMAT,
    alphaMode: ALPHA_MODE,
};

pub const D2D_POINT_2U = extern struct {
    x: UINT32,
    y: UINT32,
};

pub const D2D_POINT_2F = extern struct {
    x: FLOAT,
    y: FLOAT,
};

pub const D2D_POINT_2L = POINT;

pub const D2D_VECTOR_2F = extern struct {
    x: FLOAT,
    y: FLOAT,
};

pub const D2D_VECTOR_3F = extern struct {
    x: FLOAT,
    y: FLOAT,
    z: FLOAT,
};

pub const D2D_VECTOR_4F = extern struct {
    x: FLOAT,
    y: FLOAT,
    z: FLOAT,
    w: FLOAT,
};

pub const D2D_RECT_F = extern struct {
    left: FLOAT,
    top: FLOAT,
    right: FLOAT,
    bottom: FLOAT,
};

pub const D2D_RECT_U = extern struct {
    left: UINT32,
    top: UINT32,
    right: UINT32,
    bottom: UINT32,
};

pub const D2D_RECT_L = RECT;

pub const D2D_SIZE_F = extern struct {
    width: FLOAT,
    height: FLOAT,
};

pub const D2D_SIZE_U = extern struct {
    width: UINT32,
    height: UINT32,
};

pub const D2D_MATRIX_3X2_F = extern struct {
    m: [3][2]FLOAT,

    pub fn initTranslation(x: FLOAT, y: FLOAT) D2D_MATRIX_3X2_F {
        return .{
            .m = [_][2]FLOAT{
                [2]FLOAT{ 1.0, 0.0 },
                [2]FLOAT{ 0.0, 1.0 },
                [2]FLOAT{ x, y },
            },
        };
    }

    pub fn initIdentity() D2D_MATRIX_3X2_F {
        return .{
            .m = [_][2]FLOAT{
                [2]FLOAT{ 1.0, 0.0 },
                [2]FLOAT{ 0.0, 1.0 },
                [2]FLOAT{ 0.0, 0.0 },
            },
        };
    }
};

pub const D2D_MATRIX_4X3_F = extern struct {
    m: [4][3]FLOAT,
};

pub const D2D_MATRIX_4X4_F = extern struct {
    m: [4][4]FLOAT,
};

pub const D2D_MATRIX_5X4_F = extern struct {
    m: [5][4]FLOAT,
};

pub const CAP_STYLE = enum(UINT) {
    FLAT = 0,
    SQUARE = 1,
    ROUND = 2,
    TRIANGLE = 3,
};

pub const DASH_STYLE = enum(UINT) {
    SOLID = 0,
    DASH = 1,
    DOT = 2,
    DASH_DOT = 3,
    DASH_DOT_DOT = 4,
    CUSTOM = 5,
};

pub const LINE_JOIN = enum(UINT) {
    MITER = 0,
    BEVEL = 1,
    ROUND = 2,
    MITER_OR_BEVEL = 3,
};

pub const STROKE_STYLE_PROPERTIES = extern struct {
    startCap: CAP_STYLE,
    endCap: CAP_STYLE,
    dashCap: CAP_STYLE,
    lineJoin: LINE_JOIN,
    miterLimit: FLOAT,
    dashStyle: DASH_STYLE,
    dashOffset: FLOAT,
};

pub const RADIAL_GRADIENT_BRUSH_PROPERTIES = extern struct {
    center: POINT_2F,
    gradientOriginOffset: POINT_2F,
    radiusX: FLOAT,
    radiusY: FLOAT,
};

pub const IResource = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IResource, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IResource) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IResource) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetFactory: *anyopaque,
    };
};

pub const IImage = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IImage, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IImage) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IImage) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
    };
};

pub const IBitmap = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IBitmap, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IImage.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IBitmap) ULONG {
        return IImage.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IBitmap) ULONG {
        return IImage.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IImage.VTable,
        GetSize: *anyopaque,
        GetPixelSize: *anyopaque,
        GetPixelFormat: *anyopaque,
        GetPixelDpi: *anyopaque,
        CopyFromBitmap: *anyopaque,
        CopyFromRenderTarget: *anyopaque,
        CopyFromMemory: *anyopaque,
    };
};

pub const GAMMA = enum(UINT) {
    _2_2 = 0,
    _1_0 = 1,
};

pub const EXTEND_MODE = enum(UINT) {
    CLAMP = 0,
    WRAP = 1,
    MIRROR = 2,
};

pub const GRADIENT_STOP = extern struct {
    position: FLOAT,
    color: COLOR_F,
};

pub const IGradientStopCollection = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGradientStopCollection, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGradientStopCollection) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGradientStopCollection) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
        GetGradientStopCount: *anyopaque,
        GetGradientStops: *anyopaque,
        GetColorInterpolationGamma: *anyopaque,
        GetExtendMode: *anyopaque,
    };
};

pub const IBrush = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IBrush, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IBrush) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IBrush) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
        SetOpacity: *anyopaque,
        SetTransform: *anyopaque,
        GetOpacity: *anyopaque,
        GetTransform: *anyopaque,
    };
};

pub const ISolidColorBrush = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ISolidColorBrush, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IBrush.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ISolidColorBrush) ULONG {
        return IBrush.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ISolidColorBrush) ULONG {
        return IBrush.Release(@ptrCast(self));
    }
    pub inline fn SetColor(self: *ISolidColorBrush, color: *const COLOR_F) void {
        self.__v.SetColor(self, color);
    }
    pub inline fn GetColor(self: *ISolidColorBrush, color: *COLOR_F) *COLOR_F {
        return self.__v.GetColor(self, color);
    }
    pub const VTable = extern struct {
        base: IBrush.VTable,
        SetColor: *const fn (*ISolidColorBrush, *const COLOR_F) callconv(WINAPI) void,
        GetColor: *const fn (*ISolidColorBrush, *COLOR_F) callconv(WINAPI) *COLOR_F,
    };
};

pub const IRadialGradientBrush = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IRadialGradientBrush, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IBrush.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IRadialGradientBrush) ULONG {
        return IBrush.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IRadialGradientBrush) ULONG {
        return IBrush.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IBrush.VTable,
        SetCenter: *anyopaque,
        SetGradientOriginOffset: *anyopaque,
        SetRadiusX: *anyopaque,
        SetRadiusY: *anyopaque,
        GetCenter: *anyopaque,
        GetGradientOriginOffset: *anyopaque,
        GetRadiusX: *anyopaque,
        GetRadiusY: *anyopaque,
        GetGradientStopCollection: *anyopaque,
    };
};

pub const IStrokeStyle = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IStrokeStyle, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IStrokeStyle) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IStrokeStyle) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
        GetStartCap: *anyopaque,
        GetEndCap: *anyopaque,
        GetDashCap: *anyopaque,
        GetMiterLimit: *anyopaque,
        GetLineJoin: *anyopaque,
        GetDashOffset: *anyopaque,
        GetDashStyle: *anyopaque,
        GetDashesCount: *anyopaque,
        GetDashes: *anyopaque,
    };
};

pub const IGeometry = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGeometry, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGeometry) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGeometry) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
        GetBounds: *anyopaque,
        GetWidenedBounds: *anyopaque,
        StrokeContainsPoint: *anyopaque,
        FillContainsPoint: *anyopaque,
        CompareWithGeometry: *anyopaque,
        Simplify: *anyopaque,
        Tessellate: *anyopaque,
        CombineWithGeometry: *anyopaque,
        Outline: *anyopaque,
        ComputeArea: *anyopaque,
        ComputeLength: *anyopaque,
        ComputePointAtLength: *anyopaque,
        Widen: *anyopaque,
    };
};

pub const IRectangleGeometry = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IRectangleGeometry, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGeometry.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IRectangleGeometry) ULONG {
        return IGeometry.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IRectangleGeometry) ULONG {
        return IGeometry.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IGeometry.VTable,
        GetRect: *anyopaque,
    };
};

pub const IRoundedRectangleGeometry = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IRoundedRectangleGeometry, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGeometry.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IRoundedRectangleGeometry) ULONG {
        return IGeometry.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IRoundedRectangleGeometry) ULONG {
        return IGeometry.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IGeometry.VTable,
        GetRoundedRect: *anyopaque,
    };
};

pub const IEllipseGeometry = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IEllipseGeometry, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGeometry.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IEllipseGeometry) ULONG {
        return IGeometry.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IEllipseGeometry) ULONG {
        return IGeometry.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IGeometry.VTable,
        GetEllipse: *anyopaque,
    };
};

pub const IGeometryGroup = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGeometryGroup, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGeometry.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGeometryGroup) ULONG {
        return IGeometry.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGeometryGroup) ULONG {
        return IGeometry.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IGeometry.VTable,
        GetFillMode: *anyopaque,
        GetSourceGeometryCount: *anyopaque,
        GetSourceGeometries: *anyopaque,
    };
};

pub const ITransformedGeometry = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ITransformedGeometry, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGeometry.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ITransformedGeometry) ULONG {
        return IGeometry.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ITransformedGeometry) ULONG {
        return IGeometry.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IGeometry.VTable,
        GetSourceGeometry: *anyopaque,
        GetTransform: *anyopaque,
    };
};

pub const FIGURE_BEGIN = enum(UINT) {
    FILLED = 0,
    HOLLOW = 1,
};

pub const FIGURE_END = enum(UINT) {
    OPEN = 0,
    CLOSED = 1,
};

pub const BEZIER_SEGMENT = extern struct {
    point1: POINT_2F,
    point2: POINT_2F,
    point3: POINT_2F,
};

pub const TRIANGLE = extern struct {
    point1: POINT_2F,
    point2: POINT_2F,
    point3: POINT_2F,
};

pub const PATH_SEGMENT = UINT;
pub const PATH_SEGMENT_NONE = 0x00000000;
pub const PATH_SEGMENT_FORCE_UNSTROKED = 0x00000001;
pub const PATH_SEGMENT_FORCE_ROUND_LINE_JOIN = 0x00000002;

pub const SWEEP_DIRECTION = enum(UINT) {
    COUNTER_CLOCKWISE = 0,
    CLOCKWISE = 1,
};

pub const FILL_MODE = enum(UINT) {
    ALTERNATE = 0,
    WINDING = 1,
};

pub const ARC_SIZE = enum(UINT) {
    SMALL = 0,
    LARGE = 1,
};

pub const ARC_SEGMENT = extern struct {
    point: POINT_2F,
    size: SIZE_F,
    rotationAngle: FLOAT,
    sweepDirection: SWEEP_DIRECTION,
    arcSize: ARC_SIZE,
};

pub const QUADRATIC_BEZIER_SEGMENT = extern struct {
    point1: POINT_2F,
    point2: POINT_2F,
};

pub const ISimplifiedGeometrySink = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ISimplifiedGeometrySink, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ISimplifiedGeometrySink) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ISimplifiedGeometrySink) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn SetFillMode(self: *ISimplifiedGeometrySink, mode: FILL_MODE) void {
        self.__v.SetFillMode(self, mode);
    }
    pub inline fn SetSegmentFlags(self: *ISimplifiedGeometrySink, flags: PATH_SEGMENT) void {
        self.__v.SetSegmentFlags(self, flags);
    }
    pub inline fn BeginFigure(self: *ISimplifiedGeometrySink, point: POINT_2F, begin: FIGURE_BEGIN) void {
        self.__v.BeginFigure(self, point, begin);
    }
    pub inline fn AddLines(self: *ISimplifiedGeometrySink, points: [*]const POINT_2F, count: UINT32) void {
        self.__v.AddLines(self, points, count);
    }
    pub inline fn AddBeziers(self: *ISimplifiedGeometrySink, segments: [*]const BEZIER_SEGMENT, count: UINT32) void {
        self.__v.AddBeziers(self, segments, count);
    }
    pub inline fn EndFigure(self: *ISimplifiedGeometrySink, end: FIGURE_END) void {
        self.__v.EndFigure(self, end);
    }
    pub inline fn Close(self: *ISimplifiedGeometrySink) HRESULT {
        return self.__v.Close(self);
    }
    pub const VTable = extern struct {
        const T = ISimplifiedGeometrySink;
        base: IUnknown.VTable,
        SetFillMode: *const fn (*T, FILL_MODE) callconv(WINAPI) void,
        SetSegmentFlags: *const fn (*T, PATH_SEGMENT) callconv(WINAPI) void,
        BeginFigure: *const fn (*T, POINT_2F, FIGURE_BEGIN) callconv(WINAPI) void,
        AddLines: *const fn (*T, [*]const POINT_2F, UINT32) callconv(WINAPI) void,
        AddBeziers: *const fn (*T, [*]const BEZIER_SEGMENT, UINT32) callconv(WINAPI) void,
        EndFigure: *const fn (*T, FIGURE_END) callconv(WINAPI) void,
        Close: *const fn (*T) callconv(WINAPI) HRESULT,
    };
};

pub const IGeometrySink = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGeometrySink, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return ISimplifiedGeometrySink.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGeometrySink) ULONG {
        return ISimplifiedGeometrySink.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGeometrySink) ULONG {
        return ISimplifiedGeometrySink.Release(@ptrCast(self));
    }
    pub inline fn SetFillMode(self: *IGeometrySink, mode: FILL_MODE) void {
        ISimplifiedGeometrySink.SetFillMode(@ptrCast(self), mode);
    }
    pub inline fn SetSegmentFlags(self: *IGeometrySink, flags: PATH_SEGMENT) void {
        ISimplifiedGeometrySink.SetSegmentFlags(@ptrCast(self), flags);
    }
    pub inline fn BeginFigure(self: *IGeometrySink, point: POINT_2F, begin: FIGURE_BEGIN) void {
        ISimplifiedGeometrySink.BeginFigure(@ptrCast(self), point, begin);
    }
    pub inline fn AddLines(self: *IGeometrySink, points: [*]const POINT_2F, count: UINT32) void {
        ISimplifiedGeometrySink.AddLines(@ptrCast(self), points, count);
    }
    pub inline fn AddBeziers(self: *IGeometrySink, segments: [*]const BEZIER_SEGMENT, count: UINT32) void {
        ISimplifiedGeometrySink.AddBeziers(@ptrCast(self), segments, count);
    }
    pub inline fn EndFigure(self: *IGeometrySink, end: FIGURE_END) void {
        ISimplifiedGeometrySink.EndFigure(@ptrCast(self), end);
    }
    pub inline fn Close(self: *IGeometrySink) HRESULT {
        return ISimplifiedGeometrySink.Close(@ptrCast(self));
    }
    pub inline fn AddLine(self: *IGeometrySink, point: POINT_2F) void {
        self.__v.AddLine(self, point);
    }
    pub inline fn AddBezier(self: *IGeometrySink, segment: *const BEZIER_SEGMENT) void {
        self.__v.AddBezier(self, segment);
    }
    pub inline fn AddQuadraticBezier(self: *IGeometrySink, segment: *const QUADRATIC_BEZIER_SEGMENT) void {
        self.__v.AddQuadraticBezier(self, segment);
    }
    pub inline fn AddQuadraticBeziers(self: *IGeometrySink, segments: [*]const QUADRATIC_BEZIER_SEGMENT, count: UINT32) void {
        self.__v.AddQuadraticBeziers(self, segments, count);
    }
    pub inline fn AddArc(self: *IGeometrySink, segment: *const ARC_SEGMENT) void {
        self.__v.AddArc(self, segment);
    }
    pub const VTable = extern struct {
        const T = IGeometrySink;
        base: ISimplifiedGeometrySink.VTable,
        AddLine: *const fn (*T, POINT_2F) callconv(WINAPI) void,
        AddBezier: *const fn (*T, *const BEZIER_SEGMENT) callconv(WINAPI) void,
        AddQuadraticBezier: *const fn (*T, *const QUADRATIC_BEZIER_SEGMENT) callconv(WINAPI) void,
        AddQuadraticBeziers: *const fn (*T, [*]const QUADRATIC_BEZIER_SEGMENT, UINT32) callconv(WINAPI) void,
        AddArc: *const fn (*T, *const ARC_SEGMENT) callconv(WINAPI) void,
    };
};

pub const IPathGeometry = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IPathGeometry, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGeometry.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IPathGeometry) ULONG {
        return IGeometry.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IPathGeometry) ULONG {
        return IGeometry.Release(@ptrCast(self));
    }
    pub inline fn Open(self: *IPathGeometry, sink: *?*IGeometrySink) HRESULT {
        return self.__v.Open(self, sink);
    }
    pub inline fn GetSegmentCount(self: *IPathGeometry, count: *UINT32) HRESULT {
        return self.__v.GetSegmentCount(self, count);
    }
    pub inline fn GetFigureCount(self: *IPathGeometry, count: *UINT32) HRESULT {
        return self.__v.GetFigureCount(self, count);
    }
    pub const VTable = extern struct {
        const T = IPathGeometry;
        base: IGeometry.VTable,
        Open: *const fn (*T, *?*IGeometrySink) callconv(WINAPI) HRESULT,
        Stream: *anyopaque,
        GetSegmentCount: *const fn (*T, *UINT32) callconv(WINAPI) HRESULT,
        GetFigureCount: *const fn (*T, *UINT32) callconv(WINAPI) HRESULT,
    };
};

pub const BRUSH_PROPERTIES = extern struct {
    opacity: FLOAT,
    transform: MATRIX_3X2_F,
};

pub const ELLIPSE = extern struct {
    point: POINT_2F,
    radiusX: FLOAT,
    radiusY: FLOAT,
};

pub const ROUNDED_RECT = extern struct {
    rect: RECT_F,
    radiusX: FLOAT,
    radiusY: FLOAT,
};

pub const BITMAP_INTERPOLATION_MODE = enum(UINT) {
    NEAREST_NEIGHBOR = 0,
    LINEAR = 1,
};

pub const DRAW_TEXT_OPTIONS = UINT;
pub const DRAW_TEXT_OPTIONS_NONE = 0;
pub const DRAW_TEXT_OPTIONS_NO_SNAP = 0x1;
pub const DRAW_TEXT_OPTIONS_CLIP = 0x2;
pub const DRAW_TEXT_OPTIONS_ENABLE_COLOR_FONT = 0x4;
pub const DRAW_TEXT_OPTIONS_DISABLE_COLOR_BITMAP_SNAPPING = 0x8;

pub const TAG = UINT64;

pub const IRenderTarget = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IRenderTarget, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IRenderTarget) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IRenderTarget) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub inline fn CreateSolidColorBrush(self: *IRenderTarget, color: *const COLOR_F, properties: ?*const BRUSH_PROPERTIES, brush: *?*ISolidColorBrush) HRESULT {
        return self.__v.CreateSolidColorBrush(self, color, properties, brush);
    }
    pub inline fn CreateGradientStopCollection(self: *IRenderTarget, stops: [*]const GRADIENT_STOP, num_stops: UINT32, gamma: GAMMA, extend_mode: EXTEND_MODE, stop_collection: *?*IGradientStopCollection) HRESULT {
        return self.__v.CreateGradientStopCollection(self, stops, num_stops, gamma, extend_mode, stop_collection);
    }
    pub inline fn CreateRadialGradientBrush(self: *IRenderTarget, gradient_properties: *const RADIAL_GRADIENT_BRUSH_PROPERTIES, brush_properties: ?*const BRUSH_PROPERTIES, stop_collection: *IGradientStopCollection, brush: *?*IRadialGradientBrush) HRESULT {
        return self.__v.CreateRadialGradientBrush(self, gradient_properties, brush_properties, stop_collection, brush);
    }
    pub inline fn DrawLine(self: *IRenderTarget, p0: POINT_2F, p1: POINT_2F, brush: *IBrush, width: FLOAT, style: ?*IStrokeStyle) void {
        self.__v.DrawLine(self, p0, p1, brush, width, style);
    }
    pub inline fn DrawRectangle(self: *IRenderTarget, rect: *const RECT_F, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        self.__v.DrawRectangle(self, rect, brush, width, stroke);
    }
    pub inline fn FillRectangle(self: *IRenderTarget, rect: *const RECT_F, brush: *IBrush) void {
        self.__v.FillRectangle(self, rect, brush);
    }
    pub inline fn DrawRoundedRectangle(self: *IRenderTarget, rect: *const ROUNDED_RECT, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        self.__v.DrawRoundedRectangle(self, rect, brush, width, stroke);
    }
    pub inline fn FillRoundedRectangle(self: *IRenderTarget, rect: *const ROUNDED_RECT, brush: *IBrush) void {
        self.__v.FillRoundedRectangle(self, rect, brush);
    }
    pub inline fn DrawEllipse(self: *IRenderTarget, ellipse: *const ELLIPSE, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        self.__v.DrawEllipse(self, ellipse, brush, width, stroke);
    }
    pub inline fn FillEllipse(self: *IRenderTarget, ellipse: *const ELLIPSE, brush: *IBrush) void {
        self.__v.FillEllipse(self, ellipse, brush);
    }
    pub inline fn DrawGeometry(self: *IRenderTarget, geo: *IGeometry, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        self.__v.DrawGeometry(self, geo, brush, width, stroke);
    }
    pub inline fn FillGeometry(self: *IRenderTarget, geo: *IGeometry, brush: *IBrush, opacity_brush: ?*IBrush) void {
        self.__v.FillGeometry(self, geo, brush, opacity_brush);
    }
    pub inline fn DrawBitmap(self: *IRenderTarget, bitmap: *IBitmap, dst_rect: ?*const RECT_F, opacity: FLOAT, interpolation_mode: BITMAP_INTERPOLATION_MODE, src_rect: ?*const RECT_F) void {
        self.__v.DrawBitmap(self, bitmap, dst_rect, opacity, interpolation_mode, src_rect);
    }
    pub inline fn DrawText(self: *IRenderTarget, string: LPCWSTR, length: UINT, format: *dwrite.ITextFormat, layout_rect: *const RECT_F, brush: *IBrush, options: DRAW_TEXT_OPTIONS, measuring_mode: dwrite.MEASURING_MODE) void {
        self.__v.DrawText(self, string, length, format, layout_rect, brush, options, measuring_mode);
    }
    pub inline fn SetTransform(self: *IRenderTarget, m: *const MATRIX_3X2_F) void {
        self.__v.SetTransform(self, m);
    }
    pub inline fn Clear(self: *IRenderTarget, color: ?*const COLOR_F) void {
        self.__v.Clear(self, color);
    }
    pub inline fn BeginDraw(self: *IRenderTarget) void {
        self.__v.BeginDraw(self);
    }
    pub inline fn EndDraw(self: *IRenderTarget, tag1: ?*TAG, tag2: ?*TAG) HRESULT {
        return self.__v.EndDraw(self, tag1, tag2);
    }
    pub const VTable = extern struct {
        const T = IRenderTarget;
        base: IResource.VTable,
        CreateBitmap: *anyopaque,
        CreateBitmapFromWicBitmap: *anyopaque,
        CreateSharedBitmap: *anyopaque,
        CreateBitmapBrush: *anyopaque,
        CreateSolidColorBrush: *const fn (
            *T,
            *const COLOR_F,
            ?*const BRUSH_PROPERTIES,
            *?*ISolidColorBrush,
        ) callconv(WINAPI) HRESULT,
        CreateGradientStopCollection: *const fn (
            *T,
            [*]const GRADIENT_STOP,
            UINT32,
            GAMMA,
            EXTEND_MODE,
            *?*IGradientStopCollection,
        ) callconv(WINAPI) HRESULT,
        CreateLinearGradientBrush: *anyopaque,
        CreateRadialGradientBrush: *const fn (
            *T,
            *const RADIAL_GRADIENT_BRUSH_PROPERTIES,
            ?*const BRUSH_PROPERTIES,
            *IGradientStopCollection,
            *?*IRadialGradientBrush,
        ) callconv(WINAPI) HRESULT,
        CreateCompatibleRenderTarget: *anyopaque,
        CreateLayer: *anyopaque,
        CreateMesh: *anyopaque,
        DrawLine: *const fn (
            *T,
            POINT_2F,
            POINT_2F,
            *IBrush,
            FLOAT,
            ?*IStrokeStyle,
        ) callconv(WINAPI) void,
        DrawRectangle: *const fn (*T, *const RECT_F, *IBrush, FLOAT, ?*IStrokeStyle) callconv(WINAPI) void,
        FillRectangle: *const fn (*T, *const RECT_F, *IBrush) callconv(WINAPI) void,
        DrawRoundedRectangle: *const fn (
            *T,
            *const ROUNDED_RECT,
            *IBrush,
            FLOAT,
            ?*IStrokeStyle,
        ) callconv(WINAPI) void,
        FillRoundedRectangle: *const fn (*T, *const ROUNDED_RECT, *IBrush) callconv(WINAPI) void,
        DrawEllipse: *const fn (*T, *const ELLIPSE, *IBrush, FLOAT, ?*IStrokeStyle) callconv(WINAPI) void,
        FillEllipse: *const fn (*T, *const ELLIPSE, *IBrush) callconv(WINAPI) void,
        DrawGeometry: *const fn (*T, *IGeometry, *IBrush, FLOAT, ?*IStrokeStyle) callconv(WINAPI) void,
        FillGeometry: *const fn (*T, *IGeometry, *IBrush, ?*IBrush) callconv(WINAPI) void,
        FillMesh: *anyopaque,
        FillOpacityMask: *anyopaque,
        DrawBitmap: *const fn (
            *T,
            *IBitmap,
            ?*const RECT_F,
            FLOAT,
            BITMAP_INTERPOLATION_MODE,
            ?*const RECT_F,
        ) callconv(WINAPI) void,
        DrawText: *const fn (
            *T,
            LPCWSTR,
            UINT,
            *dwrite.ITextFormat,
            *const RECT_F,
            *IBrush,
            DRAW_TEXT_OPTIONS,
            dwrite.MEASURING_MODE,
        ) callconv(WINAPI) void,
        DrawTextLayout: *anyopaque,
        DrawGlyphRun: *anyopaque,
        SetTransform: *const fn (*T, *const MATRIX_3X2_F) callconv(WINAPI) void,
        GetTransform: *anyopaque,
        SetAntialiasMode: *anyopaque,
        GetAntialiasMode: *anyopaque,
        SetTextAntialiasMode: *anyopaque,
        GetTextAntialiasMode: *anyopaque,
        SetTextRenderingParams: *anyopaque,
        GetTextRenderingParams: *anyopaque,
        SetTags: *anyopaque,
        GetTags: *anyopaque,
        PushLayer: *anyopaque,
        PopLayer: *anyopaque,
        Flush: *anyopaque,
        SaveDrawingState: *anyopaque,
        RestoreDrawingState: *anyopaque,
        PushAxisAlignedClip: *anyopaque,
        PopAxisAlignedClip: *anyopaque,
        Clear: *const fn (*T, ?*const COLOR_F) callconv(WINAPI) void,
        BeginDraw: *const fn (*T) callconv(WINAPI) void,
        EndDraw: *const fn (*T, ?*TAG, ?*TAG) callconv(WINAPI) HRESULT,
        GetPixelFormat: *anyopaque,
        SetDpi: *anyopaque,
        GetDpi: *anyopaque,
        GetSize: *anyopaque,
        GetPixelSize: *anyopaque,
        GetMaximumBitmapSize: *anyopaque,
        IsSupported: *anyopaque,
    };
};

pub const IFactory = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn CreateRectangleGeometry(self: *IFactory, rect: *const RECT_F, geo: *?*IRectangleGeometry) HRESULT {
        return self.__v.CreateRectangleGeometry(self, rect, geo);
    }
    pub inline fn CreateRoundedRectangleGeometry(self: *IFactory, rect: *const ROUNDED_RECT, geo: *?*IRoundedRectangleGeometry) HRESULT {
        return self.__v.CreateRoundedRectangleGeometry(self, rect, geo);
    }
    pub inline fn CreateEllipseGeometry(self: *IFactory, ellipse: *const ELLIPSE, geo: *?*IEllipseGeometry) HRESULT {
        return self.__v.CreateEllipseGeometry(self, ellipse, geo);
    }
    pub inline fn CreatePathGeometry(self: *IFactory, geo: *?*IPathGeometry) HRESULT {
        return self.__v.CreatePathGeometry(self, geo);
    }
    pub inline fn CreateStrokeStyle(self: *IFactory, properties: *const STROKE_STYLE_PROPERTIES, dashes: ?[*]const FLOAT, dashes_count: UINT32, stroke_style: *?*IStrokeStyle) HRESULT {
        return self.__v.CreateStrokeStyle(self, properties, dashes, dashes_count, stroke_style);
    }
    pub const VTable = extern struct {
        const T = IFactory;
        base: IUnknown.VTable,
        ReloadSystemMetrics: *anyopaque,
        GetDesktopDpi: *anyopaque,
        CreateRectangleGeometry: *const fn (*T, *const RECT_F, *?*IRectangleGeometry) callconv(WINAPI) HRESULT,
        CreateRoundedRectangleGeometry: *const fn (
            *T,
            *const ROUNDED_RECT,
            *?*IRoundedRectangleGeometry,
        ) callconv(WINAPI) HRESULT,
        CreateEllipseGeometry: *const fn (*T, *const ELLIPSE, *?*IEllipseGeometry) callconv(WINAPI) HRESULT,
        CreateGeometryGroup: *anyopaque,
        CreateTransformedGeometry: *anyopaque,
        CreatePathGeometry: *const fn (*T, *?*IPathGeometry) callconv(WINAPI) HRESULT,
        CreateStrokeStyle: *const fn (
            *T,
            *const STROKE_STYLE_PROPERTIES,
            ?[*]const FLOAT,
            UINT32,
            *?*IStrokeStyle,
        ) callconv(WINAPI) HRESULT,
        CreateDrawingStateBlock: *anyopaque,
        CreateWicBitmapRenderTarget: *anyopaque,
        CreateHwndRenderTarget: *anyopaque,
        CreateDxgiSurfaceRenderTarget: *anyopaque,
        CreateDCRenderTarget: *anyopaque,
    };
};

pub const FACTORY_TYPE = enum(UINT) {
    SINGLE_THREADED = 0,
    MULTI_THREADED = 1,
};

pub const DEBUG_LEVEL = enum(UINT) {
    NONE = 0,
    ERROR = 1,
    WARNING = 2,
    INFORMATION = 3,
};

pub const FACTORY_OPTIONS = extern struct {
    debugLevel: DEBUG_LEVEL,
};

pub extern "d2d1" fn D2D1CreateFactory(
    FACTORY_TYPE,
    *const GUID,
    ?*const FACTORY_OPTIONS,
    *?*anyopaque,
) callconv(WINAPI) HRESULT;

pub const IBitmap1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IBitmap1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IBitmap.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IBitmap1) ULONG {
        return IBitmap.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IBitmap1) ULONG {
        return IBitmap.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IBitmap.VTable,
        GetColorContext: *anyopaque,
        GetOptions: *anyopaque,
        GetSurface: *anyopaque,
        Map: *anyopaque,
        Unmap: *anyopaque,
    };
};

pub const IColorContext = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IColorContext, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IColorContext) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IColorContext) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
        GetColorSpace: *anyopaque,
        GetProfileSize: *anyopaque,
        GetProfile: *anyopaque,
    };
};

pub const DEVICE_CONTEXT_OPTIONS = UINT;
pub const DEVICE_CONTEXT_OPTIONS_NONE = 0;
pub const DEVICE_CONTEXT_OPTIONS_ENABLE_MULTITHREADED_OPTIMIZATIONS = 0x1;

pub const BITMAP_OPTIONS = UINT;
pub const BITMAP_OPTIONS_NONE = 0;
pub const BITMAP_OPTIONS_TARGET = 0x1;
pub const BITMAP_OPTIONS_CANNOT_DRAW = 0x2;
pub const BITMAP_OPTIONS_CPU_READ = 0x4;
pub const BITMAP_OPTIONS_GDI_COMPATIBLE = 0x8;

pub const BITMAP_PROPERTIES1 = extern struct {
    pixelFormat: PIXEL_FORMAT,
    dpiX: FLOAT,
    dpiY: FLOAT,
    bitmapOptions: BITMAP_OPTIONS,
    colorContext: ?*IColorContext,
};

pub const IDeviceContext = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceContext, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IRenderTarget.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceContext) ULONG {
        return IRenderTarget.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceContext) ULONG {
        return IRenderTarget.Release(@ptrCast(self));
    }
    pub inline fn CreateSolidColorBrush(self: *IDeviceContext, color: *const COLOR_F, properties: ?*const BRUSH_PROPERTIES, brush: *?*ISolidColorBrush) HRESULT {
        return IRenderTarget.CreateSolidColorBrush(@ptrCast(self), color, properties, brush);
    }
    pub inline fn CreateGradientStopCollection(self: *IDeviceContext, stops: [*]const GRADIENT_STOP, num_stops: UINT32, gamma: GAMMA, extend_mode: EXTEND_MODE, stop_collection: *?*IGradientStopCollection) HRESULT {
        return IRenderTarget.CreateGradientStopCollection(@ptrCast(self), stops, num_stops, gamma, extend_mode, stop_collection);
    }
    pub inline fn CreateRadialGradientBrush(self: *IDeviceContext, gradient_properties: *const RADIAL_GRADIENT_BRUSH_PROPERTIES, brush_properties: ?*const BRUSH_PROPERTIES, stop_collection: *IGradientStopCollection, brush: *?*IRadialGradientBrush) HRESULT {
        return IRenderTarget.CreateRadialGradientBrush(@ptrCast(self), gradient_properties, brush_properties, stop_collection, brush);
    }
    pub inline fn DrawLine(self: *IDeviceContext, p0: POINT_2F, p1: POINT_2F, brush: *IBrush, width: FLOAT, style: ?*IStrokeStyle) void {
        IRenderTarget.DrawLine(@ptrCast(self), p0, p1, brush, width, style);
    }
    pub inline fn DrawRectangle(self: *IDeviceContext, rect: *const RECT_F, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IRenderTarget.DrawRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRectangle(self: *IDeviceContext, rect: *const RECT_F, brush: *IBrush) void {
        IRenderTarget.FillRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawRoundedRectangle(self: *IDeviceContext, rect: *const ROUNDED_RECT, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IRenderTarget.DrawRoundedRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRoundedRectangle(self: *IDeviceContext, rect: *const ROUNDED_RECT, brush: *IBrush) void {
        IRenderTarget.FillRoundedRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawEllipse(self: *IDeviceContext, ellipse: *const ELLIPSE, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IRenderTarget.DrawEllipse(@ptrCast(self), ellipse, brush, width, stroke);
    }
    pub inline fn FillEllipse(self: *IDeviceContext, ellipse: *const ELLIPSE, brush: *IBrush) void {
        IRenderTarget.FillEllipse(@ptrCast(self), ellipse, brush);
    }
    pub inline fn DrawGeometry(self: *IDeviceContext, geo: *IGeometry, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IRenderTarget.DrawGeometry(@ptrCast(self), geo, brush, width, stroke);
    }
    pub inline fn FillGeometry(self: *IDeviceContext, geo: *IGeometry, brush: *IBrush, opacity_brush: ?*IBrush) void {
        IRenderTarget.FillGeometry(@ptrCast(self), geo, brush, opacity_brush);
    }
    pub inline fn DrawBitmap(self: *IDeviceContext, bitmap: *IBitmap, dst_rect: ?*const RECT_F, opacity: FLOAT, interpolation_mode: BITMAP_INTERPOLATION_MODE, src_rect: ?*const RECT_F) void {
        IRenderTarget.DrawBitmap(@ptrCast(self), bitmap, dst_rect, opacity, interpolation_mode, src_rect);
    }
    pub inline fn DrawText(self: *IDeviceContext, string: LPCWSTR, length: UINT, format: *dwrite.ITextFormat, layout_rect: *const RECT_F, brush: *IBrush, options: DRAW_TEXT_OPTIONS, measuring_mode: dwrite.MEASURING_MODE) void {
        IRenderTarget.DrawText(@ptrCast(self), string, length, format, layout_rect, brush, options, measuring_mode);
    }
    pub inline fn SetTransform(self: *IDeviceContext, m: *const MATRIX_3X2_F) void {
        IRenderTarget.SetTransform(@ptrCast(self), m);
    }
    pub inline fn Clear(self: *IDeviceContext, color: ?*const COLOR_F) void {
        IRenderTarget.Clear(@ptrCast(self), color);
    }
    pub inline fn BeginDraw(self: *IDeviceContext) void {
        IRenderTarget.BeginDraw(@ptrCast(self));
    }
    pub inline fn EndDraw(self: *IDeviceContext, tag1: ?*TAG, tag2: ?*TAG) HRESULT {
        return IRenderTarget.EndDraw(@ptrCast(self), tag1, tag2);
    }
    pub inline fn CreateBitmapFromDxgiSurface(self: *IDeviceContext, surface: *dxgi.ISurface, properties: ?*const BITMAP_PROPERTIES1, bitmap: *?*IBitmap1) HRESULT {
        return self.__v.CreateBitmapFromDxgiSurface(self, surface, properties, bitmap);
    }
    pub inline fn SetTarget(self: *IDeviceContext, image: ?*IImage) void {
        self.__v.SetTarget(self, image);
    }
    pub const VTable = extern struct {
        const T = IDeviceContext;
        base: IRenderTarget.VTable,
        CreateBitmap1: *anyopaque,
        CreateBitmapFromWicBitmap1: *anyopaque,
        CreateColorContext: *anyopaque,
        CreateColorContextFromFilename: *anyopaque,
        CreateColorContextFromWicColorContext: *anyopaque,
        CreateBitmapFromDxgiSurface: *const fn (
            *T,
            *dxgi.ISurface,
            ?*const BITMAP_PROPERTIES1,
            *?*IBitmap1,
        ) callconv(WINAPI) HRESULT,
        CreateEffect: *anyopaque,
        CreateGradientStopCollection1: *anyopaque,
        CreateImageBrush: *anyopaque,
        CreateBitmapBrush1: *anyopaque,
        CreateCommandList: *anyopaque,
        IsDxgiFormatSupported: *anyopaque,
        IsBufferPrecisionSupported: *anyopaque,
        GetImageLocalBounds: *anyopaque,
        GetImageWorldBounds: *anyopaque,
        GetGlyphRunWorldBounds: *anyopaque,
        GetDevice: *anyopaque,
        SetTarget: *const fn (*T, ?*IImage) callconv(WINAPI) void,
        GetTarget: *anyopaque,
        SetRenderingControls: *anyopaque,
        GetRenderingControls: *anyopaque,
        SetPrimitiveBlend: *anyopaque,
        GetPrimitiveBlend: *anyopaque,
        SetUnitMode: *anyopaque,
        GetUnitMode: *anyopaque,
        DrawGlyphRun1: *anyopaque,
        DrawImage: *anyopaque,
        DrawGdiMetafile: *anyopaque,
        DrawBitmap1: *anyopaque,
        PushLayer1: *anyopaque,
        InvalidateEffectInputRectangle: *anyopaque,
        GetEffectInvalidRectangleCount: *anyopaque,
        GetEffectInvalidRectangles: *anyopaque,
        GetEffectRequiredInputRectangles: *anyopaque,
        FillOpacityMask1: *anyopaque,
    };
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
    pub inline fn CreateRectangleGeometry(self: *IFactory1, rect: *const RECT_F, geo: *?*IRectangleGeometry) HRESULT {
        return IFactory.CreateRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateRoundedRectangleGeometry(self: *IFactory1, rect: *const ROUNDED_RECT, geo: *?*IRoundedRectangleGeometry) HRESULT {
        return IFactory.CreateRoundedRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateEllipseGeometry(self: *IFactory1, ellipse: *const ELLIPSE, geo: *?*IEllipseGeometry) HRESULT {
        return IFactory.CreateEllipseGeometry(@ptrCast(self), ellipse, geo);
    }
    pub inline fn CreatePathGeometry(self: *IFactory1, geo: *?*IPathGeometry) HRESULT {
        return IFactory.CreatePathGeometry(@ptrCast(self), geo);
    }
    pub inline fn CreateStrokeStyle(self: *IFactory1, properties: *const STROKE_STYLE_PROPERTIES, dashes: ?[*]const FLOAT, dashes_count: UINT32, stroke_style: *?*IStrokeStyle) HRESULT {
        return IFactory.CreateStrokeStyle(@ptrCast(self), properties, dashes, dashes_count, stroke_style);
    }
    pub const VTable = extern struct {
        base: IFactory.VTable,
        CreateDevice: *anyopaque,
        CreateStrokeStyle1: *anyopaque,
        CreatePathGeometry1: *anyopaque,
        CreateDrawingStateBlock1: *anyopaque,
        CreateGdiMetafile: *anyopaque,
        RegisterEffectFromStream: *anyopaque,
        RegisterEffectFromString: *anyopaque,
        UnregisterEffect: *anyopaque,
        GetRegisteredEffects: *anyopaque,
        GetEffectProperties: *anyopaque,
    };
};

pub const IDevice = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
        CreateDeviceContext: *anyopaque,
        CreatePrintControl: *anyopaque,
        SetMaximumTextureMemory: *anyopaque,
        GetMaximumTextureMemory: *anyopaque,
        ClearResources: *anyopaque,
    };
};

pub const IDeviceContext1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceContext1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceContext.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceContext1) ULONG {
        return IDeviceContext.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceContext1) ULONG {
        return IDeviceContext.Release(@ptrCast(self));
    }
    pub inline fn CreateSolidColorBrush(self: *IDeviceContext1, color: *const COLOR_F, properties: ?*const BRUSH_PROPERTIES, brush: *?*ISolidColorBrush) HRESULT {
        return IDeviceContext.CreateSolidColorBrush(@ptrCast(self), color, properties, brush);
    }
    pub inline fn CreateGradientStopCollection(self: *IDeviceContext1, stops: [*]const GRADIENT_STOP, num_stops: UINT32, gamma: GAMMA, extend_mode: EXTEND_MODE, stop_collection: *?*IGradientStopCollection) HRESULT {
        return IDeviceContext.CreateGradientStopCollection(@ptrCast(self), stops, num_stops, gamma, extend_mode, stop_collection);
    }
    pub inline fn CreateRadialGradientBrush(self: *IDeviceContext1, gradient_properties: *const RADIAL_GRADIENT_BRUSH_PROPERTIES, brush_properties: ?*const BRUSH_PROPERTIES, stop_collection: *IGradientStopCollection, brush: *?*IRadialGradientBrush) HRESULT {
        return IDeviceContext.CreateRadialGradientBrush(@ptrCast(self), gradient_properties, brush_properties, stop_collection, brush);
    }
    pub inline fn DrawLine(self: *IDeviceContext1, p0: POINT_2F, p1: POINT_2F, brush: *IBrush, width: FLOAT, style: ?*IStrokeStyle) void {
        IDeviceContext.DrawLine(@ptrCast(self), p0, p1, brush, width, style);
    }
    pub inline fn DrawRectangle(self: *IDeviceContext1, rect: *const RECT_F, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext.DrawRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRectangle(self: *IDeviceContext1, rect: *const RECT_F, brush: *IBrush) void {
        IDeviceContext.FillRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawRoundedRectangle(self: *IDeviceContext1, rect: *const ROUNDED_RECT, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext.DrawRoundedRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRoundedRectangle(self: *IDeviceContext1, rect: *const ROUNDED_RECT, brush: *IBrush) void {
        IDeviceContext.FillRoundedRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawEllipse(self: *IDeviceContext1, ellipse: *const ELLIPSE, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext.DrawEllipse(@ptrCast(self), ellipse, brush, width, stroke);
    }
    pub inline fn FillEllipse(self: *IDeviceContext1, ellipse: *const ELLIPSE, brush: *IBrush) void {
        IDeviceContext.FillEllipse(@ptrCast(self), ellipse, brush);
    }
    pub inline fn DrawGeometry(self: *IDeviceContext1, geo: *IGeometry, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext.DrawGeometry(@ptrCast(self), geo, brush, width, stroke);
    }
    pub inline fn FillGeometry(self: *IDeviceContext1, geo: *IGeometry, brush: *IBrush, opacity_brush: ?*IBrush) void {
        IDeviceContext.FillGeometry(@ptrCast(self), geo, brush, opacity_brush);
    }
    pub inline fn DrawBitmap(self: *IDeviceContext1, bitmap: *IBitmap, dst_rect: ?*const RECT_F, opacity: FLOAT, interpolation_mode: BITMAP_INTERPOLATION_MODE, src_rect: ?*const RECT_F) void {
        IDeviceContext.DrawBitmap(@ptrCast(self), bitmap, dst_rect, opacity, interpolation_mode, src_rect);
    }
    pub inline fn DrawText(self: *IDeviceContext1, string: LPCWSTR, length: UINT, format: *dwrite.ITextFormat, layout_rect: *const RECT_F, brush: *IBrush, options: DRAW_TEXT_OPTIONS, measuring_mode: dwrite.MEASURING_MODE) void {
        IDeviceContext.DrawText(@ptrCast(self), string, length, format, layout_rect, brush, options, measuring_mode);
    }
    pub inline fn SetTransform(self: *IDeviceContext1, m: *const MATRIX_3X2_F) void {
        IDeviceContext.SetTransform(@ptrCast(self), m);
    }
    pub inline fn Clear(self: *IDeviceContext1, color: ?*const COLOR_F) void {
        IDeviceContext.Clear(@ptrCast(self), color);
    }
    pub inline fn BeginDraw(self: *IDeviceContext1) void {
        IDeviceContext.BeginDraw(@ptrCast(self));
    }
    pub inline fn EndDraw(self: *IDeviceContext1, tag1: ?*TAG, tag2: ?*TAG) HRESULT {
        return IDeviceContext.EndDraw(@ptrCast(self), tag1, tag2);
    }
    pub inline fn CreateBitmapFromDxgiSurface(self: *IDeviceContext1, surface: *dxgi.ISurface, properties: ?*const BITMAP_PROPERTIES1, bitmap: *?*IBitmap1) HRESULT {
        return IDeviceContext.CreateBitmapFromDxgiSurface(@ptrCast(self), surface, properties, bitmap);
    }
    pub inline fn SetTarget(self: *IDeviceContext1, image: ?*IImage) void {
        IDeviceContext.SetTarget(@ptrCast(self), image);
    }
    pub const VTable = extern struct {
        base: IDeviceContext.VTable,
        CreateFilledGeometryRealization: *anyopaque,
        CreateStrokedGeometryRealization: *anyopaque,
        DrawGeometryRealization: *anyopaque,
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
    pub inline fn CreateRectangleGeometry(self: *IFactory2, rect: *const RECT_F, geo: *?*IRectangleGeometry) HRESULT {
        return IFactory1.CreateRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateRoundedRectangleGeometry(self: *IFactory2, rect: *const ROUNDED_RECT, geo: *?*IRoundedRectangleGeometry) HRESULT {
        return IFactory1.CreateRoundedRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateEllipseGeometry(self: *IFactory2, ellipse: *const ELLIPSE, geo: *?*IEllipseGeometry) HRESULT {
        return IFactory1.CreateEllipseGeometry(@ptrCast(self), ellipse, geo);
    }
    pub inline fn CreatePathGeometry(self: *IFactory2, geo: *?*IPathGeometry) HRESULT {
        return IFactory1.CreatePathGeometry(@ptrCast(self), geo);
    }
    pub inline fn CreateStrokeStyle(self: *IFactory2, properties: *const STROKE_STYLE_PROPERTIES, dashes: ?[*]const FLOAT, dashes_count: UINT32, stroke_style: *?*IStrokeStyle) HRESULT {
        return IFactory1.CreateStrokeStyle(@ptrCast(self), properties, dashes, dashes_count, stroke_style);
    }
    pub const VTable = extern struct {
        base: IFactory1.VTable,
        CreateDevice1: *anyopaque,
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
    pub const VTable = extern struct {
        base: IDevice.VTable,
        GetRenderingPriority: *anyopaque,
        SetRenderingPriority: *anyopaque,
        CreateDeviceContext1: *anyopaque,
    };
};

pub const INK_NIB_SHAPE = enum(UINT) {
    ROUND = 0,
    SQUARE = 1,
};

pub const INK_POINT = extern struct {
    x: FLOAT,
    y: FLOAT,
    radius: FLOAT,
};

pub const INK_BEZIER_SEGMENT = extern struct {
    point1: INK_POINT,
    point2: INK_POINT,
    point3: INK_POINT,
};

pub const INK_STYLE_PROPERTIES = extern struct {
    nibShape: INK_NIB_SHAPE,
    nibTransform: MATRIX_3X2_F,
};

pub const IInk = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IInk, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IInk) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IInk) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub inline fn SetStartPoint(self: *IInk, point: *const INK_POINT) void {
        self.__v.SetStartPoint(self, point);
    }
    pub inline fn GetStartPoint(self: *IInk, point: *INK_POINT) *INK_POINT {
        return self.__v.GetStartPoint(self, point);
    }
    pub inline fn AddSegments(self: *IInk, segments: [*]const INK_BEZIER_SEGMENT, count: UINT32) HRESULT {
        return self.__v.AddSegments(self, segments, count);
    }
    pub inline fn RemoveSegmentsAtEnd(self: *IInk, count: UINT32) HRESULT {
        return self.__v.RemoveSegmentsAtEnd(self, count);
    }
    pub inline fn SetSegments(self: *IInk, start_segment: UINT32, segments: [*]const INK_BEZIER_SEGMENT, count: UINT32) HRESULT {
        return self.__v.SetSegments(self, start_segment, segments, count);
    }
    pub inline fn SetSegmentAtEnd(self: *IInk, segment: *const INK_BEZIER_SEGMENT) HRESULT {
        return self.__v.SetSegmentAtEnd(self, segment);
    }
    pub inline fn GetSegmentCount(self: *IInk) UINT32 {
        return self.__v.GetSegmentCount(self);
    }
    pub inline fn GetSegments(self: *IInk, start_segment: UINT32, segments: [*]const INK_BEZIER_SEGMENT, count: UINT32) HRESULT {
        return self.__v.GetSegments(self, start_segment, segments, count);
    }
    pub const VTable = extern struct {
        const T = IInk;
        base: IResource.VTable,
        SetStartPoint: *const fn (*T, *const INK_POINT) callconv(WINAPI) void,
        GetStartPoint: *const fn (*T, *INK_POINT) callconv(WINAPI) *INK_POINT,
        AddSegments: *const fn (*T, [*]const INK_BEZIER_SEGMENT, UINT32) callconv(WINAPI) HRESULT,
        RemoveSegmentsAtEnd: *const fn (*T, UINT32) callconv(WINAPI) HRESULT,
        SetSegments: *const fn (*T, UINT32, [*]const INK_BEZIER_SEGMENT, UINT32) callconv(WINAPI) HRESULT,
        SetSegmentAtEnd: *const fn (*T, *const INK_BEZIER_SEGMENT) callconv(WINAPI) HRESULT,
        GetSegmentCount: *const fn (*T) callconv(WINAPI) UINT32,
        GetSegments: *const fn (*T, UINT32, [*]const INK_BEZIER_SEGMENT, UINT32) callconv(WINAPI) HRESULT,
        StreamAsGeometry: *anyopaque,
        GetBounds: *anyopaque,
    };
};

pub const IInkStyle = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IInkStyle, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IInkStyle) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IInkStyle) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
        SetNibTransform: *anyopaque,
        GetNibTransform: *anyopaque,
        SetNibShape: *anyopaque,
        GetNibShape: *anyopaque,
    };
};

pub const IDeviceContext2 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceContext2, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceContext1.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceContext2) ULONG {
        return IDeviceContext1.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceContext2) ULONG {
        return IDeviceContext1.Release(@ptrCast(self));
    }
    pub inline fn CreateSolidColorBrush(self: *IDeviceContext2, color: *const COLOR_F, properties: ?*const BRUSH_PROPERTIES, brush: *?*ISolidColorBrush) HRESULT {
        return IDeviceContext1.CreateSolidColorBrush(@ptrCast(self), color, properties, brush);
    }
    pub inline fn CreateGradientStopCollection(self: *IDeviceContext2, stops: [*]const GRADIENT_STOP, num_stops: UINT32, gamma: GAMMA, extend_mode: EXTEND_MODE, stop_collection: *?*IGradientStopCollection) HRESULT {
        return IDeviceContext1.CreateGradientStopCollection(@ptrCast(self), stops, num_stops, gamma, extend_mode, stop_collection);
    }
    pub inline fn CreateRadialGradientBrush(self: *IDeviceContext2, gradient_properties: *const RADIAL_GRADIENT_BRUSH_PROPERTIES, brush_properties: ?*const BRUSH_PROPERTIES, stop_collection: *IGradientStopCollection, brush: *?*IRadialGradientBrush) HRESULT {
        return IDeviceContext1.CreateRadialGradientBrush(@ptrCast(self), gradient_properties, brush_properties, stop_collection, brush);
    }
    pub inline fn DrawLine(self: *IDeviceContext2, p0: POINT_2F, p1: POINT_2F, brush: *IBrush, width: FLOAT, style: ?*IStrokeStyle) void {
        IDeviceContext1.DrawLine(@ptrCast(self), p0, p1, brush, width, style);
    }
    pub inline fn DrawRectangle(self: *IDeviceContext2, rect: *const RECT_F, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext1.DrawRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRectangle(self: *IDeviceContext2, rect: *const RECT_F, brush: *IBrush) void {
        IDeviceContext1.FillRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawRoundedRectangle(self: *IDeviceContext2, rect: *const ROUNDED_RECT, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext1.DrawRoundedRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRoundedRectangle(self: *IDeviceContext2, rect: *const ROUNDED_RECT, brush: *IBrush) void {
        IDeviceContext1.FillRoundedRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawEllipse(self: *IDeviceContext2, ellipse: *const ELLIPSE, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext1.DrawEllipse(@ptrCast(self), ellipse, brush, width, stroke);
    }
    pub inline fn FillEllipse(self: *IDeviceContext2, ellipse: *const ELLIPSE, brush: *IBrush) void {
        IDeviceContext1.FillEllipse(@ptrCast(self), ellipse, brush);
    }
    pub inline fn DrawGeometry(self: *IDeviceContext2, geo: *IGeometry, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext1.DrawGeometry(@ptrCast(self), geo, brush, width, stroke);
    }
    pub inline fn FillGeometry(self: *IDeviceContext2, geo: *IGeometry, brush: *IBrush, opacity_brush: ?*IBrush) void {
        IDeviceContext1.FillGeometry(@ptrCast(self), geo, brush, opacity_brush);
    }
    pub inline fn DrawBitmap(self: *IDeviceContext2, bitmap: *IBitmap, dst_rect: ?*const RECT_F, opacity: FLOAT, interpolation_mode: BITMAP_INTERPOLATION_MODE, src_rect: ?*const RECT_F) void {
        IDeviceContext1.DrawBitmap(@ptrCast(self), bitmap, dst_rect, opacity, interpolation_mode, src_rect);
    }
    pub inline fn DrawText(self: *IDeviceContext2, string: LPCWSTR, length: UINT, format: *dwrite.ITextFormat, layout_rect: *const RECT_F, brush: *IBrush, options: DRAW_TEXT_OPTIONS, measuring_mode: dwrite.MEASURING_MODE) void {
        IDeviceContext1.DrawText(@ptrCast(self), string, length, format, layout_rect, brush, options, measuring_mode);
    }
    pub inline fn SetTransform(self: *IDeviceContext2, m: *const MATRIX_3X2_F) void {
        IDeviceContext1.SetTransform(@ptrCast(self), m);
    }
    pub inline fn Clear(self: *IDeviceContext2, color: ?*const COLOR_F) void {
        IDeviceContext1.Clear(@ptrCast(self), color);
    }
    pub inline fn BeginDraw(self: *IDeviceContext2) void {
        IDeviceContext1.BeginDraw(@ptrCast(self));
    }
    pub inline fn EndDraw(self: *IDeviceContext2, tag1: ?*TAG, tag2: ?*TAG) HRESULT {
        return IDeviceContext1.EndDraw(@ptrCast(self), tag1, tag2);
    }
    pub inline fn CreateBitmapFromDxgiSurface(self: *IDeviceContext2, surface: *dxgi.ISurface, properties: ?*const BITMAP_PROPERTIES1, bitmap: *?*IBitmap1) HRESULT {
        return IDeviceContext1.CreateBitmapFromDxgiSurface(@ptrCast(self), surface, properties, bitmap);
    }
    pub inline fn SetTarget(self: *IDeviceContext2, image: ?*IImage) void {
        IDeviceContext1.SetTarget(@ptrCast(self), image);
    }
    pub inline fn CreateInk(self: *IDeviceContext2, start_point: *const INK_POINT, ink: *?*IInk) HRESULT {
        return self.__v.CreateInk(self, start_point, ink);
    }
    pub inline fn CreateInkStyle(self: *IDeviceContext2, properties: ?*const INK_STYLE_PROPERTIES, ink_style: *?*IInkStyle) HRESULT {
        return self.__v.CreateInkStyle(self, properties, ink_style);
    }
    pub inline fn DrawInk(self: *IDeviceContext2, ink: *IInk, brush: *IBrush, style: ?*IInkStyle) void {
        self.__v.DrawInk(self, ink, brush, style);
    }
    pub const VTable = extern struct {
        const T = IDeviceContext2;
        base: IDeviceContext1.VTable,
        CreateInk: *const fn (*T, *const INK_POINT, *?*IInk) callconv(WINAPI) HRESULT,
        CreateInkStyle: *const fn (*T, ?*const INK_STYLE_PROPERTIES, *?*IInkStyle) callconv(WINAPI) HRESULT,
        CreateGradientMesh: *anyopaque,
        CreateImageSourceFromWic: *anyopaque,
        CreateLookupTable3D: *anyopaque,
        CreateImageSourceFromDxgi: *anyopaque,
        GetGradientMeshWorldBounds: *anyopaque,
        DrawInk: *const fn (*T, *IInk, *IBrush, ?*IInkStyle) callconv(WINAPI) void,
        DrawGradientMesh: *anyopaque,
        DrawGdiMetafile1: *anyopaque,
        CreateTransformedImageSource: *anyopaque,
    };
};

pub const IDeviceContext3 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceContext3, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceContext2.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceContext3) ULONG {
        return IDeviceContext2.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceContext3) ULONG {
        return IDeviceContext2.Release(@ptrCast(self));
    }
    pub inline fn CreateSolidColorBrush(self: *IDeviceContext3, color: *const COLOR_F, properties: ?*const BRUSH_PROPERTIES, brush: *?*ISolidColorBrush) HRESULT {
        return IDeviceContext2.CreateSolidColorBrush(@ptrCast(self), color, properties, brush);
    }
    pub inline fn CreateGradientStopCollection(self: *IDeviceContext3, stops: [*]const GRADIENT_STOP, num_stops: UINT32, gamma: GAMMA, extend_mode: EXTEND_MODE, stop_collection: *?*IGradientStopCollection) HRESULT {
        return IDeviceContext2.CreateGradientStopCollection(@ptrCast(self), stops, num_stops, gamma, extend_mode, stop_collection);
    }
    pub inline fn CreateRadialGradientBrush(self: *IDeviceContext3, gradient_properties: *const RADIAL_GRADIENT_BRUSH_PROPERTIES, brush_properties: ?*const BRUSH_PROPERTIES, stop_collection: *IGradientStopCollection, brush: *?*IRadialGradientBrush) HRESULT {
        return IDeviceContext2.CreateRadialGradientBrush(@ptrCast(self), gradient_properties, brush_properties, stop_collection, brush);
    }
    pub inline fn DrawLine(self: *IDeviceContext3, p0: POINT_2F, p1: POINT_2F, brush: *IBrush, width: FLOAT, style: ?*IStrokeStyle) void {
        IDeviceContext2.DrawLine(@ptrCast(self), p0, p1, brush, width, style);
    }
    pub inline fn DrawRectangle(self: *IDeviceContext3, rect: *const RECT_F, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext2.DrawRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRectangle(self: *IDeviceContext3, rect: *const RECT_F, brush: *IBrush) void {
        IDeviceContext2.FillRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawRoundedRectangle(self: *IDeviceContext3, rect: *const ROUNDED_RECT, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext2.DrawRoundedRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRoundedRectangle(self: *IDeviceContext3, rect: *const ROUNDED_RECT, brush: *IBrush) void {
        IDeviceContext2.FillRoundedRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawEllipse(self: *IDeviceContext3, ellipse: *const ELLIPSE, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext2.DrawEllipse(@ptrCast(self), ellipse, brush, width, stroke);
    }
    pub inline fn FillEllipse(self: *IDeviceContext3, ellipse: *const ELLIPSE, brush: *IBrush) void {
        IDeviceContext2.FillEllipse(@ptrCast(self), ellipse, brush);
    }
    pub inline fn DrawGeometry(self: *IDeviceContext3, geo: *IGeometry, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext2.DrawGeometry(@ptrCast(self), geo, brush, width, stroke);
    }
    pub inline fn FillGeometry(self: *IDeviceContext3, geo: *IGeometry, brush: *IBrush, opacity_brush: ?*IBrush) void {
        IDeviceContext2.FillGeometry(@ptrCast(self), geo, brush, opacity_brush);
    }
    pub inline fn DrawBitmap(self: *IDeviceContext3, bitmap: *IBitmap, dst_rect: ?*const RECT_F, opacity: FLOAT, interpolation_mode: BITMAP_INTERPOLATION_MODE, src_rect: ?*const RECT_F) void {
        IDeviceContext2.DrawBitmap(@ptrCast(self), bitmap, dst_rect, opacity, interpolation_mode, src_rect);
    }
    pub inline fn DrawText(self: *IDeviceContext3, string: LPCWSTR, length: UINT, format: *dwrite.ITextFormat, layout_rect: *const RECT_F, brush: *IBrush, options: DRAW_TEXT_OPTIONS, measuring_mode: dwrite.MEASURING_MODE) void {
        IDeviceContext2.DrawText(@ptrCast(self), string, length, format, layout_rect, brush, options, measuring_mode);
    }
    pub inline fn SetTransform(self: *IDeviceContext3, m: *const MATRIX_3X2_F) void {
        IDeviceContext2.SetTransform(@ptrCast(self), m);
    }
    pub inline fn Clear(self: *IDeviceContext3, color: ?*const COLOR_F) void {
        IDeviceContext2.Clear(@ptrCast(self), color);
    }
    pub inline fn BeginDraw(self: *IDeviceContext3) void {
        IDeviceContext2.BeginDraw(@ptrCast(self));
    }
    pub inline fn EndDraw(self: *IDeviceContext3, tag1: ?*TAG, tag2: ?*TAG) HRESULT {
        return IDeviceContext2.EndDraw(@ptrCast(self), tag1, tag2);
    }
    pub inline fn CreateBitmapFromDxgiSurface(self: *IDeviceContext3, surface: *dxgi.ISurface, properties: ?*const BITMAP_PROPERTIES1, bitmap: *?*IBitmap1) HRESULT {
        return IDeviceContext2.CreateBitmapFromDxgiSurface(@ptrCast(self), surface, properties, bitmap);
    }
    pub inline fn SetTarget(self: *IDeviceContext3, image: ?*IImage) void {
        IDeviceContext2.SetTarget(@ptrCast(self), image);
    }
    pub inline fn CreateInk(self: *IDeviceContext3, start_point: *const INK_POINT, ink: *?*IInk) HRESULT {
        return IDeviceContext2.CreateInk(@ptrCast(self), start_point, ink);
    }
    pub inline fn CreateInkStyle(self: *IDeviceContext3, properties: ?*const INK_STYLE_PROPERTIES, ink_style: *?*IInkStyle) HRESULT {
        return IDeviceContext2.CreateInkStyle(@ptrCast(self), properties, ink_style);
    }
    pub inline fn DrawInk(self: *IDeviceContext3, ink: *IInk, brush: *IBrush, style: ?*IInkStyle) void {
        IDeviceContext2.DrawInk(@ptrCast(self), ink, brush, style);
    }
    pub const VTable = extern struct {
        base: IDeviceContext2.VTable,
        CreateSpriteBatch: *anyopaque,
        DrawSpriteBatch: *anyopaque,
    };
};

pub const IDeviceContext4 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceContext4, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceContext3.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceContext4) ULONG {
        return IDeviceContext3.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceContext4) ULONG {
        return IDeviceContext3.Release(@ptrCast(self));
    }
    pub inline fn CreateSolidColorBrush(self: *IDeviceContext4, color: *const COLOR_F, properties: ?*const BRUSH_PROPERTIES, brush: *?*ISolidColorBrush) HRESULT {
        return IDeviceContext3.CreateSolidColorBrush(@ptrCast(self), color, properties, brush);
    }
    pub inline fn CreateGradientStopCollection(self: *IDeviceContext4, stops: [*]const GRADIENT_STOP, num_stops: UINT32, gamma: GAMMA, extend_mode: EXTEND_MODE, stop_collection: *?*IGradientStopCollection) HRESULT {
        return IDeviceContext3.CreateGradientStopCollection(@ptrCast(self), stops, num_stops, gamma, extend_mode, stop_collection);
    }
    pub inline fn CreateRadialGradientBrush(self: *IDeviceContext4, gradient_properties: *const RADIAL_GRADIENT_BRUSH_PROPERTIES, brush_properties: ?*const BRUSH_PROPERTIES, stop_collection: *IGradientStopCollection, brush: *?*IRadialGradientBrush) HRESULT {
        return IDeviceContext3.CreateRadialGradientBrush(@ptrCast(self), gradient_properties, brush_properties, stop_collection, brush);
    }
    pub inline fn DrawLine(self: *IDeviceContext4, p0: POINT_2F, p1: POINT_2F, brush: *IBrush, width: FLOAT, style: ?*IStrokeStyle) void {
        IDeviceContext3.DrawLine(@ptrCast(self), p0, p1, brush, width, style);
    }
    pub inline fn DrawRectangle(self: *IDeviceContext4, rect: *const RECT_F, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext3.DrawRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRectangle(self: *IDeviceContext4, rect: *const RECT_F, brush: *IBrush) void {
        IDeviceContext3.FillRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawRoundedRectangle(self: *IDeviceContext4, rect: *const ROUNDED_RECT, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext3.DrawRoundedRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRoundedRectangle(self: *IDeviceContext4, rect: *const ROUNDED_RECT, brush: *IBrush) void {
        IDeviceContext3.FillRoundedRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawEllipse(self: *IDeviceContext4, ellipse: *const ELLIPSE, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext3.DrawEllipse(@ptrCast(self), ellipse, brush, width, stroke);
    }
    pub inline fn FillEllipse(self: *IDeviceContext4, ellipse: *const ELLIPSE, brush: *IBrush) void {
        IDeviceContext3.FillEllipse(@ptrCast(self), ellipse, brush);
    }
    pub inline fn DrawGeometry(self: *IDeviceContext4, geo: *IGeometry, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext3.DrawGeometry(@ptrCast(self), geo, brush, width, stroke);
    }
    pub inline fn FillGeometry(self: *IDeviceContext4, geo: *IGeometry, brush: *IBrush, opacity_brush: ?*IBrush) void {
        IDeviceContext3.FillGeometry(@ptrCast(self), geo, brush, opacity_brush);
    }
    pub inline fn DrawBitmap(self: *IDeviceContext4, bitmap: *IBitmap, dst_rect: ?*const RECT_F, opacity: FLOAT, interpolation_mode: BITMAP_INTERPOLATION_MODE, src_rect: ?*const RECT_F) void {
        IDeviceContext3.DrawBitmap(@ptrCast(self), bitmap, dst_rect, opacity, interpolation_mode, src_rect);
    }
    pub inline fn DrawText(self: *IDeviceContext4, string: LPCWSTR, length: UINT, format: *dwrite.ITextFormat, layout_rect: *const RECT_F, brush: *IBrush, options: DRAW_TEXT_OPTIONS, measuring_mode: dwrite.MEASURING_MODE) void {
        IDeviceContext3.DrawText(@ptrCast(self), string, length, format, layout_rect, brush, options, measuring_mode);
    }
    pub inline fn SetTransform(self: *IDeviceContext4, m: *const MATRIX_3X2_F) void {
        IDeviceContext3.SetTransform(@ptrCast(self), m);
    }
    pub inline fn Clear(self: *IDeviceContext4, color: ?*const COLOR_F) void {
        IDeviceContext3.Clear(@ptrCast(self), color);
    }
    pub inline fn BeginDraw(self: *IDeviceContext4) void {
        IDeviceContext3.BeginDraw(@ptrCast(self));
    }
    pub inline fn EndDraw(self: *IDeviceContext4, tag1: ?*TAG, tag2: ?*TAG) HRESULT {
        return IDeviceContext3.EndDraw(@ptrCast(self), tag1, tag2);
    }
    pub inline fn CreateBitmapFromDxgiSurface(self: *IDeviceContext4, surface: *dxgi.ISurface, properties: ?*const BITMAP_PROPERTIES1, bitmap: *?*IBitmap1) HRESULT {
        return IDeviceContext3.CreateBitmapFromDxgiSurface(@ptrCast(self), surface, properties, bitmap);
    }
    pub inline fn SetTarget(self: *IDeviceContext4, image: ?*IImage) void {
        IDeviceContext3.SetTarget(@ptrCast(self), image);
    }
    pub inline fn CreateInk(self: *IDeviceContext4, start_point: *const INK_POINT, ink: *?*IInk) HRESULT {
        return IDeviceContext3.CreateInk(@ptrCast(self), start_point, ink);
    }
    pub inline fn CreateInkStyle(self: *IDeviceContext4, properties: ?*const INK_STYLE_PROPERTIES, ink_style: *?*IInkStyle) HRESULT {
        return IDeviceContext3.CreateInkStyle(@ptrCast(self), properties, ink_style);
    }
    pub inline fn DrawInk(self: *IDeviceContext4, ink: *IInk, brush: *IBrush, style: ?*IInkStyle) void {
        IDeviceContext3.DrawInk(@ptrCast(self), ink, brush, style);
    }
    pub const VTable = extern struct {
        base: IDeviceContext3.VTable,
        CreateSvgGlyphStyle: *anyopaque,
        DrawText1: *anyopaque,
        DrawTextLayout1: *anyopaque,
        DrawColorBitmapGlyphRun: *anyopaque,
        DrawSvgGlyphRun: *anyopaque,
        GetColorBitmapGlyphImage: *anyopaque,
        GetSvgGlyphImage: *anyopaque,
    };
};

pub const IDeviceContext5 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceContext5, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceContext4.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceContext5) ULONG {
        return IDeviceContext4.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceContext5) ULONG {
        return IDeviceContext4.Release(@ptrCast(self));
    }
    pub inline fn CreateSolidColorBrush(self: *IDeviceContext5, color: *const COLOR_F, properties: ?*const BRUSH_PROPERTIES, brush: *?*ISolidColorBrush) HRESULT {
        return IDeviceContext4.CreateSolidColorBrush(@ptrCast(self), color, properties, brush);
    }
    pub inline fn CreateGradientStopCollection(self: *IDeviceContext5, stops: [*]const GRADIENT_STOP, num_stops: UINT32, gamma: GAMMA, extend_mode: EXTEND_MODE, stop_collection: *?*IGradientStopCollection) HRESULT {
        return IDeviceContext4.CreateGradientStopCollection(@ptrCast(self), stops, num_stops, gamma, extend_mode, stop_collection);
    }
    pub inline fn CreateRadialGradientBrush(self: *IDeviceContext5, gradient_properties: *const RADIAL_GRADIENT_BRUSH_PROPERTIES, brush_properties: ?*const BRUSH_PROPERTIES, stop_collection: *IGradientStopCollection, brush: *?*IRadialGradientBrush) HRESULT {
        return IDeviceContext4.CreateRadialGradientBrush(@ptrCast(self), gradient_properties, brush_properties, stop_collection, brush);
    }
    pub inline fn DrawLine(self: *IDeviceContext5, p0: POINT_2F, p1: POINT_2F, brush: *IBrush, width: FLOAT, style: ?*IStrokeStyle) void {
        IDeviceContext4.DrawLine(@ptrCast(self), p0, p1, brush, width, style);
    }
    pub inline fn DrawRectangle(self: *IDeviceContext5, rect: *const RECT_F, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext4.DrawRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRectangle(self: *IDeviceContext5, rect: *const RECT_F, brush: *IBrush) void {
        IDeviceContext4.FillRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawRoundedRectangle(self: *IDeviceContext5, rect: *const ROUNDED_RECT, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext4.DrawRoundedRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRoundedRectangle(self: *IDeviceContext5, rect: *const ROUNDED_RECT, brush: *IBrush) void {
        IDeviceContext4.FillRoundedRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawEllipse(self: *IDeviceContext5, ellipse: *const ELLIPSE, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext4.DrawEllipse(@ptrCast(self), ellipse, brush, width, stroke);
    }
    pub inline fn FillEllipse(self: *IDeviceContext5, ellipse: *const ELLIPSE, brush: *IBrush) void {
        IDeviceContext4.FillEllipse(@ptrCast(self), ellipse, brush);
    }
    pub inline fn DrawGeometry(self: *IDeviceContext5, geo: *IGeometry, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext4.DrawGeometry(@ptrCast(self), geo, brush, width, stroke);
    }
    pub inline fn FillGeometry(self: *IDeviceContext5, geo: *IGeometry, brush: *IBrush, opacity_brush: ?*IBrush) void {
        IDeviceContext4.FillGeometry(@ptrCast(self), geo, brush, opacity_brush);
    }
    pub inline fn DrawBitmap(self: *IDeviceContext5, bitmap: *IBitmap, dst_rect: ?*const RECT_F, opacity: FLOAT, interpolation_mode: BITMAP_INTERPOLATION_MODE, src_rect: ?*const RECT_F) void {
        IDeviceContext4.DrawBitmap(@ptrCast(self), bitmap, dst_rect, opacity, interpolation_mode, src_rect);
    }
    pub inline fn DrawText(self: *IDeviceContext5, string: LPCWSTR, length: UINT, format: *dwrite.ITextFormat, layout_rect: *const RECT_F, brush: *IBrush, options: DRAW_TEXT_OPTIONS, measuring_mode: dwrite.MEASURING_MODE) void {
        IDeviceContext4.DrawText(@ptrCast(self), string, length, format, layout_rect, brush, options, measuring_mode);
    }
    pub inline fn SetTransform(self: *IDeviceContext5, m: *const MATRIX_3X2_F) void {
        IDeviceContext4.SetTransform(@ptrCast(self), m);
    }
    pub inline fn Clear(self: *IDeviceContext5, color: ?*const COLOR_F) void {
        IDeviceContext4.Clear(@ptrCast(self), color);
    }
    pub inline fn BeginDraw(self: *IDeviceContext5) void {
        IDeviceContext4.BeginDraw(@ptrCast(self));
    }
    pub inline fn EndDraw(self: *IDeviceContext5, tag1: ?*TAG, tag2: ?*TAG) HRESULT {
        return IDeviceContext4.EndDraw(@ptrCast(self), tag1, tag2);
    }
    pub inline fn CreateBitmapFromDxgiSurface(self: *IDeviceContext5, surface: *dxgi.ISurface, properties: ?*const BITMAP_PROPERTIES1, bitmap: *?*IBitmap1) HRESULT {
        return IDeviceContext4.CreateBitmapFromDxgiSurface(@ptrCast(self), surface, properties, bitmap);
    }
    pub inline fn SetTarget(self: *IDeviceContext5, image: ?*IImage) void {
        IDeviceContext4.SetTarget(@ptrCast(self), image);
    }
    pub inline fn CreateInk(self: *IDeviceContext5, start_point: *const INK_POINT, ink: *?*IInk) HRESULT {
        return IDeviceContext4.CreateInk(@ptrCast(self), start_point, ink);
    }
    pub inline fn CreateInkStyle(self: *IDeviceContext5, properties: ?*const INK_STYLE_PROPERTIES, ink_style: *?*IInkStyle) HRESULT {
        return IDeviceContext4.CreateInkStyle(@ptrCast(self), properties, ink_style);
    }
    pub inline fn DrawInk(self: *IDeviceContext5, ink: *IInk, brush: *IBrush, style: ?*IInkStyle) void {
        IDeviceContext4.DrawInk(@ptrCast(self), ink, brush, style);
    }
    pub const VTable = extern struct {
        base: IDeviceContext4.VTable,
        CreateSvgDocument: *anyopaque,
        DrawSvgDocument: *anyopaque,
        CreateColorContextFromDxgiColorSpace: *anyopaque,
        CreateColorContextFromSimpleColorProfile: *anyopaque,
    };
};

pub const IDeviceContext6 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceContext6, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceContext5.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceContext6) ULONG {
        return IDeviceContext5.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceContext6) ULONG {
        return IDeviceContext5.Release(@ptrCast(self));
    }
    pub inline fn CreateSolidColorBrush(self: *IDeviceContext6, color: *const COLOR_F, properties: ?*const BRUSH_PROPERTIES, brush: *?*ISolidColorBrush) HRESULT {
        return IDeviceContext5.CreateSolidColorBrush(@ptrCast(self), color, properties, brush);
    }
    pub inline fn CreateGradientStopCollection(self: *IDeviceContext6, stops: [*]const GRADIENT_STOP, num_stops: UINT32, gamma: GAMMA, extend_mode: EXTEND_MODE, stop_collection: *?*IGradientStopCollection) HRESULT {
        return IDeviceContext5.CreateGradientStopCollection(@ptrCast(self), stops, num_stops, gamma, extend_mode, stop_collection);
    }
    pub inline fn CreateRadialGradientBrush(self: *IDeviceContext6, gradient_properties: *const RADIAL_GRADIENT_BRUSH_PROPERTIES, brush_properties: ?*const BRUSH_PROPERTIES, stop_collection: *IGradientStopCollection, brush: *?*IRadialGradientBrush) HRESULT {
        return IDeviceContext5.CreateRadialGradientBrush(@ptrCast(self), gradient_properties, brush_properties, stop_collection, brush);
    }
    pub inline fn DrawLine(self: *IDeviceContext6, p0: POINT_2F, p1: POINT_2F, brush: *IBrush, width: FLOAT, style: ?*IStrokeStyle) void {
        IDeviceContext5.DrawLine(@ptrCast(self), p0, p1, brush, width, style);
    }
    pub inline fn DrawRectangle(self: *IDeviceContext6, rect: *const RECT_F, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext5.DrawRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRectangle(self: *IDeviceContext6, rect: *const RECT_F, brush: *IBrush) void {
        IDeviceContext5.FillRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawRoundedRectangle(self: *IDeviceContext6, rect: *const ROUNDED_RECT, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext5.DrawRoundedRectangle(@ptrCast(self), rect, brush, width, stroke);
    }
    pub inline fn FillRoundedRectangle(self: *IDeviceContext6, rect: *const ROUNDED_RECT, brush: *IBrush) void {
        IDeviceContext5.FillRoundedRectangle(@ptrCast(self), rect, brush);
    }
    pub inline fn DrawEllipse(self: *IDeviceContext6, ellipse: *const ELLIPSE, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext5.DrawEllipse(@ptrCast(self), ellipse, brush, width, stroke);
    }
    pub inline fn FillEllipse(self: *IDeviceContext6, ellipse: *const ELLIPSE, brush: *IBrush) void {
        IDeviceContext5.FillEllipse(@ptrCast(self), ellipse, brush);
    }
    pub inline fn DrawGeometry(self: *IDeviceContext6, geo: *IGeometry, brush: *IBrush, width: FLOAT, stroke: ?*IStrokeStyle) void {
        IDeviceContext5.DrawGeometry(@ptrCast(self), geo, brush, width, stroke);
    }
    pub inline fn FillGeometry(self: *IDeviceContext6, geo: *IGeometry, brush: *IBrush, opacity_brush: ?*IBrush) void {
        IDeviceContext5.FillGeometry(@ptrCast(self), geo, brush, opacity_brush);
    }
    pub inline fn DrawBitmap(self: *IDeviceContext6, bitmap: *IBitmap, dst_rect: ?*const RECT_F, opacity: FLOAT, interpolation_mode: BITMAP_INTERPOLATION_MODE, src_rect: ?*const RECT_F) void {
        IDeviceContext5.DrawBitmap(@ptrCast(self), bitmap, dst_rect, opacity, interpolation_mode, src_rect);
    }
    pub inline fn DrawText(self: *IDeviceContext6, string: LPCWSTR, length: UINT, format: *dwrite.ITextFormat, layout_rect: *const RECT_F, brush: *IBrush, options: DRAW_TEXT_OPTIONS, measuring_mode: dwrite.MEASURING_MODE) void {
        IDeviceContext5.DrawText(@ptrCast(self), string, length, format, layout_rect, brush, options, measuring_mode);
    }
    pub inline fn SetTransform(self: *IDeviceContext6, m: *const MATRIX_3X2_F) void {
        IDeviceContext5.SetTransform(@ptrCast(self), m);
    }
    pub inline fn Clear(self: *IDeviceContext6, color: ?*const COLOR_F) void {
        IDeviceContext5.Clear(@ptrCast(self), color);
    }
    pub inline fn BeginDraw(self: *IDeviceContext6) void {
        IDeviceContext5.BeginDraw(@ptrCast(self));
    }
    pub inline fn EndDraw(self: *IDeviceContext6, tag1: ?*TAG, tag2: ?*TAG) HRESULT {
        return IDeviceContext5.EndDraw(@ptrCast(self), tag1, tag2);
    }
    pub inline fn CreateBitmapFromDxgiSurface(self: *IDeviceContext6, surface: *dxgi.ISurface, properties: ?*const BITMAP_PROPERTIES1, bitmap: *?*IBitmap1) HRESULT {
        return IDeviceContext5.CreateBitmapFromDxgiSurface(@ptrCast(self), surface, properties, bitmap);
    }
    pub inline fn SetTarget(self: *IDeviceContext6, image: ?*IImage) void {
        IDeviceContext5.SetTarget(@ptrCast(self), image);
    }
    pub inline fn CreateInk(self: *IDeviceContext6, start_point: *const INK_POINT, ink: *?*IInk) HRESULT {
        return IDeviceContext5.CreateInk(@ptrCast(self), start_point, ink);
    }
    pub inline fn CreateInkStyle(self: *IDeviceContext6, properties: ?*const INK_STYLE_PROPERTIES, ink_style: *?*IInkStyle) HRESULT {
        return IDeviceContext5.CreateInkStyle(@ptrCast(self), properties, ink_style);
    }
    pub inline fn DrawInk(self: *IDeviceContext6, ink: *IInk, brush: *IBrush, style: ?*IInkStyle) void {
        IDeviceContext5.DrawInk(@ptrCast(self), ink, brush, style);
    }
    pub const VTable = extern struct {
        base: IDeviceContext5.VTable,
        BlendImage: *anyopaque,
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
    pub inline fn CreateRectangleGeometry(self: *IFactory3, rect: *const RECT_F, geo: *?*IRectangleGeometry) HRESULT {
        return IFactory2.CreateRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateRoundedRectangleGeometry(self: *IFactory3, rect: *const ROUNDED_RECT, geo: *?*IRoundedRectangleGeometry) HRESULT {
        return IFactory2.CreateRoundedRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateEllipseGeometry(self: *IFactory3, ellipse: *const ELLIPSE, geo: *?*IEllipseGeometry) HRESULT {
        return IFactory2.CreateEllipseGeometry(@ptrCast(self), ellipse, geo);
    }
    pub inline fn CreatePathGeometry(self: *IFactory3, geo: *?*IPathGeometry) HRESULT {
        return IFactory2.CreatePathGeometry(@ptrCast(self), geo);
    }
    pub inline fn CreateStrokeStyle(self: *IFactory3, properties: *const STROKE_STYLE_PROPERTIES, dashes: ?[*]const FLOAT, dashes_count: UINT32, stroke_style: *?*IStrokeStyle) HRESULT {
        return IFactory2.CreateStrokeStyle(@ptrCast(self), properties, dashes, dashes_count, stroke_style);
    }
    pub const VTable = extern struct {
        base: IFactory2.VTable,
        CreateDevice2: *anyopaque,
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
    pub inline fn CreateRectangleGeometry(self: *IFactory4, rect: *const RECT_F, geo: *?*IRectangleGeometry) HRESULT {
        return IFactory3.CreateRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateRoundedRectangleGeometry(self: *IFactory4, rect: *const ROUNDED_RECT, geo: *?*IRoundedRectangleGeometry) HRESULT {
        return IFactory3.CreateRoundedRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateEllipseGeometry(self: *IFactory4, ellipse: *const ELLIPSE, geo: *?*IEllipseGeometry) HRESULT {
        return IFactory3.CreateEllipseGeometry(@ptrCast(self), ellipse, geo);
    }
    pub inline fn CreatePathGeometry(self: *IFactory4, geo: *?*IPathGeometry) HRESULT {
        return IFactory3.CreatePathGeometry(@ptrCast(self), geo);
    }
    pub inline fn CreateStrokeStyle(self: *IFactory4, properties: *const STROKE_STYLE_PROPERTIES, dashes: ?[*]const FLOAT, dashes_count: UINT32, stroke_style: *?*IStrokeStyle) HRESULT {
        return IFactory3.CreateStrokeStyle(@ptrCast(self), properties, dashes, dashes_count, stroke_style);
    }
    pub const VTable = extern struct {
        base: IFactory3.VTable,
        CreateDevice3: *anyopaque,
    };
};

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
    pub inline fn CreateRectangleGeometry(self: *IFactory5, rect: *const RECT_F, geo: *?*IRectangleGeometry) HRESULT {
        return IFactory4.CreateRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateRoundedRectangleGeometry(self: *IFactory5, rect: *const ROUNDED_RECT, geo: *?*IRoundedRectangleGeometry) HRESULT {
        return IFactory4.CreateRoundedRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateEllipseGeometry(self: *IFactory5, ellipse: *const ELLIPSE, geo: *?*IEllipseGeometry) HRESULT {
        return IFactory4.CreateEllipseGeometry(@ptrCast(self), ellipse, geo);
    }
    pub inline fn CreatePathGeometry(self: *IFactory5, geo: *?*IPathGeometry) HRESULT {
        return IFactory4.CreatePathGeometry(@ptrCast(self), geo);
    }
    pub inline fn CreateStrokeStyle(self: *IFactory5, properties: *const STROKE_STYLE_PROPERTIES, dashes: ?[*]const FLOAT, dashes_count: UINT32, stroke_style: *?*IStrokeStyle) HRESULT {
        return IFactory4.CreateStrokeStyle(@ptrCast(self), properties, dashes, dashes_count, stroke_style);
    }
    pub const VTable = extern struct {
        base: IFactory4.VTable,
        CreateDevice4: *anyopaque,
    };
};

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
    pub inline fn CreateRectangleGeometry(self: *IFactory6, rect: *const RECT_F, geo: *?*IRectangleGeometry) HRESULT {
        return IFactory5.CreateRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateRoundedRectangleGeometry(self: *IFactory6, rect: *const ROUNDED_RECT, geo: *?*IRoundedRectangleGeometry) HRESULT {
        return IFactory5.CreateRoundedRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateEllipseGeometry(self: *IFactory6, ellipse: *const ELLIPSE, geo: *?*IEllipseGeometry) HRESULT {
        return IFactory5.CreateEllipseGeometry(@ptrCast(self), ellipse, geo);
    }
    pub inline fn CreatePathGeometry(self: *IFactory6, geo: *?*IPathGeometry) HRESULT {
        return IFactory5.CreatePathGeometry(@ptrCast(self), geo);
    }
    pub inline fn CreateStrokeStyle(self: *IFactory6, properties: *const STROKE_STYLE_PROPERTIES, dashes: ?[*]const FLOAT, dashes_count: UINT32, stroke_style: *?*IStrokeStyle) HRESULT {
        return IFactory5.CreateStrokeStyle(@ptrCast(self), properties, dashes, dashes_count, stroke_style);
    }
    pub const VTable = extern struct {
        base: IFactory5.VTable,
        CreateDevice5: *anyopaque,
    };
};

pub const IFactory7 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFactory7, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IFactory6.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFactory7) ULONG {
        return IFactory6.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFactory7) ULONG {
        return IFactory6.Release(@ptrCast(self));
    }
    pub inline fn CreateRectangleGeometry(self: *IFactory7, rect: *const RECT_F, geo: *?*IRectangleGeometry) HRESULT {
        return IFactory6.CreateRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateRoundedRectangleGeometry(self: *IFactory7, rect: *const ROUNDED_RECT, geo: *?*IRoundedRectangleGeometry) HRESULT {
        return IFactory6.CreateRoundedRectangleGeometry(@ptrCast(self), rect, geo);
    }
    pub inline fn CreateEllipseGeometry(self: *IFactory7, ellipse: *const ELLIPSE, geo: *?*IEllipseGeometry) HRESULT {
        return IFactory6.CreateEllipseGeometry(@ptrCast(self), ellipse, geo);
    }
    pub inline fn CreatePathGeometry(self: *IFactory7, geo: *?*IPathGeometry) HRESULT {
        return IFactory6.CreatePathGeometry(@ptrCast(self), geo);
    }
    pub inline fn CreateStrokeStyle(self: *IFactory7, properties: *const STROKE_STYLE_PROPERTIES, dashes: ?[*]const FLOAT, dashes_count: UINT32, stroke_style: *?*IStrokeStyle) HRESULT {
        return IFactory6.CreateStrokeStyle(@ptrCast(self), properties, dashes, dashes_count, stroke_style);
    }
    pub inline fn CreateDevice6(self: *IFactory7, dxgi_device: *dxgi.IDevice, d2d_device6: *?*IDevice6) HRESULT {
        return self.__v.CreateDevice6(self, dxgi_device, d2d_device6);
    }
    pub const VTable = extern struct {
        base: IFactory6.VTable,
        CreateDevice6: *const fn (*IFactory7, *dxgi.IDevice, *?*IDevice6) callconv(WINAPI) HRESULT,
    };
};

pub const IDevice2 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice2, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice1.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice2) ULONG {
        return IDevice1.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice2) ULONG {
        return IDevice1.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IDevice1.VTable,
        CreateDeviceContext2: *anyopaque,
        FlushDeviceContexts: *anyopaque,
        GetDxgiDevice: *anyopaque,
    };
};

pub const IDevice3 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice3, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice2.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice3) ULONG {
        return IDevice2.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice3) ULONG {
        return IDevice2.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IDevice2.VTable,
        CreateDeviceContext3: *anyopaque,
    };
};

pub const IDevice4 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice4, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice3.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice4) ULONG {
        return IDevice3.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice4) ULONG {
        return IDevice3.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IDevice3.VTable,
        CreateDeviceContext4: *anyopaque,
        SetMaximumColorGlyphCacheMemory: *anyopaque,
        GetMaximumColorGlyphCacheMemory: *anyopaque,
    };
};

pub const IDevice5 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice5, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice4.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice5) ULONG {
        return IDevice4.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice5) ULONG {
        return IDevice4.Release(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IDevice4.VTable,
        CreateDeviceContext5: *anyopaque,
    };
};

pub const IDevice6 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice6, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice5.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice6) ULONG {
        return IDevice5.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice6) ULONG {
        return IDevice5.Release(@ptrCast(self));
    }
    pub inline fn CreateDeviceContext6(self: *IDevice6, options: DEVICE_CONTEXT_OPTIONS, devctx: *?*IDeviceContext6) HRESULT {
        return self.__v.CreateDeviceContext6(self, options, devctx);
    }
    pub const VTable = extern struct {
        base: IDevice5.VTable,
        CreateDeviceContext6: *const fn (
            *IDevice6,
            DEVICE_CONTEXT_OPTIONS,
            *?*IDeviceContext6,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const IID_IFactory7 = GUID{
    .Data1 = 0xbdc2bdd3,
    .Data2 = 0xb96c,
    .Data3 = 0x4de6,
    .Data4 = .{ 0xbd, 0xf7, 0x99, 0xd4, 0x74, 0x54, 0x54, 0xde },
};
