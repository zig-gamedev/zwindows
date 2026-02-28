const std = @import("std");

const windows = @import("../windows.zig");
const UINT = windows.UINT;
const IUnknown = windows.IUnknown;
const ULONG = windows.ULONG;
const HRESULT = windows.HRESULT;
const GUID = windows.GUID;
const LUID = windows.LUID;
const WINAPI = windows.WINAPI;
const FLOAT = windows.FLOAT;
const LPCWSTR = windows.LPCWSTR;
const LPCSTR = windows.LPCSTR;
const UINT8 = windows.UINT8;
const UINT16 = windows.UINT16;
const UINT32 = windows.UINT32;
const UINT64 = windows.UINT64;
const INT = windows.INT;
const INT8 = windows.INT8;
const BYTE = windows.BYTE;
const DWORD = windows.DWORD;
const SIZE_T = windows.SIZE_T;
const HANDLE = windows.HANDLE;
const SECURITY_ATTRIBUTES = windows.SECURITY_ATTRIBUTES;
const BOOL = windows.BOOL;
const FALSE = windows.FALSE;
const TRUE = windows.TRUE;

const dxgi = @import("dxgi.zig");
const d3d = @import("d3dcommon.zig");

pub const req_blend_object_count_per_device: u32 = 4096;
pub const req_buffer_resource_texel_count_2_to_exp: u32 = 27;
pub const req_constant_buffer_element_count: u32 = 4096;
pub const req_depth_stencil_object_count_per_device: u32 = 4096;
pub const req_drawindexed_index_count_2_to_exp: u32 = 32;
pub const req_draw_vertex_count_2_to_exp: u32 = 32;
pub const req_filtering_hw_addressable_resource_dimension: u32 = 16384;
pub const req_gs_invocation_32bit_output_component_limit: u32 = 1024;
pub const req_immediate_constant_buffer_element_count: u32 = 4096;
pub const req_maxanisotropy: u32 = 16;
pub const req_mip_levels: u32 = 15;
pub const req_multi_element_structure_size_in_bytes: u32 = 2048;
pub const req_rasterizer_object_count_per_device: u32 = 4096;
pub const req_render_to_buffer_window_width: u32 = 16384;
pub const req_resource_size_in_megabytes_expression_a_term: u32 = 128;
pub const req_resource_size_in_megabytes_expression_b_term: f32 = 0.25;
pub const req_resource_size_in_megabytes_expression_c_term: u32 = 2048;
pub const req_resource_view_count_per_device_2_to_exp: u32 = 20;
pub const req_sampler_object_count_per_device: u32 = 4096;
pub const req_subresources: u32 = 30720;
pub const req_texture1d_array_axis_dimension: u32 = 2024;
pub const req_texture1d_u_dimension: u32 = 16384;
pub const req_texture2d_array_axis_dimension: u32 = 2024;
pub const req_texture2d_u_or_v_dimension: u32 = 16384;
pub const req_texture3d_u_v_or_w_dimension: u32 = 2048;
pub const req_texturecube_dimension: u32 = 16384;

pub const RESOURCE_BARRIER_ALL_SUBRESOURCES = 0xffff_ffff;

pub const SHADER_IDENTIFIER_SIZE_IN_BYTES = 32;

pub const CONSTANT_BUFFER_DATA_PLACEMENT_ALIGNMENT = 256;

pub const GPU_VIRTUAL_ADDRESS = UINT64;

pub const PRIMITIVE_TOPOLOGY = d3d.PRIMITIVE_TOPOLOGY;

pub const CPU_DESCRIPTOR_HANDLE = extern struct {
    ptr: UINT64,
};

pub const GPU_DESCRIPTOR_HANDLE = extern struct {
    ptr: UINT64,
};

pub const PRIMITIVE_TOPOLOGY_TYPE = enum(UINT) {
    UNDEFINED = 0,
    POINT = 1,
    LINE = 2,
    TRIANGLE = 3,
    PATCH = 4,
};

pub const HEAP_TYPE = enum(UINT) {
    DEFAULT = 1,
    UPLOAD = 2,
    READBACK = 3,
    CUSTOM = 4,
};

pub const CPU_PAGE_PROPERTY = enum(UINT) {
    UNKNOWN = 0,
    NOT_AVAILABLE = 1,
    WRITE_COMBINE = 2,
    WRITE_BACK = 3,
};

pub const MEMORY_POOL = enum(UINT) {
    UNKNOWN = 0,
    L0 = 1,
    L1 = 2,
};

pub const HEAP_PROPERTIES = extern struct {
    Type: HEAP_TYPE,
    CPUPageProperty: CPU_PAGE_PROPERTY,
    MemoryPoolPreference: MEMORY_POOL,
    CreationNodeMask: UINT,
    VisibleNodeMask: UINT,

    pub fn initType(heap_type: HEAP_TYPE) HEAP_PROPERTIES {
        var v = std.mem.zeroes(@This());
        v = HEAP_PROPERTIES{
            .Type = heap_type,
            .CPUPageProperty = .UNKNOWN,
            .MemoryPoolPreference = .UNKNOWN,
            .CreationNodeMask = 0,
            .VisibleNodeMask = 0,
        };
        return v;
    }
};

pub const HEAP_FLAGS = packed struct(UINT) {
    SHARED: bool = false,
    __unused1: bool = false,
    DENY_BUFFERS: bool = false,
    ALLOW_DISPLAY: bool = false,
    __unused4: bool = false,
    SHARED_CROSS_ADAPTER: bool = false,
    DENY_RT_DS_TEXTURES: bool = false,
    DENY_NON_RT_DS_TEXTURES: bool = false,
    HARDWARE_PROTECTED: bool = false,
    ALLOW_WRITE_WATCH: bool = false,
    ALLOW_SHADER_ATOMICS: bool = false,
    CREATE_NOT_RESIDENT: bool = false,
    CREATE_NOT_ZEROED: bool = false,
    __unused: u19 = 0,

    pub const ALLOW_ALL_BUFFERS_AND_TEXTURES = HEAP_FLAGS{};
    pub const ALLOW_ONLY_NON_RT_DS_TEXTURES = HEAP_FLAGS{ .DENY_BUFFERS = true, .DENY_RT_DS_TEXTURES = true };
    pub const ALLOW_ONLY_BUFFERS = HEAP_FLAGS{ .DENY_RT_DS_TEXTURES = true, .DENY_NON_RT_DS_TEXTURES = true };
    pub const HEAP_FLAG_ALLOW_ONLY_RT_DS_TEXTURES = HEAP_FLAGS{
        .DENY_BUFFERS = true,
        .DENY_NON_RT_DS_TEXTURES = true,
    };
};

pub const HEAP_DESC = extern struct {
    SizeInBytes: UINT64,
    Properties: HEAP_PROPERTIES,
    Alignment: UINT64,
    Flags: HEAP_FLAGS,
};

pub const RANGE = extern struct {
    Begin: UINT64,
    End: UINT64,
};

pub const BOX = extern struct {
    left: UINT,
    top: UINT,
    front: UINT,
    right: UINT,
    bottom: UINT,
    back: UINT,
};

pub const RESOURCE_DIMENSION = enum(UINT) {
    UNKNOWN = 0,
    BUFFER = 1,
    TEXTURE1D = 2,
    TEXTURE2D = 3,
    TEXTURE3D = 4,
};

pub const TEXTURE_LAYOUT = enum(UINT) {
    UNKNOWN = 0,
    ROW_MAJOR = 1,
    @"64KB_UNDEFINED_SWIZZLE" = 2,
    @"64KB_STANDARD_SWIZZLE" = 3,
};

pub const RESOURCE_FLAGS = packed struct(UINT) {
    ALLOW_RENDER_TARGET: bool = false,
    ALLOW_DEPTH_STENCIL: bool = false,
    ALLOW_UNORDERED_ACCESS: bool = false,
    DENY_SHADER_RESOURCE: bool = false,
    ALLOW_CROSS_ADAPTER: bool = false,
    ALLOW_SIMULTANEOUS_ACCESS: bool = false,
    VIDEO_DECODE_REFERENCE_ONLY: bool = false,
    VIDEO_ENCODE_REFERENCE_ONLY: bool = false,
    __unused: u24 = 0,
};

pub const RESOURCE_DESC = extern struct {
    Dimension: RESOURCE_DIMENSION,
    Alignment: UINT64,
    Width: UINT64,
    Height: UINT,
    DepthOrArraySize: UINT16,
    MipLevels: UINT16,
    Format: dxgi.FORMAT,
    SampleDesc: dxgi.SAMPLE_DESC,
    Layout: TEXTURE_LAYOUT,
    Flags: RESOURCE_FLAGS,

    pub fn initBuffer(width: UINT64) RESOURCE_DESC {
        var v = std.mem.zeroes(@This());
        v = .{
            .Dimension = .BUFFER,
            .Alignment = 0,
            .Width = width,
            .Height = 1,
            .DepthOrArraySize = 1,
            .MipLevels = 1,
            .Format = .UNKNOWN,
            .SampleDesc = .{ .Count = 1, .Quality = 0 },
            .Layout = .ROW_MAJOR,
            .Flags = .{},
        };
        return v;
    }

    pub fn initTex2d(format: dxgi.FORMAT, width: UINT64, height: UINT, mip_levels: u32) RESOURCE_DESC {
        var v = std.mem.zeroes(@This());
        v = .{
            .Dimension = .TEXTURE2D,
            .Alignment = 0,
            .Width = width,
            .Height = height,
            .DepthOrArraySize = 1,
            .MipLevels = @as(u16, @intCast(mip_levels)),
            .Format = format,
            .SampleDesc = .{ .Count = 1, .Quality = 0 },
            .Layout = .UNKNOWN,
            .Flags = .{},
        };
        return v;
    }

    pub fn initDepthBuffer(format: dxgi.FORMAT, width: UINT64, height: UINT) RESOURCE_DESC {
        var v = std.mem.zeroes(@This());
        v = .{
            .Dimension = .TEXTURE2D,
            .Alignment = 0,
            .Width = width,
            .Height = height,
            .DepthOrArraySize = 1,
            .MipLevels = 1,
            .Format = format,
            .SampleDesc = .{ .Count = 1, .Quality = 0 },
            .Layout = .UNKNOWN,
            .Flags = .{ .ALLOW_DEPTH_STENCIL = true, .DENY_SHADER_RESOURCE = true },
        };
        return v;
    }

    pub fn initTexCube(format: dxgi.FORMAT, width: UINT64, height: UINT, mip_levels: u32) RESOURCE_DESC {
        var v = std.mem.zeroes(@This());
        v = .{
            .Dimension = .TEXTURE2D,
            .Alignment = 0,
            .Width = width,
            .Height = height,
            .DepthOrArraySize = 6,
            .MipLevels = @as(u16, @intCast(mip_levels)),
            .Format = format,
            .SampleDesc = .{ .Count = 1, .Quality = 0 },
            .Layout = .UNKNOWN,
            .Flags = .{},
        };
        return v;
    }

    pub fn initFrameBuffer(format: dxgi.FORMAT, width: UINT64, height: UINT, sample_count: u32) RESOURCE_DESC {
        var v = std.mem.zeroes(@This());
        v = .{
            .Dimension = .TEXTURE2D,
            .Alignment = 0,
            .Width = width,
            .Height = height,
            .DepthOrArraySize = 1,
            .MipLevels = 1,
            .Format = format,
            .SampleDesc = .{ .Count = sample_count, .Quality = 0 },
            .Layout = .UNKNOWN,
            .Flags = .{ .ALLOW_RENDER_TARGET = true },
        };
        return v;
    }
};

pub const FENCE_FLAGS = packed struct(UINT) {
    SHARED: bool = false,
    SHARED_CROSS_ADAPTER: bool = false,
    NON_MONITORED: bool = false,
    __unused: u29 = 0,
};

pub const DESCRIPTOR_HEAP_TYPE = enum(UINT) {
    CBV_SRV_UAV = 0,
    SAMPLER = 1,
    RTV = 2,
    DSV = 3,
};

pub const DESCRIPTOR_HEAP_FLAGS = packed struct(UINT) {
    SHADER_VISIBLE: bool = false,
    __unused: u31 = 0,
};

pub const DESCRIPTOR_HEAP_DESC = extern struct {
    Type: DESCRIPTOR_HEAP_TYPE,
    NumDescriptors: UINT,
    Flags: DESCRIPTOR_HEAP_FLAGS,
    NodeMask: UINT,
};

pub const DESCRIPTOR_RANGE_TYPE = enum(UINT) {
    SRV = 0,
    UAV = 1,
    CBV = 2,
    SAMPLER = 3,
};

pub const DESCRIPTOR_RANGE = extern struct {
    RangeType: DESCRIPTOR_RANGE_TYPE,
    NumDescriptors: UINT,
    BaseShaderRegister: UINT,
    RegisterSpace: UINT,
    OffsetInDescriptorsFromStart: UINT,
};

pub const ROOT_DESCRIPTOR_TABLE = extern struct {
    NumDescriptorRanges: UINT,
    pDescriptorRanges: ?[*]const DESCRIPTOR_RANGE,
};

pub const ROOT_CONSTANTS = extern struct {
    ShaderRegister: UINT,
    RegisterSpace: UINT,
    Num32BitValues: UINT,
};

pub const ROOT_DESCRIPTOR = extern struct {
    ShaderRegister: UINT,
    RegisterSpace: UINT,
};

pub const ROOT_PARAMETER_TYPE = enum(UINT) {
    DESCRIPTOR_TABLE = 0,
    @"32BIT_CONSTANTS" = 1,
    CBV = 2,
    SRV = 3,
    UAV = 4,
};

pub const SHADER_VISIBILITY = enum(UINT) {
    ALL = 0,
    VERTEX = 1,
    HULL = 2,
    DOMAIN = 3,
    GEOMETRY = 4,
    PIXEL = 5,
    AMPLIFICATION = 6,
    MESH = 7,
};

pub const ROOT_PARAMETER = extern struct {
    ParameterType: ROOT_PARAMETER_TYPE,
    u: extern union {
        DescriptorTable: ROOT_DESCRIPTOR_TABLE,
        Constants: ROOT_CONSTANTS,
        Descriptor: ROOT_DESCRIPTOR,
    },
    ShaderVisibility: SHADER_VISIBILITY,
};

pub const STATIC_BORDER_COLOR = enum(UINT) {
    TRANSPARENT_BLACK = 0,
    OPAQUE_BLACK = 1,
    OPAQUE_WHITE = 2,
};

pub const STATIC_SAMPLER_DESC = extern struct {
    Filter: FILTER,
    AddressU: TEXTURE_ADDRESS_MODE,
    AddressV: TEXTURE_ADDRESS_MODE,
    AddressW: TEXTURE_ADDRESS_MODE,
    MipLODBias: FLOAT,
    MaxAnisotropy: UINT,
    ComparisonFunc: COMPARISON_FUNC,
    BorderColor: STATIC_BORDER_COLOR,
    MinLOD: FLOAT,
    MaxLOD: FLOAT,
    ShaderRegister: UINT,
    RegisterSpace: UINT,
    ShaderVisibility: SHADER_VISIBILITY,
};

pub const ROOT_SIGNATURE_FLAGS = packed struct(UINT) {
    ALLOW_INPUT_ASSEMBLER_INPUT_LAYOUT: bool = false,
    DENY_VERTEX_SHADER_ROOT_ACCESS: bool = false,
    DENY_HULL_SHADER_ROOT_ACCESS: bool = false,
    DENY_DOMAIN_SHADER_ROOT_ACCESS: bool = false,
    DENY_GEOMETRY_SHADER_ROOT_ACCESS: bool = false,
    DENY_PIXEL_SHADER_ROOT_ACCESS: bool = false,
    ALLOW_STREAM_OUTPUT: bool = false,
    LOCAL_ROOT_SIGNATURE: bool = false,
    DENY_AMPLIFICATION_SHADER_ROOT_ACCESS: bool = false,
    DENY_MESH_SHADER_ROOT_ACCESS: bool = false,
    CBV_SRV_UAV_HEAP_DIRECTLY_INDEXED: bool = false,
    SAMPLER_HEAP_DIRECTLY_INDEXED: bool = false,
    __unused: u20 = 0,
};

pub const ROOT_SIGNATURE_DESC = extern struct {
    NumParameters: UINT,
    pParameters: ?[*]const ROOT_PARAMETER,
    NumStaticSamplers: UINT,
    pStaticSamplers: ?[*]const STATIC_SAMPLER_DESC,
    Flags: ROOT_SIGNATURE_FLAGS,
};

pub const DESCRIPTOR_RANGE_FLAGS = packed struct(UINT) {
    DESCRIPTORS_VOLATILE: bool = false, // 0x1
    DATA_VOLATILE: bool = false,
    DATA_STATIC_WHILE_SET_AT_EXECUTE: bool = false,
    DATA_STATIC: bool = false,
    __unused4: bool = false, // 0x10
    __unused5: bool = false,
    __unused6: bool = false,
    __unused7: bool = false,
    __unused8: bool = false, // 0x100
    __unused9: bool = false,
    __unused10: bool = false,
    __unused11: bool = false,
    __unused12: bool = false, // 0x1000
    __unused13: bool = false,
    __unused14: bool = false,
    __unused15: bool = false,
    DESCRIPTORS_STATIC_KEEPING_BUFFER_BOUNDS_CHECKS: bool = false, // 0x10000
    __unused: u15 = 0,
};

pub const DESCRIPTOR_RANGE_OFFSET_APPEND = 0xffffffff; // defined as -1

pub const DESCRIPTOR_RANGE1 = extern struct {
    RangeType: DESCRIPTOR_RANGE_TYPE,
    NumDescriptors: UINT,
    BaseShaderRegister: UINT,
    RegisterSpace: UINT,
    Flags: DESCRIPTOR_RANGE_FLAGS,
    OffsetInDescriptorsFromTableStart: UINT,
};

pub const ROOT_DESCRIPTOR_TABLE1 = extern struct {
    NumDescriptorRanges: UINT,
    pDescriptorRanges: ?[*]const DESCRIPTOR_RANGE1,
};

pub const ROOT_DESCRIPTOR_FLAGS = packed struct(UINT) {
    __unused0: bool = false,
    DATA_VOLATILE: bool = false,
    DATA_STATIC_WHILE_SET_AT_EXECUTE: bool = false,
    DATA_STATIC: bool = false,
    _: u28 = 0,
};

pub const ROOT_DESCRIPTOR1 = extern struct {
    ShaderRegister: UINT,
    RegisterSpace: UINT = 0,
    Flags: ROOT_DESCRIPTOR_FLAGS = .{},
};

pub const ROOT_PARAMETER1 = extern struct {
    ParameterType: ROOT_PARAMETER_TYPE,
    u: extern union {
        DescriptorTable: ROOT_DESCRIPTOR_TABLE1,
        Constants: ROOT_CONSTANTS,
        Descriptor: ROOT_DESCRIPTOR1,
    },
    ShaderVisibility: SHADER_VISIBILITY,
};

pub const ROOT_SIGNATURE_DESC1 = extern struct {
    NumParameters: UINT,
    pParameters: ?[*]const ROOT_PARAMETER1,
    NumStaticSamplers: UINT,
    pStaticSamplers: ?[*]const STATIC_SAMPLER_DESC,
    Flags: ROOT_SIGNATURE_FLAGS,

    pub fn init(parameters: []const ROOT_PARAMETER1, static_samplers: []const STATIC_SAMPLER_DESC, flags: ROOT_SIGNATURE_FLAGS) ROOT_SIGNATURE_DESC1 {
        return .{
            .NumParameters = @intCast(parameters.len),
            .pParameters = if (parameters.len > 0) parameters.ptr else null,
            .NumStaticSamplers = @intCast(static_samplers.len),
            .pStaticSamplers = if (static_samplers.len > 0) static_samplers.ptr else null,
            .Flags = flags,
        };
    }
};

pub const ROOT_SIGNATURE_VERSION = enum(UINT) {
    VERSION_1_0 = 0x1,
    VERSION_1_1 = 0x2,
};

pub const VERSIONED_ROOT_SIGNATURE_DESC = extern struct {
    Version: ROOT_SIGNATURE_VERSION,
    u: extern union {
        Desc_1_0: ROOT_SIGNATURE_DESC,
        Desc_1_1: ROOT_SIGNATURE_DESC1,
    },

    pub fn initVersion1_0(desc: ROOT_SIGNATURE_DESC) VERSIONED_ROOT_SIGNATURE_DESC {
        return .{
            .Version = .VERSION_1_0,
            .u = .{
                .Desc_1_0 = desc,
            },
        };
    }

    pub fn initVersion1_1(desc: ROOT_SIGNATURE_DESC1) VERSIONED_ROOT_SIGNATURE_DESC {
        return .{
            .Version = .VERSION_1_1,
            .u = .{
                .Desc_1_1 = desc,
            },
        };
    }
};

pub const COMMAND_LIST_TYPE = enum(UINT) {
    DIRECT = 0,
    BUNDLE = 1,
    COMPUTE = 2,
    COPY = 3,
    VIDEO_DECODE = 4,
    VIDEO_PROCESS = 5,
    VIDEO_ENCODE = 6,
};

pub const RESOURCE_BARRIER_TYPE = enum(UINT) {
    TRANSITION = 0,
    ALIASING = 1,
    UAV = 2,
};

pub const RESOURCE_TRANSITION_BARRIER = extern struct {
    pResource: *IResource,
    Subresource: UINT,
    StateBefore: RESOURCE_STATES,
    StateAfter: RESOURCE_STATES,
};

pub const RESOURCE_ALIASING_BARRIER = extern struct {
    pResourceBefore: ?*IResource,
    pResourceAfter: ?*IResource,
};

pub const RESOURCE_UAV_BARRIER = extern struct {
    pResource: ?*IResource,
};

pub const RESOURCE_BARRIER_FLAGS = packed struct(UINT) {
    BEGIN_ONLY: bool = false,
    END_ONLY: bool = false,
    __unused: u30 = 0,
};

pub const RESOURCE_BARRIER = extern struct {
    Type: RESOURCE_BARRIER_TYPE,
    Flags: RESOURCE_BARRIER_FLAGS,
    u: extern union {
        Transition: RESOURCE_TRANSITION_BARRIER,
        Aliasing: RESOURCE_ALIASING_BARRIER,
        UAV: RESOURCE_UAV_BARRIER,
    },

    pub fn initUav(resource: *IResource) RESOURCE_BARRIER {
        var v = std.mem.zeroes(@This());
        v = .{ .Type = .UAV, .Flags = .{}, .u = .{ .UAV = .{ .pResource = resource } } };
        return v;
    }
};

pub const SUBRESOURCE_DATA = extern struct {
    pData: ?[*]u8,
    RowPitch: UINT,
    SlicePitch: UINT,
};

pub const MEMCPY_DEST = extern struct {
    pData: ?[*]u8,
    RowPitch: UINT,
    SlicePitch: UINT,
};

pub const SUBRESOURCE_FOOTPRINT = extern struct {
    Format: dxgi.FORMAT,
    Width: UINT,
    Height: UINT,
    Depth: UINT,
    RowPitch: UINT,
};

pub const PLACED_SUBRESOURCE_FOOTPRINT = extern struct {
    Offset: UINT64,
    Footprint: SUBRESOURCE_FOOTPRINT,
};

pub const TEXTURE_COPY_TYPE = enum(UINT) {
    SUBRESOURCE_INDEX = 0,
    PLACED_FOOTPRINT = 1,
};

pub const TEXTURE_COPY_LOCATION = extern struct {
    pResource: *IResource,
    Type: TEXTURE_COPY_TYPE,
    u: extern union {
        PlacedFootprint: PLACED_SUBRESOURCE_FOOTPRINT,
        SubresourceIndex: UINT,
    },
};

pub const TILED_RESOURCE_COORDINATE = extern struct {
    X: UINT,
    Y: UINT,
    Z: UINT,
    Subresource: UINT,
};

pub const TILE_REGION_SIZE = extern struct {
    NumTiles: UINT,
    UseBox: BOOL,
    Width: UINT,
    Height: UINT16,
    Depth: UINT16,
};

pub const TILE_RANGE_FLAGS = packed struct(UINT) {
    NULL: bool = false,
    SKIP: bool = false,
    REUSE_SINGLE_TILE: bool = false,
    __unused: u29 = 0,
};

pub const SUBRESOURCE_TILING = extern struct {
    WidthInTiles: UINT,
    HeightInTiles: UINT16,
    DepthInTiles: UINT16,
    StartTileIndexInOverallResource: UINT,
};

pub const TILE_SHAPE = extern struct {
    WidthInTexels: UINT,
    HeightInTexels: UINT,
    DepthInTexels: UINT,
};

pub const TILE_MAPPING_FLAGS = packed struct(UINT) {
    NO_HAZARD: bool = false,
    __unused: u31 = 0,
};

pub const TILE_COPY_FLAGS = packed struct(UINT) {
    NO_HAZARD: bool = false,
    LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE: bool = false,
    SWIZZLED_TILED_RESOURCE_TO_LINEAR_BUFFER: bool = false,
    __unused: u29 = 0,
};

pub const VIEWPORT = extern struct {
    TopLeftX: FLOAT,
    TopLeftY: FLOAT,
    Width: FLOAT,
    Height: FLOAT,
    MinDepth: FLOAT,
    MaxDepth: FLOAT,
};

pub const RECT = windows.RECT;

pub const RESOURCE_STATES = packed struct(UINT) {
    VERTEX_AND_CONSTANT_BUFFER: bool = false, // 0x1
    INDEX_BUFFER: bool = false,
    RENDER_TARGET: bool = false,
    UNORDERED_ACCESS: bool = false,
    DEPTH_WRITE: bool = false, // 0x10
    DEPTH_READ: bool = false,
    NON_PIXEL_SHADER_RESOURCE: bool = false,
    PIXEL_SHADER_RESOURCE: bool = false,
    STREAM_OUT: bool = false, // 0x100
    INDIRECT_ARGUMENT_OR_PREDICATION: bool = false,
    COPY_DEST: bool = false,
    COPY_SOURCE: bool = false,
    RESOLVE_DEST: bool = false, // 0x1000
    RESOLVE_SOURCE: bool = false,
    __unused14: bool = false,
    __unused15: bool = false,
    VIDEO_DECODE_READ: bool = false, // 0x10000
    VIDEO_DECODE_WRITE: bool = false,
    VIDEO_PROCESS_READ: bool = false,
    VIDEO_PROCESS_WRITE: bool = false,
    __unused20: bool = false, // 0x100000
    VIDEO_ENCODE_READ: bool = false,
    RAYTRACING_ACCELERATION_STRUCTURE: bool = false,
    VIDEO_ENCODE_WRITE: bool = false,
    SHADING_RATE_SOURCE: bool = false, // 0x1000000
    __unused: u7 = 0,

    pub const COMMON = RESOURCE_STATES{};
    pub const PRESENT = RESOURCE_STATES{};
    pub const GENERIC_READ = RESOURCE_STATES{
        .VERTEX_AND_CONSTANT_BUFFER = true,
        .INDEX_BUFFER = true,
        .NON_PIXEL_SHADER_RESOURCE = true,
        .PIXEL_SHADER_RESOURCE = true,
        .INDIRECT_ARGUMENT_OR_PREDICATION = true,
        .COPY_SOURCE = true,
    };
    pub const ALL_SHADER_RESOURCE = RESOURCE_STATES{
        .NON_PIXEL_SHADER_RESOURCE = true,
        .PIXEL_SHADER_RESOURCE = true,
    };
};

pub const INDEX_BUFFER_STRIP_CUT_VALUE = enum(UINT) {
    DISABLED = 0,
    OxFFFF = 1,
    OxFFFFFFFF = 2,
};

pub const VERTEX_BUFFER_VIEW = extern struct {
    BufferLocation: GPU_VIRTUAL_ADDRESS,
    SizeInBytes: UINT,
    StrideInBytes: UINT,
};

pub const INDEX_BUFFER_VIEW = extern struct {
    BufferLocation: GPU_VIRTUAL_ADDRESS,
    SizeInBytes: UINT,
    Format: dxgi.FORMAT,
};

pub const STREAM_OUTPUT_BUFFER_VIEW = extern struct {
    BufferLocation: GPU_VIRTUAL_ADDRESS,
    SizeInBytes: UINT64,
    BufferFilledSizeLocation: GPU_VIRTUAL_ADDRESS,
};

pub const CLEAR_FLAGS = packed struct(UINT) {
    DEPTH: bool = false,
    STENCIL: bool = false,
    __unused: u30 = 0,
};

pub const DISCARD_REGION = extern struct {
    NumRects: UINT,
    pRects: *const RECT,
    FirstSubresource: UINT,
    NumSubresources: UINT,
};

pub const QUERY_HEAP_TYPE = enum(UINT) {
    OCCLUSION = 0,
    TIMESTAMP = 1,
    PIPELINE_STATISTICS = 2,
    SO_STATISTICS = 3,
};

pub const QUERY_HEAP_DESC = extern struct {
    Type: QUERY_HEAP_TYPE,
    Count: UINT,
    NodeMask: UINT,
};

pub const QUERY_TYPE = enum(UINT) {
    OCCLUSION = 0,
    BINARY_OCCLUSION = 1,
    TIMESTAMP = 2,
    PIPELINE_STATISTICS = 3,
    SO_STATISTICS_STREAM0 = 4,
    SO_STATISTICS_STREAM1 = 5,
    SO_STATISTICS_STREAM2 = 6,
    SO_STATISTICS_STREAM3 = 7,
    VIDEO_DECODE_STATISTICS = 8,
    PIPELINE_STATISTICS1 = 10,
};

pub const PREDICATION_OP = enum(UINT) {
    EQUAL_ZERO = 0,
    NOT_EQUAL_ZERO = 1,
};

pub const INDIRECT_ARGUMENT_TYPE = enum(UINT) {
    DRAW = 0,
    DRAW_INDEXED = 1,
    DISPATCH = 2,
    VERTEX_BUFFER_VIEW = 3,
    INDEX_BUFFER_VIEW = 4,
    CONSTANT = 5,
    CONSTANT_BUFFER_VIEW = 6,
    SHADER_RESOURCE_VIEW = 7,
    UNORDERED_ACCESS_VIEW = 8,
    DISPATCH_RAYS = 9,
    DISPATCH_MESH = 10,
};

pub const INDIRECT_ARGUMENT_DESC = extern struct {
    Type: INDIRECT_ARGUMENT_TYPE,
    u: extern union {
        VertexBuffer: extern struct {
            Slot: UINT,
        },
        Constant: extern struct {
            RootParameterIndex: UINT,
            DestOffsetIn32BitValues: UINT,
            Num32BitValuesToSet: UINT,
        },
        ConstantBufferView: extern struct {
            RootParameterIndex: UINT,
        },
        ShaderResourceView: extern struct {
            RootParameterIndex: UINT,
        },
        UnorderedAccessView: extern struct {
            RootParameterIndex: UINT,
        },
    },
};

pub const COMMAND_SIGNATURE_DESC = extern struct {
    ByteStride: UINT,
    NumArgumentDescs: UINT,
    pArgumentDescs: *const INDIRECT_ARGUMENT_DESC,
    NodeMask: UINT,
};

pub const PACKED_MIP_INFO = extern struct {
    NumStandardMips: UINT8,
    NumPackedMips: UINT8,
    NumTilesForPackedMips: UINT,
    StartTileIndexInOverallResource: UINT,
};

pub const COMMAND_QUEUE_FLAGS = packed struct(UINT) {
    DISABLE_GPU_TIMEOUT: bool = false,
    __unused: u31 = 0,
};

pub const COMMAND_QUEUE_PRIORITY = enum(UINT) {
    NORMAL = 0,
    HIGH = 100,
    GLOBAL_REALTIME = 10000,
};

pub const COMMAND_QUEUE_DESC = extern struct {
    Type: COMMAND_LIST_TYPE,
    Priority: INT,
    Flags: COMMAND_QUEUE_FLAGS,
    NodeMask: UINT,
};

pub const SHADER_BYTECODE = extern struct {
    pShaderBytecode: ?*const anyopaque,
    BytecodeLength: UINT64,

    pub inline fn initZero() SHADER_BYTECODE {
        return std.mem.zeroes(@This());
    }

    pub inline fn init(bytecode: []const u8) SHADER_BYTECODE {
        return .{
            .pShaderBytecode = bytecode.ptr,
            .BytecodeLength = bytecode.len,
        };
    }
};

pub const SO_DECLARATION_ENTRY = extern struct {
    Stream: UINT,
    SemanticName: LPCSTR,
    SemanticIndex: UINT,
    StartComponent: UINT8,
    ComponentCount: UINT8,
    OutputSlot: UINT8,
};

pub const STREAM_OUTPUT_DESC = extern struct {
    pSODeclaration: ?[*]const SO_DECLARATION_ENTRY,
    NumEntries: UINT,
    pBufferStrides: ?[*]const UINT,
    NumStrides: UINT,
    RasterizedStream: UINT,

    pub inline fn initZero() STREAM_OUTPUT_DESC {
        return std.mem.zeroes(@This());
    }
};

pub const BLEND = enum(UINT) {
    ZERO = 1,
    ONE = 2,
    SRC_COLOR = 3,
    INV_SRC_COLOR = 4,
    SRC_ALPHA = 5,
    INV_SRC_ALPHA = 6,
    DEST_ALPHA = 7,
    INV_DEST_ALPHA = 8,
    DEST_COLOR = 9,
    INV_DEST_COLOR = 10,
    SRC_ALPHA_SAT = 11,
    BLEND_FACTOR = 14,
    INV_BLEND_FACTOR = 15,
    SRC1_COLOR = 16,
    INV_SRC1_COLOR = 17,
    SRC1_ALPHA = 18,
    INV_SRC1_ALPHA = 19,
};

pub const BLEND_OP = enum(UINT) {
    ADD = 1,
    SUBTRACT = 2,
    REV_SUBTRACT = 3,
    MIN = 4,
    MAX = 5,
};

pub const COLOR_WRITE_ENABLE = packed struct(UINT) {
    RED: bool = false,
    GREEN: bool = false,
    BLUE: bool = false,
    ALPHA: bool = false,
    __unused: u28 = 0,

    pub const ALL = COLOR_WRITE_ENABLE{ .RED = true, .GREEN = true, .BLUE = true, .ALPHA = true };
};

pub const LOGIC_OP = enum(UINT) {
    CLEAR = 0,
    SET = 1,
    COPY = 2,
    COPY_INVERTED = 3,
    NOOP = 4,
    INVERT = 5,
    AND = 6,
    NAND = 7,
    OR = 8,
    NOR = 9,
    XOR = 10,
    EQUIV = 11,
    AND_REVERSE = 12,
    AND_INVERTED = 13,
    OR_REVERSE = 14,
    OR_INVERTED = 15,
};

pub const RENDER_TARGET_BLEND_DESC = extern struct {
    BlendEnable: BOOL = FALSE,
    LogicOpEnable: BOOL = FALSE,
    SrcBlend: BLEND = .ONE,
    DestBlend: BLEND = .ZERO,
    BlendOp: BLEND_OP = .ADD,
    SrcBlendAlpha: BLEND = .ONE,
    DestBlendAlpha: BLEND = .ZERO,
    BlendOpAlpha: BLEND_OP = .ADD,
    LogicOp: LOGIC_OP = .NOOP,
    RenderTargetWriteMask: COLOR_WRITE_ENABLE = COLOR_WRITE_ENABLE.ALL,

    pub fn initDefault() RENDER_TARGET_BLEND_DESC {
        return .{};
    }
};

pub const BLEND_DESC = extern struct {
    AlphaToCoverageEnable: BOOL = FALSE,
    IndependentBlendEnable: BOOL = FALSE,
    RenderTarget: [8]RENDER_TARGET_BLEND_DESC = [_]RENDER_TARGET_BLEND_DESC{.{}} ** 8,

    pub fn initDefault() BLEND_DESC {
        return .{};
    }
};

pub const RASTERIZER_DESC = extern struct {
    FillMode: FILL_MODE = .SOLID,
    CullMode: CULL_MODE = .BACK,
    FrontCounterClockwise: BOOL = FALSE,
    DepthBias: INT = 0,
    DepthBiasClamp: FLOAT = 0.0,
    SlopeScaledDepthBias: FLOAT = 0.0,
    DepthClipEnable: BOOL = TRUE,
    MultisampleEnable: BOOL = FALSE,
    AntialiasedLineEnable: BOOL = FALSE,
    ForcedSampleCount: UINT = 0,
    ConservativeRaster: CONSERVATIVE_RASTERIZATION_MODE = .OFF,

    pub fn initDefault() RASTERIZER_DESC {
        return .{};
    }
};

pub const FILL_MODE = enum(UINT) {
    WIREFRAME = 2,
    SOLID = 3,
};

pub const CULL_MODE = enum(UINT) {
    NONE = 1,
    FRONT = 2,
    BACK = 3,
};

pub const CONSERVATIVE_RASTERIZATION_MODE = enum(UINT) {
    OFF = 0,
    ON = 1,
};

pub const COMPARISON_FUNC = enum(UINT) {
    NEVER = 1,
    LESS = 2,
    EQUAL = 3,
    LESS_EQUAL = 4,
    GREATER = 5,
    NOT_EQUAL = 6,
    GREATER_EQUAL = 7,
    ALWAYS = 8,
};

pub const DEPTH_WRITE_MASK = enum(UINT) {
    ZERO = 0,
    ALL = 1,
};

pub const STENCIL_OP = enum(UINT) {
    KEEP = 1,
    ZERO = 2,
    REPLACE = 3,
    INCR_SAT = 4,
    DECR_SAT = 5,
    INVERT = 6,
    INCR = 7,
    DECR = 8,
};

pub const DEPTH_STENCILOP_DESC = extern struct {
    StencilFailOp: STENCIL_OP = .KEEP,
    StencilDepthFailOp: STENCIL_OP = .KEEP,
    StencilPassOp: STENCIL_OP = .KEEP,
    StencilFunc: COMPARISON_FUNC = .ALWAYS,

    pub fn initDefault() DEPTH_STENCILOP_DESC {
        return .{};
    }
};

pub const DEPTH_STENCIL_DESC = extern struct {
    DepthEnable: BOOL = TRUE,
    DepthWriteMask: DEPTH_WRITE_MASK = .ALL,
    DepthFunc: COMPARISON_FUNC = .LESS,
    StencilEnable: BOOL = FALSE,
    StencilReadMask: UINT8 = 0xff,
    StencilWriteMask: UINT8 = 0xff,
    FrontFace: DEPTH_STENCILOP_DESC = .{},
    BackFace: DEPTH_STENCILOP_DESC = .{},

    pub fn initDefault() DEPTH_STENCIL_DESC {
        return .{};
    }
};

pub const DEPTH_STENCIL_DESC1 = extern struct {
    DepthEnable: BOOL = TRUE,
    DepthWriteMask: DEPTH_WRITE_MASK = .ALL,
    DepthFunc: COMPARISON_FUNC = .LESS,
    StencilEnable: BOOL = FALSE,
    StencilReadMask: UINT8 = 0xff,
    StencilWriteMask: UINT8 = 0xff,
    FrontFace: DEPTH_STENCILOP_DESC = .{},
    BackFace: DEPTH_STENCILOP_DESC = .{},
    DepthBoundsTestEnable: BOOL = FALSE,

    pub fn initDefault() DEPTH_STENCIL_DESC1 {
        return .{};
    }
};

pub const INPUT_LAYOUT_DESC = extern struct {
    pInputElementDescs: ?[*]const INPUT_ELEMENT_DESC,
    NumElements: UINT,

    pub inline fn initZero() INPUT_LAYOUT_DESC {
        return std.mem.zeroes(@This());
    }

    pub inline fn init(elements: []const INPUT_ELEMENT_DESC) INPUT_LAYOUT_DESC {
        return .{
            .pInputElementDescs = elements.ptr,
            .NumElements = @intCast(elements.len),
        };
    }
};

pub const INPUT_CLASSIFICATION = enum(UINT) {
    PER_VERTEX_DATA = 0,
    PER_INSTANCE_DATA = 1,
};

pub const APPEND_ALIGNED_ELEMENT = 0xffffffff;

pub const INPUT_ELEMENT_DESC = extern struct {
    SemanticName: LPCSTR,
    SemanticIndex: UINT,
    Format: dxgi.FORMAT,
    InputSlot: UINT,
    AlignedByteOffset: UINT,
    InputSlotClass: INPUT_CLASSIFICATION,
    InstanceDataStepRate: UINT,

    pub inline fn init(
        semanticName: LPCSTR,
        semanticIndex: UINT,
        format: dxgi.FORMAT,
        inputSlot: UINT,
        alignedByteOffset: UINT,
        inputSlotClass: INPUT_CLASSIFICATION,
        instanceDataStepRate: UINT,
    ) INPUT_ELEMENT_DESC {
        var v = std.mem.zeroes(@This());
        v = .{
            .SemanticName = semanticName,
            .SemanticIndex = semanticIndex,
            .Format = format,
            .InputSlot = inputSlot,
            .AlignedByteOffset = alignedByteOffset,
            .InputSlotClass = inputSlotClass,
            .InstanceDataStepRate = instanceDataStepRate,
        };
        return v;
    }
};

pub const CACHED_PIPELINE_STATE = extern struct {
    pCachedBlob: ?*const anyopaque,
    CachedBlobSizeInBytes: UINT64,

    pub inline fn initZero() CACHED_PIPELINE_STATE {
        return std.mem.zeroes(@This());
    }
};

pub const PIPELINE_STATE_FLAGS = packed struct(UINT) {
    TOOL_DEBUG: bool = false,
    __unused1: bool = false,
    DYNAMIC_DEPTH_BIAS: bool = false,
    DYNAMIC_INDEX_BUFFER_STRIP_CUT: bool = false,
    __unused: u28 = 0,
};

pub const GRAPHICS_PIPELINE_STATE_DESC = extern struct {
    pRootSignature: ?*IRootSignature = null,
    VS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    PS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    DS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    HS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    GS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    StreamOutput: STREAM_OUTPUT_DESC = STREAM_OUTPUT_DESC.initZero(),
    BlendState: BLEND_DESC = .{},
    SampleMask: UINT = 0xffff_ffff,
    RasterizerState: RASTERIZER_DESC = .{},
    DepthStencilState: DEPTH_STENCIL_DESC = .{},
    InputLayout: INPUT_LAYOUT_DESC = INPUT_LAYOUT_DESC.initZero(),
    IBStripCutValue: INDEX_BUFFER_STRIP_CUT_VALUE = .DISABLED,
    PrimitiveTopologyType: PRIMITIVE_TOPOLOGY_TYPE = .UNDEFINED,
    NumRenderTargets: UINT = 0,
    RTVFormats: [8]dxgi.FORMAT = [_]dxgi.FORMAT{.UNKNOWN} ** 8,
    DSVFormat: dxgi.FORMAT = .UNKNOWN,
    SampleDesc: dxgi.SAMPLE_DESC = .{ .Count = 1, .Quality = 0 },
    NodeMask: UINT = 0,
    CachedPSO: CACHED_PIPELINE_STATE = CACHED_PIPELINE_STATE.initZero(),
    Flags: PIPELINE_STATE_FLAGS = .{},

    pub fn initDefault() GRAPHICS_PIPELINE_STATE_DESC {
        return .{};
    }
};

pub const COMPUTE_PIPELINE_STATE_DESC = extern struct {
    pRootSignature: ?*IRootSignature = null,
    CS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    NodeMask: UINT = 0,
    CachedPSO: CACHED_PIPELINE_STATE = CACHED_PIPELINE_STATE.initZero(),
    Flags: PIPELINE_STATE_FLAGS = .{},

    pub fn initDefault() COMPUTE_PIPELINE_STATE_DESC {
        return .{};
    }
};

pub const FEATURE = enum(UINT) {
    OPTIONS = 0,
    ARCHITECTURE = 1,
    FEATURE_LEVELS = 2,
    FORMAT_SUPPORT = 3,
    MULTISAMPLE_QUALITY_LEVELS = 4,
    FORMAT_INFO = 5,
    GPU_VIRTUAL_ADDRESS_SUPPORT = 6,
    SHADER_MODEL = 7,
    OPTIONS1 = 8,
    PROTECTED_RESOURCE_SESSION_SUPPORT = 10,
    ROOT_SIGNATURE = 12,
    ARCHITECTURE1 = 16,
    OPTIONS2 = 18,
    SHADER_CACHE = 19,
    COMMAND_QUEUE_PRIORITY = 20,
    OPTIONS3 = 21,
    EXISTING_HEAPS = 22,
    OPTIONS4 = 23,
    SERIALIZATION = 24,
    CROSS_NODE = 25,
    OPTIONS5 = 27,
    DISPLAYABLE = 28,
    OPTIONS6 = 30,
    QUERY_META_COMMAND = 31,
    OPTIONS7 = 32,
    PROTECTED_RESOURCE_SESSION_TYPE_COUNT = 33,
    PROTECTED_RESOURCE_SESSION_TYPES = 34,
    OPTIONS8 = 36,
    OPTIONS9 = 37,
    OPTIONS10 = 39,
    OPTIONS11 = 40,

    pub fn Data(self: FEATURE) type {
        // enum to type https://learn.microsoft.com/en-us/windows/win32/api/d3d12/ne-d3d12-d3d12_feature#constants
        return switch (self) {
            .OPTIONS => FEATURE_DATA_D3D12_OPTIONS,
            .FORMAT_INFO => FEATURE_DATA_FORMAT_INFO,
            .SHADER_MODEL => FEATURE_DATA_SHADER_MODEL,
            .ROOT_SIGNATURE => FEATURE_DATA_ROOT_SIGNATURE,
            .OPTIONS3 => FEATURE_DATA_D3D12_OPTIONS3,
            .OPTIONS5 => FEATURE_DATA_D3D12_OPTIONS5,
            .OPTIONS7 => FEATURE_DATA_D3D12_OPTIONS7,
            else => @compileError("not implemented"),
        };
    }
};

pub const SHADER_MODEL = enum(UINT) {
    @"5_1" = 0x51,
    @"6_0" = 0x60,
    @"6_1" = 0x61,
    @"6_2" = 0x62,
    @"6_3" = 0x63,
    @"6_4" = 0x64,
    @"6_5" = 0x65,
    @"6_6" = 0x66,
    @"6_7" = 0x67,
};

pub const RESOURCE_BINDING_TIER = enum(UINT) {
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
};

pub const RESOURCE_HEAP_TIER = enum(UINT) {
    TIER_1 = 1,
    TIER_2 = 2,
};

pub const SHADER_MIN_PRECISION_SUPPORT = packed struct(UINT) {
    @"10_BIT": bool = false,
    @"16_BIT": bool = false,
    __unused: u30 = 0,
};

pub const TILED_RESOURCES_TIER = enum(UINT) {
    NOT_SUPPORTED = 0,
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
    TIER_4 = 4,
};

pub const CONSERVATIVE_RASTERIZATION_TIER = enum(UINT) {
    NOT_SUPPORTED = 0,
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
};

pub const CROSS_NODE_SHARING_TIER = enum(UINT) {
    NOT_SUPPORTED = 0,
    TIER_1_EMULATED = 1,
    TIER_1 = 2,
    TIER_2 = 3,
    TIER_3 = 4,
};

pub const FEATURE_DATA_D3D12_OPTIONS = extern struct {
    DoublePrecisionFloatShaderOps: BOOL,
    OutputMergerLogicOp: BOOL,
    MinPrecisionSupport: SHADER_MIN_PRECISION_SUPPORT,
    TiledResourcesTier: TILED_RESOURCES_TIER,
    ResourceBindingTier: RESOURCE_BINDING_TIER,
    PSSpecifiedStencilRefSupported: BOOL,
    TypedUAVLoadAdditionalFormats: BOOL,
    ROVsSupported: BOOL,
    ConservativeRasterizationTier: CONSERVATIVE_RASTERIZATION_TIER,
    MaxGPUVirtualAddressBitsPerResource: UINT,
    StandardSwizzle64KBSupported: BOOL,
    CrossNodeSharingTier: CROSS_NODE_SHARING_TIER,
    CrossAdapterRowMajorTextureSupported: BOOL,
    VPAndRTArrayIndexFromAnyShaderFeedingRasterizerSupportedWithoutGSEmulation: BOOL,
    ResourceHeapTier: RESOURCE_HEAP_TIER,
};

pub const FEATURE_DATA_SHADER_MODEL = extern struct {
    HighestShaderModel: SHADER_MODEL,
};

pub const FEATURE_DATA_ROOT_SIGNATURE = extern struct {
    HighestVersion: ROOT_SIGNATURE_VERSION,
};

pub const FEATURE_DATA_FORMAT_INFO = extern struct {
    Format: dxgi.FORMAT,
    PlaneCount: u8,
};

pub const RENDER_PASS_TIER = enum(UINT) {
    TIER_0 = 0,
    TIER_1 = 1,
    TIER_2 = 2,
};

pub const RAYTRACING_TIER = enum(UINT) {
    NOT_SUPPORTED = 0,
    TIER_1_0 = 10,
    TIER_1_1 = 11,
};

pub const MESH_SHADER_TIER = enum(UINT) {
    NOT_SUPPORTED = 0,
    TIER_1 = 10,
};

pub const SAMPLER_FEEDBACK_TIER = enum(UINT) {
    NOT_SUPPORTED = 0,
    TIER_0_9 = 90,
    TIER_1_0 = 100,
};

pub const FEATURE_DATA_D3D12_OPTIONS7 = extern struct {
    MeshShaderTier: MESH_SHADER_TIER,
    SamplerFeedbackTier: SAMPLER_FEEDBACK_TIER,
};

pub const COMMAND_LIST_SUPPORT_FLAGS = packed struct(UINT) {
    DIRECT: bool = false,
    BUNDLE: bool = false,
    COMPUTE: bool = false,
    COPY: bool = false,
    VIDEO_DECODE: bool = false,
    VIDEO_PROCESS: bool = false,
    VIDEO_ENCODE: bool = false,
    __unused: u25 = 0,
};

pub const VIEW_INSTANCING_TIER = enum(UINT) {
    NOT_SUPPORTED = 0,
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
};

pub const FEATURE_DATA_D3D12_OPTIONS3 = extern struct {
    CopyQueueTimestampQueriesSupported: BOOL,
    CastingFullyTypedFormatSupported: BOOL,
    WriteBufferImmediateSupportFlags: COMMAND_LIST_SUPPORT_FLAGS,
    ViewInstancingTier: VIEW_INSTANCING_TIER,
    BarycentricsSupported: BOOL,
};

pub const FEATURE_DATA_D3D12_OPTIONS5 = extern struct {
    SRVOnlyTiledResourceTier3: BOOL,
    RenderPassesTier: RENDER_PASS_TIER,
    RaytracingTier: RAYTRACING_TIER,
};

pub const CONSTANT_BUFFER_VIEW_DESC = extern struct {
    BufferLocation: GPU_VIRTUAL_ADDRESS,
    SizeInBytes: UINT,
};

pub inline fn encodeShader4ComponentMapping(src0: UINT, src1: UINT, src2: UINT, src3: UINT) UINT {
    return (src0 & 0x7) | ((src1 & 0x7) << 3) | ((src2 & 0x7) << (3 * 2)) | ((src3 & 0x7) << (3 * 3)) |
        (1 << (3 * 4));
}
pub const DEFAULT_SHADER_4_COMPONENT_MAPPING = encodeShader4ComponentMapping(0, 1, 2, 3);

pub const BUFFER_SRV_FLAGS = packed struct(UINT) {
    RAW: bool = false,
    __unused: u31 = 0,
};

pub const BUFFER_SRV = extern struct {
    FirstElement: UINT64,
    NumElements: UINT,
    StructureByteStride: UINT,
    Flags: BUFFER_SRV_FLAGS,
};

pub const TEX1D_SRV = extern struct {
    MostDetailedMip: UINT,
    MipLevels: UINT,
    ResourceMinLODClamp: FLOAT,
};

pub const TEX1D_ARRAY_SRV = extern struct {
    MostDetailedMip: UINT,
    MipLevels: UINT,
    FirstArraySlice: UINT,
    ArraySize: UINT,
    ResourceMinLODClamp: FLOAT,
};

pub const TEX2D_SRV = extern struct {
    MostDetailedMip: UINT,
    MipLevels: UINT,
    PlaneSlice: UINT,
    ResourceMinLODClamp: FLOAT,
};

pub const TEX2D_ARRAY_SRV = extern struct {
    MostDetailedMip: UINT,
    MipLevels: UINT,
    FirstArraySlice: UINT,
    ArraySize: UINT,
    PlaneSlice: UINT,
    ResourceMinLODClamp: FLOAT,
};

pub const TEX3D_SRV = extern struct {
    MostDetailedMip: UINT,
    MipLevels: UINT,
    ResourceMinLODClamp: FLOAT,
};

pub const TEXCUBE_SRV = extern struct {
    MostDetailedMip: UINT,
    MipLevels: UINT,
    ResourceMinLODClamp: FLOAT,
};

pub const TEXCUBE_ARRAY_SRV = extern struct {
    MostDetailedMip: UINT,
    MipLevels: UINT,
    First2DArrayFace: UINT,
    NumCubes: UINT,
    ResourceMinLODClamp: FLOAT,
};

pub const TEX2DMS_SRV = extern struct {
    UnusedField_NothingToDefine: UINT,
};

pub const TEX2DMS_ARRAY_SRV = extern struct {
    FirstArraySlice: UINT,
    ArraySize: UINT,
};

pub const SRV_DIMENSION = enum(UINT) {
    UNKNOWN = 0,
    BUFFER = 1,
    TEXTURE1D = 2,
    TEXTURE1DARRAY = 3,
    TEXTURE2D = 4,
    TEXTURE2DARRAY = 5,
    TEXTURE2DMS = 6,
    TEXTURE2DMSARRAY = 7,
    TEXTURE3D = 8,
    TEXTURECUBE = 9,
    TEXTURECUBEARRAY = 10,
};

pub const SHADER_RESOURCE_VIEW_DESC = extern struct {
    Format: dxgi.FORMAT,
    ViewDimension: SRV_DIMENSION,
    Shader4ComponentMapping: UINT,
    u: extern union {
        Buffer: BUFFER_SRV,
        Texture1D: TEX1D_SRV,
        Texture1DArray: TEX1D_ARRAY_SRV,
        Texture2D: TEX2D_SRV,
        Texture2DArray: TEX2D_ARRAY_SRV,
        Texture2DMS: TEX2DMS_SRV,
        Texture2DMSArray: TEX2DMS_ARRAY_SRV,
        Texture3D: TEX3D_SRV,
        TextureCube: TEXCUBE_SRV,
        TextureCubeArray: TEXCUBE_ARRAY_SRV,
    },

    pub fn initTypedBuffer(
        format: dxgi.FORMAT,
        first_element: UINT64,
        num_elements: UINT,
    ) SHADER_RESOURCE_VIEW_DESC {
        var desc = std.mem.zeroes(@This());
        desc = .{
            .Format = format,
            .ViewDimension = .BUFFER,
            .Shader4ComponentMapping = DEFAULT_SHADER_4_COMPONENT_MAPPING,
            .u = .{
                .Buffer = .{
                    .FirstElement = first_element,
                    .NumElements = num_elements,
                    .StructureByteStride = 0,
                    .Flags = .{},
                },
            },
        };
        return desc;
    }

    pub fn initStructuredBuffer(
        first_element: UINT64,
        num_elements: UINT,
        stride: UINT,
    ) SHADER_RESOURCE_VIEW_DESC {
        var v = std.mem.zeroes(@This());
        v = .{
            .Format = .UNKNOWN,
            .ViewDimension = .BUFFER,
            .Shader4ComponentMapping = DEFAULT_SHADER_4_COMPONENT_MAPPING,
            .u = .{
                .Buffer = .{
                    .FirstElement = first_element,
                    .NumElements = num_elements,
                    .StructureByteStride = stride,
                    .Flags = .{},
                },
            },
        };
        return v;
    }
};

pub const FILTER = enum(UINT) {
    MIN_MAG_MIP_POINT = 0,
    MIN_MAG_POINT_MIP_LINEAR = 0x1,
    MIN_POINT_MAG_LINEAR_MIP_POINT = 0x4,
    MIN_POINT_MAG_MIP_LINEAR = 0x5,
    MIN_LINEAR_MAG_MIP_POINT = 0x10,
    MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x11,
    MIN_MAG_LINEAR_MIP_POINT = 0x14,
    MIN_MAG_MIP_LINEAR = 0x15,
    ANISOTROPIC = 0x55,
    COMPARISON_MIN_MAG_MIP_POINT = 0x80,
    COMPARISON_MIN_MAG_POINT_MIP_LINEAR = 0x81,
    COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT = 0x84,
    COMPARISON_MIN_POINT_MAG_MIP_LINEAR = 0x85,
    COMPARISON_MIN_LINEAR_MAG_MIP_POINT = 0x90,
    COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x91,
    COMPARISON_MIN_MAG_LINEAR_MIP_POINT = 0x94,
    COMPARISON_MIN_MAG_MIP_LINEAR = 0x95,
    COMPARISON_ANISOTROPIC = 0xd5,
    MINIMUM_MIN_MAG_MIP_POINT = 0x100,
    MINIMUM_MIN_MAG_POINT_MIP_LINEAR = 0x101,
    MINIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT = 0x104,
    MINIMUM_MIN_POINT_MAG_MIP_LINEAR = 0x105,
    MINIMUM_MIN_LINEAR_MAG_MIP_POINT = 0x110,
    MINIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x111,
    MINIMUM_MIN_MAG_LINEAR_MIP_POINT = 0x114,
    MINIMUM_MIN_MAG_MIP_LINEAR = 0x115,
    MINIMUM_ANISOTROPIC = 0x155,
    MAXIMUM_MIN_MAG_MIP_POINT = 0x180,
    MAXIMUM_MIN_MAG_POINT_MIP_LINEAR = 0x181,
    MAXIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT = 0x184,
    MAXIMUM_MIN_POINT_MAG_MIP_LINEAR = 0x185,
    MAXIMUM_MIN_LINEAR_MAG_MIP_POINT = 0x190,
    MAXIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x191,
    MAXIMUM_MIN_MAG_LINEAR_MIP_POINT = 0x194,
    MAXIMUM_MIN_MAG_MIP_LINEAR = 0x195,
    MAXIMUM_ANISOTROPIC = 0x1d5,
};

pub const FILTER_TYPE = enum(UINT) {
    POINT = 0,
    LINEAR = 1,
};

pub const FILTER_REDUCTION_TYPE = enum(UINT) {
    STANDARD = 0,
    COMPARISON = 1,
    MINIMUM = 2,
    MAXIMUM = 3,
};

pub const TEXTURE_ADDRESS_MODE = enum(UINT) {
    WRAP = 1,
    MIRROR = 2,
    CLAMP = 3,
    BORDER = 4,
    MIRROR_ONCE = 5,
};

pub const SAMPLER_DESC = extern struct {
    Filter: FILTER,
    AddressU: TEXTURE_ADDRESS_MODE,
    AddressV: TEXTURE_ADDRESS_MODE,
    AddressW: TEXTURE_ADDRESS_MODE,
    MipLODBias: FLOAT,
    MaxAnisotropy: UINT,
    ComparisonFunc: COMPARISON_FUNC,
    BorderColor: [4]FLOAT,
    MinLOD: FLOAT,
    MaxLOD: FLOAT,
};

pub const BUFFER_UAV_FLAGS = packed struct(UINT) {
    RAW: bool = false,
    __unused: u31 = 0,
};

pub const BUFFER_UAV = extern struct {
    FirstElement: UINT64,
    NumElements: UINT,
    StructureByteStride: UINT,
    CounterOffsetInBytes: UINT64,
    Flags: BUFFER_UAV_FLAGS,
};

pub const TEX1D_UAV = extern struct {
    MipSlice: UINT,
};

pub const TEX1D_ARRAY_UAV = extern struct {
    MipSlice: UINT,
    FirstArraySlice: UINT,
    ArraySize: UINT,
};

pub const TEX2D_UAV = extern struct {
    MipSlice: UINT,
    PlaneSlice: UINT,
};

pub const TEX2D_ARRAY_UAV = extern struct {
    MipSlice: UINT,
    FirstArraySlice: UINT,
    ArraySize: UINT,
    PlaneSlice: UINT,
};

pub const TEX3D_UAV = extern struct {
    MipSlice: UINT,
    FirstWSlice: UINT,
    WSize: UINT,
};

pub const UAV_DIMENSION = enum(UINT) {
    UNKNOWN = 0,
    BUFFER = 1,
    TEXTURE1D = 2,
    TEXTURE1DARRAY = 3,
    TEXTURE2D = 4,
    TEXTURE2DARRAY = 5,
    TEXTURE3D = 8,
};

pub const UNORDERED_ACCESS_VIEW_DESC = extern struct {
    Format: dxgi.FORMAT,
    ViewDimension: UAV_DIMENSION,
    u: extern union {
        Buffer: BUFFER_UAV,
        Texture1D: TEX1D_UAV,
        Texture1DArray: TEX1D_ARRAY_UAV,
        Texture2D: TEX2D_UAV,
        Texture2DArray: TEX2D_ARRAY_UAV,
        Texture3D: TEX3D_UAV,
    },

    pub fn initTypedBuffer(
        format: dxgi.FORMAT,
        first_element: UINT64,
        num_elements: UINT,
        counter_offset: UINT64,
    ) UNORDERED_ACCESS_VIEW_DESC {
        var desc = std.mem.zeroes(@This());
        desc = .{
            .Format = format,
            .ViewDimension = .BUFFER,
            .u = .{
                .Buffer = .{
                    .FirstElement = first_element,
                    .NumElements = num_elements,
                    .StructureByteStride = 0,
                    .CounterOffsetInBytes = counter_offset,
                    .Flags = .{},
                },
            },
        };
        return desc;
    }

    pub fn initStructuredBuffer(
        first_element: UINT64,
        num_elements: UINT,
        stride: UINT,
        counter_offset: UINT64,
    ) UNORDERED_ACCESS_VIEW_DESC {
        var v = std.mem.zeroes(@This());
        v = .{
            .Format = .UNKNOWN,
            .ViewDimension = .BUFFER,
            .u = .{
                .Buffer = .{
                    .FirstElement = first_element,
                    .NumElements = num_elements,
                    .StructureByteStride = stride,
                    .CounterOffsetInBytes = counter_offset,
                    .Flags = .{},
                },
            },
        };
        return v;
    }
};

pub const BUFFER_RTV = extern struct {
    FirstElement: UINT64,
    NumElements: UINT,
};

pub const TEX1D_RTV = extern struct {
    MipSlice: UINT,
};

pub const TEX1D_ARRAY_RTV = extern struct {
    MipSlice: UINT,
    FirstArraySlice: UINT,
    ArraySize: UINT,
};

pub const TEX2D_RTV = extern struct {
    MipSlice: UINT,
    PlaneSlice: UINT,
};

pub const TEX2DMS_RTV = extern struct {
    UnusedField_NothingToDefine: UINT,
};

pub const TEX2D_ARRAY_RTV = extern struct {
    MipSlice: UINT,
    FirstArraySlice: UINT,
    ArraySize: UINT,
    PlaneSlice: UINT,
};

pub const TEX2DMS_ARRAY_RTV = extern struct {
    FirstArraySlice: UINT,
    ArraySize: UINT,
};

pub const TEX3D_RTV = extern struct {
    MipSlice: UINT,
    FirstWSlice: UINT,
    WSize: UINT,
};

pub const RTV_DIMENSION = enum(UINT) {
    UNKNOWN = 0,
    BUFFER = 1,
    TEXTURE1D = 2,
    TEXTURE1DARRAY = 3,
    TEXTURE2D = 4,
    TEXTURE2DARRAY = 5,
    TEXTURE2DMS = 6,
    TEXTURE2DMSARRAY = 7,
    TEXTURE3D = 8,
};

pub const RENDER_TARGET_VIEW_DESC = extern struct {
    Format: dxgi.FORMAT,
    ViewDimension: RTV_DIMENSION,
    u: extern union {
        Buffer: BUFFER_RTV,
        Texture1D: TEX1D_RTV,
        Texture1DArray: TEX1D_ARRAY_RTV,
        Texture2D: TEX2D_RTV,
        Texture2DArray: TEX2D_ARRAY_RTV,
        Texture2DMS: TEX2DMS_RTV,
        Texture2DMSArray: TEX2DMS_ARRAY_RTV,
        Texture3D: TEX3D_RTV,
    },
};

pub const TEX1D_DSV = extern struct {
    MipSlice: UINT,
};

pub const TEX1D_ARRAY_DSV = extern struct {
    MipSlice: UINT,
    FirstArraySlice: UINT,
    ArraySize: UINT,
};

pub const TEX2D_DSV = extern struct {
    MipSlice: UINT,
};

pub const TEX2D_ARRAY_DSV = extern struct {
    MipSlice: UINT,
    FirstArraySlice: UINT,
    ArraySize: UINT,
};

pub const TEX2DMS_DSV = extern struct {
    UnusedField_NothingToDefine: UINT,
};

pub const TEX2DMS_ARRAY_DSV = extern struct {
    FirstArraySlice: UINT,
    ArraySize: UINT,
};

pub const DSV_FLAGS = packed struct(UINT) {
    READ_ONLY_DEPTH: bool = false,
    READ_ONLY_STENCIL: bool = false,
    __unused: u30 = 0,
};

pub const DSV_DIMENSION = enum(UINT) {
    UNKNOWN = 0,
    TEXTURE1D = 1,
    TEXTURE1DARRAY = 2,
    TEXTURE2D = 3,
    TEXTURE2DARRAY = 4,
    TEXTURE2DMS = 5,
    TEXTURE2DMSARRAY = 6,
};

pub const DEPTH_STENCIL_VIEW_DESC = extern struct {
    Format: dxgi.FORMAT,
    ViewDimension: DSV_DIMENSION,
    Flags: DSV_FLAGS,
    u: extern union {
        Texture1D: TEX1D_DSV,
        Texture1DArray: TEX1D_ARRAY_DSV,
        Texture2D: TEX2D_DSV,
        Texture2DArray: TEX2D_ARRAY_DSV,
        Texture2DMS: TEX2DMS_DSV,
        Texture2DMSArray: TEX2DMS_ARRAY_DSV,
    },
};

pub const RESOURCE_ALLOCATION_INFO = extern struct {
    SizeInBytes: UINT64,
    Alignment: UINT64,
};

pub const DEPTH_STENCIL_VALUE = extern struct {
    Depth: FLOAT,
    Stencil: UINT8,
};

pub const CLEAR_VALUE = extern struct {
    Format: dxgi.FORMAT,
    u: extern union {
        Color: [4]FLOAT,
        DepthStencil: DEPTH_STENCIL_VALUE,
    },

    pub fn initColor(format: dxgi.FORMAT, in_color: *const [4]FLOAT) CLEAR_VALUE {
        var v = std.mem.zeroes(@This());
        v = .{
            .Format = format,
            .u = .{ .Color = in_color.* },
        };
        return v;
    }

    pub fn initDepthStencil(format: dxgi.FORMAT, depth: FLOAT, stencil: UINT8) CLEAR_VALUE {
        var v = std.mem.zeroes(@This());
        v = .{
            .Format = format,
            .u = .{ .DepthStencil = .{ .Depth = depth, .Stencil = stencil } },
        };
        return v;
    }
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
    pub inline fn GetPrivateData(self: *IObject, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return self.__v.GetPrivateData(self, guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IObject, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return self.__v.SetPrivateData(self, guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IObject, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return self.__v.SetPrivateDataInterface(self, guid, data);
    }
    pub inline fn SetName(self: *IObject, name: LPCWSTR) HRESULT {
        return self.__v.SetName(self, name);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetPrivateData: *const fn (*IObject, *const GUID, *UINT, ?*anyopaque) callconv(WINAPI) HRESULT,
        SetPrivateData: *const fn (*IObject, *const GUID, UINT, ?*const anyopaque) callconv(WINAPI) HRESULT,
        SetPrivateDataInterface: *const fn (*IObject, *const GUID, ?*const IUnknown) callconv(WINAPI) HRESULT,
        SetName: *const fn (*IObject, LPCWSTR) callconv(WINAPI) HRESULT,
    };
};

pub const IDeviceChild = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDeviceChild, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IObject.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDeviceChild) ULONG {
        return IObject.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDeviceChild) ULONG {
        return IObject.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IDeviceChild, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDeviceChild, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDeviceChild, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDeviceChild, name: LPCWSTR) HRESULT {
        return IObject.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IDeviceChild, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return self.__v.GetDevice(self, guid, device);
    }
    pub const VTable = extern struct {
        base: IObject.VTable,
        GetDevice: *const fn (*IDeviceChild, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT,
    };
};

pub const IPageable = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IPageable, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceChild.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IPageable) ULONG {
        return IDeviceChild.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IPageable) ULONG {
        return IDeviceChild.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IPageable, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDeviceChild.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IPageable, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDeviceChild.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IPageable, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceChild.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IPageable, name: LPCWSTR) HRESULT {
        return IDeviceChild.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IPageable, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IDeviceChild.GetDevice(@ptrCast(self), guid, device);
    }
    pub const VTable = extern struct {
        base: IDeviceChild.VTable,
    };
};

pub const IRootSignature = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IRootSignature, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceChild.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IRootSignature) ULONG {
        return IDeviceChild.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IRootSignature) ULONG {
        return IDeviceChild.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IRootSignature, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDeviceChild.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IRootSignature, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDeviceChild.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IRootSignature, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceChild.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IRootSignature, name: LPCWSTR) HRESULT {
        return IDeviceChild.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IRootSignature, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IDeviceChild.GetDevice(@ptrCast(self), guid, device);
    }
    pub const VTable = extern struct {
        base: IDeviceChild.VTable,
    };
};

pub const IQueryHeap = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IQueryHeap, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IQueryHeap) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IQueryHeap) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IQueryHeap, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IQueryHeap, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IQueryHeap, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IQueryHeap, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IQueryHeap, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub const VTable = extern struct {
        base: IPageable.VTable,
    };
};

pub const ICommandSignature = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ICommandSignature, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ICommandSignature) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ICommandSignature) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *ICommandSignature, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *ICommandSignature, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ICommandSignature, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *ICommandSignature, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *ICommandSignature, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub const VTable = extern struct {
        base: IPageable.VTable,
    };
};

pub const IHeap = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IHeap, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IHeap) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IHeap) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IHeap, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IHeap, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IHeap, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IHeap, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IHeap, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetDesc(self: *IHeap, desc: *HEAP_DESC) *HEAP_DESC {
        return self.__v.GetDesc(self, desc);
    }
    pub const VTable = extern struct {
        base: IPageable.VTable,
        GetDesc: *const fn (*IHeap, *HEAP_DESC) callconv(WINAPI) *HEAP_DESC,
    };
};

pub const IResource = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IResource, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IResource) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IResource) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IResource, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IResource, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IResource, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IResource, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IResource, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn Map(self: *IResource, subresource: UINT, read_range: ?*const RANGE, data: *?*anyopaque) HRESULT {
        return self.__v.Map(self, subresource, read_range, data);
    }
    pub inline fn Unmap(self: *IResource, subresource: UINT, written_range: ?*const RANGE) void {
        self.__v.Unmap(self, subresource, written_range);
    }
    pub inline fn GetDesc(self: *IResource, desc: *RESOURCE_DESC) *RESOURCE_DESC {
        return self.__v.GetDesc(self, desc);
    }
    pub inline fn GetGPUVirtualAddress(self: *IResource) GPU_VIRTUAL_ADDRESS {
        return self.__v.GetGPUVirtualAddress(self);
    }
    pub inline fn WriteToSubresource(self: *IResource, dst_subresource: UINT, dst_box: ?*const BOX, src_data: *const anyopaque, src_row_pitch: UINT, src_depth_pitch: UINT) HRESULT {
        return self.__v.WriteToSubresource(self, dst_subresource, dst_box, src_data, src_row_pitch, src_depth_pitch);
    }
    pub inline fn ReadFromSubresource(self: *IResource, dst_data: *anyopaque, dst_row_pitch: UINT, dst_depth_pitch: UINT, src_subresource: UINT, src_box: ?*const BOX) HRESULT {
        return self.__v.ReadFromSubresource(self, dst_data, dst_row_pitch, dst_depth_pitch, src_subresource, src_box);
    }
    pub inline fn GetHeapProperties(self: *IResource, properties: ?*HEAP_PROPERTIES, flags: ?*HEAP_FLAGS) HRESULT {
        return self.__v.GetHeapProperties(self, properties, flags);
    }
    pub const VTable = extern struct {
        base: IPageable.VTable,
        Map: *const fn (*IResource, UINT, ?*const RANGE, *?*anyopaque) callconv(WINAPI) HRESULT,
        Unmap: *const fn (*IResource, UINT, ?*const RANGE) callconv(WINAPI) void,
        GetDesc: *const fn (*IResource, *RESOURCE_DESC) callconv(WINAPI) *RESOURCE_DESC,
        GetGPUVirtualAddress: *const fn (*IResource) callconv(WINAPI) GPU_VIRTUAL_ADDRESS,
        WriteToSubresource: *const fn (
            *IResource,
            UINT,
            ?*const BOX,
            *const anyopaque,
            UINT,
            UINT,
        ) callconv(WINAPI) HRESULT,
        ReadFromSubresource: *const fn (
            *IResource,
            *anyopaque,
            UINT,
            UINT,
            UINT,
            ?*const BOX,
        ) callconv(WINAPI) HRESULT,
        GetHeapProperties: *const fn (*IResource, ?*HEAP_PROPERTIES, ?*HEAP_FLAGS) callconv(WINAPI) HRESULT,
    };
};

pub const IResource1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IResource1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IResource.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IResource1) ULONG {
        return IResource.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IResource1) ULONG {
        return IResource.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IResource1, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IResource.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IResource1, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IResource.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IResource1, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IResource.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IResource1, name: LPCWSTR) HRESULT {
        return IResource.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IResource1, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IResource.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn Map(self: *IResource1, subresource: UINT, read_range: ?*const RANGE, data: *?*anyopaque) HRESULT {
        return IResource.Map(@ptrCast(self), subresource, read_range, data);
    }
    pub inline fn Unmap(self: *IResource1, subresource: UINT, written_range: ?*const RANGE) void {
        IResource.Unmap(@ptrCast(self), subresource, written_range);
    }
    pub inline fn GetDesc(self: *IResource1, desc: *RESOURCE_DESC) *RESOURCE_DESC {
        return IResource.GetDesc(@ptrCast(self), desc);
    }
    pub inline fn GetGPUVirtualAddress(self: *IResource1) GPU_VIRTUAL_ADDRESS {
        return IResource.GetGPUVirtualAddress(@ptrCast(self));
    }
    pub inline fn WriteToSubresource(self: *IResource1, dst_subresource: UINT, dst_box: ?*const BOX, src_data: *const anyopaque, src_row_pitch: UINT, src_depth_pitch: UINT) HRESULT {
        return IResource.WriteToSubresource(@ptrCast(self), dst_subresource, dst_box, src_data, src_row_pitch, src_depth_pitch);
    }
    pub inline fn ReadFromSubresource(self: *IResource1, dst_data: *anyopaque, dst_row_pitch: UINT, dst_depth_pitch: UINT, src_subresource: UINT, src_box: ?*const BOX) HRESULT {
        return IResource.ReadFromSubresource(@ptrCast(self), dst_data, dst_row_pitch, dst_depth_pitch, src_subresource, src_box);
    }
    pub inline fn GetHeapProperties(self: *IResource1, properties: ?*HEAP_PROPERTIES, flags: ?*HEAP_FLAGS) HRESULT {
        return IResource.GetHeapProperties(@ptrCast(self), properties, flags);
    }
    pub inline fn GetProtectedResourceSession(self: *IResource1, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return self.__v.GetProtectedResourceSession(self, guid, session);
    }
    pub const VTable = extern struct {
        base: IResource.VTable,
        GetProtectedResourceSession: *const fn (*IResource1, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT,
    };
};

pub const ICommandAllocator = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ICommandAllocator, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ICommandAllocator) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ICommandAllocator) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *ICommandAllocator, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *ICommandAllocator, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ICommandAllocator, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *ICommandAllocator, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *ICommandAllocator, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn Reset(self: *ICommandAllocator) HRESULT {
        return self.__v.Reset(self);
    }
    pub const VTable = extern struct {
        base: IPageable.VTable,
        Reset: *const fn (*ICommandAllocator) callconv(WINAPI) HRESULT,
    };
};

pub const IFence = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFence, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFence) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFence) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IFence, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IFence, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFence, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IFence, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IFence, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetCompletedValue(self: *IFence) UINT64 {
        return self.__v.GetCompletedValue(self);
    }
    pub inline fn SetEventOnCompletion(self: *IFence, value: UINT64, event: HANDLE) HRESULT {
        return self.__v.SetEventOnCompletion(self, value, event);
    }
    pub inline fn Signal(self: *IFence, value: UINT64) HRESULT {
        return self.__v.Signal(self, value);
    }
    pub const VTable = extern struct {
        base: IPageable.VTable,
        GetCompletedValue: *const fn (*IFence) callconv(WINAPI) UINT64,
        SetEventOnCompletion: *const fn (*IFence, UINT64, HANDLE) callconv(WINAPI) HRESULT,
        Signal: *const fn (*IFence, UINT64) callconv(WINAPI) HRESULT,
    };
};

pub const IFence1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IFence1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IFence.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IFence1) ULONG {
        return IFence.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IFence1) ULONG {
        return IFence.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IFence1, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IFence.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IFence1, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IFence.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IFence1, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IFence.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IFence1, name: LPCWSTR) HRESULT {
        return IFence.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IFence1, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IFence.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetCompletedValue(self: *IFence1) UINT64 {
        return IFence.GetCompletedValue(@ptrCast(self));
    }
    pub inline fn SetEventOnCompletion(self: *IFence1, value: UINT64, event: HANDLE) HRESULT {
        return IFence.SetEventOnCompletion(@ptrCast(self), value, event);
    }
    pub inline fn Signal(self: *IFence1, value: UINT64) HRESULT {
        return IFence.Signal(@ptrCast(self), value);
    }
    pub inline fn GetCreationFlags(self: *IFence1) FENCE_FLAGS {
        return self.__v.GetCreationFlags(self);
    }
    pub const VTable = extern struct {
        base: IFence.VTable,
        GetCreationFlags: *const fn (*IFence1) callconv(WINAPI) FENCE_FLAGS,
    };
};

pub const IPipelineState = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IPipelineState, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IPipelineState) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IPipelineState) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IPipelineState, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IPipelineState, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IPipelineState, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IPipelineState, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IPipelineState, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetCachedBlob(self: *IPipelineState, blob: **d3d.IBlob) HRESULT {
        return self.__v.GetCachedBlob(self, blob);
    }
    pub const VTable = extern struct {
        base: IPageable.VTable,
        GetCachedBlob: *const fn (*IPipelineState, **d3d.IBlob) callconv(WINAPI) HRESULT,
    };
};

pub const IDescriptorHeap = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDescriptorHeap, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDescriptorHeap) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDescriptorHeap) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IDescriptorHeap, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDescriptorHeap, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDescriptorHeap, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDescriptorHeap, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IDescriptorHeap, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetDesc(self: *IDescriptorHeap, desc: *DESCRIPTOR_HEAP_DESC) *DESCRIPTOR_HEAP_DESC {
        return self.__v.GetDesc(self, desc);
    }
    pub inline fn GetCPUDescriptorHandleForHeapStart(self: *IDescriptorHeap, handle: *CPU_DESCRIPTOR_HANDLE) *CPU_DESCRIPTOR_HANDLE {
        return self.__v.GetCPUDescriptorHandleForHeapStart(self, handle);
    }
    pub inline fn GetGPUDescriptorHandleForHeapStart(self: *IDescriptorHeap, handle: *GPU_DESCRIPTOR_HANDLE) *GPU_DESCRIPTOR_HANDLE {
        return self.__v.GetGPUDescriptorHandleForHeapStart(self, handle);
    }
    pub const VTable = extern struct {
        base: IPageable.VTable,
        GetDesc: *const fn (*IDescriptorHeap, *DESCRIPTOR_HEAP_DESC) callconv(WINAPI) *DESCRIPTOR_HEAP_DESC,
        GetCPUDescriptorHandleForHeapStart: *const fn (
            *IDescriptorHeap,
            *CPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) *CPU_DESCRIPTOR_HANDLE,
        GetGPUDescriptorHandleForHeapStart: *const fn (
            *IDescriptorHeap,
            *GPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) *GPU_DESCRIPTOR_HANDLE,
    };
};

pub const ICommandList = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ICommandList, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceChild.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ICommandList) ULONG {
        return IDeviceChild.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ICommandList) ULONG {
        return IDeviceChild.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *ICommandList, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDeviceChild.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *ICommandList, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDeviceChild.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ICommandList, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceChild.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *ICommandList, name: LPCWSTR) HRESULT {
        return IDeviceChild.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *ICommandList, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IDeviceChild.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *ICommandList) COMMAND_LIST_TYPE {
        return self.__v.GetType(self);
    }
    pub const VTable = extern struct {
        base: IDeviceChild.VTable,
        GetType: *const fn (*ICommandList) callconv(WINAPI) COMMAND_LIST_TYPE,
    };
};

pub const IID_IGraphicsCommandList = GUID.parse("{5b160d0f-ac1b-4185-8ba8-b3ae42a5a455}");
pub const IGraphicsCommandList = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return ICommandList.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList) ULONG {
        return ICommandList.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList) ULONG {
        return ICommandList.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return ICommandList.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return ICommandList.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return ICommandList.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList, name: LPCWSTR) HRESULT {
        return ICommandList.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return ICommandList.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList) COMMAND_LIST_TYPE {
        return ICommandList.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList) HRESULT {
        return self.__v.Close(self);
    }
    pub inline fn Reset(self: *IGraphicsCommandList, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return self.__v.Reset(self, alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList, pso: ?*IPipelineState) void {
        self.__v.ClearState(self, pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        self.__v.DrawInstanced(self, vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        self.__v.DrawIndexedInstanced(self, index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList, count_x: UINT, count_y: UINT, count_z: UINT) void {
        self.__v.Dispatch(self, count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        self.__v.CopyBufferRegion(self, dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        self.__v.CopyTextureRegion(self, dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList, dst: *IResource, src: *IResource) void {
        self.__v.CopyResource(self, dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        self.__v.CopyTiles(self, tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        self.__v.ResolveSubresource(self, dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList, topology: PRIMITIVE_TOPOLOGY) void {
        self.__v.IASetPrimitiveTopology(self, topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList, num: UINT, viewports: [*]const VIEWPORT) void {
        self.__v.RSSetViewports(self, num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList, num: UINT, rects: [*]const RECT) void {
        self.__v.RSSetScissorRects(self, num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList, blend_factor: *const [4]FLOAT) void {
        self.__v.OMSetBlendFactor(self, blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList, stencil_ref: UINT) void {
        self.__v.OMSetStencilRef(self, stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList, pso: *IPipelineState) void {
        self.__v.SetPipelineState(self, pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        self.__v.ResourceBarrier(self, num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList, cmdlist: *IGraphicsCommandList) void {
        self.__v.ExecuteBundle(self, cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        self.__v.SetDescriptorHeaps(self, num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList, root_signature: ?*IRootSignature) void {
        self.__v.SetComputeRootSignature(self, root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList, root_signature: ?*IRootSignature) void {
        self.__v.SetGraphicsRootSignature(self, root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        self.__v.SetComputeRootDescriptorTable(self, root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        self.__v.SetGraphicsRootDescriptorTable(self, root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList, index: UINT, data: UINT, off: UINT) void {
        self.__v.SetComputeRoot32BitConstant(self, index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList, index: UINT, data: UINT, off: UINT) void {
        self.__v.SetGraphicsRoot32BitConstant(self, index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        self.__v.SetComputeRoot32BitConstants(self, root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        self.__v.SetGraphicsRoot32BitConstants(self, root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        self.__v.SetComputeRootConstantBufferView(self, index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        self.__v.SetGraphicsRootConstantBufferView(self, index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        self.__v.SetComputeRootShaderResourceView(self, index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        self.__v.SetGraphicsRootShaderResourceView(self, index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        self.__v.SetComputeRootUnorderedAccessView(self, index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        self.__v.SetGraphicsRootUnorderedAccessView(self, index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList, view: ?*const INDEX_BUFFER_VIEW) void {
        self.__v.IASetIndexBuffer(self, view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        self.__v.IASetVertexBuffers(self, start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        self.__v.SOSetTargets(self, start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        self.__v.OMSetRenderTargets(self, num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        self.__v.ClearDepthStencilView(self, ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        self.__v.ClearRenderTargetView(self, rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        self.__v.ClearUnorderedAccessViewUint(self, gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        self.__v.ClearUnorderedAccessViewFloat(self, gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList, resource: *IResource, region: ?*const DISCARD_REGION) void {
        self.__v.DiscardResource(self, resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        self.__v.BeginQuery(self, query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        self.__v.EndQuery(self, query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        self.__v.ResolveQueryData(self, query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        self.__v.SetPredication(self, buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        self.__v.SetMarker(self, metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        self.__v.BeginEvent(self, metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList) void {
        self.__v.EndEvent(self);
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        self.__v.ExecuteIndirect(self, command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub const VTable = extern struct {
        const T = IGraphicsCommandList;
        base: ICommandList.VTable,
        Close: *const fn (*T) callconv(.C) HRESULT,
        Reset: *const fn (*T, *ICommandAllocator, ?*IPipelineState) callconv(WINAPI) HRESULT,
        ClearState: *const fn (*T, ?*IPipelineState) callconv(WINAPI) void,
        DrawInstanced: *const fn (*T, UINT, UINT, UINT, UINT) callconv(WINAPI) void,
        DrawIndexedInstanced: *const fn (*T, UINT, UINT, UINT, INT, UINT) callconv(WINAPI) void,
        Dispatch: *const fn (*T, UINT, UINT, UINT) callconv(WINAPI) void,
        CopyBufferRegion: *const fn (*T, *IResource, UINT64, *IResource, UINT64, UINT64) callconv(WINAPI) void,
        CopyTextureRegion: *const fn (
            *T,
            *const TEXTURE_COPY_LOCATION,
            UINT,
            UINT,
            UINT,
            *const TEXTURE_COPY_LOCATION,
            ?*const BOX,
        ) callconv(WINAPI) void,
        CopyResource: *const fn (*T, *IResource, *IResource) callconv(WINAPI) void,
        CopyTiles: *const fn (
            *T,
            *IResource,
            *const TILED_RESOURCE_COORDINATE,
            *const TILE_REGION_SIZE,
            *IResource,
            buffer_start_offset_in_bytes: UINT64,
            TILE_COPY_FLAGS,
        ) callconv(WINAPI) void,
        ResolveSubresource: *const fn (*T, *IResource, UINT, *IResource, UINT, dxgi.FORMAT) callconv(WINAPI) void,
        IASetPrimitiveTopology: *const fn (*T, PRIMITIVE_TOPOLOGY) callconv(WINAPI) void,
        RSSetViewports: *const fn (*T, UINT, [*]const VIEWPORT) callconv(WINAPI) void,
        RSSetScissorRects: *const fn (*T, UINT, [*]const RECT) callconv(WINAPI) void,
        OMSetBlendFactor: *const fn (*T, *const [4]FLOAT) callconv(WINAPI) void,
        OMSetStencilRef: *const fn (*T, UINT) callconv(WINAPI) void,
        SetPipelineState: *const fn (*T, *IPipelineState) callconv(WINAPI) void,
        ResourceBarrier: *const fn (*T, UINT, [*]const RESOURCE_BARRIER) callconv(WINAPI) void,
        ExecuteBundle: *const fn (*T, *IGraphicsCommandList) callconv(WINAPI) void,
        SetDescriptorHeaps: *const fn (*T, UINT, [*]const *IDescriptorHeap) callconv(WINAPI) void,
        SetComputeRootSignature: *const fn (*T, ?*IRootSignature) callconv(WINAPI) void,
        SetGraphicsRootSignature: *const fn (*T, ?*IRootSignature) callconv(WINAPI) void,
        SetComputeRootDescriptorTable: *const fn (*T, UINT, GPU_DESCRIPTOR_HANDLE) callconv(WINAPI) void,
        SetGraphicsRootDescriptorTable: *const fn (*T, UINT, GPU_DESCRIPTOR_HANDLE) callconv(WINAPI) void,
        SetComputeRoot32BitConstant: *const fn (*T, UINT, UINT, UINT) callconv(WINAPI) void,
        SetGraphicsRoot32BitConstant: *const fn (*T, UINT, UINT, UINT) callconv(WINAPI) void,
        SetComputeRoot32BitConstants: *const fn (*T, UINT, UINT, *const anyopaque, UINT) callconv(WINAPI) void,
        SetGraphicsRoot32BitConstants: *const fn (*T, UINT, UINT, *const anyopaque, UINT) callconv(WINAPI) void,
        SetComputeRootConstantBufferView: *const fn (*T, UINT, GPU_VIRTUAL_ADDRESS) callconv(WINAPI) void,
        SetGraphicsRootConstantBufferView: *const fn (*T, UINT, GPU_VIRTUAL_ADDRESS) callconv(WINAPI) void,
        SetComputeRootShaderResourceView: *const fn (*T, UINT, GPU_VIRTUAL_ADDRESS) callconv(WINAPI) void,
        SetGraphicsRootShaderResourceView: *const fn (*T, UINT, GPU_VIRTUAL_ADDRESS) callconv(WINAPI) void,
        SetComputeRootUnorderedAccessView: *const fn (*T, UINT, GPU_VIRTUAL_ADDRESS) callconv(WINAPI) void,
        SetGraphicsRootUnorderedAccessView: *const fn (*T, UINT, GPU_VIRTUAL_ADDRESS) callconv(WINAPI) void,
        IASetIndexBuffer: *const fn (*T, ?*const INDEX_BUFFER_VIEW) callconv(WINAPI) void,
        IASetVertexBuffers: *const fn (*T, UINT, UINT, ?[*]const VERTEX_BUFFER_VIEW) callconv(WINAPI) void,
        SOSetTargets: *const fn (*T, UINT, UINT, ?[*]const STREAM_OUTPUT_BUFFER_VIEW) callconv(WINAPI) void,
        OMSetRenderTargets: *const fn (
            *T,
            UINT,
            ?[*]const CPU_DESCRIPTOR_HANDLE,
            BOOL,
            ?*const CPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) void,
        ClearDepthStencilView: *const fn (
            *T,
            CPU_DESCRIPTOR_HANDLE,
            CLEAR_FLAGS,
            FLOAT,
            UINT8,
            UINT,
            ?[*]const RECT,
        ) callconv(WINAPI) void,
        ClearRenderTargetView: *const fn (
            *T,
            CPU_DESCRIPTOR_HANDLE,
            *const [4]FLOAT,
            UINT,
            ?[*]const RECT,
        ) callconv(WINAPI) void,
        ClearUnorderedAccessViewUint: *const fn (
            *T,
            GPU_DESCRIPTOR_HANDLE,
            CPU_DESCRIPTOR_HANDLE,
            *IResource,
            *const [4]UINT,
            UINT,
            ?[*]const RECT,
        ) callconv(WINAPI) void,
        ClearUnorderedAccessViewFloat: *const fn (
            *T,
            GPU_DESCRIPTOR_HANDLE,
            CPU_DESCRIPTOR_HANDLE,
            *IResource,
            *const [4]FLOAT,
            UINT,
            ?[*]const RECT,
        ) callconv(WINAPI) void,
        DiscardResource: *const fn (*T, *IResource, ?*const DISCARD_REGION) callconv(WINAPI) void,
        BeginQuery: *const fn (*T, *IQueryHeap, QUERY_TYPE, UINT) callconv(WINAPI) void,
        EndQuery: *const fn (*T, *IQueryHeap, QUERY_TYPE, UINT) callconv(WINAPI) void,
        ResolveQueryData: *const fn (
            *T,
            *IQueryHeap,
            QUERY_TYPE,
            UINT,
            UINT,
            *IResource,
            UINT64,
        ) callconv(WINAPI) void,
        SetPredication: *const fn (*T, ?*IResource, UINT64, PREDICATION_OP) callconv(WINAPI) void,
        SetMarker: *const fn (*T, UINT, ?*const anyopaque, UINT) callconv(WINAPI) void,
        BeginEvent: *const fn (*T, UINT, ?*const anyopaque, UINT) callconv(WINAPI) void,
        EndEvent: *const fn (*T) callconv(WINAPI) void,
        ExecuteIndirect: *const fn (
            *T,
            *ICommandSignature,
            UINT,
            *IResource,
            UINT64,
            ?*IResource,
            UINT64,
        ) callconv(WINAPI) void,
    };
};

pub const RANGE_UINT64 = extern struct {
    Begin: UINT64,
    End: UINT64,
};

pub const SUBRESOURCE_RANGE_UINT64 = extern struct {
    Subresource: UINT,
    Range: RANGE_UINT64,
};

pub const SAMPLE_POSITION = extern struct {
    X: INT8,
    Y: INT8,
};

pub const RESOLVE_MODE = enum(UINT) {
    DECOMPRESS = 0,
    MIN = 1,
    MAX = 2,
    AVERAGE = 3,
    ENCODE_SAMPLER_FEEDBACK = 4,
    DECODE_SAMPLER_FEEDBACK = 5,
};

pub const IID_IGraphicsCommandList1 = GUID.parse("{553103fb-1fe7-4557-bb38-946d7d0e7ca7}");
pub const IGraphicsCommandList1 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList1, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList1) ULONG {
        return IGraphicsCommandList.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList1) ULONG {
        return IGraphicsCommandList.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList1, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList1, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList1, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList1, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList1, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList1) COMMAND_LIST_TYPE {
        return IGraphicsCommandList.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList1) HRESULT {
        return IGraphicsCommandList.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList1, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList1, pso: ?*IPipelineState) void {
        IGraphicsCommandList.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList1, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList1, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList1, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList1, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList1, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList1, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList1, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList1, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList1, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList1, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList1, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList1, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList1, stencil_ref: UINT) void {
        IGraphicsCommandList.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList1, pso: *IPipelineState) void {
        IGraphicsCommandList.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList1, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList1, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList1, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList1, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList1, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList1, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList1, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList1, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList1, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList1, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList1, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList1, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList1, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList1, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList1, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList1, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList1, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList1, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList1, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList1, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList1, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList1, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList1, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList1, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList1, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList1, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList1, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList1, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList1, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList1, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList1, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList1, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList1) void {
        IGraphicsCommandList.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList1, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList1, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        self.__v.AtomicCopyBufferUINT(self, dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList1, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        self.__v.AtomicCopyBufferUINT64(self, dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList1, min: FLOAT, max: FLOAT) void {
        self.__v.OMSetDepthBounds(self, min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList1, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        self.__v.SetSamplePositions(self, num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList1, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        self.__v.ResolveSubresourceRegion(self, dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList1, mask: UINT) void {
        self.__v.SetViewInstanceMask(self, mask);
    }
    pub const VTable = extern struct {
        const T = IGraphicsCommandList1;
        base: IGraphicsCommandList.VTable,
        AtomicCopyBufferUINT: *const fn (
            *T,
            *IResource,
            UINT64,
            *IResource,
            UINT64,
            UINT,
            [*]const *IResource,
            [*]const SUBRESOURCE_RANGE_UINT64,
        ) callconv(WINAPI) void,
        AtomicCopyBufferUINT64: *const fn (
            *T,
            *IResource,
            UINT64,
            *IResource,
            UINT64,
            UINT,
            [*]const *IResource,
            [*]const SUBRESOURCE_RANGE_UINT64,
        ) callconv(WINAPI) void,
        OMSetDepthBounds: *const fn (*T, FLOAT, FLOAT) callconv(WINAPI) void,
        SetSamplePositions: *const fn (*T, UINT, UINT, *SAMPLE_POSITION) callconv(WINAPI) void,
        ResolveSubresourceRegion: *const fn (
            *T,
            *IResource,
            UINT,
            UINT,
            UINT,
            *IResource,
            UINT,
            *RECT,
            dxgi.FORMAT,
            RESOLVE_MODE,
        ) callconv(WINAPI) void,
        SetViewInstanceMask: *const fn (*T, UINT) callconv(WINAPI) void,
    };
};

pub const WRITEBUFFERIMMEDIATE_PARAMETER = extern struct {
    Dest: GPU_VIRTUAL_ADDRESS,
    Value: UINT32,
};

pub const WRITEBUFFERIMMEDIATE_MODE = enum(UINT) {
    DEFAULT = 0,
    MARKER_IN = 0x1,
    MARKER_OUT = 0x2,
};

pub const IID_IGraphicsCommandList2 = GUID.parse("{38C3E585-FF17-412C-9150-4FC6F9D72A28}");
pub const IGraphicsCommandList2 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList2, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList1.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList2) ULONG {
        return IGraphicsCommandList1.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList2) ULONG {
        return IGraphicsCommandList1.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList2, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList1.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList2, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList1.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList2, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList1.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList2, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList1.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList2, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList1.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList2) COMMAND_LIST_TYPE {
        return IGraphicsCommandList1.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList2) HRESULT {
        return IGraphicsCommandList1.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList2, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList1.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList2, pso: ?*IPipelineState) void {
        IGraphicsCommandList1.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList2, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList1.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList2, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList1.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList2, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList1.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList2, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList1.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList2, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList1.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList2, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList1.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList2, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList1.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList2, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList1.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList2, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList1.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList2, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList1.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList2, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList1.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList2, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList1.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList2, stencil_ref: UINT) void {
        IGraphicsCommandList1.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList2, pso: *IPipelineState) void {
        IGraphicsCommandList1.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList2, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList1.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList2, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList1.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList2, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList1.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList2, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList1.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList2, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList1.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList2, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList1.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList2, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList1.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList2, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList1.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList2, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList1.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList2, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList1.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList2, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList1.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList2, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList1.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList2, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList1.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList2, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList1.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList2, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList1.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList2, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList1.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList2, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList1.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList2, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList1.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList2, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList1.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList2, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList1.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList2, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList1.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList2, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList1.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList2, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList1.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList2, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList1.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList2, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList1.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList2, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList1.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList2, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList1.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList2, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList1.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList2, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList1.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList2, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList1.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList2, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList1.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList2, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList1.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList2) void {
        IGraphicsCommandList1.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList2, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList1.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList2, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList1.AtomicCopyBufferUINT(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList2, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList1.AtomicCopyBufferUINT64(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList2, min: FLOAT, max: FLOAT) void {
        IGraphicsCommandList1.OMSetDepthBounds(@ptrCast(self), min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList2, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        IGraphicsCommandList1.SetSamplePositions(@ptrCast(self), num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList2, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        IGraphicsCommandList1.ResolveSubresourceRegion(@ptrCast(self), dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList2, mask: UINT) void {
        IGraphicsCommandList1.SetViewInstanceMask(@ptrCast(self), mask);
    }
    pub inline fn WriteBufferImmediate(self: *IGraphicsCommandList2, count: UINT, params: [*]const WRITEBUFFERIMMEDIATE_PARAMETER, modes: ?[*]const WRITEBUFFERIMMEDIATE_MODE) void {
        self.__v.WriteBufferImmediate(self, count, params, modes);
    }
    pub const VTable = extern struct {
        base: IGraphicsCommandList1.VTable,
        WriteBufferImmediate: *const fn (
            *IGraphicsCommandList2,
            UINT,
            [*]const WRITEBUFFERIMMEDIATE_PARAMETER,
            ?[*]const WRITEBUFFERIMMEDIATE_MODE,
        ) callconv(WINAPI) void,
    };
};

pub const IID_IGraphicsCommandList3 = GUID.parse("{6FDA83A7-B84C-4E38-9AC8-C7BD22016B3D}");
pub const IGraphicsCommandList3 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList3, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList2.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList3) ULONG {
        return IGraphicsCommandList2.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList3) ULONG {
        return IGraphicsCommandList2.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList3, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList2.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList3, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList2.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList3, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList2.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList3, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList2.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList3, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList2.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList3) COMMAND_LIST_TYPE {
        return IGraphicsCommandList2.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList3) HRESULT {
        return IGraphicsCommandList2.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList3, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList2.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList3, pso: ?*IPipelineState) void {
        IGraphicsCommandList2.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList3, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList2.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList3, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList2.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList3, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList2.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList3, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList2.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList3, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList2.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList3, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList2.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList3, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList2.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList3, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList2.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList3, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList2.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList3, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList2.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList3, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList2.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList3, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList2.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList3, stencil_ref: UINT) void {
        IGraphicsCommandList2.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList3, pso: *IPipelineState) void {
        IGraphicsCommandList2.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList3, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList2.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList3, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList2.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList3, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList2.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList3, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList2.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList3, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList2.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList3, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList2.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList3, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList2.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList3, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList2.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList3, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList2.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList3, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList2.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList3, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList2.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList3, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList2.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList3, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList2.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList3, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList2.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList3, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList2.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList3, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList2.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList3, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList2.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList3, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList2.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList3, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList2.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList3, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList2.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList3, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList2.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList3, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList2.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList3, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList2.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList3, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList2.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList3, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList2.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList3, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList2.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList3, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList2.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList3, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList2.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList3, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList2.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList3, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList2.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList3, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList2.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList3, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList2.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList3) void {
        IGraphicsCommandList2.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList3, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList2.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList3, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList2.AtomicCopyBufferUINT(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList3, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList2.AtomicCopyBufferUINT64(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList3, min: FLOAT, max: FLOAT) void {
        IGraphicsCommandList2.OMSetDepthBounds(@ptrCast(self), min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList3, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        IGraphicsCommandList2.SetSamplePositions(@ptrCast(self), num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList3, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        IGraphicsCommandList2.ResolveSubresourceRegion(@ptrCast(self), dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList3, mask: UINT) void {
        IGraphicsCommandList2.SetViewInstanceMask(@ptrCast(self), mask);
    }
    pub inline fn WriteBufferImmediate(self: *IGraphicsCommandList3, count: UINT, params: [*]const WRITEBUFFERIMMEDIATE_PARAMETER, modes: ?[*]const WRITEBUFFERIMMEDIATE_MODE) void {
        IGraphicsCommandList2.WriteBufferImmediate(@ptrCast(self), count, params, modes);
    }
    pub inline fn SetProtectedResourceSession(self: *IGraphicsCommandList3, prsession: ?*IProtectedResourceSession) void {
        self.__v.SetProtectedResourceSession(self, prsession);
    }
    pub const VTable = extern struct {
        base: IGraphicsCommandList2.VTable,
        SetProtectedResourceSession: *const fn (
            *IGraphicsCommandList3,
            ?*IProtectedResourceSession,
        ) callconv(WINAPI) void,
    };
};

pub const RENDER_PASS_BEGINNING_ACCESS_TYPE = enum(UINT) {
    DISCARD = 0,
    PRESERVE = 1,
    CLEAR = 2,
    NO_ACCESS = 3,
};

pub const RENDER_PASS_BEGINNING_ACCESS_CLEAR_PARAMETERS = extern struct {
    ClearValue: CLEAR_VALUE,
};

pub const RENDER_PASS_BEGINNING_ACCESS = extern struct {
    Type: RENDER_PASS_BEGINNING_ACCESS_TYPE,
    u: extern union {
        Clear: RENDER_PASS_BEGINNING_ACCESS_CLEAR_PARAMETERS,
    },
};

pub const RENDER_PASS_ENDING_ACCESS_TYPE = enum(UINT) {
    DISCARD = 0,
    PRESERVE = 1,
    RESOLVE = 2,
    NO_ACCESS = 3,
};

pub const RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS = extern struct {
    SrcSubresource: UINT,
    DstSubresource: UINT,
    DstX: UINT,
    DstY: UINT,
    SrcRect: RECT,
};

pub const RENDER_PASS_ENDING_ACCESS_RESOLVE_PARAMETERS = extern struct {
    pSrcResource: *IResource,
    pDstResource: *IResource,
    SubresourceCount: UINT,
    pSubresourceParameters: [*]const RENDER_PASS_ENDING_ACCESS_RESOLVE_SUBRESOURCE_PARAMETERS,
    Format: dxgi.FORMAT,
    ResolveMode: RESOLVE_MODE,
    PreserveResolveSource: BOOL,
};

pub const RENDER_PASS_ENDING_ACCESS = extern struct {
    Type: RENDER_PASS_ENDING_ACCESS_TYPE,
    u: extern union {
        Resolve: RENDER_PASS_ENDING_ACCESS_RESOLVE_PARAMETERS,
    },
};

pub const RENDER_PASS_RENDER_TARGET_DESC = extern struct {
    cpuDescriptor: CPU_DESCRIPTOR_HANDLE,
    BeginningAccess: RENDER_PASS_BEGINNING_ACCESS,
    EndingAccess: RENDER_PASS_ENDING_ACCESS,
};

pub const RENDER_PASS_DEPTH_STENCIL_DESC = extern struct {
    cpuDescriptor: CPU_DESCRIPTOR_HANDLE,
    DepthBeginningAccess: RENDER_PASS_BEGINNING_ACCESS,
    StencilBeginningAccess: RENDER_PASS_BEGINNING_ACCESS,
    DepthEndingAccess: RENDER_PASS_ENDING_ACCESS,
    StencilEndingAccess: RENDER_PASS_ENDING_ACCESS,
};

pub const RENDER_PASS_FLAGS = packed struct(UINT) {
    ALLOW_UAV_WRITES: bool = false,
    SUSPENDING_PASS: bool = false,
    RESUMING_PASS: bool = false,
    __unused: u29 = 0,
};

pub const META_COMMAND_PARAMETER_TYPE = enum(UINT) {
    FLOAT = 0,
    UINT64 = 1,
    GPU_VIRTUAL_ADDRESS = 2,
    CPU_DESCRIPTOR_HANDLE_HEAP_TYPE_CBV_SRV_UAV = 3,
    GPU_DESCRIPTOR_HANDLE_HEAP_TYPE_CBV_SRV_UAV = 4,
};

pub const META_COMMAND_PARAMETER_FLAGS = packed struct(UINT) {
    INPUT: bool = false,
    OUTPUT: bool = false,
    __unused: u30 = 0,
};

pub const META_COMMAND_PARAMETER_STAGE = enum(UINT) {
    CREATION = 0,
    INITIALIZATION = 1,
    EXECUTION = 2,
};

pub const META_COMMAND_PARAMETER_DESC = extern struct {
    Name: LPCWSTR,
    Type: META_COMMAND_PARAMETER_TYPE,
    Flags: META_COMMAND_PARAMETER_FLAGS,
    RequiredResourceState: RESOURCE_STATES,
    StructureOffset: UINT,
};

pub const GRAPHICS_STATES = packed struct(UINT) {
    IA_VERTEX_BUFFERS: bool = false,
    IA_INDEX_BUFFER: bool = false,
    IA_PRIMITIVE_TOPOLOGY: bool = false,
    DESCRIPTOR_HEAP: bool = false,
    GRAPHICS_ROOT_SIGNATURE: bool = false,
    COMPUTE_ROOT_SIGNATURE: bool = false,
    RS_VIEWPORTS: bool = false,
    RS_SCISSOR_RECTS: bool = false,
    PREDICATION: bool = false,
    OM_RENDER_TARGETS: bool = false,
    OM_STENCIL_REF: bool = false,
    OM_BLEND_FACTOR: bool = false,
    PIPELINE_STATE: bool = false,
    SO_TARGETS: bool = false,
    OM_DEPTH_BOUNDS: bool = false,
    SAMPLE_POSITIONS: bool = false,
    VIEW_INSTANCE_MASK: bool = false,
    __unused: u15 = 0,
};

pub const META_COMMAND_DESC = extern struct {
    Id: GUID,
    Name: LPCWSTR,
    InitializationDirtyState: GRAPHICS_STATES,
    ExecutionDirtyState: GRAPHICS_STATES,
};

pub const IMetaCommand = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IMetaCommand, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceChild.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IMetaCommand) ULONG {
        return IDeviceChild.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IMetaCommand) ULONG {
        return IDeviceChild.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IMetaCommand, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDeviceChild.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IMetaCommand, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDeviceChild.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IMetaCommand, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceChild.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IMetaCommand, name: LPCWSTR) HRESULT {
        return IDeviceChild.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IMetaCommand, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IDeviceChild.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetRequiredParameterResourceSize(self: *IMetaCommand, stage: META_COMMAND_PARAMETER_STAGE, param_index: UINT) UINT64 {
        return self.__v.GetRequiredParameterResourceSize(self, stage, param_index);
    }
    pub const VTable = extern struct {
        base: IDeviceChild.VTable,
        GetRequiredParameterResourceSize: *const fn (
            *IMetaCommand,
            META_COMMAND_PARAMETER_STAGE,
            UINT,
        ) callconv(WINAPI) UINT64,
    };
};

pub const STATE_SUBOBJECT_TYPE = enum(UINT) {
    STATE_OBJECT_CONFIG = 0,
    GLOBAL_ROOT_SIGNATURE = 1,
    LOCAL_ROOT_SIGNATURE = 2,
    NODE_MASK = 3,
    DXIL_LIBRARY = 5,
    EXISTING_COLLECTION = 6,
    SUBOBJECT_TO_EXPORTS_ASSOCIATION = 7,
    DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION = 8,
    RAYTRACING_SHADER_CONFIG = 9,
    RAYTRACING_PIPELINE_CONFIG = 10,
    HIT_GROUP = 11,
    RAYTRACING_PIPELINE_CONFIG1 = 12,
    MAX_VALID,
};

pub const STATE_SUBOBJECT = extern struct {
    Type: STATE_SUBOBJECT_TYPE,
    pDesc: *const anyopaque,
};

pub const STATE_OBJECT_FLAGS = packed struct(UINT) {
    ALLOW_LOCAL_DEPENDENCIES_ON_EXTERNAL_DEFINITIONS: bool = false,
    ALLOW_EXTERNAL_DEPENDENCIES_ON_LOCAL_DEFINITIONS: bool = false,
    ALLOW_STATE_OBJECT_ADDITIONS: bool = false,
    __unused: u29 = 0,
};

pub const STATE_OBJECT_CONFIG = extern struct {
    Flags: STATE_OBJECT_FLAGS,
};

pub const GLOBAL_ROOT_SIGNATURE = extern struct {
    pGlobalRootSignature: *IRootSignature,
};

pub const LOCAL_ROOT_SIGNATURE = extern struct {
    pLocalRootSignature: *IRootSignature,
};

pub const NODE_MASK = extern struct {
    NodeMask: UINT,
};

pub const EXPORT_FLAGS = packed struct(UINT) {
    __unused: u32 = 0,
};

pub const EXPORT_DESC = extern struct {
    Name: LPCWSTR,
    ExportToRename: LPCWSTR,
    Flags: EXPORT_FLAGS,
};

pub const DXIL_LIBRARY_DESC = extern struct {
    DXILLibrary: SHADER_BYTECODE,
    NumExports: UINT,
    pExports: ?[*]EXPORT_DESC,
};

pub const EXISTING_COLLECTION_DESC = extern struct {
    pExistingCollection: *IStateObject,
    NumExports: UINT,
    pExports: [*]EXPORT_DESC,
};

pub const SUBOBJECT_TO_EXPORTS_ASSOCIATION = extern struct {
    pSubobjectToAssociate: *const STATE_SUBOBJECT,
    NumExports: UINT,
    pExports: [*]LPCWSTR,
};

pub const DXIL_SUBOBJECT_TO_EXPORTS_ASSOCIATION = extern struct {
    SubobjectToAssociate: LPCWSTR,
    NumExports: UINT,
    pExports: [*]LPCWSTR,
};

pub const HIT_GROUP_TYPE = enum(UINT) {
    TRIANGLES = 0,
    PROCEDURAL_PRIMITIVE = 0x1,
};

pub const HIT_GROUP_DESC = extern struct {
    HitGroupExport: LPCWSTR,
    Type: HIT_GROUP_TYPE,
    AnyHitShaderImport: LPCWSTR,
    ClosestHitShaderImport: LPCWSTR,
    IntersectionShaderImport: LPCWSTR,
};

pub const RAYTRACING_SHADER_CONFIG = extern struct {
    MaxPayloadSizeInBytes: UINT,
    MaxAttributeSizeInBytes: UINT,
};

pub const RAYTRACING_PIPELINE_CONFIG = extern struct {
    MaxTraceRecursionDepth: UINT,
};

pub const RAYTRACING_PIPELINE_FLAGS = packed struct(UINT) {
    __unused0: bool = false, // 0x1
    __unused1: bool = false,
    __unused2: bool = false,
    __unused3: bool = false,
    __unused4: bool = false, // 0x10
    __unused5: bool = false,
    __unused6: bool = false,
    __unused7: bool = false,
    SKIP_TRIANGLES: bool = false, // 0x100
    SKIP_PROCEDURAL_PRIMITIVES: bool = false,
    __unused: u22 = 0,
};

pub const RAYTRACING_PIPELINE_CONFIG1 = extern struct {
    MaxTraceRecursionDepth: UINT,
    Flags: RAYTRACING_PIPELINE_FLAGS,
};

pub const STATE_OBJECT_TYPE = enum(UINT) {
    COLLECTION = 0,
    RAYTRACING_PIPELINE = 3,
};

pub const STATE_OBJECT_DESC = extern struct {
    Type: STATE_OBJECT_TYPE,
    NumSubobjects: UINT,
    pSubobjects: [*]const STATE_SUBOBJECT,
};

pub const RAYTRACING_GEOMETRY_FLAGS = packed struct(UINT) {
    OPAQUE: bool = false,
    NO_DUPLICATE_ANYHIT_INVOCATION: bool = false,
    __unused: u30 = 0,
};

pub const RAYTRACING_GEOMETRY_TYPE = enum(UINT) {
    TRIANGLES = 0,
    PROCEDURAL_PRIMITIVE_AABBS = 1,
};

pub const RAYTRACING_INSTANCE_FLAGS = packed struct(UINT) {
    TRIANGLE_CULL_DISABLE: bool = false,
    TRIANGLE_FRONT_COUNTERCLOCKWISE: bool = false,
    FORCE_OPAQUE: bool = false,
    FORCE_NON_OPAQUE: bool = false,
    __unused: u28 = 0,
};

pub const GPU_VIRTUAL_ADDRESS_AND_STRIDE = extern struct {
    StartAddress: GPU_VIRTUAL_ADDRESS,
    StrideInBytes: UINT64,
};

pub const GPU_VIRTUAL_ADDRESS_RANGE = extern struct {
    StartAddress: GPU_VIRTUAL_ADDRESS,
    SizeInBytes: UINT64,
};

pub const GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE = extern struct {
    StartAddress: GPU_VIRTUAL_ADDRESS,
    SizeInBytes: UINT64,
    StrideInBytes: UINT64,
};

pub const RAYTRACING_GEOMETRY_TRIANGLES_DESC = extern struct {
    Transform3x4: GPU_VIRTUAL_ADDRESS,
    IndexFormat: dxgi.FORMAT,
    VertexFormat: dxgi.FORMAT,
    IndexCount: UINT,
    VertexCount: UINT,
    IndexBuffer: GPU_VIRTUAL_ADDRESS,
    VertexBuffer: GPU_VIRTUAL_ADDRESS_AND_STRIDE,
};

pub const RAYTRACING_AABB = extern struct {
    MinX: FLOAT,
    MinY: FLOAT,
    MinZ: FLOAT,
    MaxX: FLOAT,
    MaxY: FLOAT,
    MaxZ: FLOAT,
};

pub const RAYTRACING_GEOMETRY_AABBS_DESC = extern struct {
    AABBCount: UINT64,
    AABBs: GPU_VIRTUAL_ADDRESS_AND_STRIDE,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS = packed struct(UINT) {
    ALLOW_UPDATE: bool = false,
    ALLOW_COMPACTION: bool = false,
    PREFER_FAST_TRACE: bool = false,
    PREFER_FAST_BUILD: bool = false,
    MINIMIZE_MEMORY: bool = false,
    PERFORM_UPDATE: bool = false,
    __unused: u26 = 0,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE = enum(UINT) {
    CLONE = 0,
    COMPACT = 0x1,
    VISUALIZATION_DECODE_FOR_TOOLS = 0x2,
    SERIALIZE = 0x3,
    DESERIALIZE = 0x4,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_TYPE = enum(UINT) {
    TOP_LEVEL = 0,
    BOTTOM_LEVEL = 0x1,
};

pub const ELEMENTS_LAYOUT = enum(UINT) {
    ARRAY = 0,
    ARRAY_OF_POINTERS = 0x1,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TYPE = enum(UINT) {
    COMPACTED_SIZE = 0,
    TOOLS_VISUALIZATION = 0x1,
    SERIALIZATION = 0x2,
    CURRENT_SIZE = 0x3,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC = extern struct {
    DestBuffer: GPU_VIRTUAL_ADDRESS,
    InfoType: RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TYPE,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_COMPACTED_SIZE_DESC = extern struct {
    CompactedSizeInBytes: UINT64,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_TOOLS_VISUALIZATION_DESC = extern struct {
    DecodedSizeInBytes: UINT64,
};

pub const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_TOOLS_VISUALIZATION_HEADER = extern struct {
    Type: RAYTRACING_ACCELERATION_STRUCTURE_TYPE,
    NumDescs: UINT,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_SERIALIZATION_DESC = extern struct {
    SerializedSizeInBytes: UINT64,
    NumBottomLevelAccelerationStructurePointers: UINT64,
};

pub const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER = extern struct {
    DriverOpaqueGUID: GUID,
    DriverOpaqueVersioningData: [16]BYTE,
};

pub const SERIALIZED_DATA_TYPE = enum(UINT) {
    RAYTRACING_ACCELERATION_STRUCTURE = 0,
};

pub const DRIVER_MATCHING_IDENTIFIER_STATUS = enum(UINT) {
    COMPATIBLE_WITH_DEVICE = 0,
    UNSUPPORTED_TYPE = 0x1,
    UNRECOGNIZED = 0x2,
    INCOMPATIBLE_VERSION = 0x3,
    INCOMPATIBLE_TYPE = 0x4,
};

pub const SERIALIZED_RAYTRACING_ACCELERATION_STRUCTURE_HEADER = extern struct {
    DriverMatchingIdentifier: SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER,
    SerializedSizeInBytesIncludingHeader: UINT64,
    DeserializedSizeInBytes: UINT64,
    NumBottomLevelAccelerationStructurePointersAfterHeader: UINT64,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_CURRENT_SIZE_DESC = extern struct {
    CurrentSizeInBytes: UINT64,
};

pub const RAYTRACING_INSTANCE_DESC = extern struct {
    Transform: [3][4]FLOAT align(16),
    p: packed struct(u64) {
        InstanceID: u24,
        InstanceMask: u8,
        InstanceContributionToHitGroupIndex: u24,
        Flags: u8,
    },
    AccelerationStructure: GPU_VIRTUAL_ADDRESS,
};
comptime {
    std.debug.assert(@sizeOf(RAYTRACING_INSTANCE_DESC) == 64);
    std.debug.assert(@alignOf(RAYTRACING_INSTANCE_DESC) == 16);
}

pub const RAYTRACING_GEOMETRY_DESC = extern struct {
    Type: RAYTRACING_GEOMETRY_TYPE,
    Flags: RAYTRACING_GEOMETRY_FLAGS,
    u: extern union {
        Triangles: RAYTRACING_GEOMETRY_TRIANGLES_DESC,
        AABBs: RAYTRACING_GEOMETRY_AABBS_DESC,
    },
};

pub const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS = extern struct {
    Type: RAYTRACING_ACCELERATION_STRUCTURE_TYPE,
    Flags: RAYTRACING_ACCELERATION_STRUCTURE_BUILD_FLAGS,
    NumDescs: UINT,
    DescsLayout: ELEMENTS_LAYOUT,
    u: extern union {
        InstanceDescs: GPU_VIRTUAL_ADDRESS,
        pGeometryDescs: [*]const RAYTRACING_GEOMETRY_DESC,
        ppGeometryDescs: [*]const *RAYTRACING_GEOMETRY_DESC,
    },
};

pub const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC = extern struct {
    DestAccelerationStructureData: GPU_VIRTUAL_ADDRESS,
    Inputs: BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS,
    SourceAccelerationStructureData: GPU_VIRTUAL_ADDRESS,
    ScratchAccelerationStructureData: GPU_VIRTUAL_ADDRESS,
};

pub const RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO = extern struct {
    ResultDataMaxSizeInBytes: UINT64,
    ScratchDataSizeInBytes: UINT64,
    UpdateScratchDataSizeInBytes: UINT64,
};

pub const IID_IStateObject = GUID.parse("{47016943-fca8-4594-93ea-af258b55346d}");
pub const IStateObject = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IStateObject, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceChild.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IStateObject) ULONG {
        return IDeviceChild.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IStateObject) ULONG {
        return IDeviceChild.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IStateObject, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDeviceChild.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IStateObject, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDeviceChild.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IStateObject, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceChild.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IStateObject, name: LPCWSTR) HRESULT {
        return IDeviceChild.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IStateObject, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IDeviceChild.GetDevice(@ptrCast(self), guid, device);
    }
    pub const VTable = extern struct {
        base: IDeviceChild.VTable,
    };
};

pub const IID_IStateObjectProperties = GUID.parse("{de5fa827-9bf9-4f26-89ff-d7f56fde3860}");
pub const IStateObjectProperties = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IStateObjectProperties, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IStateObjectProperties) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IStateObjectProperties) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn GetShaderIdentifier(self: *IStateObjectProperties, export_name: LPCWSTR) *anyopaque {
        return self.__v.GetShaderIdentifier(self, export_name);
    }
    pub inline fn GetShaderStackSize(self: *IStateObjectProperties, export_name: LPCWSTR) UINT64 {
        return self.__v.GetShaderStackSize(self, export_name);
    }
    pub inline fn GetPipelineStackSize(self: *IStateObjectProperties) UINT64 {
        return self.__v.GetPipelineStackSize(self);
    }
    pub inline fn SetPipelineStackSize(self: *IStateObjectProperties, stack_size: UINT64) void {
        self.__v.SetPipelineStackSize(self, stack_size);
    }
    pub const VTable = extern struct {
        const T = IStateObjectProperties;
        base: IUnknown.VTable,
        GetShaderIdentifier: *const fn (*T, LPCWSTR) callconv(WINAPI) *anyopaque,
        GetShaderStackSize: *const fn (*T, LPCWSTR) callconv(WINAPI) UINT64,
        GetPipelineStackSize: *const fn (*T) callconv(WINAPI) UINT64,
        SetPipelineStackSize: *const fn (*T, UINT64) callconv(WINAPI) void,
    };
};

pub const DISPATCH_RAYS_DESC = extern struct {
    RayGenerationShaderRecord: GPU_VIRTUAL_ADDRESS_RANGE,
    MissShaderTable: GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE,
    HitGroupTable: GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE,
    CallableShaderTable: GPU_VIRTUAL_ADDRESS_RANGE_AND_STRIDE,
    Width: UINT,
    Height: UINT,
    Depth: UINT,
};

pub const IID_IGraphicsCommandList4 = GUID.parse("{8754318e-d3a9-4541-98cf-645b50dc4874}");
pub const IGraphicsCommandList4 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList4, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList3.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList4) ULONG {
        return IGraphicsCommandList3.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList4) ULONG {
        return IGraphicsCommandList3.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList4, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList3.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList4, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList3.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList4, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList3.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList4, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList3.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList4, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList3.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList4) COMMAND_LIST_TYPE {
        return IGraphicsCommandList3.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList4) HRESULT {
        return IGraphicsCommandList3.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList4, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList3.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList4, pso: ?*IPipelineState) void {
        IGraphicsCommandList3.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList4, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList3.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList4, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList3.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList4, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList3.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList4, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList3.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList4, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList3.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList4, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList3.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList4, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList3.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList4, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList3.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList4, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList3.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList4, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList3.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList4, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList3.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList4, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList3.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList4, stencil_ref: UINT) void {
        IGraphicsCommandList3.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList4, pso: *IPipelineState) void {
        IGraphicsCommandList3.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList4, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList3.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList4, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList3.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList4, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList3.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList4, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList3.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList4, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList3.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList4, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList3.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList4, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList3.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList4, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList3.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList4, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList3.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList4, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList3.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList4, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList3.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList4, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList3.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList4, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList3.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList4, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList3.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList4, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList3.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList4, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList3.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList4, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList3.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList4, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList3.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList4, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList3.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList4, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList3.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList4, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList3.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList4, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList3.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList4, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList3.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList4, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList3.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList4, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList3.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList4, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList3.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList4, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList3.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList4, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList3.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList4, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList3.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList4, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList3.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList4, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList3.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList4, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList3.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList4) void {
        IGraphicsCommandList3.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList4, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList3.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList4, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList3.AtomicCopyBufferUINT(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList4, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList3.AtomicCopyBufferUINT64(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList4, min: FLOAT, max: FLOAT) void {
        IGraphicsCommandList3.OMSetDepthBounds(@ptrCast(self), min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList4, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        IGraphicsCommandList3.SetSamplePositions(@ptrCast(self), num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList4, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        IGraphicsCommandList3.ResolveSubresourceRegion(@ptrCast(self), dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList4, mask: UINT) void {
        IGraphicsCommandList3.SetViewInstanceMask(@ptrCast(self), mask);
    }
    pub inline fn WriteBufferImmediate(self: *IGraphicsCommandList4, count: UINT, params: [*]const WRITEBUFFERIMMEDIATE_PARAMETER, modes: ?[*]const WRITEBUFFERIMMEDIATE_MODE) void {
        IGraphicsCommandList3.WriteBufferImmediate(@ptrCast(self), count, params, modes);
    }
    pub inline fn SetProtectedResourceSession(self: *IGraphicsCommandList4, prsession: ?*IProtectedResourceSession) void {
        IGraphicsCommandList3.SetProtectedResourceSession(@ptrCast(self), prsession);
    }
    pub inline fn BeginRenderPass(self: *IGraphicsCommandList4, num_render_targets: UINT, render_targets: ?[*]const RENDER_PASS_RENDER_TARGET_DESC, depth_stencil: ?*const RENDER_PASS_DEPTH_STENCIL_DESC, flags: RENDER_PASS_FLAGS) void {
        self.__v.BeginRenderPass(self, num_render_targets, render_targets, depth_stencil, flags);
    }
    pub inline fn EndRenderPass(self: *IGraphicsCommandList4) void {
        self.__v.EndRenderPass(self);
    }
    pub inline fn InitializeMetaCommand(self: *IGraphicsCommandList4, meta_cmd: *IMetaCommand, init_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        self.__v.InitializeMetaCommand(self, meta_cmd, init_param_data, data_size);
    }
    pub inline fn ExecuteMetaCommand(self: *IGraphicsCommandList4, meta_cmd: *IMetaCommand, exe_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        self.__v.ExecuteMetaCommand(self, meta_cmd, exe_param_data, data_size);
    }
    pub inline fn BuildRaytracingAccelerationStructure(self: *IGraphicsCommandList4, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC, num_post_build_descs: UINT, post_build_descs: ?[*]const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC) void {
        self.__v.BuildRaytracingAccelerationStructure(self, desc, num_post_build_descs, post_build_descs);
    }
    pub inline fn EmitRaytracingAccelerationStructurePostbuildInfo(self: *IGraphicsCommandList4, desc: *const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC, num_src_accel_structs: UINT, src_accel_struct_data: [*]const GPU_VIRTUAL_ADDRESS) void {
        self.__v.EmitRaytracingAccelerationStructurePostbuildInfo(self, desc, num_src_accel_structs, src_accel_struct_data);
    }
    pub inline fn CopyRaytracingAccelerationStructure(self: *IGraphicsCommandList4, dst_data: GPU_VIRTUAL_ADDRESS, src_data: GPU_VIRTUAL_ADDRESS, mode: RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE) void {
        self.__v.CopyRaytracingAccelerationStructure(self, dst_data, src_data, mode);
    }
    pub inline fn SetPipelineState1(self: *IGraphicsCommandList4, state_obj: *IStateObject) void {
        self.__v.SetPipelineState1(self, state_obj);
    }
    pub inline fn DispatchRays(self: *IGraphicsCommandList4, desc: *const DISPATCH_RAYS_DESC) void {
        self.__v.DispatchRays(self, desc);
    }
    pub const VTable = extern struct {
        const T = IGraphicsCommandList4;
        base: IGraphicsCommandList3.VTable,
        BeginRenderPass: *const fn (*T, UINT, ?[*]const RENDER_PASS_RENDER_TARGET_DESC, ?*const RENDER_PASS_DEPTH_STENCIL_DESC, RENDER_PASS_FLAGS) callconv(WINAPI) void,
        EndRenderPass: *const fn (*T) callconv(WINAPI) void,
        InitializeMetaCommand: *const fn (*T, *IMetaCommand, ?*const anyopaque, SIZE_T) callconv(WINAPI) void,
        ExecuteMetaCommand: *const fn (*T, *IMetaCommand, ?*const anyopaque, SIZE_T) callconv(WINAPI) void,
        BuildRaytracingAccelerationStructure: *const fn (*T, *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC, UINT, ?[*]const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC) callconv(WINAPI) void,
        EmitRaytracingAccelerationStructurePostbuildInfo: *const fn (*T, *const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC, UINT, [*]const GPU_VIRTUAL_ADDRESS) callconv(WINAPI) void,
        CopyRaytracingAccelerationStructure: *const fn (*T, GPU_VIRTUAL_ADDRESS, GPU_VIRTUAL_ADDRESS, RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE) callconv(WINAPI) void,
        SetPipelineState1: *const fn (*T, *IStateObject) callconv(WINAPI) void,
        DispatchRays: *const fn (*T, *const DISPATCH_RAYS_DESC) callconv(WINAPI) void,
    };
};

pub const RS_SET_SHADING_RATE_COMBINER_COUNT = 2;

pub const SHADING_RATE = enum(UINT) {
    @"1X1" = 0,
    @"1X2" = 0x1,
    @"2X1" = 0x4,
    @"2X2" = 0x5,
    @"2X4" = 0x6,
    @"4X2" = 0x9,
    @"4X4" = 0xa,
};

pub const SHADING_RATE_COMBINER = enum(UINT) {
    PASSTHROUGH = 0,
    OVERRIDE = 1,
    COMBINER_MIN = 2,
    COMBINER_MAX = 3,
    COMBINER_SUM = 4,
};

pub const IID_IGraphicsCommandList5 = GUID.parse("{55050859-4024-474c-87f5-6472eaee44ea}");
pub const IGraphicsCommandList5 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList5, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList4.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList5) ULONG {
        return IGraphicsCommandList4.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList5) ULONG {
        return IGraphicsCommandList4.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList5, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList4.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList5, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList4.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList5, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList4.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList5, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList4.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList5, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList4.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList5) COMMAND_LIST_TYPE {
        return IGraphicsCommandList4.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList5) HRESULT {
        return IGraphicsCommandList4.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList5, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList4.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList5, pso: ?*IPipelineState) void {
        IGraphicsCommandList4.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList5, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList4.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList5, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList4.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList5, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList4.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList5, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList4.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList5, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList4.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList5, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList4.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList5, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList4.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList5, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList4.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList5, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList4.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList5, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList4.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList5, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList4.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList5, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList4.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList5, stencil_ref: UINT) void {
        IGraphicsCommandList4.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList5, pso: *IPipelineState) void {
        IGraphicsCommandList4.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList5, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList4.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList5, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList4.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList5, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList4.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList5, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList4.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList5, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList4.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList5, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList4.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList5, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList4.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList5, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList4.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList5, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList4.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList5, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList4.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList5, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList4.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList5, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList4.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList5, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList4.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList5, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList4.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList5, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList4.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList5, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList4.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList5, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList4.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList5, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList4.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList5, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList4.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList5, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList4.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList5, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList4.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList5, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList4.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList5, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList4.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList5, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList4.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList5, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList4.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList5, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList4.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList5, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList4.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList5, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList4.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList5, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList4.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList5, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList4.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList5, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList4.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList5, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList4.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList5) void {
        IGraphicsCommandList4.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList5, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList4.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList5, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList4.AtomicCopyBufferUINT(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList5, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList4.AtomicCopyBufferUINT64(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList5, min: FLOAT, max: FLOAT) void {
        IGraphicsCommandList4.OMSetDepthBounds(@ptrCast(self), min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList5, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        IGraphicsCommandList4.SetSamplePositions(@ptrCast(self), num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList5, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        IGraphicsCommandList4.ResolveSubresourceRegion(@ptrCast(self), dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList5, mask: UINT) void {
        IGraphicsCommandList4.SetViewInstanceMask(@ptrCast(self), mask);
    }
    pub inline fn WriteBufferImmediate(self: *IGraphicsCommandList5, count: UINT, params: [*]const WRITEBUFFERIMMEDIATE_PARAMETER, modes: ?[*]const WRITEBUFFERIMMEDIATE_MODE) void {
        IGraphicsCommandList4.WriteBufferImmediate(@ptrCast(self), count, params, modes);
    }
    pub inline fn SetProtectedResourceSession(self: *IGraphicsCommandList5, prsession: ?*IProtectedResourceSession) void {
        IGraphicsCommandList4.SetProtectedResourceSession(@ptrCast(self), prsession);
    }
    pub inline fn BeginRenderPass(self: *IGraphicsCommandList5, num_render_targets: UINT, render_targets: ?[*]const RENDER_PASS_RENDER_TARGET_DESC, depth_stencil: ?*const RENDER_PASS_DEPTH_STENCIL_DESC, flags: RENDER_PASS_FLAGS) void {
        IGraphicsCommandList4.BeginRenderPass(@ptrCast(self), num_render_targets, render_targets, depth_stencil, flags);
    }
    pub inline fn EndRenderPass(self: *IGraphicsCommandList5) void {
        IGraphicsCommandList4.EndRenderPass(@ptrCast(self));
    }
    pub inline fn InitializeMetaCommand(self: *IGraphicsCommandList5, meta_cmd: *IMetaCommand, init_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList4.InitializeMetaCommand(@ptrCast(self), meta_cmd, init_param_data, data_size);
    }
    pub inline fn ExecuteMetaCommand(self: *IGraphicsCommandList5, meta_cmd: *IMetaCommand, exe_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList4.ExecuteMetaCommand(@ptrCast(self), meta_cmd, exe_param_data, data_size);
    }
    pub inline fn BuildRaytracingAccelerationStructure(self: *IGraphicsCommandList5, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC, num_post_build_descs: UINT, post_build_descs: ?[*]const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC) void {
        IGraphicsCommandList4.BuildRaytracingAccelerationStructure(@ptrCast(self), desc, num_post_build_descs, post_build_descs);
    }
    pub inline fn EmitRaytracingAccelerationStructurePostbuildInfo(self: *IGraphicsCommandList5, desc: *const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC, num_src_accel_structs: UINT, src_accel_struct_data: [*]const GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList4.EmitRaytracingAccelerationStructurePostbuildInfo(@ptrCast(self), desc, num_src_accel_structs, src_accel_struct_data);
    }
    pub inline fn CopyRaytracingAccelerationStructure(self: *IGraphicsCommandList5, dst_data: GPU_VIRTUAL_ADDRESS, src_data: GPU_VIRTUAL_ADDRESS, mode: RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE) void {
        IGraphicsCommandList4.CopyRaytracingAccelerationStructure(@ptrCast(self), dst_data, src_data, mode);
    }
    pub inline fn SetPipelineState1(self: *IGraphicsCommandList5, state_obj: *IStateObject) void {
        IGraphicsCommandList4.SetPipelineState1(@ptrCast(self), state_obj);
    }
    pub inline fn DispatchRays(self: *IGraphicsCommandList5, desc: *const DISPATCH_RAYS_DESC) void {
        IGraphicsCommandList4.DispatchRays(@ptrCast(self), desc);
    }
    pub inline fn RSSetShadingRate(self: *IGraphicsCommandList5, base_shading_rate: SHADING_RATE, combiners: ?*const [RS_SET_SHADING_RATE_COMBINER_COUNT]SHADING_RATE_COMBINER) void {
        self.__v.RSSetShadingRate(self, base_shading_rate, combiners);
    }
    pub inline fn RSSetShadingRateImage(self: *IGraphicsCommandList5, shading_rate_img: ?*IResource) void {
        self.__v.RSSetShadingRateImage(self, shading_rate_img);
    }
    pub const VTable = extern struct {
        base: IGraphicsCommandList4.VTable,
        RSSetShadingRate: *const fn (
            *IGraphicsCommandList5,
            SHADING_RATE,
            ?*const [RS_SET_SHADING_RATE_COMBINER_COUNT]SHADING_RATE_COMBINER,
        ) callconv(WINAPI) void,
        RSSetShadingRateImage: *const fn (*IGraphicsCommandList5, ?*IResource) callconv(WINAPI) void,
    };
};

pub const IID_IGraphicsCommandList6 = GUID.parse("{c3827890-e548-4cfa-96cf-5689a9370f80}");
pub const IGraphicsCommandList6 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList6, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList5.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList6) ULONG {
        return IGraphicsCommandList5.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList6) ULONG {
        return IGraphicsCommandList5.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList6, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList5.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList6, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList5.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList6, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList5.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList6, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList5.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList6, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList5.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList6) COMMAND_LIST_TYPE {
        return IGraphicsCommandList5.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList6) HRESULT {
        return IGraphicsCommandList5.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList6, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList5.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList6, pso: ?*IPipelineState) void {
        IGraphicsCommandList5.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList6, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList5.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList6, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList5.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList6, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList5.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList6, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList5.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList6, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList5.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList6, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList5.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList6, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList5.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList6, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList5.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList6, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList5.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList6, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList5.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList6, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList5.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList6, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList5.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList6, stencil_ref: UINT) void {
        IGraphicsCommandList5.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList6, pso: *IPipelineState) void {
        IGraphicsCommandList5.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList6, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList5.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList6, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList5.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList6, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList5.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList6, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList5.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList6, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList5.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList6, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList5.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList6, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList5.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList6, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList5.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList6, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList5.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList6, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList5.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList6, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList5.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList6, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList5.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList6, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList5.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList6, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList5.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList6, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList5.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList6, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList5.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList6, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList5.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList6, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList5.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList6, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList5.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList6, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList5.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList6, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList5.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList6, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList5.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList6, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList5.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList6, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList5.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList6, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList5.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList6, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList5.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList6, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList5.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList6, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList5.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList6, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList5.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList6, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList5.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList6, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList5.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList6, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList5.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList6) void {
        IGraphicsCommandList5.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList6, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList5.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList6, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList5.AtomicCopyBufferUINT(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList6, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList5.AtomicCopyBufferUINT64(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList6, min: FLOAT, max: FLOAT) void {
        IGraphicsCommandList5.OMSetDepthBounds(@ptrCast(self), min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList6, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        IGraphicsCommandList5.SetSamplePositions(@ptrCast(self), num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList6, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        IGraphicsCommandList5.ResolveSubresourceRegion(@ptrCast(self), dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList6, mask: UINT) void {
        IGraphicsCommandList5.SetViewInstanceMask(@ptrCast(self), mask);
    }
    pub inline fn WriteBufferImmediate(self: *IGraphicsCommandList6, count: UINT, params: [*]const WRITEBUFFERIMMEDIATE_PARAMETER, modes: ?[*]const WRITEBUFFERIMMEDIATE_MODE) void {
        IGraphicsCommandList5.WriteBufferImmediate(@ptrCast(self), count, params, modes);
    }
    pub inline fn SetProtectedResourceSession(self: *IGraphicsCommandList6, prsession: ?*IProtectedResourceSession) void {
        IGraphicsCommandList5.SetProtectedResourceSession(@ptrCast(self), prsession);
    }
    pub inline fn BeginRenderPass(self: *IGraphicsCommandList6, num_render_targets: UINT, render_targets: ?[*]const RENDER_PASS_RENDER_TARGET_DESC, depth_stencil: ?*const RENDER_PASS_DEPTH_STENCIL_DESC, flags: RENDER_PASS_FLAGS) void {
        IGraphicsCommandList5.BeginRenderPass(@ptrCast(self), num_render_targets, render_targets, depth_stencil, flags);
    }
    pub inline fn EndRenderPass(self: *IGraphicsCommandList6) void {
        IGraphicsCommandList5.EndRenderPass(@ptrCast(self));
    }
    pub inline fn InitializeMetaCommand(self: *IGraphicsCommandList6, meta_cmd: *IMetaCommand, init_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList5.InitializeMetaCommand(@ptrCast(self), meta_cmd, init_param_data, data_size);
    }
    pub inline fn ExecuteMetaCommand(self: *IGraphicsCommandList6, meta_cmd: *IMetaCommand, exe_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList5.ExecuteMetaCommand(@ptrCast(self), meta_cmd, exe_param_data, data_size);
    }
    pub inline fn BuildRaytracingAccelerationStructure(self: *IGraphicsCommandList6, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC, num_post_build_descs: UINT, post_build_descs: ?[*]const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC) void {
        IGraphicsCommandList5.BuildRaytracingAccelerationStructure(@ptrCast(self), desc, num_post_build_descs, post_build_descs);
    }
    pub inline fn EmitRaytracingAccelerationStructurePostbuildInfo(self: *IGraphicsCommandList6, desc: *const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC, num_src_accel_structs: UINT, src_accel_struct_data: [*]const GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList5.EmitRaytracingAccelerationStructurePostbuildInfo(@ptrCast(self), desc, num_src_accel_structs, src_accel_struct_data);
    }
    pub inline fn CopyRaytracingAccelerationStructure(self: *IGraphicsCommandList6, dst_data: GPU_VIRTUAL_ADDRESS, src_data: GPU_VIRTUAL_ADDRESS, mode: RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE) void {
        IGraphicsCommandList5.CopyRaytracingAccelerationStructure(@ptrCast(self), dst_data, src_data, mode);
    }
    pub inline fn SetPipelineState1(self: *IGraphicsCommandList6, state_obj: *IStateObject) void {
        IGraphicsCommandList5.SetPipelineState1(@ptrCast(self), state_obj);
    }
    pub inline fn DispatchRays(self: *IGraphicsCommandList6, desc: *const DISPATCH_RAYS_DESC) void {
        IGraphicsCommandList5.DispatchRays(@ptrCast(self), desc);
    }
    pub inline fn RSSetShadingRate(self: *IGraphicsCommandList6, base_shading_rate: SHADING_RATE, combiners: ?*const [RS_SET_SHADING_RATE_COMBINER_COUNT]SHADING_RATE_COMBINER) void {
        IGraphicsCommandList5.RSSetShadingRate(@ptrCast(self), base_shading_rate, combiners);
    }
    pub inline fn RSSetShadingRateImage(self: *IGraphicsCommandList6, shading_rate_img: ?*IResource) void {
        IGraphicsCommandList5.RSSetShadingRateImage(@ptrCast(self), shading_rate_img);
    }
    pub inline fn DispatchMesh(self: *IGraphicsCommandList6, thread_group_count_x: UINT, thread_group_count_y: UINT, thread_group_count_z: UINT) void {
        self.__v.DispatchMesh(self, thread_group_count_x, thread_group_count_y, thread_group_count_z);
    }
    pub const VTable = extern struct {
        base: IGraphicsCommandList5.VTable,
        DispatchMesh: *const fn (*IGraphicsCommandList6, UINT, UINT, UINT) callconv(WINAPI) void,
    };
};

pub const IID_IGraphicsCommandList7 = GUID.parse("{dd171223-8b61-4769-90e3-160ccde4e2c1}");
pub const IGraphicsCommandList7 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList7, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList6.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList7) ULONG {
        return IGraphicsCommandList6.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList7) ULONG {
        return IGraphicsCommandList6.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList7, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList6.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList7, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList6.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList7, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList6.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList7, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList6.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList7, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList6.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList7) COMMAND_LIST_TYPE {
        return IGraphicsCommandList6.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList7) HRESULT {
        return IGraphicsCommandList6.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList7, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList6.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList7, pso: ?*IPipelineState) void {
        IGraphicsCommandList6.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList7, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList6.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList7, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList6.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList7, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList6.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList7, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList6.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList7, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList6.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList7, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList6.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList7, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList6.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList7, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList6.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList7, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList6.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList7, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList6.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList7, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList6.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList7, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList6.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList7, stencil_ref: UINT) void {
        IGraphicsCommandList6.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList7, pso: *IPipelineState) void {
        IGraphicsCommandList6.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList7, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList6.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList7, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList6.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList7, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList6.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList7, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList6.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList7, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList6.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList7, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList6.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList7, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList6.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList7, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList6.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList7, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList6.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList7, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList6.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList7, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList6.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList7, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList6.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList7, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList6.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList7, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList6.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList7, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList6.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList7, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList6.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList7, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList6.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList7, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList6.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList7, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList6.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList7, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList6.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList7, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList6.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList7, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList6.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList7, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList6.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList7, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList6.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList7, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList6.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList7, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList6.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList7, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList6.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList7, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList6.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList7, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList6.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList7, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList6.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList7, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList6.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList7, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList6.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList7) void {
        IGraphicsCommandList6.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList7, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList6.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList7, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList6.AtomicCopyBufferUINT(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList7, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList6.AtomicCopyBufferUINT64(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList7, min: FLOAT, max: FLOAT) void {
        IGraphicsCommandList6.OMSetDepthBounds(@ptrCast(self), min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList7, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        IGraphicsCommandList6.SetSamplePositions(@ptrCast(self), num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList7, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        IGraphicsCommandList6.ResolveSubresourceRegion(@ptrCast(self), dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList7, mask: UINT) void {
        IGraphicsCommandList6.SetViewInstanceMask(@ptrCast(self), mask);
    }
    pub inline fn WriteBufferImmediate(self: *IGraphicsCommandList7, count: UINT, params: [*]const WRITEBUFFERIMMEDIATE_PARAMETER, modes: ?[*]const WRITEBUFFERIMMEDIATE_MODE) void {
        IGraphicsCommandList6.WriteBufferImmediate(@ptrCast(self), count, params, modes);
    }
    pub inline fn SetProtectedResourceSession(self: *IGraphicsCommandList7, prsession: ?*IProtectedResourceSession) void {
        IGraphicsCommandList6.SetProtectedResourceSession(@ptrCast(self), prsession);
    }
    pub inline fn BeginRenderPass(self: *IGraphicsCommandList7, num_render_targets: UINT, render_targets: ?[*]const RENDER_PASS_RENDER_TARGET_DESC, depth_stencil: ?*const RENDER_PASS_DEPTH_STENCIL_DESC, flags: RENDER_PASS_FLAGS) void {
        IGraphicsCommandList6.BeginRenderPass(@ptrCast(self), num_render_targets, render_targets, depth_stencil, flags);
    }
    pub inline fn EndRenderPass(self: *IGraphicsCommandList7) void {
        IGraphicsCommandList6.EndRenderPass(@ptrCast(self));
    }
    pub inline fn InitializeMetaCommand(self: *IGraphicsCommandList7, meta_cmd: *IMetaCommand, init_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList6.InitializeMetaCommand(@ptrCast(self), meta_cmd, init_param_data, data_size);
    }
    pub inline fn ExecuteMetaCommand(self: *IGraphicsCommandList7, meta_cmd: *IMetaCommand, exe_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList6.ExecuteMetaCommand(@ptrCast(self), meta_cmd, exe_param_data, data_size);
    }
    pub inline fn BuildRaytracingAccelerationStructure(self: *IGraphicsCommandList7, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC, num_post_build_descs: UINT, post_build_descs: ?[*]const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC) void {
        IGraphicsCommandList6.BuildRaytracingAccelerationStructure(@ptrCast(self), desc, num_post_build_descs, post_build_descs);
    }
    pub inline fn EmitRaytracingAccelerationStructurePostbuildInfo(self: *IGraphicsCommandList7, desc: *const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC, num_src_accel_structs: UINT, src_accel_struct_data: [*]const GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList6.EmitRaytracingAccelerationStructurePostbuildInfo(@ptrCast(self), desc, num_src_accel_structs, src_accel_struct_data);
    }
    pub inline fn CopyRaytracingAccelerationStructure(self: *IGraphicsCommandList7, dst_data: GPU_VIRTUAL_ADDRESS, src_data: GPU_VIRTUAL_ADDRESS, mode: RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE) void {
        IGraphicsCommandList6.CopyRaytracingAccelerationStructure(@ptrCast(self), dst_data, src_data, mode);
    }
    pub inline fn SetPipelineState1(self: *IGraphicsCommandList7, state_obj: *IStateObject) void {
        IGraphicsCommandList6.SetPipelineState1(@ptrCast(self), state_obj);
    }
    pub inline fn DispatchRays(self: *IGraphicsCommandList7, desc: *const DISPATCH_RAYS_DESC) void {
        IGraphicsCommandList6.DispatchRays(@ptrCast(self), desc);
    }
    pub inline fn RSSetShadingRate(self: *IGraphicsCommandList7, base_shading_rate: SHADING_RATE, combiners: ?*const [RS_SET_SHADING_RATE_COMBINER_COUNT]SHADING_RATE_COMBINER) void {
        IGraphicsCommandList6.RSSetShadingRate(@ptrCast(self), base_shading_rate, combiners);
    }
    pub inline fn RSSetShadingRateImage(self: *IGraphicsCommandList7, shading_rate_img: ?*IResource) void {
        IGraphicsCommandList6.RSSetShadingRateImage(@ptrCast(self), shading_rate_img);
    }
    pub inline fn DispatchMesh(self: *IGraphicsCommandList7, thread_group_count_x: UINT, thread_group_count_y: UINT, thread_group_count_z: UINT) void {
        IGraphicsCommandList6.DispatchMesh(@ptrCast(self), thread_group_count_x, thread_group_count_y, thread_group_count_z);
    }
    pub inline fn Barrier(self: *IGraphicsCommandList7, num_barrier_groups: UINT32, barrier_groups: [*]const BARRIER_GROUP) void {
        self.__v.Barrier(self, num_barrier_groups, barrier_groups);
    }
    pub const VTable = extern struct {
        base: IGraphicsCommandList6.VTable,
        Barrier: *const fn (*IGraphicsCommandList7, UINT32, [*]const BARRIER_GROUP) callconv(WINAPI) void,
    };
};

pub const IID_IGraphicsCommandList8 = GUID.parse("{ee936ef9-599d-4d28-938e-23c4ad05ce51}");
pub const IGraphicsCommandList8 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList8, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList7.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList8) ULONG {
        return IGraphicsCommandList7.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList8) ULONG {
        return IGraphicsCommandList7.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList8, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList7.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList8, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList7.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList8, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList7.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList8, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList7.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList8, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList7.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList8) COMMAND_LIST_TYPE {
        return IGraphicsCommandList7.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList8) HRESULT {
        return IGraphicsCommandList7.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList8, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList7.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList8, pso: ?*IPipelineState) void {
        IGraphicsCommandList7.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList8, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList7.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList8, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList7.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList8, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList7.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList8, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList7.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList8, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList7.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList8, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList7.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList8, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList7.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList8, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList7.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList8, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList7.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList8, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList7.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList8, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList7.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList8, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList7.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList8, stencil_ref: UINT) void {
        IGraphicsCommandList7.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList8, pso: *IPipelineState) void {
        IGraphicsCommandList7.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList8, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList7.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList8, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList7.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList8, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList7.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList8, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList7.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList8, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList7.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList8, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList7.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList8, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList7.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList8, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList7.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList8, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList7.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList8, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList7.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList8, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList7.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList8, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList7.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList8, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList7.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList8, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList7.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList8, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList7.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList8, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList7.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList8, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList7.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList8, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList7.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList8, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList7.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList8, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList7.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList8, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList7.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList8, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList7.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList8, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList7.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList8, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList7.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList8, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList7.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList8, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList7.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList8, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList7.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList8, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList7.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList8, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList7.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList8, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList7.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList8, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList7.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList8, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList7.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList8) void {
        IGraphicsCommandList7.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList8, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList7.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList8, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList7.AtomicCopyBufferUINT(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList8, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList7.AtomicCopyBufferUINT64(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList8, min: FLOAT, max: FLOAT) void {
        IGraphicsCommandList7.OMSetDepthBounds(@ptrCast(self), min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList8, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        IGraphicsCommandList7.SetSamplePositions(@ptrCast(self), num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList8, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        IGraphicsCommandList7.ResolveSubresourceRegion(@ptrCast(self), dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList8, mask: UINT) void {
        IGraphicsCommandList7.SetViewInstanceMask(@ptrCast(self), mask);
    }
    pub inline fn WriteBufferImmediate(self: *IGraphicsCommandList8, count: UINT, params: [*]const WRITEBUFFERIMMEDIATE_PARAMETER, modes: ?[*]const WRITEBUFFERIMMEDIATE_MODE) void {
        IGraphicsCommandList7.WriteBufferImmediate(@ptrCast(self), count, params, modes);
    }
    pub inline fn SetProtectedResourceSession(self: *IGraphicsCommandList8, prsession: ?*IProtectedResourceSession) void {
        IGraphicsCommandList7.SetProtectedResourceSession(@ptrCast(self), prsession);
    }
    pub inline fn BeginRenderPass(self: *IGraphicsCommandList8, num_render_targets: UINT, render_targets: ?[*]const RENDER_PASS_RENDER_TARGET_DESC, depth_stencil: ?*const RENDER_PASS_DEPTH_STENCIL_DESC, flags: RENDER_PASS_FLAGS) void {
        IGraphicsCommandList7.BeginRenderPass(@ptrCast(self), num_render_targets, render_targets, depth_stencil, flags);
    }
    pub inline fn EndRenderPass(self: *IGraphicsCommandList8) void {
        IGraphicsCommandList7.EndRenderPass(@ptrCast(self));
    }
    pub inline fn InitializeMetaCommand(self: *IGraphicsCommandList8, meta_cmd: *IMetaCommand, init_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList7.InitializeMetaCommand(@ptrCast(self), meta_cmd, init_param_data, data_size);
    }
    pub inline fn ExecuteMetaCommand(self: *IGraphicsCommandList8, meta_cmd: *IMetaCommand, exe_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList7.ExecuteMetaCommand(@ptrCast(self), meta_cmd, exe_param_data, data_size);
    }
    pub inline fn BuildRaytracingAccelerationStructure(self: *IGraphicsCommandList8, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC, num_post_build_descs: UINT, post_build_descs: ?[*]const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC) void {
        IGraphicsCommandList7.BuildRaytracingAccelerationStructure(@ptrCast(self), desc, num_post_build_descs, post_build_descs);
    }
    pub inline fn EmitRaytracingAccelerationStructurePostbuildInfo(self: *IGraphicsCommandList8, desc: *const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC, num_src_accel_structs: UINT, src_accel_struct_data: [*]const GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList7.EmitRaytracingAccelerationStructurePostbuildInfo(@ptrCast(self), desc, num_src_accel_structs, src_accel_struct_data);
    }
    pub inline fn CopyRaytracingAccelerationStructure(self: *IGraphicsCommandList8, dst_data: GPU_VIRTUAL_ADDRESS, src_data: GPU_VIRTUAL_ADDRESS, mode: RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE) void {
        IGraphicsCommandList7.CopyRaytracingAccelerationStructure(@ptrCast(self), dst_data, src_data, mode);
    }
    pub inline fn SetPipelineState1(self: *IGraphicsCommandList8, state_obj: *IStateObject) void {
        IGraphicsCommandList7.SetPipelineState1(@ptrCast(self), state_obj);
    }
    pub inline fn DispatchRays(self: *IGraphicsCommandList8, desc: *const DISPATCH_RAYS_DESC) void {
        IGraphicsCommandList7.DispatchRays(@ptrCast(self), desc);
    }
    pub inline fn RSSetShadingRate(self: *IGraphicsCommandList8, base_shading_rate: SHADING_RATE, combiners: ?*const [RS_SET_SHADING_RATE_COMBINER_COUNT]SHADING_RATE_COMBINER) void {
        IGraphicsCommandList7.RSSetShadingRate(@ptrCast(self), base_shading_rate, combiners);
    }
    pub inline fn RSSetShadingRateImage(self: *IGraphicsCommandList8, shading_rate_img: ?*IResource) void {
        IGraphicsCommandList7.RSSetShadingRateImage(@ptrCast(self), shading_rate_img);
    }
    pub inline fn DispatchMesh(self: *IGraphicsCommandList8, thread_group_count_x: UINT, thread_group_count_y: UINT, thread_group_count_z: UINT) void {
        IGraphicsCommandList7.DispatchMesh(@ptrCast(self), thread_group_count_x, thread_group_count_y, thread_group_count_z);
    }
    pub inline fn Barrier(self: *IGraphicsCommandList8, num_barrier_groups: UINT32, barrier_groups: [*]const BARRIER_GROUP) void {
        IGraphicsCommandList7.Barrier(@ptrCast(self), num_barrier_groups, barrier_groups);
    }
    pub inline fn OMSetFrontAndBackStencilRef(self: *IGraphicsCommandList8, front_stencil_ref: UINT, back_stencil_ref: UINT) void {
        self.__v.OMSetFrontAndBackStencilRef(self, front_stencil_ref, back_stencil_ref);
    }
    pub const VTable = extern struct {
        base: IGraphicsCommandList7.VTable,
        Barrier: *const fn (*IGraphicsCommandList8, UINT, UINT) callconv(WINAPI) void,
    };
};

pub const IID_IGraphicsCommandList9 = GUID.parse("{34ed2808-ffe6-4c2b-b11a-cabd2b0c59e1}");
pub const IGraphicsCommandList9 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IGraphicsCommandList9, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IGraphicsCommandList8.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IGraphicsCommandList9) ULONG {
        return IGraphicsCommandList8.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IGraphicsCommandList9) ULONG {
        return IGraphicsCommandList8.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IGraphicsCommandList9, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IGraphicsCommandList8.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IGraphicsCommandList9, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IGraphicsCommandList8.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IGraphicsCommandList9, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IGraphicsCommandList8.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IGraphicsCommandList9, name: LPCWSTR) HRESULT {
        return IGraphicsCommandList8.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IGraphicsCommandList9, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IGraphicsCommandList8.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetType(self: *IGraphicsCommandList9) COMMAND_LIST_TYPE {
        return IGraphicsCommandList8.GetType(@ptrCast(self));
    }
    pub inline fn Close(self: *IGraphicsCommandList9) HRESULT {
        return IGraphicsCommandList8.Close(@ptrCast(self));
    }
    pub inline fn Reset(self: *IGraphicsCommandList9, alloc: *ICommandAllocator, initial_state: ?*IPipelineState) HRESULT {
        return IGraphicsCommandList8.Reset(@ptrCast(self), alloc, initial_state);
    }
    pub inline fn ClearState(self: *IGraphicsCommandList9, pso: ?*IPipelineState) void {
        IGraphicsCommandList8.ClearState(@ptrCast(self), pso);
    }
    pub inline fn DrawInstanced(self: *IGraphicsCommandList9, vertex_count_per_instance: UINT, instance_count: UINT, start_vertex_location: UINT, start_instance_location: UINT) void {
        IGraphicsCommandList8.DrawInstanced(@ptrCast(self), vertex_count_per_instance, instance_count, start_vertex_location, start_instance_location);
    }
    pub inline fn DrawIndexedInstanced(self: *IGraphicsCommandList9, index_count_per_instance: UINT, instance_count: UINT, start_index_location: UINT, base_vertex_location: INT, start_instance_location: UINT) void {
        IGraphicsCommandList8.DrawIndexedInstanced(@ptrCast(self), index_count_per_instance, instance_count, start_index_location, base_vertex_location, start_instance_location);
    }
    pub inline fn Dispatch(self: *IGraphicsCommandList9, count_x: UINT, count_y: UINT, count_z: UINT) void {
        IGraphicsCommandList8.Dispatch(@ptrCast(self), count_x, count_y, count_z);
    }
    pub inline fn CopyBufferRegion(self: *IGraphicsCommandList9, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, num_bytes: UINT64) void {
        IGraphicsCommandList8.CopyBufferRegion(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, num_bytes);
    }
    pub inline fn CopyTextureRegion(self: *IGraphicsCommandList9, dst: *const TEXTURE_COPY_LOCATION, dst_x: UINT, dst_y: UINT, dst_z: UINT, src: *const TEXTURE_COPY_LOCATION, src_box: ?*const BOX) void {
        IGraphicsCommandList8.CopyTextureRegion(@ptrCast(self), dst, dst_x, dst_y, dst_z, src, src_box);
    }
    pub inline fn CopyResource(self: *IGraphicsCommandList9, dst: *IResource, src: *IResource) void {
        IGraphicsCommandList8.CopyResource(@ptrCast(self), dst, src);
    }
    pub inline fn CopyTiles(self: *IGraphicsCommandList9, tiled_resource: *IResource, tile_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, tile_region_size: *const TILE_REGION_SIZE, buffer: *IResource, buffer_start_offset_in_bytes: UINT64, flags: TILE_COPY_FLAGS) void {
        IGraphicsCommandList8.CopyTiles(@ptrCast(self), tiled_resource, tile_region_start_coordinate, tile_region_size, buffer, buffer_start_offset_in_bytes, flags);
    }
    pub inline fn ResolveSubresource(self: *IGraphicsCommandList9, dst_resource: *IResource, dst_subresource: UINT, src_resource: *IResource, src_subresource: UINT, format: dxgi.FORMAT) void {
        IGraphicsCommandList8.ResolveSubresource(@ptrCast(self), dst_resource, dst_subresource, src_resource, src_subresource, format);
    }
    pub inline fn IASetPrimitiveTopology(self: *IGraphicsCommandList9, topology: PRIMITIVE_TOPOLOGY) void {
        IGraphicsCommandList8.IASetPrimitiveTopology(@ptrCast(self), topology);
    }
    pub inline fn RSSetViewports(self: *IGraphicsCommandList9, num: UINT, viewports: [*]const VIEWPORT) void {
        IGraphicsCommandList8.RSSetViewports(@ptrCast(self), num, viewports);
    }
    pub inline fn RSSetScissorRects(self: *IGraphicsCommandList9, num: UINT, rects: [*]const RECT) void {
        IGraphicsCommandList8.RSSetScissorRects(@ptrCast(self), num, rects);
    }
    pub inline fn OMSetBlendFactor(self: *IGraphicsCommandList9, blend_factor: *const [4]FLOAT) void {
        IGraphicsCommandList8.OMSetBlendFactor(@ptrCast(self), blend_factor);
    }
    pub inline fn OMSetStencilRef(self: *IGraphicsCommandList9, stencil_ref: UINT) void {
        IGraphicsCommandList8.OMSetStencilRef(@ptrCast(self), stencil_ref);
    }
    pub inline fn SetPipelineState(self: *IGraphicsCommandList9, pso: *IPipelineState) void {
        IGraphicsCommandList8.SetPipelineState(@ptrCast(self), pso);
    }
    pub inline fn ResourceBarrier(self: *IGraphicsCommandList9, num: UINT, barriers: [*]const RESOURCE_BARRIER) void {
        IGraphicsCommandList8.ResourceBarrier(@ptrCast(self), num, barriers);
    }
    pub inline fn ExecuteBundle(self: *IGraphicsCommandList9, cmdlist: *IGraphicsCommandList) void {
        IGraphicsCommandList8.ExecuteBundle(@ptrCast(self), cmdlist);
    }
    pub inline fn SetDescriptorHeaps(self: *IGraphicsCommandList9, num: UINT, heaps: [*]const *IDescriptorHeap) void {
        IGraphicsCommandList8.SetDescriptorHeaps(@ptrCast(self), num, heaps);
    }
    pub inline fn SetComputeRootSignature(self: *IGraphicsCommandList9, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList8.SetComputeRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetGraphicsRootSignature(self: *IGraphicsCommandList9, root_signature: ?*IRootSignature) void {
        IGraphicsCommandList8.SetGraphicsRootSignature(@ptrCast(self), root_signature);
    }
    pub inline fn SetComputeRootDescriptorTable(self: *IGraphicsCommandList9, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList8.SetComputeRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetGraphicsRootDescriptorTable(self: *IGraphicsCommandList9, root_index: UINT, base_descriptor: GPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList8.SetGraphicsRootDescriptorTable(@ptrCast(self), root_index, base_descriptor);
    }
    pub inline fn SetComputeRoot32BitConstant(self: *IGraphicsCommandList9, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList8.SetComputeRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetGraphicsRoot32BitConstant(self: *IGraphicsCommandList9, index: UINT, data: UINT, off: UINT) void {
        IGraphicsCommandList8.SetGraphicsRoot32BitConstant(@ptrCast(self), index, data, off);
    }
    pub inline fn SetComputeRoot32BitConstants(self: *IGraphicsCommandList9, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList8.SetComputeRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetGraphicsRoot32BitConstants(self: *IGraphicsCommandList9, root_index: UINT, num: UINT, data: *const anyopaque, offset: UINT) void {
        IGraphicsCommandList8.SetGraphicsRoot32BitConstants(@ptrCast(self), root_index, num, data, offset);
    }
    pub inline fn SetComputeRootConstantBufferView(self: *IGraphicsCommandList9, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList8.SetComputeRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootConstantBufferView(self: *IGraphicsCommandList9, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList8.SetGraphicsRootConstantBufferView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootShaderResourceView(self: *IGraphicsCommandList9, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList8.SetComputeRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootShaderResourceView(self: *IGraphicsCommandList9, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList8.SetGraphicsRootShaderResourceView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetComputeRootUnorderedAccessView(self: *IGraphicsCommandList9, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList8.SetComputeRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn SetGraphicsRootUnorderedAccessView(self: *IGraphicsCommandList9, index: UINT, buffer_location: GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList8.SetGraphicsRootUnorderedAccessView(@ptrCast(self), index, buffer_location);
    }
    pub inline fn IASetIndexBuffer(self: *IGraphicsCommandList9, view: ?*const INDEX_BUFFER_VIEW) void {
        IGraphicsCommandList8.IASetIndexBuffer(@ptrCast(self), view);
    }
    pub inline fn IASetVertexBuffers(self: *IGraphicsCommandList9, start_slot: UINT, num_views: UINT, views: ?[*]const VERTEX_BUFFER_VIEW) void {
        IGraphicsCommandList8.IASetVertexBuffers(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn SOSetTargets(self: *IGraphicsCommandList9, start_slot: UINT, num_views: UINT, views: ?[*]const STREAM_OUTPUT_BUFFER_VIEW) void {
        IGraphicsCommandList8.SOSetTargets(@ptrCast(self), start_slot, num_views, views);
    }
    pub inline fn OMSetRenderTargets(self: *IGraphicsCommandList9, num_rt_descriptors: UINT, rt_descriptors: ?[*]const CPU_DESCRIPTOR_HANDLE, single_handle: BOOL, ds_descriptors: ?*const CPU_DESCRIPTOR_HANDLE) void {
        IGraphicsCommandList8.OMSetRenderTargets(@ptrCast(self), num_rt_descriptors, rt_descriptors, single_handle, ds_descriptors);
    }
    pub inline fn ClearDepthStencilView(self: *IGraphicsCommandList9, ds_view: CPU_DESCRIPTOR_HANDLE, clear_flags: CLEAR_FLAGS, depth: FLOAT, stencil: UINT8, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList8.ClearDepthStencilView(@ptrCast(self), ds_view, clear_flags, depth, stencil, num_rects, rects);
    }
    pub inline fn ClearRenderTargetView(self: *IGraphicsCommandList9, rt_view: CPU_DESCRIPTOR_HANDLE, rgba: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList8.ClearRenderTargetView(@ptrCast(self), rt_view, rgba, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewUint(self: *IGraphicsCommandList9, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]UINT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList8.ClearUnorderedAccessViewUint(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn ClearUnorderedAccessViewFloat(self: *IGraphicsCommandList9, gpu_view: GPU_DESCRIPTOR_HANDLE, cpu_view: CPU_DESCRIPTOR_HANDLE, resource: *IResource, values: *const [4]FLOAT, num_rects: UINT, rects: ?[*]const RECT) void {
        IGraphicsCommandList8.ClearUnorderedAccessViewFloat(@ptrCast(self), gpu_view, cpu_view, resource, values, num_rects, rects);
    }
    pub inline fn DiscardResource(self: *IGraphicsCommandList9, resource: *IResource, region: ?*const DISCARD_REGION) void {
        IGraphicsCommandList8.DiscardResource(@ptrCast(self), resource, region);
    }
    pub inline fn BeginQuery(self: *IGraphicsCommandList9, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList8.BeginQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn EndQuery(self: *IGraphicsCommandList9, query: *IQueryHeap, query_type: QUERY_TYPE, index: UINT) void {
        IGraphicsCommandList8.EndQuery(@ptrCast(self), query, query_type, index);
    }
    pub inline fn ResolveQueryData(self: *IGraphicsCommandList9, query: *IQueryHeap, query_type: QUERY_TYPE, start_index: UINT, num_queries: UINT, dst_resource: *IResource, buffer_offset: UINT64) void {
        IGraphicsCommandList8.ResolveQueryData(@ptrCast(self), query, query_type, start_index, num_queries, dst_resource, buffer_offset);
    }
    pub inline fn SetPredication(self: *IGraphicsCommandList9, buffer: ?*IResource, buffer_offset: UINT64, operation: PREDICATION_OP) void {
        IGraphicsCommandList8.SetPredication(@ptrCast(self), buffer, buffer_offset, operation);
    }
    pub inline fn SetMarker(self: *IGraphicsCommandList9, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList8.SetMarker(@ptrCast(self), metadata, data, size);
    }
    pub inline fn BeginEvent(self: *IGraphicsCommandList9, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        IGraphicsCommandList8.BeginEvent(@ptrCast(self), metadata, data, size);
    }
    pub inline fn EndEvent(self: *IGraphicsCommandList9) void {
        IGraphicsCommandList8.EndEvent(@ptrCast(self));
    }
    pub inline fn ExecuteIndirect(self: *IGraphicsCommandList9, command_signature: *ICommandSignature, max_command_count: UINT, arg_buffer: *IResource, arg_buffer_offset: UINT64, count_buffer: ?*IResource, count_buffer_offset: UINT64) void {
        IGraphicsCommandList8.ExecuteIndirect(@ptrCast(self), command_signature, max_command_count, arg_buffer, arg_buffer_offset, count_buffer, count_buffer_offset);
    }
    pub inline fn AtomicCopyBufferUINT(self: *IGraphicsCommandList9, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList8.AtomicCopyBufferUINT(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn AtomicCopyBufferUINT64(self: *IGraphicsCommandList9, dst_buffer: *IResource, dst_offset: UINT64, src_buffer: *IResource, src_offset: UINT64, dependencies: UINT, dependent_resources: [*]const *IResource, dependent_subresource_ranges: [*]const SUBRESOURCE_RANGE_UINT64) void {
        IGraphicsCommandList8.AtomicCopyBufferUINT64(@ptrCast(self), dst_buffer, dst_offset, src_buffer, src_offset, dependencies, dependent_resources, dependent_subresource_ranges);
    }
    pub inline fn OMSetDepthBounds(self: *IGraphicsCommandList9, min: FLOAT, max: FLOAT) void {
        IGraphicsCommandList8.OMSetDepthBounds(@ptrCast(self), min, max);
    }
    pub inline fn SetSamplePositions(self: *IGraphicsCommandList9, num_samples: UINT, num_pixels: UINT, sample_positions: *SAMPLE_POSITION) void {
        IGraphicsCommandList8.SetSamplePositions(@ptrCast(self), num_samples, num_pixels, sample_positions);
    }
    pub inline fn ResolveSubresourceRegion(self: *IGraphicsCommandList9, dst_resource: *IResource, dst_subresource: UINT, dst_x: UINT, dst_y: UINT, src_resource: *IResource, src_subresource: UINT, src_rect: *RECT, format: dxgi.FORMAT, resolve_mode: RESOLVE_MODE) void {
        IGraphicsCommandList8.ResolveSubresourceRegion(@ptrCast(self), dst_resource, dst_subresource, dst_x, dst_y, src_resource, src_subresource, src_rect, format, resolve_mode);
    }
    pub inline fn SetViewInstanceMask(self: *IGraphicsCommandList9, mask: UINT) void {
        IGraphicsCommandList8.SetViewInstanceMask(@ptrCast(self), mask);
    }
    pub inline fn WriteBufferImmediate(self: *IGraphicsCommandList9, count: UINT, params: [*]const WRITEBUFFERIMMEDIATE_PARAMETER, modes: ?[*]const WRITEBUFFERIMMEDIATE_MODE) void {
        IGraphicsCommandList8.WriteBufferImmediate(@ptrCast(self), count, params, modes);
    }
    pub inline fn SetProtectedResourceSession(self: *IGraphicsCommandList9, prsession: ?*IProtectedResourceSession) void {
        IGraphicsCommandList8.SetProtectedResourceSession(@ptrCast(self), prsession);
    }
    pub inline fn BeginRenderPass(self: *IGraphicsCommandList9, num_render_targets: UINT, render_targets: ?[*]const RENDER_PASS_RENDER_TARGET_DESC, depth_stencil: ?*const RENDER_PASS_DEPTH_STENCIL_DESC, flags: RENDER_PASS_FLAGS) void {
        IGraphicsCommandList8.BeginRenderPass(@ptrCast(self), num_render_targets, render_targets, depth_stencil, flags);
    }
    pub inline fn EndRenderPass(self: *IGraphicsCommandList9) void {
        IGraphicsCommandList8.EndRenderPass(@ptrCast(self));
    }
    pub inline fn InitializeMetaCommand(self: *IGraphicsCommandList9, meta_cmd: *IMetaCommand, init_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList8.InitializeMetaCommand(@ptrCast(self), meta_cmd, init_param_data, data_size);
    }
    pub inline fn ExecuteMetaCommand(self: *IGraphicsCommandList9, meta_cmd: *IMetaCommand, exe_param_data: ?*const anyopaque, data_size: SIZE_T) void {
        IGraphicsCommandList8.ExecuteMetaCommand(@ptrCast(self), meta_cmd, exe_param_data, data_size);
    }
    pub inline fn BuildRaytracingAccelerationStructure(self: *IGraphicsCommandList9, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_DESC, num_post_build_descs: UINT, post_build_descs: ?[*]const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC) void {
        IGraphicsCommandList8.BuildRaytracingAccelerationStructure(@ptrCast(self), desc, num_post_build_descs, post_build_descs);
    }
    pub inline fn EmitRaytracingAccelerationStructurePostbuildInfo(self: *IGraphicsCommandList9, desc: *const RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_DESC, num_src_accel_structs: UINT, src_accel_struct_data: [*]const GPU_VIRTUAL_ADDRESS) void {
        IGraphicsCommandList8.EmitRaytracingAccelerationStructurePostbuildInfo(@ptrCast(self), desc, num_src_accel_structs, src_accel_struct_data);
    }
    pub inline fn CopyRaytracingAccelerationStructure(self: *IGraphicsCommandList9, dst_data: GPU_VIRTUAL_ADDRESS, src_data: GPU_VIRTUAL_ADDRESS, mode: RAYTRACING_ACCELERATION_STRUCTURE_COPY_MODE) void {
        IGraphicsCommandList8.CopyRaytracingAccelerationStructure(@ptrCast(self), dst_data, src_data, mode);
    }
    pub inline fn SetPipelineState1(self: *IGraphicsCommandList9, state_obj: *IStateObject) void {
        IGraphicsCommandList8.SetPipelineState1(@ptrCast(self), state_obj);
    }
    pub inline fn DispatchRays(self: *IGraphicsCommandList9, desc: *const DISPATCH_RAYS_DESC) void {
        IGraphicsCommandList8.DispatchRays(@ptrCast(self), desc);
    }
    pub inline fn RSSetShadingRate(self: *IGraphicsCommandList9, base_shading_rate: SHADING_RATE, combiners: ?*const [RS_SET_SHADING_RATE_COMBINER_COUNT]SHADING_RATE_COMBINER) void {
        IGraphicsCommandList8.RSSetShadingRate(@ptrCast(self), base_shading_rate, combiners);
    }
    pub inline fn RSSetShadingRateImage(self: *IGraphicsCommandList9, shading_rate_img: ?*IResource) void {
        IGraphicsCommandList8.RSSetShadingRateImage(@ptrCast(self), shading_rate_img);
    }
    pub inline fn DispatchMesh(self: *IGraphicsCommandList9, thread_group_count_x: UINT, thread_group_count_y: UINT, thread_group_count_z: UINT) void {
        IGraphicsCommandList8.DispatchMesh(@ptrCast(self), thread_group_count_x, thread_group_count_y, thread_group_count_z);
    }
    pub inline fn Barrier(self: *IGraphicsCommandList9, num_barrier_groups: UINT32, barrier_groups: [*]const BARRIER_GROUP) void {
        IGraphicsCommandList8.Barrier(@ptrCast(self), num_barrier_groups, barrier_groups);
    }
    pub inline fn OMSetFrontAndBackStencilRef(self: *IGraphicsCommandList9, front_stencil_ref: UINT, back_stencil_ref: UINT) void {
        IGraphicsCommandList8.OMSetFrontAndBackStencilRef(@ptrCast(self), front_stencil_ref, back_stencil_ref);
    }
    pub inline fn RSSetDepthBias(self: *IGraphicsCommandList9, depth_bias: FLOAT, depth_bias_clamp: FLOAT, slope_scaled_depth_bias: FLOAT) void {
        self.__v.RSSetDepthBias(self, depth_bias, depth_bias_clamp, slope_scaled_depth_bias);
    }
    pub inline fn IASetIndexBufferStripCutValue(self: *IGraphicsCommandList9, cut_value: INDEX_BUFFER_STRIP_CUT_VALUE) void {
        self.__v.IASetIndexBufferStripCutValue(self, cut_value);
    }
    pub const VTable = extern struct {
        base: IGraphicsCommandList8.VTable,
        RSSetDepthBias: *const fn (*IGraphicsCommandList9, FLOAT, FLOAT, FLOAT) callconv(WINAPI) void,
        IASetIndexBufferStripCutValue: *const fn (
            *IGraphicsCommandList9,
            INDEX_BUFFER_STRIP_CUT_VALUE,
        ) callconv(WINAPI) void,
    };
};

pub const ICommandQueue = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ICommandQueue, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IPageable.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ICommandQueue) ULONG {
        return IPageable.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ICommandQueue) ULONG {
        return IPageable.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *ICommandQueue, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IPageable.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *ICommandQueue, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IPageable.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *ICommandQueue, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IPageable.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *ICommandQueue, name: LPCWSTR) HRESULT {
        return IPageable.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *ICommandQueue, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IPageable.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn UpdateTileMappings(self: *ICommandQueue, resource: *IResource, num_resource_regions: UINT, resource_region_start_coordinates: ?[*]const TILED_RESOURCE_COORDINATE, resource_region_sizes: ?[*]const TILE_REGION_SIZE, heap: ?*IHeap, num_ranges: UINT, range_flags: ?[*]const TILE_RANGE_FLAGS, heap_range_start_offsets: ?[*]const UINT, range_tile_counts: ?[*]const UINT, flags: TILE_MAPPING_FLAGS) void {
        self.__v.UpdateTileMappings(self, resource, num_resource_regions, resource_region_start_coordinates, resource_region_sizes, heap, num_ranges, range_flags, heap_range_start_offsets, range_tile_counts, flags);
    }
    pub inline fn CopyTileMappings(self: *ICommandQueue, dst_resource: *IResource, dst_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, src_resource: *IResource, src_region_start_coordinate: *const TILED_RESOURCE_COORDINATE, region_size: *const TILE_REGION_SIZE, flags: TILE_MAPPING_FLAGS) void {
        self.__v.CopyTileMappings(self, dst_resource, dst_region_start_coordinate, src_resource, src_region_start_coordinate, region_size, flags);
    }
    pub inline fn ExecuteCommandLists(self: *ICommandQueue, num: UINT, cmdlists: [*]const *ICommandList) void {
        self.__v.ExecuteCommandLists(self, num, cmdlists);
    }
    pub inline fn SetMarker(self: *ICommandQueue, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        self.__v.SetMarker(self, metadata, data, size);
    }
    pub inline fn BeginEvent(self: *ICommandQueue, metadata: UINT, data: ?*const anyopaque, size: UINT) void {
        self.__v.BeginEvent(self, metadata, data, size);
    }
    pub inline fn EndEvent(self: *ICommandQueue) void {
        self.__v.EndEvent(self);
    }
    pub inline fn Signal(self: *ICommandQueue, fence: *IFence, value: UINT64) HRESULT {
        return self.__v.Signal(self, fence, value);
    }
    pub inline fn Wait(self: *ICommandQueue, fence: *IFence, value: UINT64) HRESULT {
        return self.__v.Wait(self, fence, value);
    }
    pub inline fn GetTimestampFrequency(self: *ICommandQueue, frequency: *UINT64) HRESULT {
        return self.__v.GetTimestampFrequency(self, frequency);
    }
    pub inline fn GetClockCalibration(self: *ICommandQueue, gpu_timestamp: *UINT64, cpu_timestamp: *UINT64) HRESULT {
        return self.__v.GetClockCalibration(self, gpu_timestamp, cpu_timestamp);
    }
    pub inline fn GetDesc(self: *ICommandQueue, desc: *COMMAND_QUEUE_DESC) *COMMAND_QUEUE_DESC {
        return self.__v.GetDesc(self, desc);
    }
    pub const VTable = extern struct {
        const T = ICommandQueue;
        base: IPageable.VTable,
        UpdateTileMappings: *const fn (
            *T,
            *IResource,
            UINT,
            ?[*]const TILED_RESOURCE_COORDINATE,
            ?[*]const TILE_REGION_SIZE,
            *IHeap,
            UINT,
            ?[*]const TILE_RANGE_FLAGS,
            ?[*]const UINT,
            ?[*]const UINT,
            TILE_MAPPING_FLAGS,
        ) callconv(WINAPI) void,
        CopyTileMappings: *const fn (
            *T,
            *IResource,
            *const TILED_RESOURCE_COORDINATE,
            *IResource,
            *const TILED_RESOURCE_COORDINATE,
            *const TILE_REGION_SIZE,
            TILE_MAPPING_FLAGS,
        ) callconv(WINAPI) void,
        ExecuteCommandLists: *const fn (*T, UINT, [*]const *ICommandList) callconv(WINAPI) void,
        SetMarker: *const fn (*T, UINT, ?*const anyopaque, UINT) callconv(WINAPI) void,
        BeginEvent: *const fn (*T, UINT, ?*const anyopaque, UINT) callconv(WINAPI) void,
        EndEvent: *const fn (*T) callconv(WINAPI) void,
        Signal: *const fn (*T, *IFence, UINT64) callconv(WINAPI) HRESULT,
        Wait: *const fn (*T, *IFence, UINT64) callconv(WINAPI) HRESULT,
        GetTimestampFrequency: *const fn (*T, *UINT64) callconv(WINAPI) HRESULT,
        GetClockCalibration: *const fn (*T, *UINT64, *UINT64) callconv(WINAPI) HRESULT,
        GetDesc: *const fn (*T, *COMMAND_QUEUE_DESC) callconv(WINAPI) *COMMAND_QUEUE_DESC,
    };
};

pub const IID_IDevice = GUID.parse("{189819f1-1db6-4b57-be54-1821339b85f7}");
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
    pub inline fn GetPrivateData(self: *IDevice, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IObject.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IObject.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IObject.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice, name: LPCWSTR) HRESULT {
        return IObject.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice) UINT {
        return self.__v.GetNodeCount(self);
    }
    pub inline fn CreateCommandQueue(self: *IDevice, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return self.__v.CreateCommandQueue(self, desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return self.__v.CreateCommandAllocator(self, cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return self.__v.CreateGraphicsPipelineState(self, desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return self.__v.CreateComputePipelineState(self, desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return self.__v.CreateCommandList(self, node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return self.__v.CheckFeatureSupport(self, feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return self.__v.CreateDescriptorHeap(self, desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return self.__v.GetDescriptorHandleIncrementSize(self, heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return self.__v.CreateRootSignature(self, node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        self.__v.CreateConstantBufferView(self, desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        self.__v.CreateShaderResourceView(self, resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        self.__v.CreateUnorderedAccessView(self, resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        self.__v.CreateRenderTargetView(self, resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        self.__v.CreateDepthStencilView(self, resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        self.__v.CreateSampler(self, desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        self.__v.CopyDescriptors(self, num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        self.__v.CopyDescriptorsSimple(self, num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return self.__v.GetResourceAllocationInfo(self, info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return self.__v.GetCustomHeapProperties(self, props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreateCommittedResource(self, heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return self.__v.CreateHeap(self, desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreatePlacedResource(self, heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreateReservedResource(self, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return self.__v.CreateSharedHandle(self, object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return self.__v.OpenSharedHandle(self, handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return self.__v.OpenSharedHandleByName(self, name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice, num: UINT, objects: [*]const *IPageable) HRESULT {
        return self.__v.MakeResident(self, num, objects);
    }
    pub inline fn Evict(self: *IDevice, num: UINT, objects: [*]const *IPageable) HRESULT {
        return self.__v.Evict(self, num, objects);
    }
    pub inline fn CreateFence(self: *IDevice, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return self.__v.CreateFence(self, initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice) HRESULT {
        return self.__v.GetDeviceRemovedReason(self);
    }
    pub inline fn GetCopyableFootprints(self: *IDevice, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        self.__v.GetCopyableFootprints(self, desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return self.__v.CreateQueryHeap(self, desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice, enable: BOOL) HRESULT {
        return self.__v.SetStablePowerState(self, enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return self.__v.CreateCommandSignature(self, desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        self.__v.GetResourceTiling(self, resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice, luid: *LUID) *LUID {
        return self.__v.GetAdapterLuid(self, luid);
    }
    pub const VTable = extern struct {
        const T = IDevice;
        base: IObject.VTable,
        GetNodeCount: *const fn (*T) callconv(WINAPI) UINT,
        CreateCommandQueue: *const fn (
            *T,
            *const COMMAND_QUEUE_DESC,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateCommandAllocator: *const fn (
            *T,
            COMMAND_LIST_TYPE,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateGraphicsPipelineState: *const fn (
            *T,
            *const GRAPHICS_PIPELINE_STATE_DESC,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateComputePipelineState: *const fn (
            *T,
            *const COMPUTE_PIPELINE_STATE_DESC,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateCommandList: *const fn (
            *T,
            UINT,
            COMMAND_LIST_TYPE,
            *ICommandAllocator,
            ?*IPipelineState,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CheckFeatureSupport: *const fn (*T, FEATURE, *anyopaque, UINT) callconv(WINAPI) HRESULT,
        CreateDescriptorHeap: *const fn (
            *T,
            *const DESCRIPTOR_HEAP_DESC,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        GetDescriptorHandleIncrementSize: *const fn (*T, DESCRIPTOR_HEAP_TYPE) callconv(WINAPI) UINT,
        CreateRootSignature: *const fn (
            *T,
            UINT,
            *const anyopaque,
            UINT64,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateConstantBufferView: *const fn (
            *T,
            ?*const CONSTANT_BUFFER_VIEW_DESC,
            CPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) void,
        CreateShaderResourceView: *const fn (
            *T,
            ?*IResource,
            ?*const SHADER_RESOURCE_VIEW_DESC,
            CPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) void,
        CreateUnorderedAccessView: *const fn (
            *T,
            ?*IResource,
            ?*IResource,
            ?*const UNORDERED_ACCESS_VIEW_DESC,
            CPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) void,
        CreateRenderTargetView: *const fn (
            *T,
            ?*IResource,
            ?*const RENDER_TARGET_VIEW_DESC,
            CPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) void,
        CreateDepthStencilView: *const fn (
            *T,
            ?*IResource,
            ?*const DEPTH_STENCIL_VIEW_DESC,
            CPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) void,
        CreateSampler: *const fn (*T, *const SAMPLER_DESC, CPU_DESCRIPTOR_HANDLE) callconv(WINAPI) void,
        CopyDescriptors: *const fn (
            *T,
            UINT,
            [*]const CPU_DESCRIPTOR_HANDLE,
            ?[*]const UINT,
            UINT,
            [*]const CPU_DESCRIPTOR_HANDLE,
            ?[*]const UINT,
            DESCRIPTOR_HEAP_TYPE,
        ) callconv(WINAPI) void,
        CopyDescriptorsSimple: *const fn (
            *T,
            UINT,
            CPU_DESCRIPTOR_HANDLE,
            CPU_DESCRIPTOR_HANDLE,
            DESCRIPTOR_HEAP_TYPE,
        ) callconv(WINAPI) void,
        GetResourceAllocationInfo: *const fn (
            *T,
            *RESOURCE_ALLOCATION_INFO,
            UINT,
            UINT,
            [*]const RESOURCE_DESC,
        ) callconv(WINAPI) *RESOURCE_ALLOCATION_INFO,
        GetCustomHeapProperties: *const fn (
            *T,
            *HEAP_PROPERTIES,
            UINT,
            HEAP_TYPE,
        ) callconv(WINAPI) *HEAP_PROPERTIES,
        CreateCommittedResource: *const fn (
            *T,
            *const HEAP_PROPERTIES,
            HEAP_FLAGS,
            *const RESOURCE_DESC,
            RESOURCE_STATES,
            ?*const CLEAR_VALUE,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateHeap: *const fn (*T, *const HEAP_DESC, *const GUID, ?*?*anyopaque) callconv(WINAPI) HRESULT,
        CreatePlacedResource: *const fn (
            *T,
            *IHeap,
            UINT64,
            *const RESOURCE_DESC,
            RESOURCE_STATES,
            ?*const CLEAR_VALUE,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateReservedResource: *const fn (
            *T,
            *const RESOURCE_DESC,
            RESOURCE_STATES,
            ?*const CLEAR_VALUE,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateSharedHandle: *const fn (
            *T,
            *IDeviceChild,
            ?*const SECURITY_ATTRIBUTES,
            DWORD,
            ?LPCWSTR,
            ?*HANDLE,
        ) callconv(WINAPI) HRESULT,
        OpenSharedHandle: *const fn (*T, HANDLE, *const GUID, ?*?*anyopaque) callconv(WINAPI) HRESULT,
        OpenSharedHandleByName: *const fn (*T, LPCWSTR, DWORD, ?*HANDLE) callconv(WINAPI) HRESULT,
        MakeResident: *const fn (*T, UINT, [*]const *IPageable) callconv(WINAPI) HRESULT,
        Evict: *const fn (*T, UINT, [*]const *IPageable) callconv(WINAPI) HRESULT,
        CreateFence: *const fn (*T, UINT64, FENCE_FLAGS, *const GUID, *?*anyopaque) callconv(WINAPI) HRESULT,
        GetDeviceRemovedReason: *const fn (*T) callconv(WINAPI) HRESULT,
        GetCopyableFootprints: *const fn (
            *T,
            *const RESOURCE_DESC,
            UINT,
            UINT,
            UINT64,
            ?[*]PLACED_SUBRESOURCE_FOOTPRINT,
            ?[*]UINT,
            ?[*]UINT64,
            ?*UINT64,
        ) callconv(WINAPI) void,
        CreateQueryHeap: *const fn (*T, *const QUERY_HEAP_DESC, *const GUID, ?*?*anyopaque) callconv(WINAPI) HRESULT,
        SetStablePowerState: *const fn (*T, BOOL) callconv(WINAPI) HRESULT,
        CreateCommandSignature: *const fn (
            *T,
            *const COMMAND_SIGNATURE_DESC,
            ?*IRootSignature,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        GetResourceTiling: *const fn (
            *T,
            *IResource,
            ?*UINT,
            ?*PACKED_MIP_INFO,
            ?*TILE_SHAPE,
            ?*UINT,
            UINT,
            [*]SUBRESOURCE_TILING,
        ) callconv(WINAPI) void,
        GetAdapterLuid: *const fn (*T, *LUID) callconv(WINAPI) *LUID,
    };
};

pub const MULTIPLE_FENCE_WAIT_FLAGS = enum(UINT) {
    ALL = 0,
    ANY = 1,
};

pub const RESIDENCY_PRIORITY = enum(UINT) {
    MINIMUM = 0x28000000,
    LOW = 0x50000000,
    NORMAL = 0x78000000,
    HIGH = 0xa0010000,
    MAXIMUM = 0xc8000000,
};

pub const IID_IDevice1 = GUID.parse("{77acce80-638e-4e65-8895-c1f23386863e}");
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
    pub inline fn GetPrivateData(self: *IDevice1, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice1, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice1, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice1, name: LPCWSTR) HRESULT {
        return IDevice.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice1) UINT {
        return IDevice.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice1, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice1, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice1, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice1, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice1, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice1, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice1, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice1, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice1, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice1, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice1, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice1, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice1, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice1, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice1, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice1, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice1, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice1, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice1, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice1, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice1, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice1, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice1, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice1, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice1, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice1, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice1, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice1, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice1, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice1) HRESULT {
        return IDevice.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice1, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice1, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice1, enable: BOOL) HRESULT {
        return IDevice.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice1, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice1, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice1, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice1, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return self.__v.CreatePipelineLibrary(self, blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice1, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return self.__v.SetEventOnMultipleFenceCompletion(self, fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice1, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return self.__v.SetResidencyPriority(self, num_objects, objects, priorities);
    }
    pub const VTable = extern struct {
        base: IDevice.VTable,
        CreatePipelineLibrary: *const fn (
            *IDevice1,
            *const anyopaque,
            SIZE_T,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        SetEventOnMultipleFenceCompletion: *const fn (
            *IDevice1,
            [*]const *IFence,
            [*]const UINT64,
            UINT,
            MULTIPLE_FENCE_WAIT_FLAGS,
            HANDLE,
        ) callconv(WINAPI) HRESULT,
        SetResidencyPriority: *const fn (
            *IDevice1,
            UINT,
            [*]const *IPageable,
            [*]const RESIDENCY_PRIORITY,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const PIPELINE_STATE_SUBOBJECT_TYPE = enum(UINT) {
    ROOT_SIGNATURE = 0,
    VS = 1,
    PS = 2,
    DS = 3,
    HS = 4,
    GS = 5,
    CS = 6,
    STREAM_OUTPUT = 7,
    BLEND = 8,
    SAMPLE_MASK = 9,
    RASTERIZER = 10,
    DEPTH_STENCIL = 11,
    INPUT_LAYOUT = 12,
    IB_STRIP_CUT_VALUE = 13,
    PRIMITIVE_TOPOLOGY = 14,
    RENDER_TARGET_FORMATS = 15,
    DEPTH_STENCIL_FORMAT = 16,
    SAMPLE_DESC = 17,
    NODE_MASK = 18,
    CACHED_PSO = 19,
    FLAGS = 20,
    DEPTH_STENCIL1 = 21,
    VIEW_INSTANCING = 22,
    AS = 24,
    MS = 25,
    MAX_VALID,
};

pub const RT_FORMAT_ARRAY = extern struct {
    RTFormats: [8]dxgi.FORMAT,
    NumRenderTargets: UINT,
};

pub const PIPELINE_STATE_STREAM_DESC = extern struct {
    SizeInBytes: SIZE_T,
    pPipelineStateSubobjectStream: *anyopaque,
};

// NOTE(mziulek): Helper structures for defining Mesh Shaders.
pub const MESH_SHADER_PIPELINE_STATE_DESC = extern struct {
    pRootSignature: ?*IRootSignature = null,
    AS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    MS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    PS: SHADER_BYTECODE = SHADER_BYTECODE.initZero(),
    BlendState: BLEND_DESC = .{},
    SampleMask: UINT = 0xffff_ffff,
    RasterizerState: RASTERIZER_DESC = .{},
    DepthStencilState: DEPTH_STENCIL_DESC1 = .{},
    PrimitiveTopologyType: PRIMITIVE_TOPOLOGY_TYPE = .UNDEFINED,
    NumRenderTargets: UINT = 0,
    RTVFormats: [8]dxgi.FORMAT = [_]dxgi.FORMAT{.UNKNOWN} ** 8,
    DSVFormat: dxgi.FORMAT = .UNKNOWN,
    SampleDesc: dxgi.SAMPLE_DESC = .{ .Count = 1, .Quality = 0 },
    NodeMask: UINT = 0,
    CachedPSO: CACHED_PIPELINE_STATE = CACHED_PIPELINE_STATE.initZero(),
    Flags: PIPELINE_STATE_FLAGS = .{},

    pub fn initDefault() MESH_SHADER_PIPELINE_STATE_DESC {
        return .{};
    }
};

pub const PIPELINE_MESH_STATE_STREAM = extern struct {
    Flags_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .FLAGS,
    Flags: PIPELINE_STATE_FLAGS,
    NodeMask_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .NODE_MASK,
    NodeMask: UINT,
    pRootSignature_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .ROOT_SIGNATURE,
    pRootSignature: ?*IRootSignature,
    PS_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .PS,
    PS: SHADER_BYTECODE,
    AS_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .AS,
    AS: SHADER_BYTECODE,
    MS_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .MS,
    MS: SHADER_BYTECODE,
    BlendState_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .BLEND,
    BlendState: BLEND_DESC,
    DepthStencilState_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .DEPTH_STENCIL1,
    DepthStencilState: DEPTH_STENCIL_DESC1,
    DSVFormat_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .DEPTH_STENCIL_FORMAT,
    DSVFormat: dxgi.FORMAT,
    RasterizerState_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .RASTERIZER,
    RasterizerState: RASTERIZER_DESC,
    RTVFormats_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .RENDER_TARGET_FORMATS,
    RTVFormats: RT_FORMAT_ARRAY,
    SampleDesc_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .SAMPLE_DESC,
    SampleDesc: dxgi.SAMPLE_DESC,
    SampleMask_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .SAMPLE_MASK,
    SampleMask: UINT,
    CachedPSO_type: PIPELINE_STATE_SUBOBJECT_TYPE align(8) = .CACHED_PSO,
    CachedPSO: CACHED_PIPELINE_STATE,

    pub fn init(desc: MESH_SHADER_PIPELINE_STATE_DESC) PIPELINE_MESH_STATE_STREAM {
        const stream = PIPELINE_MESH_STATE_STREAM{
            .Flags = desc.Flags,
            .NodeMask = desc.NodeMask,
            .pRootSignature = desc.pRootSignature,
            .PS = desc.PS,
            .AS = desc.AS,
            .MS = desc.MS,
            .BlendState = desc.BlendState,
            .DepthStencilState = desc.DepthStencilState,
            .DSVFormat = desc.DSVFormat,
            .RasterizerState = desc.RasterizerState,
            .RTVFormats = .{ .RTFormats = desc.RTVFormats, .NumRenderTargets = desc.NumRenderTargets },
            .SampleDesc = desc.SampleDesc,
            .SampleMask = desc.SampleMask,
            .CachedPSO = desc.CachedPSO,
        };
        return stream;
    }
};

pub const IID_IDevice2 = GUID.parse("{30baa41e-b15b-475c-a0bb-1af5c5b64328}");
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
    pub inline fn GetPrivateData(self: *IDevice2, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice1.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice2, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice1.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice2, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice1.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice2, name: LPCWSTR) HRESULT {
        return IDevice1.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice2) UINT {
        return IDevice1.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice2, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice1.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice2, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice1.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice2, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice1.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice2, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice1.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice2, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice1.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice2, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice1.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice2, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice1.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice2, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice1.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice2, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice1.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice2, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice1.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice2, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice1.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice2, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice1.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice2, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice1.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice2, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice1.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice2, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice1.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice2, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice1.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice2, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice1.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice2, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice2, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice2, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice1.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice2, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice1.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice2, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice1.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice2, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice1.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice2, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice1.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice2, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice1.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice2, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice1.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice2, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice1.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice2, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice1.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice2, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice1.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice2) HRESULT {
        return IDevice1.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice2, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice1.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice2, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice1.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice2, enable: BOOL) HRESULT {
        return IDevice1.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice2, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice1.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice2, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice1.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice2, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice2, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice1.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice2, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice1.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice2, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice1.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice2, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return self.__v.CreatePipelineState(self, desc, guid, pso);
    }
    pub const VTable = extern struct {
        base: IDevice1.VTable,
        CreatePipelineState: *const fn (
            *IDevice2,
            *const PIPELINE_STATE_STREAM_DESC,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const RESIDENCY_FLAGS = packed struct(UINT) {
    DENY_OVERBUDGET: bool = false,
    __unused: u31 = 0,
};

pub const IID_IDevice3 = GUID.parse("{81dadc15-2bad-4392-93c5-101345c4aa98}");
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
    pub inline fn GetPrivateData(self: *IDevice3, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice2.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice3, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice2.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice3, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice2.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice3, name: LPCWSTR) HRESULT {
        return IDevice2.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice3) UINT {
        return IDevice2.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice3, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice2.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice3, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice2.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice3, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice2.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice3, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice2.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice3, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice2.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice3, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice2.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice3, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice2.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice3, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice2.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice3, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice2.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice3, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice2.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice3, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice2.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice3, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice2.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice3, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice2.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice3, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice2.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice3, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice2.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice3, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice2.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice3, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice2.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice3, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice3, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice3, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice2.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice3, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice2.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice3, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice2.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice3, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice2.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice3, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice2.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice3, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice2.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice3, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice2.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice3, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice2.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice3, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice2.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice3, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice2.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice3) HRESULT {
        return IDevice2.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice3, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice2.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice3, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice2.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice3, enable: BOOL) HRESULT {
        return IDevice2.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice3, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice2.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice3, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice2.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice3, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice3, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice2.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice3, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice2.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice3, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice2.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice3, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice2.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice3, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return self.__v.OpenExistingHeapFromAddress(self, address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice3, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return self.__v.OpenExistingHeapFromFileMapping(self, file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice3, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return self.__v.EnqueueMakeResident(self, flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub const VTable = extern struct {
        base: IDevice2.VTable,
        OpenExistingHeapFromAddress: *const fn (
            *IDevice3,
            *const anyopaque,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        OpenExistingHeapFromFileMapping: *const fn (
            *IDevice3,
            HANDLE,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        EnqueueMakeResident: *const fn (
            *IDevice3,
            RESIDENCY_FLAGS,
            UINT,
            [*]const *IPageable,
            *IFence,
            UINT64,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const COMMAND_LIST_FLAGS = packed struct(UINT) {
    __unused: u32 = 0,
};

pub const RESOURCE_ALLOCATION_INFO1 = extern struct {
    Offset: UINT64,
    Alignment: UINT64,
    SizeInBytes: UINT64,
};

pub const IID_IDevice4 = GUID.parse("{e865df17-a9ee-46f9-a463-3098315aa2e5}");
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
    pub inline fn GetPrivateData(self: *IDevice4, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice3.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice4, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice3.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice4, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice3.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice4, name: LPCWSTR) HRESULT {
        return IDevice3.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice4) UINT {
        return IDevice3.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice4, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice3.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice4, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice3.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice4, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice3.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice4, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice3.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice4, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice3.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice4, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice3.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice4, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice3.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice4, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice3.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice4, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice3.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice4, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice3.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice4, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice3.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice4, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice3.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice4, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice3.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice4, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice3.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice4, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice3.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice4, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice3.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice4, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice3.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice4, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice4, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice4, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice3.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice4, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice3.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice4, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice3.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice4, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice3.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice4, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice3.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice4, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice3.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice4, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice3.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice4, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice3.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice4, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice3.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice4, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice3.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice4) HRESULT {
        return IDevice3.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice4, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice3.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice4, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice3.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice4, enable: BOOL) HRESULT {
        return IDevice3.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice4, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice3.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice4, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice3.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice4, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice4, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice3.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice4, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice3.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice4, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice3.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice4, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice3.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice4, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice3.OpenExistingHeapFromAddress(@ptrCast(self), address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice4, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice3.OpenExistingHeapFromFileMapping(@ptrCast(self), file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice4, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return IDevice3.EnqueueMakeResident(@ptrCast(self), flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub inline fn CreateCommandList1(self: *IDevice4, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, flags: COMMAND_LIST_FLAGS, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return self.__v.CreateCommandList1(self, node_mask, cmdlist_type, flags, guid, cmdlist);
    }
    pub inline fn CreateProtectedResourceSession(self: *IDevice4, desc: *const PROTECTED_RESOURCE_SESSION_DESC, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return self.__v.CreateProtectedResourceSession(self, desc, guid, session);
    }
    pub inline fn CreateCommittedResource1(self: *IDevice4, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreateCommittedResource1(self, heap_properties, heap_flags, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn CreateHeap1(self: *IDevice4, desc: *const HEAP_DESC, psession: ?*IProtectedResourceSession, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return self.__v.CreateHeap1(self, desc, psession, guid, heap);
    }
    pub inline fn CreateReservedResource1(self: *IDevice4, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreateReservedResource1(self, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn GetResourceAllocationInfo1(self: *IDevice4, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_resource_descs: UINT, resource_descs: [*]const RESOURCE_DESC, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) *RESOURCE_ALLOCATION_INFO {
        return self.__v.GetResourceAllocationInfo1(self, info, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub const VTable = extern struct {
        const T = IDevice4;
        base: IDevice3.VTable,
        CreateCommandList1: *const fn (
            *T,
            UINT,
            COMMAND_LIST_TYPE,
            COMMAND_LIST_FLAGS,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateProtectedResourceSession: *const fn (
            *T,
            *const PROTECTED_RESOURCE_SESSION_DESC,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateCommittedResource1: *const fn (
            *T,
            *const HEAP_PROPERTIES,
            HEAP_FLAGS,
            *const RESOURCE_DESC,
            RESOURCE_STATES,
            ?*const CLEAR_VALUE,
            ?*IProtectedResourceSession,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateHeap1: *const fn (
            *T,
            *const HEAP_DESC,
            ?*IProtectedResourceSession,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateReservedResource1: *const fn (
            *T,
            *const RESOURCE_DESC,
            RESOURCE_STATES,
            ?*const CLEAR_VALUE,
            ?*IProtectedResourceSession,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        GetResourceAllocationInfo1: *const fn (
            *T,
            *RESOURCE_ALLOCATION_INFO,
            UINT,
            UINT,
            [*]const RESOURCE_DESC,
            ?[*]RESOURCE_ALLOCATION_INFO1,
        ) callconv(WINAPI) *RESOURCE_ALLOCATION_INFO,
    };
};

pub const LIFETIME_STATE = enum(UINT) {
    IN_USE = 0,
    NOT_IN_USE = 1,
};

pub const ILifetimeOwner = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *ILifetimeOwner, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *ILifetimeOwner) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *ILifetimeOwner) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn LifetimeStateUpdated(self: *ILifetimeOwner, new_state: LIFETIME_STATE) void {
        self.__v.LifetimeStateUpdated(self, new_state);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        LifetimeStateUpdated: *const fn (*ILifetimeOwner, LIFETIME_STATE) callconv(WINAPI) void,
    };
};

pub const IID_IDevice5 = GUID.parse("{8b4f173b-2fea-4b80-8f58-4307191ab95d}");
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
    pub inline fn GetPrivateData(self: *IDevice5, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice4.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice5, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice4.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice5, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice4.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice5, name: LPCWSTR) HRESULT {
        return IDevice4.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice5) UINT {
        return IDevice4.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice5, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice4.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice5, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice4.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice5, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice4.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice5, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice4.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice5, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice4.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice5, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice4.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice5, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice4.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice5, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice4.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice5, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice4.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice5, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice4.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice5, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice4.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice5, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice4.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice5, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice4.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice5, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice4.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice5, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice4.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice5, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice4.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice5, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice4.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice5, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice5, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice5, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice4.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice5, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice4.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice5, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice4.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice5, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice4.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice5, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice4.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice5, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice4.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice5, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice4.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice5, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice4.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice5, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice4.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice5, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice4.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice5) HRESULT {
        return IDevice4.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice5, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice4.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice5, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice4.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice5, enable: BOOL) HRESULT {
        return IDevice4.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice5, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice4.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice5, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice4.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice5, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice5, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice4.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice5, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice4.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice5, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice4.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice5, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice4.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice5, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice4.OpenExistingHeapFromAddress(@ptrCast(self), address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice5, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice4.OpenExistingHeapFromFileMapping(@ptrCast(self), file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice5, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return IDevice4.EnqueueMakeResident(@ptrCast(self), flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub inline fn CreateCommandList1(self: *IDevice5, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, flags: COMMAND_LIST_FLAGS, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice4.CreateCommandList1(@ptrCast(self), node_mask, cmdlist_type, flags, guid, cmdlist);
    }
    pub inline fn CreateProtectedResourceSession(self: *IDevice5, desc: *const PROTECTED_RESOURCE_SESSION_DESC, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice4.CreateProtectedResourceSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn CreateCommittedResource1(self: *IDevice5, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice4.CreateCommittedResource1(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn CreateHeap1(self: *IDevice5, desc: *const HEAP_DESC, psession: ?*IProtectedResourceSession, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice4.CreateHeap1(@ptrCast(self), desc, psession, guid, heap);
    }
    pub inline fn CreateReservedResource1(self: *IDevice5, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice4.CreateReservedResource1(@ptrCast(self), desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn GetResourceAllocationInfo1(self: *IDevice5, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_resource_descs: UINT, resource_descs: [*]const RESOURCE_DESC, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) *RESOURCE_ALLOCATION_INFO {
        return IDevice4.GetResourceAllocationInfo1(@ptrCast(self), info, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateLifetimeTracker(self: *IDevice5, owner: *ILifetimeOwner, guid: *const GUID, tracker: *?*anyopaque) HRESULT {
        return self.__v.CreateLifetimeTracker(self, owner, guid, tracker);
    }
    pub inline fn RemoveDevice(self: *IDevice5) void {
        self.__v.RemoveDevice(self);
    }
    pub inline fn EnumerateMetaCommands(self: *IDevice5, num_meta_cmds: *UINT, descs: ?[*]META_COMMAND_DESC) HRESULT {
        return self.__v.EnumerateMetaCommands(self, num_meta_cmds, descs);
    }
    pub inline fn EnumerateMetaCommandParameters(self: *IDevice5, cmd_id: *const GUID, stage: META_COMMAND_PARAMETER_STAGE, total_size: ?*UINT, param_count: *UINT, param_descs: ?[*]META_COMMAND_PARAMETER_DESC) HRESULT {
        return self.__v.EnumerateMetaCommandParameters(self, cmd_id, stage, total_size, param_count, param_descs);
    }
    pub inline fn CreateMetaCommand(self: *IDevice5, cmd_id: *const GUID, node_mask: UINT, creation_param_data: ?*const anyopaque, creation_param_data_size: SIZE_T, guid: *const GUID, meta_cmd: *?*anyopaque) HRESULT {
        return self.__v.CreateMetaCommand(self, cmd_id, node_mask, creation_param_data, creation_param_data_size, guid, meta_cmd);
    }
    pub inline fn CreateStateObject(self: *IDevice5, desc: *const STATE_OBJECT_DESC, guid: *const GUID, state_object: *?*anyopaque) HRESULT {
        return self.__v.CreateStateObject(self, desc, guid, state_object);
    }
    pub inline fn GetRaytracingAccelerationStructurePrebuildInfo(self: *IDevice5, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS, info: *RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO) void {
        self.__v.GetRaytracingAccelerationStructurePrebuildInfo(self, desc, info);
    }
    pub inline fn CheckDriverMatchingIdentifier(self: *IDevice5, serialized_data_type: SERIALIZED_DATA_TYPE, identifier_to_check: *const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER) DRIVER_MATCHING_IDENTIFIER_STATUS {
        return self.__v.CheckDriverMatchingIdentifier(self, serialized_data_type, identifier_to_check);
    }
    pub const VTable = extern struct {
        const T = IDevice5;
        base: IDevice4.VTable,
        CreateLifetimeTracker: *const fn (
            *T,
            *ILifetimeOwner,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        RemoveDevice: *const fn (self: *T) callconv(WINAPI) void,
        EnumerateMetaCommands: *const fn (*T, *UINT, ?[*]META_COMMAND_DESC) callconv(WINAPI) HRESULT,
        EnumerateMetaCommandParameters: *const fn (
            *T,
            *const GUID,
            META_COMMAND_PARAMETER_STAGE,
            ?*UINT,
            *UINT,
            ?[*]META_COMMAND_PARAMETER_DESC,
        ) callconv(WINAPI) HRESULT,
        CreateMetaCommand: *const fn (
            *T,
            *const GUID,
            UINT,
            ?*const anyopaque,
            SIZE_T,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateStateObject: *const fn (
            *T,
            *const STATE_OBJECT_DESC,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        GetRaytracingAccelerationStructurePrebuildInfo: *const fn (
            *T,
            *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS,
            *RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO,
        ) callconv(WINAPI) void,
        CheckDriverMatchingIdentifier: *const fn (
            *T,
            SERIALIZED_DATA_TYPE,
            *const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER,
        ) callconv(WINAPI) DRIVER_MATCHING_IDENTIFIER_STATUS,
    };
};

pub const BACKGROUND_PROCESSING_MODE = enum(UINT) {
    ALLOWED = 0,
    ALLOW_INTRUSIVE_MEASUREMENTS = 1,
    DISABLE_BACKGROUND_WORK = 2,
    DISABLE_PROFILING_BY_SYSTEM = 3,
};

pub const MEASUREMENTS_ACTION = enum(UINT) {
    KEEP_ALL = 0,
    COMMIT_RESULTS = 1,
    COMMIT_RESULTS_HIGH_PRIORITY = 2,
    DISCARD_PREVIOUS = 3,
};

pub const IID_IDevice6 = GUID.parse("{c70b221b-40e4-4a17-89af-025a0727a6dc}");
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
    pub inline fn GetPrivateData(self: *IDevice6, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice5.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice6, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice5.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice6, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice5.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice6, name: LPCWSTR) HRESULT {
        return IDevice5.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice6) UINT {
        return IDevice5.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice6, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice5.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice6, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice5.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice6, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice5.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice6, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice5.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice6, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice5.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice6, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice5.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice6, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice5.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice6, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice5.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice6, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice5.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice6, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice5.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice6, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice5.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice6, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice5.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice6, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice5.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice6, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice5.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice6, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice5.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice6, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice5.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice6, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice5.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice6, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice6, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice6, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice5.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice6, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice5.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice6, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice5.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice6, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice5.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice6, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice5.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice6, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice5.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice6, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice5.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice6, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice5.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice6, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice5.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice6, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice5.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice6) HRESULT {
        return IDevice5.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice6, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice5.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice6, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice5.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice6, enable: BOOL) HRESULT {
        return IDevice5.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice6, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice5.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice6, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice5.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice6, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice6, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice5.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice6, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice5.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice6, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice5.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice6, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice5.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice6, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice5.OpenExistingHeapFromAddress(@ptrCast(self), address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice6, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice5.OpenExistingHeapFromFileMapping(@ptrCast(self), file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice6, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return IDevice5.EnqueueMakeResident(@ptrCast(self), flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub inline fn CreateCommandList1(self: *IDevice6, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, flags: COMMAND_LIST_FLAGS, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice5.CreateCommandList1(@ptrCast(self), node_mask, cmdlist_type, flags, guid, cmdlist);
    }
    pub inline fn CreateProtectedResourceSession(self: *IDevice6, desc: *const PROTECTED_RESOURCE_SESSION_DESC, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice5.CreateProtectedResourceSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn CreateCommittedResource1(self: *IDevice6, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice5.CreateCommittedResource1(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn CreateHeap1(self: *IDevice6, desc: *const HEAP_DESC, psession: ?*IProtectedResourceSession, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice5.CreateHeap1(@ptrCast(self), desc, psession, guid, heap);
    }
    pub inline fn CreateReservedResource1(self: *IDevice6, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice5.CreateReservedResource1(@ptrCast(self), desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn GetResourceAllocationInfo1(self: *IDevice6, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_resource_descs: UINT, resource_descs: [*]const RESOURCE_DESC, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) *RESOURCE_ALLOCATION_INFO {
        return IDevice4.GetResourceAllocationInfo1(@ptrCast(self), info, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateLifetimeTracker(self: *IDevice6, owner: *ILifetimeOwner, guid: *const GUID, tracker: *?*anyopaque) HRESULT {
        return IDevice5.CreateLifetimeTracker(@ptrCast(self), owner, guid, tracker);
    }
    pub inline fn RemoveDevice(self: *IDevice6) void {
        IDevice5.RemoveDevice(@ptrCast(self));
    }
    pub inline fn EnumerateMetaCommands(self: *IDevice6, num_meta_cmds: *UINT, descs: ?[*]META_COMMAND_DESC) HRESULT {
        return IDevice5.EnumerateMetaCommands(@ptrCast(self), num_meta_cmds, descs);
    }
    pub inline fn EnumerateMetaCommandParameters(self: *IDevice6, cmd_id: *const GUID, stage: META_COMMAND_PARAMETER_STAGE, total_size: ?*UINT, param_count: *UINT, param_descs: ?[*]META_COMMAND_PARAMETER_DESC) HRESULT {
        return IDevice5.EnumerateMetaCommandParameters(@ptrCast(self), cmd_id, stage, total_size, param_count, param_descs);
    }
    pub inline fn CreateMetaCommand(self: *IDevice6, cmd_id: *const GUID, node_mask: UINT, creation_param_data: ?*const anyopaque, creation_param_data_size: SIZE_T, guid: *const GUID, meta_cmd: *?*anyopaque) HRESULT {
        return IDevice5.CreateMetaCommand(@ptrCast(self), cmd_id, node_mask, creation_param_data, creation_param_data_size, guid, meta_cmd);
    }
    pub inline fn CreateStateObject(self: *IDevice6, desc: *const STATE_OBJECT_DESC, guid: *const GUID, state_object: *?*anyopaque) HRESULT {
        return IDevice5.CreateStateObject(@ptrCast(self), desc, guid, state_object);
    }
    pub inline fn GetRaytracingAccelerationStructurePrebuildInfo(self: *IDevice6, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS, info: *RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO) void {
        IDevice5.GetRaytracingAccelerationStructurePrebuildInfo(@ptrCast(self), desc, info);
    }
    pub inline fn CheckDriverMatchingIdentifier(self: *IDevice6, serialized_data_type: SERIALIZED_DATA_TYPE, identifier_to_check: *const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER) DRIVER_MATCHING_IDENTIFIER_STATUS {
        return IDevice5.CheckDriverMatchingIdentifier(@ptrCast(self), serialized_data_type, identifier_to_check);
    }
    pub inline fn SetBackgroundProcessingMode(self: *IDevice6, mode: BACKGROUND_PROCESSING_MODE, measurements_action: MEASUREMENTS_ACTION, event_to_signal_upon_completion: ?HANDLE, further_measurements_desired: ?*BOOL) HRESULT {
        return self.__v.SetBackgroundProcessingMode(self, mode, measurements_action, event_to_signal_upon_completion, further_measurements_desired);
    }
    pub const VTable = extern struct {
        base: IDevice5.VTable,
        SetBackgroundProcessingMode: *const fn (
            *IDevice6,
            BACKGROUND_PROCESSING_MODE,
            MEASUREMENTS_ACTION,
            ?HANDLE,
            ?*BOOL,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const PROTECTED_RESOURCE_SESSION_DESC1 = extern struct {
    NodeMask: UINT,
    Flags: PROTECTED_RESOURCE_SESSION_FLAGS,
    ProtectionType: GUID,
};

pub const IID_IDevice7 = GUID.parse("{5c014b53-68a1-4b9b-8bd1-dd6046b9358b}");
pub const IDevice7 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice7, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice6.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice7) ULONG {
        return IDevice6.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice7) ULONG {
        return IDevice6.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IDevice7, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice6.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice7, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice6.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice7, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice6.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice7, name: LPCWSTR) HRESULT {
        return IDevice6.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice7) UINT {
        return IDevice6.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice7, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice6.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice7, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice6.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice7, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice6.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice7, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice6.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice7, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice6.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice7, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice6.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice7, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice6.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice7, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice6.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice7, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice6.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice7, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice6.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice7, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice6.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice7, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice6.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice7, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice6.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice7, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice6.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice7, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice6.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice7, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice6.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice7, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice6.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice7, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice7, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice7, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice6.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice7, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice6.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice7, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice6.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice7, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice6.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice7, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice6.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice7, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice6.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice7, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice6.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice7, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice6.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice7, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice6.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice7, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice6.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice7) HRESULT {
        return IDevice6.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice7, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice6.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice7, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice6.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice7, enable: BOOL) HRESULT {
        return IDevice6.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice7, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice6.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice7, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice6.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice7, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice7, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice6.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice7, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice6.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice7, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice6.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice7, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice6.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice7, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice6.OpenExistingHeapFromAddress(@ptrCast(self), address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice7, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice6.OpenExistingHeapFromFileMapping(@ptrCast(self), file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice7, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return IDevice6.EnqueueMakeResident(@ptrCast(self), flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub inline fn CreateCommandList1(self: *IDevice7, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, flags: COMMAND_LIST_FLAGS, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice6.CreateCommandList1(@ptrCast(self), node_mask, cmdlist_type, flags, guid, cmdlist);
    }
    pub inline fn CreateProtectedResourceSession(self: *IDevice7, desc: *const PROTECTED_RESOURCE_SESSION_DESC, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice6.CreateProtectedResourceSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn CreateCommittedResource1(self: *IDevice7, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice6.CreateCommittedResource1(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn CreateHeap1(self: *IDevice7, desc: *const HEAP_DESC, psession: ?*IProtectedResourceSession, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice6.CreateHeap1(@ptrCast(self), desc, psession, guid, heap);
    }
    pub inline fn CreateReservedResource1(self: *IDevice7, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice6.CreateReservedResource1(@ptrCast(self), desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn GetResourceAllocationInfo1(self: *IDevice7, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_resource_descs: UINT, resource_descs: [*]const RESOURCE_DESC, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) *RESOURCE_ALLOCATION_INFO {
        return IDevice4.GetResourceAllocationInfo1(@ptrCast(self), info, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateLifetimeTracker(self: *IDevice7, owner: *ILifetimeOwner, guid: *const GUID, tracker: *?*anyopaque) HRESULT {
        return IDevice6.CreateLifetimeTracker(@ptrCast(self), owner, guid, tracker);
    }
    pub inline fn RemoveDevice(self: *IDevice7) void {
        IDevice6.RemoveDevice(@ptrCast(self));
    }
    pub inline fn EnumerateMetaCommands(self: *IDevice7, num_meta_cmds: *UINT, descs: ?[*]META_COMMAND_DESC) HRESULT {
        return IDevice6.EnumerateMetaCommands(@ptrCast(self), num_meta_cmds, descs);
    }
    pub inline fn EnumerateMetaCommandParameters(self: *IDevice7, cmd_id: *const GUID, stage: META_COMMAND_PARAMETER_STAGE, total_size: ?*UINT, param_count: *UINT, param_descs: ?[*]META_COMMAND_PARAMETER_DESC) HRESULT {
        return IDevice6.EnumerateMetaCommandParameters(@ptrCast(self), cmd_id, stage, total_size, param_count, param_descs);
    }
    pub inline fn CreateMetaCommand(self: *IDevice7, cmd_id: *const GUID, node_mask: UINT, creation_param_data: ?*const anyopaque, creation_param_data_size: SIZE_T, guid: *const GUID, meta_cmd: *?*anyopaque) HRESULT {
        return IDevice6.CreateMetaCommand(@ptrCast(self), cmd_id, node_mask, creation_param_data, creation_param_data_size, guid, meta_cmd);
    }
    pub inline fn CreateStateObject(self: *IDevice7, desc: *const STATE_OBJECT_DESC, guid: *const GUID, state_object: *?*anyopaque) HRESULT {
        return IDevice6.CreateStateObject(@ptrCast(self), desc, guid, state_object);
    }
    pub inline fn GetRaytracingAccelerationStructurePrebuildInfo(self: *IDevice7, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS, info: *RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO) void {
        IDevice6.GetRaytracingAccelerationStructurePrebuildInfo(@ptrCast(self), desc, info);
    }
    pub inline fn CheckDriverMatchingIdentifier(self: *IDevice7, serialized_data_type: SERIALIZED_DATA_TYPE, identifier_to_check: *const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER) DRIVER_MATCHING_IDENTIFIER_STATUS {
        return IDevice6.CheckDriverMatchingIdentifier(@ptrCast(self), serialized_data_type, identifier_to_check);
    }
    pub inline fn SetBackgroundProcessingMode(self: *IDevice7, mode: BACKGROUND_PROCESSING_MODE, measurements_action: MEASUREMENTS_ACTION, event_to_signal_upon_completion: ?HANDLE, further_measurements_desired: ?*BOOL) HRESULT {
        return IDevice6.SetBackgroundProcessingMode(@ptrCast(self), mode, measurements_action, event_to_signal_upon_completion, further_measurements_desired);
    }
    pub inline fn AddToStateObject(self: *IDevice7, addition: *const STATE_OBJECT_DESC, state_object: *IStateObject, guid: *const GUID, new_state_object: *?*anyopaque) HRESULT {
        return self.__v.AddToStateObject(self, addition, state_object, guid, new_state_object);
    }
    pub inline fn CreateProtectedResourceSession1(self: *IDevice7, desc: *const PROTECTED_RESOURCE_SESSION_DESC1, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return self.__v.CreateProtectedResourceSession1(self, desc, guid, session);
    }
    pub const VTable = extern struct {
        base: IDevice6.VTable,
        AddToStateObject: *const fn (
            *IDevice7,
            *const STATE_OBJECT_DESC,
            *IStateObject,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateProtectedResourceSession1: *const fn (
            *IDevice7,
            *const PROTECTED_RESOURCE_SESSION_DESC1,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const MIP_REGION = extern struct {
    Width: UINT,
    Height: UINT,
    Depth: UINT,
};

pub const RESOURCE_DESC1 = extern struct {
    Dimension: RESOURCE_DIMENSION,
    Alignment: UINT64,
    Width: UINT64,
    Height: UINT,
    DepthOrArraySize: UINT16,
    MipLevels: UINT16,
    Format: dxgi.FORMAT,
    SampleDesc: dxgi.SAMPLE_DESC,
    Layout: TEXTURE_LAYOUT,
    Flags: RESOURCE_FLAGS,
    SamplerFeedbackMipRegion: MIP_REGION,
};

pub const IID_IDevice8 = GUID.parse("{9218E6BB-F944-4F7E-A75C-B1B2C7B701F3}");
pub const IDevice8 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice8, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice7.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice8) ULONG {
        return IDevice7.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice8) ULONG {
        return IDevice7.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IDevice8, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice7.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice8, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice7.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice8, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice7.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice8, name: LPCWSTR) HRESULT {
        return IDevice7.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice8) UINT {
        return IDevice7.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice8, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice7.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice8, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice7.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice8, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice7.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice8, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice7.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice8, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice7.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice8, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice7.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice8, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice7.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice8, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice7.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice8, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice7.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice8, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice7.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice8, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice7.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice8, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice7.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice8, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice7.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice8, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice7.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice8, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice7.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice8, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice7.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice8, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice7.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice8, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice8, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice8, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice7.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice8, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice7.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice8, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice7.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice8, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice7.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice8, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice7.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice8, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice7.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice8, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice7.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice8, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice7.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice8, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice7.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice8, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice7.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice8) HRESULT {
        return IDevice7.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice8, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice7.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice8, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice7.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice8, enable: BOOL) HRESULT {
        return IDevice7.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice8, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice7.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice8, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice7.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice8, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice8, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice7.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice8, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice7.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice8, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice7.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice8, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice7.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice8, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice7.OpenExistingHeapFromAddress(@ptrCast(self), address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice8, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice7.OpenExistingHeapFromFileMapping(@ptrCast(self), file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice8, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return IDevice7.EnqueueMakeResident(@ptrCast(self), flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub inline fn CreateCommandList1(self: *IDevice8, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, flags: COMMAND_LIST_FLAGS, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice7.CreateCommandList1(@ptrCast(self), node_mask, cmdlist_type, flags, guid, cmdlist);
    }
    pub inline fn CreateProtectedResourceSession(self: *IDevice8, desc: *const PROTECTED_RESOURCE_SESSION_DESC, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice7.CreateProtectedResourceSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn CreateCommittedResource1(self: *IDevice8, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice7.CreateCommittedResource1(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn CreateHeap1(self: *IDevice8, desc: *const HEAP_DESC, psession: ?*IProtectedResourceSession, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice7.CreateHeap1(@ptrCast(self), desc, psession, guid, heap);
    }
    pub inline fn CreateReservedResource1(self: *IDevice8, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice7.CreateReservedResource1(@ptrCast(self), desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn GetResourceAllocationInfo1(self: *IDevice8, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_resource_descs: UINT, resource_descs: [*]const RESOURCE_DESC, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) *RESOURCE_ALLOCATION_INFO {
        return IDevice4.GetResourceAllocationInfo1(@ptrCast(self), info, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateLifetimeTracker(self: *IDevice8, owner: *ILifetimeOwner, guid: *const GUID, tracker: *?*anyopaque) HRESULT {
        return IDevice7.CreateLifetimeTracker(@ptrCast(self), owner, guid, tracker);
    }
    pub inline fn RemoveDevice(self: *IDevice8) void {
        IDevice7.RemoveDevice(@ptrCast(self));
    }
    pub inline fn EnumerateMetaCommands(self: *IDevice8, num_meta_cmds: *UINT, descs: ?[*]META_COMMAND_DESC) HRESULT {
        return IDevice7.EnumerateMetaCommands(@ptrCast(self), num_meta_cmds, descs);
    }
    pub inline fn EnumerateMetaCommandParameters(self: *IDevice8, cmd_id: *const GUID, stage: META_COMMAND_PARAMETER_STAGE, total_size: ?*UINT, param_count: *UINT, param_descs: ?[*]META_COMMAND_PARAMETER_DESC) HRESULT {
        return IDevice7.EnumerateMetaCommandParameters(@ptrCast(self), cmd_id, stage, total_size, param_count, param_descs);
    }
    pub inline fn CreateMetaCommand(self: *IDevice8, cmd_id: *const GUID, node_mask: UINT, creation_param_data: ?*const anyopaque, creation_param_data_size: SIZE_T, guid: *const GUID, meta_cmd: *?*anyopaque) HRESULT {
        return IDevice7.CreateMetaCommand(@ptrCast(self), cmd_id, node_mask, creation_param_data, creation_param_data_size, guid, meta_cmd);
    }
    pub inline fn CreateStateObject(self: *IDevice8, desc: *const STATE_OBJECT_DESC, guid: *const GUID, state_object: *?*anyopaque) HRESULT {
        return IDevice7.CreateStateObject(@ptrCast(self), desc, guid, state_object);
    }
    pub inline fn GetRaytracingAccelerationStructurePrebuildInfo(self: *IDevice8, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS, info: *RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO) void {
        IDevice7.GetRaytracingAccelerationStructurePrebuildInfo(@ptrCast(self), desc, info);
    }
    pub inline fn CheckDriverMatchingIdentifier(self: *IDevice8, serialized_data_type: SERIALIZED_DATA_TYPE, identifier_to_check: *const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER) DRIVER_MATCHING_IDENTIFIER_STATUS {
        return IDevice7.CheckDriverMatchingIdentifier(@ptrCast(self), serialized_data_type, identifier_to_check);
    }
    pub inline fn SetBackgroundProcessingMode(self: *IDevice8, mode: BACKGROUND_PROCESSING_MODE, measurements_action: MEASUREMENTS_ACTION, event_to_signal_upon_completion: ?HANDLE, further_measurements_desired: ?*BOOL) HRESULT {
        return IDevice7.SetBackgroundProcessingMode(@ptrCast(self), mode, measurements_action, event_to_signal_upon_completion, further_measurements_desired);
    }
    pub inline fn AddToStateObject(self: *IDevice8, addition: *const STATE_OBJECT_DESC, state_object: *IStateObject, guid: *const GUID, new_state_object: *?*anyopaque) HRESULT {
        return IDevice7.AddToStateObject(@ptrCast(self), addition, state_object, guid, new_state_object);
    }
    pub inline fn CreateProtectedResourceSession1(self: *IDevice8, desc: *const PROTECTED_RESOURCE_SESSION_DESC1, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice7.CreateProtectedResourceSession1(@ptrCast(self), desc, guid, session);
    }
    pub inline fn GetResourceAllocationInfo2(self: *IDevice8, visible_mask: UINT, num_resource_descs: UINT, resource_descs: *const RESOURCE_DESC1, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) RESOURCE_ALLOCATION_INFO {
        return self.__v.GetResourceAllocationInfo2(self, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateCommittedResource2(self: *IDevice8, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC1, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, prsession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreateCommittedResource2(self, heap_properties, heap_flags, desc, initial_state, clear_value, prsession, guid, resource);
    }
    pub inline fn CreatePlacedResource1(self: *IDevice8, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC1, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreatePlacedResource1(self, heap, heap_offset, desc, initial_state, clear_value, guid, resource);
    }
    pub inline fn CreateSamplerFeedbackUnorderedAccessView(self: *IDevice8, targeted_resource: ?*IResource, feedback_resource: ?*IResource, dest_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        self.__v.CreateSamplerFeedbackUnorderedAccessView(self, targeted_resource, feedback_resource, dest_descriptor);
    }
    pub inline fn GetCopyableFootprints1(self: *IDevice8, desc: *const RESOURCE_DESC1, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size_in_bytes: ?[*]UINT64, total_bytes: ?*UINT64) void {
        self.__v.GetCopyableFootprints1(self, desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size_in_bytes, total_bytes);
    }
    pub const VTable = extern struct {
        const T = IDevice8;
        base: IDevice7.VTable,
        GetResourceAllocationInfo2: *const fn (
            *T,
            UINT,
            UINT,
            *const RESOURCE_DESC1,
            ?[*]RESOURCE_ALLOCATION_INFO1,
        ) callconv(WINAPI) RESOURCE_ALLOCATION_INFO,
        CreateCommittedResource2: *const fn (
            *T,
            *const HEAP_PROPERTIES,
            HEAP_FLAGS,
            *const RESOURCE_DESC1,
            RESOURCE_STATES,
            ?*const CLEAR_VALUE,
            ?*IProtectedResourceSession,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreatePlacedResource1: *const fn (
            *T,
            *IHeap,
            UINT64,
            *const RESOURCE_DESC1,
            RESOURCE_STATES,
            ?*const CLEAR_VALUE,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateSamplerFeedbackUnorderedAccessView: *const fn (
            *T,
            ?*IResource,
            ?*IResource,
            CPU_DESCRIPTOR_HANDLE,
        ) callconv(WINAPI) void,
        GetCopyableFootprints1: *const fn (
            *T,
            *const RESOURCE_DESC1,
            UINT,
            UINT,
            UINT64,
            ?[*]PLACED_SUBRESOURCE_FOOTPRINT,
            ?[*]UINT,
            ?[*]UINT64,
            ?*UINT64,
        ) callconv(WINAPI) void,
    };
};

pub const SHADER_CACHE_KIND_FLAGS = packed struct(UINT) {
    IMPLICIT_D3D_CACHE_FOR_DRIVER: bool = false,
    IMPLICIT_D3D_CONVERSIONS: bool = false,
    IMPLICIT_DRIVER_MANAGED: bool = false,
    APPLICATION_MANAGED: bool = false,
    __unused: u28 = 0,
};

pub const SHADER_CACHE_CONTROL_FLAGS = packed struct(UINT) {
    DISABLE: bool = false,
    ENABLE: bool = false,
    CLEAR: bool = false,
    __unused: u29 = 0,
};

pub const SHADER_CACHE_MODE = enum(UINT) {
    MEMORY = 0,
    DISK = 1,
};

pub const SHADER_CACHE_FLAGS = packed struct(UINT) {
    DRIVER_VERSIONED: bool = false,
    USE_WORKING_DIR: bool = false,
    __unused: u30 = 0,
};

pub const SHADER_CACHE_SESSION_DESC = extern struct {
    Identifier: GUID,
    Mode: SHADER_CACHE_MODE,
    Flags: SHADER_CACHE_FLAGS,
    MaximumInMemoryCacheSizeBytes: UINT,
    MaximumInMemoryCacheEntries: UINT,
    MaximumValueFileSizeBytes: UINT,
    Version: UINT64,
};

pub const IID_IDevice9 = GUID.parse("{4c80e962-f032-4f60-bc9e-ebc2cfa1d83c}");
pub const IDevice9 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice9, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice8.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice9) ULONG {
        return IDevice8.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice9) ULONG {
        return IDevice8.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IDevice9, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice8.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice9, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice8.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice9, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice8.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice9, name: LPCWSTR) HRESULT {
        return IDevice8.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice9) UINT {
        return IDevice8.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice9, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice8.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice9, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice8.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice9, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice8.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice9, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice8.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice9, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice8.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice9, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice8.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice9, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice8.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice9, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice8.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice9, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice8.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice9, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice8.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice9, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice8.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice9, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice8.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice9, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice8.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice9, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice8.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice9, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice8.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice9, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice8.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice9, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice8.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice9, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice9, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice9, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice9, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice9, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice8.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice9, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice9, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice8.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice9, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice8.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice9, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice8.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice9, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice8.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice9, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice8.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice9, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice8.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice9) HRESULT {
        return IDevice8.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice9, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice8.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice9, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice9, enable: BOOL) HRESULT {
        return IDevice8.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice9, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice9, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice8.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice9, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice9, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice8.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice9, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice8.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice9, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice8.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice9, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice8.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice9, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice8.OpenExistingHeapFromAddress(@ptrCast(self), address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice9, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice8.OpenExistingHeapFromFileMapping(@ptrCast(self), file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice9, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return IDevice8.EnqueueMakeResident(@ptrCast(self), flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub inline fn CreateCommandList1(self: *IDevice9, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, flags: COMMAND_LIST_FLAGS, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice8.CreateCommandList1(@ptrCast(self), node_mask, cmdlist_type, flags, guid, cmdlist);
    }
    pub inline fn CreateProtectedResourceSession(self: *IDevice9, desc: *const PROTECTED_RESOURCE_SESSION_DESC, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice8.CreateProtectedResourceSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn CreateCommittedResource1(self: *IDevice9, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateCommittedResource1(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn CreateHeap1(self: *IDevice9, desc: *const HEAP_DESC, psession: ?*IProtectedResourceSession, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateHeap1(@ptrCast(self), desc, psession, guid, heap);
    }
    pub inline fn CreateReservedResource1(self: *IDevice9, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateReservedResource1(@ptrCast(self), desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn GetResourceAllocationInfo1(self: *IDevice9, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_resource_descs: UINT, resource_descs: [*]const RESOURCE_DESC, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) *RESOURCE_ALLOCATION_INFO {
        return IDevice4.GetResourceAllocationInfo1(@ptrCast(self), info, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateLifetimeTracker(self: *IDevice9, owner: *ILifetimeOwner, guid: *const GUID, tracker: *?*anyopaque) HRESULT {
        return IDevice8.CreateLifetimeTracker(@ptrCast(self), owner, guid, tracker);
    }
    pub inline fn RemoveDevice(self: *IDevice9) void {
        IDevice8.RemoveDevice(@ptrCast(self));
    }
    pub inline fn EnumerateMetaCommands(self: *IDevice9, num_meta_cmds: *UINT, descs: ?[*]META_COMMAND_DESC) HRESULT {
        return IDevice8.EnumerateMetaCommands(@ptrCast(self), num_meta_cmds, descs);
    }
    pub inline fn EnumerateMetaCommandParameters(self: *IDevice9, cmd_id: *const GUID, stage: META_COMMAND_PARAMETER_STAGE, total_size: ?*UINT, param_count: *UINT, param_descs: ?[*]META_COMMAND_PARAMETER_DESC) HRESULT {
        return IDevice8.EnumerateMetaCommandParameters(@ptrCast(self), cmd_id, stage, total_size, param_count, param_descs);
    }
    pub inline fn CreateMetaCommand(self: *IDevice9, cmd_id: *const GUID, node_mask: UINT, creation_param_data: ?*const anyopaque, creation_param_data_size: SIZE_T, guid: *const GUID, meta_cmd: *?*anyopaque) HRESULT {
        return IDevice8.CreateMetaCommand(@ptrCast(self), cmd_id, node_mask, creation_param_data, creation_param_data_size, guid, meta_cmd);
    }
    pub inline fn CreateStateObject(self: *IDevice9, desc: *const STATE_OBJECT_DESC, guid: *const GUID, state_object: *?*anyopaque) HRESULT {
        return IDevice8.CreateStateObject(@ptrCast(self), desc, guid, state_object);
    }
    pub inline fn GetRaytracingAccelerationStructurePrebuildInfo(self: *IDevice9, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS, info: *RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO) void {
        IDevice8.GetRaytracingAccelerationStructurePrebuildInfo(@ptrCast(self), desc, info);
    }
    pub inline fn CheckDriverMatchingIdentifier(self: *IDevice9, serialized_data_type: SERIALIZED_DATA_TYPE, identifier_to_check: *const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER) DRIVER_MATCHING_IDENTIFIER_STATUS {
        return IDevice8.CheckDriverMatchingIdentifier(@ptrCast(self), serialized_data_type, identifier_to_check);
    }
    pub inline fn SetBackgroundProcessingMode(self: *IDevice9, mode: BACKGROUND_PROCESSING_MODE, measurements_action: MEASUREMENTS_ACTION, event_to_signal_upon_completion: ?HANDLE, further_measurements_desired: ?*BOOL) HRESULT {
        return IDevice8.SetBackgroundProcessingMode(@ptrCast(self), mode, measurements_action, event_to_signal_upon_completion, further_measurements_desired);
    }
    pub inline fn AddToStateObject(self: *IDevice9, addition: *const STATE_OBJECT_DESC, state_object: *IStateObject, guid: *const GUID, new_state_object: *?*anyopaque) HRESULT {
        return IDevice8.AddToStateObject(@ptrCast(self), addition, state_object, guid, new_state_object);
    }
    pub inline fn CreateProtectedResourceSession1(self: *IDevice9, desc: *const PROTECTED_RESOURCE_SESSION_DESC1, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice8.CreateProtectedResourceSession1(@ptrCast(self), desc, guid, session);
    }
    pub inline fn GetResourceAllocationInfo2(self: *IDevice9, visible_mask: UINT, num_resource_descs: UINT, resource_descs: *const RESOURCE_DESC1, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) RESOURCE_ALLOCATION_INFO {
        return IDevice8.GetResourceAllocationInfo2(@ptrCast(self), visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateCommittedResource2(self: *IDevice9, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC1, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, prsession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice8.CreateCommittedResource2(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, prsession, guid, resource);
    }
    pub inline fn CreatePlacedResource1(self: *IDevice9, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC1, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice8.CreatePlacedResource1(@ptrCast(self), heap, heap_offset, desc, initial_state, clear_value, guid, resource);
    }
    pub inline fn CreateSamplerFeedbackUnorderedAccessView(self: *IDevice9, targeted_resource: ?*IResource, feedback_resource: ?*IResource, dest_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice8.CreateSamplerFeedbackUnorderedAccessView(@ptrCast(self), targeted_resource, feedback_resource, dest_descriptor);
    }
    pub inline fn GetCopyableFootprints1(self: *IDevice9, desc: *const RESOURCE_DESC1, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size_in_bytes: ?[*]UINT64, total_bytes: ?*UINT64) void {
        IDevice8.GetCopyableFootprints1(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size_in_bytes, total_bytes);
    }
    pub inline fn CreateShaderCacheSession(self: *IDevice9, desc: *const SHADER_CACHE_SESSION_DESC, guid: *const GUID, session: ?*?*anyopaque) HRESULT {
        return self.__v.CreateShaderCacheSession(self, desc, guid, session);
    }
    pub inline fn ShaderCacheControl(self: *IDevice9, kinds: SHADER_CACHE_KIND_FLAGS, control: SHADER_CACHE_CONTROL_FLAGS) HRESULT {
        return self.__v.ShaderCacheControl(self, kinds, control);
    }
    pub inline fn CreateCommandQueue1(self: *IDevice9, desc: *const COMMAND_QUEUE_DESC, creator_id: *const GUID, guid: *const GUID, cmdqueue: *?*anyopaque) HRESULT {
        return self.__v.CreateCommandQueue1(self, desc, creator_id, guid, cmdqueue);
    }
    pub const VTable = extern struct {
        base: IDevice8.VTable,
        CreateShaderCacheSession: *const fn (
            *IDevice9,
            *const SHADER_CACHE_SESSION_DESC,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        ShaderCacheControl: *const fn (
            *IDevice9,
            SHADER_CACHE_KIND_FLAGS,
            SHADER_CACHE_CONTROL_FLAGS,
        ) callconv(WINAPI) HRESULT,
        CreateCommandQueue1: *const fn (
            *IDevice9,
            *const COMMAND_QUEUE_DESC,
            *const GUID,
            *const GUID,
            *?*anyopaque,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const BARRIER_LAYOUT = enum(UINT) {
    PRESENT,
    GENERIC_READ,
    RENDER_TARGET,
    UNORDERED_ACCESS,
    DEPTH_STENCIL_WRITE,
    DEPTH_STENCIL_READ,
    SHADER_RESOURCE,
    COPY_SOURCE,
    COPY_DEST,
    RESOLVE_SOURCE,
    RESOLVE_DEST,
    SHADING_RATE_SOURCE,
    VIDEO_DECODE_READ,
    VIDEO_DECODE_WRITE,
    VIDEO_PROCESS_READ,
    VIDEO_PROCESS_WRITE,
    VIDEO_ENCODE_READ,
    VIDEO_ENCODE_WRITE,
    DIRECT_QUEUE_COMMON,
    DIRECT_QUEUE_GENERIC_READ,
    DIRECT_QUEUE_UNORDERED_ACCESS,
    DIRECT_QUEUE_SHADER_RESOURCE,
    DIRECT_QUEUE_COPY_SOURCE,
    DIRECT_QUEUE_COPY_DEST,
    COMPUTE_QUEUE_COMMON,
    COMPUTE_QUEUE_GENERIC_READ,
    COMPUTE_QUEUE_UNORDERED_ACCESS,
    COMPUTE_QUEUE_SHADER_RESOURCE,
    COMPUTE_QUEUE_COPY_SOURCE,
    COMPUTE_QUEUE_COPY_DEST,
    VIDEO_QUEUE_COMMON,
    UNDEFINED = 0xffffffff,

    pub const COMMON = .PRESENT;
};

pub const BARRIER_SYNC = packed struct(UINT) {
    ALL: bool = false, // 0x1
    DRAW: bool = false,
    INDEX_INPUT: bool = false,
    VERTEX_SHADING: bool = false,
    PIXEL_SHADING: bool = false, // 0x10
    DEPTH_STENCIL: bool = false,
    RENDER_TARGET: bool = false,
    COMPUTE_SHADING: bool = false,
    RAYTRACING: bool = false, // 0x100
    COPY: bool = false,
    RESOLVE: bool = false,
    EXECUTE_INDIRECT_OR_PREDICATION: bool = false,
    ALL_SHADING: bool = false, // 0x1000
    NON_PIXEL_SHADING: bool = false,
    EMIT_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO: bool = false,
    CLEAR_UNORDERED_ACCESS_VIEW: bool = false,
    __unused16: bool = false, // 0x10000
    __unused17: bool = false,
    __unused18: bool = false,
    __unused19: bool = false,
    VIDEO_DECODE: bool = false, // 0x100000
    VIDEO_PROCESS: bool = false,
    VIDEO_ENCODE: bool = false,
    BUILD_RAYTRACING_ACCELERATION_STRUCTURE: bool = false,
    COPY_RAYTRACING_ACCELERATION_STRUCTURE: bool = false, // 0x1000000
    __unused25: bool = false,
    __unused26: bool = false,
    __unused27: bool = false,
    __unused28: bool = false, // 0x10000000
    __unused29: bool = false,
    __unused30: bool = false,
    SPLIT: bool = false,
};

pub const BARRIER_ACCESS = packed struct(UINT) {
    VERTEX_BUFFER: bool = false,
    CONSTANT_BUFFER: bool = false,
    INDEX_BUFFER: bool = false,
    RENDER_TARGET: bool = false,
    UNORDERED_ACCESS: bool = false,
    DEPTH_STENCIL_WRITE: bool = false,
    DEPTH_STENCIL_READ: bool = false,
    SHADER_RESOURCE: bool = false,
    STREAM_OUTPUT: bool = false,
    INDIRECT_ARGUMENT_OR_PREDICATION: bool = false,
    COPY_DEST: bool = false,
    COPY_SOURCE: bool = false,
    RESOLVE_DEST: bool = false,
    RESOLVE_SOURCE: bool = false,
    RAYTRACING_ACCELERATION_STRUCTURE_READ: bool = false,
    RAYTRACING_ACCELERATION_STRUCTURE_WRITE: bool = false,
    SHADING_RATE_SOURCE: bool = false,
    VIDEO_DECODE_READ: bool = false,
    VIDEO_DECODE_WRITE: bool = false,
    VIDEO_PROCESS_READ: bool = false,
    VIDEO_PROCESS_WRITE: bool = false,
    VIDEO_ENCODE_READ: bool = false,
    VIDEO_ENCODE_WRITE: bool = false,
    __unused23: bool = false,
    __unused24: bool = false,
    __unused25: bool = false,
    __unused26: bool = false,
    __unused27: bool = false,
    __unused28: bool = false,
    __unused29: bool = false,
    __unused30: bool = false,
    NO_ACCESS: bool = false,

    pub const COMMON = BARRIER_ACCESS{};
};

pub const BARRIER_TYPE = enum(UINT) {
    GLOBAL,
    TEXTURE,
    BUFFER,
};

pub const TEXTURE_BARRIER_FLAGS = packed struct(UINT) {
    DISCARD: bool = false,
    __unused: u31 = 0,
};

pub const BARRIER_SUBRESOURCE_RANGE = extern struct {
    IndexOrFirstMipLevel: UINT,
    NumMipLevels: UINT,
    FirstArraySlice: UINT,
    NumArraySlices: UINT,
    FirstPlane: UINT,
    NumPlanes: UINT,
};

pub const GLOBAL_BARRIER = extern struct {
    SyncBefore: BARRIER_SYNC,
    SyncAfter: BARRIER_SYNC,
    AccessBefore: BARRIER_ACCESS,
    AccessAfter: BARRIER_ACCESS,
};

pub const TEXTURE_BARRIER = extern struct {
    SyncBefore: BARRIER_SYNC,
    SyncAfter: BARRIER_SYNC,
    AccessBefore: BARRIER_ACCESS,
    AccessAfter: BARRIER_ACCESS,
    LayoutBefore: BARRIER_LAYOUT,
    LayoutAfter: BARRIER_LAYOUT,
    pResource: *IResource,
    Subresources: BARRIER_SUBRESOURCE_RANGE,
    Flags: TEXTURE_BARRIER_FLAGS,
};

pub const BUFFER_BARRIER = extern struct {
    SyncBefore: BARRIER_SYNC,
    SyncAfter: BARRIER_SYNC,
    AccessBefore: BARRIER_ACCESS,
    AccessAfter: BARRIER_ACCESS,
    pResource: *IResource,
    Offset: UINT64,
    Size: UINT64,
};

pub const BARRIER_GROUP = extern struct {
    Type: BARRIER_TYPE,
    NumBarriers: UINT32,
    u: extern union {
        pGlobalBarriers: [*]const GLOBAL_BARRIER,
        pTextureBarriers: [*]const TEXTURE_BARRIER,
        pBufferBarriers: [*]const BUFFER_BARRIER,
    },
};

pub const IID_IDevice10 = GUID.parse("{517f8718-aa66-49f9-b02b-a7ab89c06031}");
pub const IDevice10 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice10, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice9.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice10) ULONG {
        return IDevice9.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice10) ULONG {
        return IDevice9.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IDevice10, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice9.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice10, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice9.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice10, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice9.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice10, name: LPCWSTR) HRESULT {
        return IDevice9.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice10) UINT {
        return IDevice9.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice10, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice9.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice10, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice9.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice10, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice9.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice10, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice9.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice10, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice9.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice10, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice9.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice10, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice9.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice10, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice9.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice10, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice9.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice10, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice9.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice10, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice9.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice10, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice9.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice10, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice9.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice10, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice9.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice10, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice9.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice10, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice9.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice10, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice9.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice10, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice10, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice10, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice10, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice10, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice9.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice10, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice10, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice9.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice10, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice9.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice10, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice9.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice10, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice9.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice10, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice9.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice10, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice9.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice10) HRESULT {
        return IDevice9.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice10, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice9.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice10, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice10, enable: BOOL) HRESULT {
        return IDevice9.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice10, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice10, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice9.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice10, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice10, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice9.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice10, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice9.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice10, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice9.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice10, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice9.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice10, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice9.OpenExistingHeapFromAddress(@ptrCast(self), address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice10, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice9.OpenExistingHeapFromFileMapping(@ptrCast(self), file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice10, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return IDevice9.EnqueueMakeResident(@ptrCast(self), flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub inline fn CreateCommandList1(self: *IDevice10, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, flags: COMMAND_LIST_FLAGS, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice9.CreateCommandList1(@ptrCast(self), node_mask, cmdlist_type, flags, guid, cmdlist);
    }
    pub inline fn CreateProtectedResourceSession(self: *IDevice10, desc: *const PROTECTED_RESOURCE_SESSION_DESC, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice9.CreateProtectedResourceSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn CreateCommittedResource1(self: *IDevice10, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateCommittedResource1(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn CreateHeap1(self: *IDevice10, desc: *const HEAP_DESC, psession: ?*IProtectedResourceSession, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateHeap1(@ptrCast(self), desc, psession, guid, heap);
    }
    pub inline fn CreateReservedResource1(self: *IDevice10, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateReservedResource1(@ptrCast(self), desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn GetResourceAllocationInfo1(self: *IDevice10, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_resource_descs: UINT, resource_descs: [*]const RESOURCE_DESC, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) *RESOURCE_ALLOCATION_INFO {
        return IDevice4.GetResourceAllocationInfo1(@ptrCast(self), info, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateLifetimeTracker(self: *IDevice10, owner: *ILifetimeOwner, guid: *const GUID, tracker: *?*anyopaque) HRESULT {
        return IDevice9.CreateLifetimeTracker(@ptrCast(self), owner, guid, tracker);
    }
    pub inline fn RemoveDevice(self: *IDevice10) void {
        IDevice9.RemoveDevice(@ptrCast(self));
    }
    pub inline fn EnumerateMetaCommands(self: *IDevice10, num_meta_cmds: *UINT, descs: ?[*]META_COMMAND_DESC) HRESULT {
        return IDevice9.EnumerateMetaCommands(@ptrCast(self), num_meta_cmds, descs);
    }
    pub inline fn EnumerateMetaCommandParameters(self: *IDevice10, cmd_id: *const GUID, stage: META_COMMAND_PARAMETER_STAGE, total_size: ?*UINT, param_count: *UINT, param_descs: ?[*]META_COMMAND_PARAMETER_DESC) HRESULT {
        return IDevice9.EnumerateMetaCommandParameters(@ptrCast(self), cmd_id, stage, total_size, param_count, param_descs);
    }
    pub inline fn CreateMetaCommand(self: *IDevice10, cmd_id: *const GUID, node_mask: UINT, creation_param_data: ?*const anyopaque, creation_param_data_size: SIZE_T, guid: *const GUID, meta_cmd: *?*anyopaque) HRESULT {
        return IDevice9.CreateMetaCommand(@ptrCast(self), cmd_id, node_mask, creation_param_data, creation_param_data_size, guid, meta_cmd);
    }
    pub inline fn CreateStateObject(self: *IDevice10, desc: *const STATE_OBJECT_DESC, guid: *const GUID, state_object: *?*anyopaque) HRESULT {
        return IDevice9.CreateStateObject(@ptrCast(self), desc, guid, state_object);
    }
    pub inline fn GetRaytracingAccelerationStructurePrebuildInfo(self: *IDevice10, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS, info: *RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO) void {
        IDevice9.GetRaytracingAccelerationStructurePrebuildInfo(@ptrCast(self), desc, info);
    }
    pub inline fn CheckDriverMatchingIdentifier(self: *IDevice10, serialized_data_type: SERIALIZED_DATA_TYPE, identifier_to_check: *const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER) DRIVER_MATCHING_IDENTIFIER_STATUS {
        return IDevice9.CheckDriverMatchingIdentifier(@ptrCast(self), serialized_data_type, identifier_to_check);
    }
    pub inline fn SetBackgroundProcessingMode(self: *IDevice10, mode: BACKGROUND_PROCESSING_MODE, measurements_action: MEASUREMENTS_ACTION, event_to_signal_upon_completion: ?HANDLE, further_measurements_desired: ?*BOOL) HRESULT {
        return IDevice9.SetBackgroundProcessingMode(@ptrCast(self), mode, measurements_action, event_to_signal_upon_completion, further_measurements_desired);
    }
    pub inline fn AddToStateObject(self: *IDevice10, addition: *const STATE_OBJECT_DESC, state_object: *IStateObject, guid: *const GUID, new_state_object: *?*anyopaque) HRESULT {
        return IDevice9.AddToStateObject(@ptrCast(self), addition, state_object, guid, new_state_object);
    }
    pub inline fn CreateProtectedResourceSession1(self: *IDevice10, desc: *const PROTECTED_RESOURCE_SESSION_DESC1, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice9.CreateProtectedResourceSession1(@ptrCast(self), desc, guid, session);
    }
    pub inline fn GetResourceAllocationInfo2(self: *IDevice10, visible_mask: UINT, num_resource_descs: UINT, resource_descs: *const RESOURCE_DESC1, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) RESOURCE_ALLOCATION_INFO {
        return IDevice9.GetResourceAllocationInfo2(@ptrCast(self), visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateCommittedResource2(self: *IDevice10, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC1, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, prsession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateCommittedResource2(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, prsession, guid, resource);
    }
    pub inline fn CreatePlacedResource1(self: *IDevice10, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC1, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice9.CreatePlacedResource1(@ptrCast(self), heap, heap_offset, desc, initial_state, clear_value, guid, resource);
    }
    pub inline fn CreateSamplerFeedbackUnorderedAccessView(self: *IDevice10, targeted_resource: ?*IResource, feedback_resource: ?*IResource, dest_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice9.CreateSamplerFeedbackUnorderedAccessView(@ptrCast(self), targeted_resource, feedback_resource, dest_descriptor);
    }
    pub inline fn GetCopyableFootprints1(self: *IDevice10, desc: *const RESOURCE_DESC1, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size_in_bytes: ?[*]UINT64, total_bytes: ?*UINT64) void {
        IDevice9.GetCopyableFootprints1(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size_in_bytes, total_bytes);
    }
    pub inline fn CreateShaderCacheSession(self: *IDevice10, desc: *const SHADER_CACHE_SESSION_DESC, guid: *const GUID, session: ?*?*anyopaque) HRESULT {
        return IDevice9.CreateShaderCacheSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn ShaderCacheControl(self: *IDevice10, kinds: SHADER_CACHE_KIND_FLAGS, control: SHADER_CACHE_CONTROL_FLAGS) HRESULT {
        return IDevice9.ShaderCacheControl(@ptrCast(self), kinds, control);
    }
    pub inline fn CreateCommandQueue1(self: *IDevice10, desc: *const COMMAND_QUEUE_DESC, creator_id: *const GUID, guid: *const GUID, cmdqueue: *?*anyopaque) HRESULT {
        return IDevice9.CreateCommandQueue1(@ptrCast(self), desc, creator_id, guid, cmdqueue);
    }
    pub inline fn CreateCommittedResource3(self: *IDevice10, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC1, initial_layout: BARRIER_LAYOUT, clear_value: ?*const CLEAR_VALUE, prsession: ?*IProtectedResourceSession, num_castable_formats: UINT32, castable_formats: ?[*]dxgi.FORMAT, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreateCommittedResource3(self, heap_properties, heap_flags, desc, initial_layout, clear_value, prsession, num_castable_formats, castable_formats, guid, resource);
    }
    pub inline fn CreatePlacedResource2(self: *IDevice10, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC1, initial_layout: BARRIER_LAYOUT, clear_value: ?*const CLEAR_VALUE, num_castable_formats: UINT32, castable_formats: ?[*]dxgi.FORMAT, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreatePlacedResource2(self, heap, heap_offset, desc, initial_layout, clear_value, num_castable_formats, castable_formats, guid, resource);
    }
    pub inline fn CreateReservedResource2(self: *IDevice10, desc: *const RESOURCE_DESC, initial_layout: BARRIER_LAYOUT, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, num_castable_formats: UINT32, castable_formats: ?[*]dxgi.FORMAT, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return self.__v.CreateReservedResource2(self, desc, initial_layout, clear_value, psession, num_castable_formats, castable_formats, guid, resource);
    }
    pub const VTable = extern struct {
        base: IDevice9.VTable,
        CreateCommittedResource3: *const fn (
            *IDevice10,
            *const HEAP_PROPERTIES,
            HEAP_FLAGS,
            *const RESOURCE_DESC1,
            BARRIER_LAYOUT,
            ?*const CLEAR_VALUE,
            ?*IProtectedResourceSession,
            UINT32,
            ?[*]dxgi.FORMAT,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreatePlacedResource2: *const fn (
            *IDevice10,
            *IHeap,
            UINT64,
            *const RESOURCE_DESC1,
            BARRIER_LAYOUT,
            ?*const CLEAR_VALUE,
            UINT32,
            ?[*]dxgi.FORMAT,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        CreateReservedResource2: *const fn (
            *IDevice10,
            *const RESOURCE_DESC,
            BARRIER_LAYOUT,
            ?*const CLEAR_VALUE,
            ?*IProtectedResourceSession,
            UINT32,
            ?[*]dxgi.FORMAT,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
    };
};

pub const SAMPLER_FLAGS = packed struct(UINT) {
    UINT_BORDER_COLOR: bool = false,
    __unused: u31 = 0,
};

pub const SAMPLER_DESC2 = extern struct {
    Filter: FILTER,
    AddressU: TEXTURE_ADDRESS_MODE,
    AddressV: TEXTURE_ADDRESS_MODE,
    AddressW: TEXTURE_ADDRESS_MODE,
    MipLODBias: FLOAT,
    MaxAnisotropy: UINT,
    ComparisonFunc: COMPARISON_FUNC,
    u: extern union {
        FloatBorderColor: [4]FLOAT,
        UintBorderColor: [4]UINT,
    },
    MinLOD: FLOAT,
    MaxLOD: FLOAT,
    Flags: SAMPLER_FLAGS,
};

pub const IID_IDevice11 = GUID.parse("{5405c344-d457-444e-b4dd-2366e45aee39}");
pub const IDevice11 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice11, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDevice10.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice11) ULONG {
        return IDevice10.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice11) ULONG {
        return IDevice10.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IDevice11, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDevice10.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IDevice11, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDevice10.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IDevice11, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDevice10.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IDevice11, name: LPCWSTR) HRESULT {
        return IDevice10.SetName(@ptrCast(self), name);
    }
    pub inline fn GetNodeCount(self: *IDevice11) UINT {
        return IDevice10.GetNodeCount(@ptrCast(self));
    }
    pub inline fn CreateCommandQueue(self: *IDevice11, desc: *const COMMAND_QUEUE_DESC, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice10.CreateCommandQueue(@ptrCast(self), desc, guid, obj);
    }
    pub inline fn CreateCommandAllocator(self: *IDevice11, cmdlist_type: COMMAND_LIST_TYPE, guid: *const GUID, obj: *?*anyopaque) HRESULT {
        return IDevice10.CreateCommandAllocator(@ptrCast(self), cmdlist_type, guid, obj);
    }
    pub inline fn CreateGraphicsPipelineState(self: *IDevice11, desc: *const GRAPHICS_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice10.CreateGraphicsPipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateComputePipelineState(self: *IDevice11, desc: *const COMPUTE_PIPELINE_STATE_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice10.CreateComputePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn CreateCommandList(self: *IDevice11, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, cmdalloc: *ICommandAllocator, initial_state: ?*IPipelineState, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice10.CreateCommandList(@ptrCast(self), node_mask, cmdlist_type, cmdalloc, initial_state, guid, cmdlist);
    }
    pub inline fn CheckFeatureSupport(self: *IDevice11, feature: FEATURE, data: *anyopaque, data_size: UINT) HRESULT {
        return IDevice10.CheckFeatureSupport(@ptrCast(self), feature, data, data_size);
    }
    pub inline fn CreateDescriptorHeap(self: *IDevice11, desc: *const DESCRIPTOR_HEAP_DESC, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice10.CreateDescriptorHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn GetDescriptorHandleIncrementSize(self: *IDevice11, heap_type: DESCRIPTOR_HEAP_TYPE) UINT {
        return IDevice10.GetDescriptorHandleIncrementSize(@ptrCast(self), heap_type);
    }
    pub inline fn CreateRootSignature(self: *IDevice11, node_mask: UINT, blob: *const anyopaque, blob_size: UINT64, guid: *const GUID, signature: *?*anyopaque) HRESULT {
        return IDevice10.CreateRootSignature(@ptrCast(self), node_mask, blob, blob_size, guid, signature);
    }
    pub inline fn CreateConstantBufferView(self: *IDevice11, desc: ?*const CONSTANT_BUFFER_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice10.CreateConstantBufferView(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CreateShaderResourceView(self: *IDevice11, resource: ?*IResource, desc: ?*const SHADER_RESOURCE_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice10.CreateShaderResourceView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateUnorderedAccessView(self: *IDevice11, resource: ?*IResource, counter_resource: ?*IResource, desc: ?*const UNORDERED_ACCESS_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice10.CreateUnorderedAccessView(@ptrCast(self), resource, counter_resource, desc, dst_descriptor);
    }
    pub inline fn CreateRenderTargetView(self: *IDevice11, resource: ?*IResource, desc: ?*const RENDER_TARGET_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice10.CreateRenderTargetView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateDepthStencilView(self: *IDevice11, resource: ?*IResource, desc: ?*const DEPTH_STENCIL_VIEW_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice10.CreateDepthStencilView(@ptrCast(self), resource, desc, dst_descriptor);
    }
    pub inline fn CreateSampler(self: *IDevice11, desc: *const SAMPLER_DESC, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice10.CreateSampler(@ptrCast(self), desc, dst_descriptor);
    }
    pub inline fn CopyDescriptors(self: *IDevice11, num_dst_ranges: UINT, dst_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, dst_range_sizes: ?[*]const UINT, num_src_ranges: UINT, src_range_starts: [*]const CPU_DESCRIPTOR_HANDLE, src_range_sizes: ?[*]const UINT, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice10.CopyDescriptors(@ptrCast(self), num_dst_ranges, dst_range_starts, dst_range_sizes, num_src_ranges, src_range_starts, src_range_sizes, heap_type);
    }
    pub inline fn CopyDescriptorsSimple(self: *IDevice11, num: UINT, dst_range_start: CPU_DESCRIPTOR_HANDLE, src_range_start: CPU_DESCRIPTOR_HANDLE, heap_type: DESCRIPTOR_HEAP_TYPE) void {
        IDevice10.CopyDescriptorsSimple(@ptrCast(self), num, dst_range_start, src_range_start, heap_type);
    }
    pub inline fn GetResourceAllocationInfo(self: *IDevice11, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_descs: UINT, descs: [*]const RESOURCE_DESC) *RESOURCE_ALLOCATION_INFO {
        return IDevice.GetResourceAllocationInfo(@ptrCast(self), info, visible_mask, num_descs, descs);
    }
    pub inline fn GetCustomHeapProperties(self: *IDevice11, props: *HEAP_PROPERTIES, node_mask: UINT, heap_type: HEAP_TYPE) *HEAP_PROPERTIES {
        return IDevice.GetCustomHeapProperties(@ptrCast(self), props, node_mask, heap_type);
    }
    pub inline fn CreateCommittedResource(self: *IDevice11, heap_props: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateCommittedResource(@ptrCast(self), heap_props, heap_flags, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateHeap(self: *IDevice11, desc: *const HEAP_DESC, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateHeap(@ptrCast(self), desc, guid, heap);
    }
    pub inline fn CreatePlacedResource(self: *IDevice11, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreatePlacedResource(@ptrCast(self), heap, heap_offset, desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateReservedResource(self: *IDevice11, desc: *const RESOURCE_DESC, state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateReservedResource(@ptrCast(self), desc, state, clear_value, guid, resource);
    }
    pub inline fn CreateSharedHandle(self: *IDevice11, object: *IDeviceChild, attributes: ?*const SECURITY_ATTRIBUTES, access: DWORD, name: ?LPCWSTR, handle: ?*HANDLE) HRESULT {
        return IDevice10.CreateSharedHandle(@ptrCast(self), object, attributes, access, name, handle);
    }
    pub inline fn OpenSharedHandle(self: *IDevice11, handle: HANDLE, guid: *const GUID, object: ?*?*anyopaque) HRESULT {
        return IDevice10.OpenSharedHandle(@ptrCast(self), handle, guid, object);
    }
    pub inline fn OpenSharedHandleByName(self: *IDevice11, name: LPCWSTR, access: DWORD, handle: ?*HANDLE) HRESULT {
        return IDevice10.OpenSharedHandleByName(@ptrCast(self), name, access, handle);
    }
    pub inline fn MakeResident(self: *IDevice11, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice10.MakeResident(@ptrCast(self), num, objects);
    }
    pub inline fn Evict(self: *IDevice11, num: UINT, objects: [*]const *IPageable) HRESULT {
        return IDevice10.Evict(@ptrCast(self), num, objects);
    }
    pub inline fn CreateFence(self: *IDevice11, initial_value: UINT64, flags: FENCE_FLAGS, guid: *const GUID, fence: *?*anyopaque) HRESULT {
        return IDevice10.CreateFence(@ptrCast(self), initial_value, flags, guid, fence);
    }
    pub inline fn GetDeviceRemovedReason(self: *IDevice11) HRESULT {
        return IDevice10.GetDeviceRemovedReason(@ptrCast(self));
    }
    pub inline fn GetCopyableFootprints(self: *IDevice11, desc: *const RESOURCE_DESC, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size: ?[*]UINT64, total_sizie: ?*UINT64) void {
        IDevice10.GetCopyableFootprints(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size, total_sizie);
    }
    pub inline fn CreateQueryHeap(self: *IDevice11, desc: *const QUERY_HEAP_DESC, guid: *const GUID, query_heap: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateQueryHeap(@ptrCast(self), desc, guid, query_heap);
    }
    pub inline fn SetStablePowerState(self: *IDevice11, enable: BOOL) HRESULT {
        return IDevice10.SetStablePowerState(@ptrCast(self), enable);
    }
    pub inline fn CreateCommandSignature(self: *IDevice11, desc: *const COMMAND_SIGNATURE_DESC, root_signature: ?*IRootSignature, guid: *const GUID, cmd_signature: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateCommandSignature(@ptrCast(self), desc, root_signature, guid, cmd_signature);
    }
    pub inline fn GetResourceTiling(self: *IDevice11, resource: *IResource, num_resource_tiles: ?*UINT, packed_mip_desc: ?*PACKED_MIP_INFO, std_tile_shape_non_packed_mips: ?*TILE_SHAPE, num_subresource_tilings: ?*UINT, first_subresource: UINT, subresource_tiling_for_non_packed_mips: [*]SUBRESOURCE_TILING) void {
        IDevice10.GetResourceTiling(@ptrCast(self), resource, num_resource_tiles, packed_mip_desc, std_tile_shape_non_packed_mips, num_subresource_tilings, first_subresource, subresource_tiling_for_non_packed_mips);
    }
    pub inline fn GetAdapterLuid(self: *IDevice11, luid: *LUID) *LUID {
        return IDevice.GetAdapterLuid(@ptrCast(self), luid);
    }
    pub inline fn CreatePipelineLibrary(self: *IDevice11, blob: *const anyopaque, blob_length: SIZE_T, guid: *const GUID, library: *?*anyopaque) HRESULT {
        return IDevice10.CreatePipelineLibrary(@ptrCast(self), blob, blob_length, guid, library);
    }
    pub inline fn SetEventOnMultipleFenceCompletion(self: *IDevice11, fences: [*]const *IFence, fence_values: [*]const UINT64, num_fences: UINT, flags: MULTIPLE_FENCE_WAIT_FLAGS, event: HANDLE) HRESULT {
        return IDevice10.SetEventOnMultipleFenceCompletion(@ptrCast(self), fences, fence_values, num_fences, flags, event);
    }
    pub inline fn SetResidencyPriority(self: *IDevice11, num_objects: UINT, objects: [*]const *IPageable, priorities: [*]const RESIDENCY_PRIORITY) HRESULT {
        return IDevice10.SetResidencyPriority(@ptrCast(self), num_objects, objects, priorities);
    }
    pub inline fn CreatePipelineState(self: *IDevice11, desc: *const PIPELINE_STATE_STREAM_DESC, guid: *const GUID, pso: *?*anyopaque) HRESULT {
        return IDevice10.CreatePipelineState(@ptrCast(self), desc, guid, pso);
    }
    pub inline fn OpenExistingHeapFromAddress(self: *IDevice11, address: *const anyopaque, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice10.OpenExistingHeapFromAddress(@ptrCast(self), address, guid, heap);
    }
    pub inline fn OpenExistingHeapFromFileMapping(self: *IDevice11, file_mapping: HANDLE, guid: *const GUID, heap: *?*anyopaque) HRESULT {
        return IDevice10.OpenExistingHeapFromFileMapping(@ptrCast(self), file_mapping, guid, heap);
    }
    pub inline fn EnqueueMakeResident(self: *IDevice11, flags: RESIDENCY_FLAGS, num_objects: UINT, objects: [*]const *IPageable, fence_to_signal: *IFence, fence_value_to_signal: UINT64) HRESULT {
        return IDevice10.EnqueueMakeResident(@ptrCast(self), flags, num_objects, objects, fence_to_signal, fence_value_to_signal);
    }
    pub inline fn CreateCommandList1(self: *IDevice11, node_mask: UINT, cmdlist_type: COMMAND_LIST_TYPE, flags: COMMAND_LIST_FLAGS, guid: *const GUID, cmdlist: *?*anyopaque) HRESULT {
        return IDevice10.CreateCommandList1(@ptrCast(self), node_mask, cmdlist_type, flags, guid, cmdlist);
    }
    pub inline fn CreateProtectedResourceSession(self: *IDevice11, desc: *const PROTECTED_RESOURCE_SESSION_DESC, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice10.CreateProtectedResourceSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn CreateCommittedResource1(self: *IDevice11, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateCommittedResource1(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn CreateHeap1(self: *IDevice11, desc: *const HEAP_DESC, psession: ?*IProtectedResourceSession, guid: *const GUID, heap: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateHeap1(@ptrCast(self), desc, psession, guid, heap);
    }
    pub inline fn CreateReservedResource1(self: *IDevice11, desc: *const RESOURCE_DESC, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateReservedResource1(@ptrCast(self), desc, initial_state, clear_value, psession, guid, resource);
    }
    pub inline fn GetResourceAllocationInfo1(self: *IDevice11, info: *RESOURCE_ALLOCATION_INFO, visible_mask: UINT, num_resource_descs: UINT, resource_descs: [*]const RESOURCE_DESC, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) *RESOURCE_ALLOCATION_INFO {
        return IDevice4.GetResourceAllocationInfo1(@ptrCast(self), info, visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateLifetimeTracker(self: *IDevice11, owner: *ILifetimeOwner, guid: *const GUID, tracker: *?*anyopaque) HRESULT {
        return IDevice10.CreateLifetimeTracker(@ptrCast(self), owner, guid, tracker);
    }
    pub inline fn RemoveDevice(self: *IDevice11) void {
        IDevice10.RemoveDevice(@ptrCast(self));
    }
    pub inline fn EnumerateMetaCommands(self: *IDevice11, num_meta_cmds: *UINT, descs: ?[*]META_COMMAND_DESC) HRESULT {
        return IDevice10.EnumerateMetaCommands(@ptrCast(self), num_meta_cmds, descs);
    }
    pub inline fn EnumerateMetaCommandParameters(self: *IDevice11, cmd_id: *const GUID, stage: META_COMMAND_PARAMETER_STAGE, total_size: ?*UINT, param_count: *UINT, param_descs: ?[*]META_COMMAND_PARAMETER_DESC) HRESULT {
        return IDevice10.EnumerateMetaCommandParameters(@ptrCast(self), cmd_id, stage, total_size, param_count, param_descs);
    }
    pub inline fn CreateMetaCommand(self: *IDevice11, cmd_id: *const GUID, node_mask: UINT, creation_param_data: ?*const anyopaque, creation_param_data_size: SIZE_T, guid: *const GUID, meta_cmd: *?*anyopaque) HRESULT {
        return IDevice10.CreateMetaCommand(@ptrCast(self), cmd_id, node_mask, creation_param_data, creation_param_data_size, guid, meta_cmd);
    }
    pub inline fn CreateStateObject(self: *IDevice11, desc: *const STATE_OBJECT_DESC, guid: *const GUID, state_object: *?*anyopaque) HRESULT {
        return IDevice10.CreateStateObject(@ptrCast(self), desc, guid, state_object);
    }
    pub inline fn GetRaytracingAccelerationStructurePrebuildInfo(self: *IDevice11, desc: *const BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INPUTS, info: *RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO) void {
        IDevice10.GetRaytracingAccelerationStructurePrebuildInfo(@ptrCast(self), desc, info);
    }
    pub inline fn CheckDriverMatchingIdentifier(self: *IDevice11, serialized_data_type: SERIALIZED_DATA_TYPE, identifier_to_check: *const SERIALIZED_DATA_DRIVER_MATCHING_IDENTIFIER) DRIVER_MATCHING_IDENTIFIER_STATUS {
        return IDevice10.CheckDriverMatchingIdentifier(@ptrCast(self), serialized_data_type, identifier_to_check);
    }
    pub inline fn SetBackgroundProcessingMode(self: *IDevice11, mode: BACKGROUND_PROCESSING_MODE, measurements_action: MEASUREMENTS_ACTION, event_to_signal_upon_completion: ?HANDLE, further_measurements_desired: ?*BOOL) HRESULT {
        return IDevice10.SetBackgroundProcessingMode(@ptrCast(self), mode, measurements_action, event_to_signal_upon_completion, further_measurements_desired);
    }
    pub inline fn AddToStateObject(self: *IDevice11, addition: *const STATE_OBJECT_DESC, state_object: *IStateObject, guid: *const GUID, new_state_object: *?*anyopaque) HRESULT {
        return IDevice10.AddToStateObject(@ptrCast(self), addition, state_object, guid, new_state_object);
    }
    pub inline fn CreateProtectedResourceSession1(self: *IDevice11, desc: *const PROTECTED_RESOURCE_SESSION_DESC1, guid: *const GUID, session: *?*anyopaque) HRESULT {
        return IDevice10.CreateProtectedResourceSession1(@ptrCast(self), desc, guid, session);
    }
    pub inline fn GetResourceAllocationInfo2(self: *IDevice11, visible_mask: UINT, num_resource_descs: UINT, resource_descs: *const RESOURCE_DESC1, alloc_info: ?[*]RESOURCE_ALLOCATION_INFO1) RESOURCE_ALLOCATION_INFO {
        return IDevice10.GetResourceAllocationInfo2(@ptrCast(self), visible_mask, num_resource_descs, resource_descs, alloc_info);
    }
    pub inline fn CreateCommittedResource2(self: *IDevice11, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC1, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, prsession: ?*IProtectedResourceSession, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateCommittedResource2(@ptrCast(self), heap_properties, heap_flags, desc, initial_state, clear_value, prsession, guid, resource);
    }
    pub inline fn CreatePlacedResource1(self: *IDevice11, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC1, initial_state: RESOURCE_STATES, clear_value: ?*const CLEAR_VALUE, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreatePlacedResource1(@ptrCast(self), heap, heap_offset, desc, initial_state, clear_value, guid, resource);
    }
    pub inline fn CreateSamplerFeedbackUnorderedAccessView(self: *IDevice11, targeted_resource: ?*IResource, feedback_resource: ?*IResource, dest_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        IDevice10.CreateSamplerFeedbackUnorderedAccessView(@ptrCast(self), targeted_resource, feedback_resource, dest_descriptor);
    }
    pub inline fn GetCopyableFootprints1(self: *IDevice11, desc: *const RESOURCE_DESC1, first_subresource: UINT, num_subresources: UINT, base_offset: UINT64, layouts: ?[*]PLACED_SUBRESOURCE_FOOTPRINT, num_rows: ?[*]UINT, row_size_in_bytes: ?[*]UINT64, total_bytes: ?*UINT64) void {
        IDevice10.GetCopyableFootprints1(@ptrCast(self), desc, first_subresource, num_subresources, base_offset, layouts, num_rows, row_size_in_bytes, total_bytes);
    }
    pub inline fn CreateShaderCacheSession(self: *IDevice11, desc: *const SHADER_CACHE_SESSION_DESC, guid: *const GUID, session: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateShaderCacheSession(@ptrCast(self), desc, guid, session);
    }
    pub inline fn ShaderCacheControl(self: *IDevice11, kinds: SHADER_CACHE_KIND_FLAGS, control: SHADER_CACHE_CONTROL_FLAGS) HRESULT {
        return IDevice10.ShaderCacheControl(@ptrCast(self), kinds, control);
    }
    pub inline fn CreateCommandQueue1(self: *IDevice11, desc: *const COMMAND_QUEUE_DESC, creator_id: *const GUID, guid: *const GUID, cmdqueue: *?*anyopaque) HRESULT {
        return IDevice10.CreateCommandQueue1(@ptrCast(self), desc, creator_id, guid, cmdqueue);
    }
    pub inline fn CreateCommittedResource3(self: *IDevice11, heap_properties: *const HEAP_PROPERTIES, heap_flags: HEAP_FLAGS, desc: *const RESOURCE_DESC1, initial_layout: BARRIER_LAYOUT, clear_value: ?*const CLEAR_VALUE, prsession: ?*IProtectedResourceSession, num_castable_formats: UINT32, castable_formats: ?[*]dxgi.FORMAT, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateCommittedResource3(@ptrCast(self), heap_properties, heap_flags, desc, initial_layout, clear_value, prsession, num_castable_formats, castable_formats, guid, resource);
    }
    pub inline fn CreatePlacedResource2(self: *IDevice11, heap: *IHeap, heap_offset: UINT64, desc: *const RESOURCE_DESC1, initial_layout: BARRIER_LAYOUT, clear_value: ?*const CLEAR_VALUE, num_castable_formats: UINT32, castable_formats: ?[*]dxgi.FORMAT, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreatePlacedResource2(@ptrCast(self), heap, heap_offset, desc, initial_layout, clear_value, num_castable_formats, castable_formats, guid, resource);
    }
    pub inline fn CreateReservedResource2(self: *IDevice11, desc: *const RESOURCE_DESC, initial_layout: BARRIER_LAYOUT, clear_value: ?*const CLEAR_VALUE, psession: ?*IProtectedResourceSession, num_castable_formats: UINT32, castable_formats: ?[*]dxgi.FORMAT, guid: *const GUID, resource: ?*?*anyopaque) HRESULT {
        return IDevice10.CreateReservedResource2(@ptrCast(self), desc, initial_layout, clear_value, psession, num_castable_formats, castable_formats, guid, resource);
    }
    pub inline fn CreateSampler2(self: *IDevice11, desc: *const SAMPLER_DESC2, dst_descriptor: CPU_DESCRIPTOR_HANDLE) void {
        self.__v.CreateSampler2(self, desc, dst_descriptor);
    }
    pub const VTable = extern struct {
        base: IDevice10.VTable,
        CreateSampler2: *const fn (*IDevice11, *const SAMPLER_DESC2, CPU_DESCRIPTOR_HANDLE) callconv(WINAPI) void,
    };
};

pub const PROTECTED_SESSION_STATUS = enum(UINT) {
    OK = 0,
    INVALID = 1,
};

pub const IProtectedSession = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IProtectedSession, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IDeviceChild.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IProtectedSession) ULONG {
        return IDeviceChild.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IProtectedSession) ULONG {
        return IDeviceChild.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IProtectedSession, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IDeviceChild.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IProtectedSession, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IDeviceChild.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IProtectedSession, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IDeviceChild.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IProtectedSession, name: LPCWSTR) HRESULT {
        return IDeviceChild.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IProtectedSession, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IDeviceChild.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetStatusFence(self: *IProtectedSession, guid: *const GUID, fence: ?*?*anyopaque) HRESULT {
        return self.__v.GetStatusFence(self, guid, fence);
    }
    pub inline fn GetSessionStatus(self: *IProtectedSession) PROTECTED_SESSION_STATUS {
        return self.__v.GetSessionStatus(self);
    }
    pub const VTable = extern struct {
        base: IDeviceChild.VTable,
        GetStatusFence: *const fn (*IProtectedSession, *const GUID, ?*?*anyopaque) callconv(WINAPI) HRESULT,
        GetSessionStatus: *const fn (*IProtectedSession) callconv(WINAPI) PROTECTED_SESSION_STATUS,
    };
};

pub const PROTECTED_RESOURCE_SESSION_FLAGS = packed struct(UINT) {
    __unused: u32 = 0,
};

pub const PROTECTED_RESOURCE_SESSION_DESC = extern struct {
    NodeMask: UINT,
    Flags: PROTECTED_RESOURCE_SESSION_FLAGS,
};

pub const IProtectedResourceSession = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IProtectedResourceSession, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IProtectedSession.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IProtectedResourceSession) ULONG {
        return IProtectedSession.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IProtectedResourceSession) ULONG {
        return IProtectedSession.Release(@ptrCast(self));
    }
    pub inline fn GetPrivateData(self: *IProtectedResourceSession, guid: *const GUID, data_size: *UINT, data: ?*anyopaque) HRESULT {
        return IProtectedSession.GetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateData(self: *IProtectedResourceSession, guid: *const GUID, data_size: UINT, data: ?*const anyopaque) HRESULT {
        return IProtectedSession.SetPrivateData(@ptrCast(self), guid, data_size, data);
    }
    pub inline fn SetPrivateDataInterface(self: *IProtectedResourceSession, guid: *const GUID, data: ?*const IUnknown) HRESULT {
        return IProtectedSession.SetPrivateDataInterface(@ptrCast(self), guid, data);
    }
    pub inline fn SetName(self: *IProtectedResourceSession, name: LPCWSTR) HRESULT {
        return IProtectedSession.SetName(@ptrCast(self), name);
    }
    pub inline fn GetDevice(self: *IProtectedResourceSession, guid: *const GUID, device: *?*anyopaque) HRESULT {
        return IProtectedSession.GetDevice(@ptrCast(self), guid, device);
    }
    pub inline fn GetStatusFence(self: *IProtectedResourceSession, guid: *const GUID, fence: ?*?*anyopaque) HRESULT {
        return IProtectedSession.GetStatusFence(@ptrCast(self), guid, fence);
    }
    pub inline fn GetSessionStatus(self: *IProtectedResourceSession) PROTECTED_SESSION_STATUS {
        return IProtectedSession.GetSessionStatus(@ptrCast(self));
    }
    pub inline fn GetDesc(self: *IProtectedResourceSession, desc: *PROTECTED_RESOURCE_SESSION_DESC) *PROTECTED_RESOURCE_SESSION_DESC {
        return self.__v.GetDesc(self, desc);
    }
    pub const VTable = extern struct {
        base: IProtectedSession.VTable,
        GetDesc: *const fn (
            *IProtectedResourceSession,
            *PROTECTED_RESOURCE_SESSION_DESC,
        ) callconv(WINAPI) *PROTECTED_RESOURCE_SESSION_DESC,
    };
};

extern "d3d12" fn D3D12GetDebugInterface(*const GUID, ?*?*anyopaque) callconv(WINAPI) HRESULT;

extern "d3d12" fn D3D12CreateDevice(
    ?*IUnknown,
    d3d.FEATURE_LEVEL,
    *const GUID,
    ?*?*anyopaque,
) callconv(WINAPI) HRESULT;

extern "d3d12" fn D3D12SerializeVersionedRootSignature(
    *const VERSIONED_ROOT_SIGNATURE_DESC,
    ?*?*d3d.IBlob,
    ?*?*d3d.IBlob,
) callconv(WINAPI) HRESULT;

pub const CreateDevice = D3D12CreateDevice;
pub const GetDebugInterface = D3D12GetDebugInterface;
pub const SerializeVersionedRootSignature = D3D12SerializeVersionedRootSignature;

pub const DEBUG_FEATURE = packed struct(UINT) {
    ALLOW_BEHAVIOR_CHANGING_DEBUG_AIDS: bool = false,
    CONSERVATIVE_RESOURCE_STATE_TRACKING: bool = false,
    DISABLE_VIRTUALIZED_BUNDLES_VALIDATION: bool = false,
    EMULATE_WINDOWS7: bool = false,
    __unused: u28 = 0,
};

pub const RLDO_FLAGS = packed struct(UINT) {
    SUMMARY: bool = false,
    DETAIL: bool = false,
    IGNORE_INTERNAL: bool = false,
    ALL: bool = false,
    __unused: u28 = 0,
};

pub const IID_IDebugDevice = GUID.parse("{3febd6dd-4973-4787-8194-e45f9e28923e}");
pub const IDebugDevice = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDebugDevice, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDebugDevice) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDebugDevice) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn SetFeatureMask(self: *IDebugDevice, mask: DEBUG_FEATURE) HRESULT {
        return self.__v.SetFeatureMask(self, mask);
    }
    pub inline fn GetFeatureMask(self: *IDebugDevice) DEBUG_FEATURE {
        return self.__v.GetFeatureMask(self);
    }
    pub inline fn ReportLiveDeviceObjects(self: *IDebugDevice, flags: RLDO_FLAGS) HRESULT {
        return self.__v.ReportLiveDeviceObjects(self, flags);
    }
    pub const VTable = extern struct {
        const T = IDebugDevice;
        base: IUnknown.VTable,
        SetFeatureMask: *const fn (*T, DEBUG_FEATURE) callconv(WINAPI) HRESULT,
        GetFeatureMask: *const fn (*T) callconv(WINAPI) DEBUG_FEATURE,
        ReportLiveDeviceObjects: *const fn (*T, RLDO_FLAGS) callconv(WINAPI) HRESULT,
    };
};

pub const IID_ICommandQueue = GUID{
    .Data1 = 0x0ec870a6,
    .Data2 = 0x5d7e,
    .Data3 = 0x4c22,
    .Data4 = .{ 0x8c, 0xfc, 0x5b, 0xaa, 0xe0, 0x76, 0x16, 0xed },
};
pub const IID_IFence = GUID{
    .Data1 = 0x0a753dcf,
    .Data2 = 0xc4d8,
    .Data3 = 0x4b91,
    .Data4 = .{ 0xad, 0xf6, 0xbe, 0x5a, 0x60, 0xd9, 0x5a, 0x76 },
};
pub const IID_ICommandAllocator = GUID{
    .Data1 = 0x6102dee4,
    .Data2 = 0xaf59,
    .Data3 = 0x4b09,
    .Data4 = .{ 0xb9, 0x99, 0xb4, 0x4d, 0x73, 0xf0, 0x9b, 0x24 },
};
pub const IID_IPipelineState = GUID{
    .Data1 = 0x765a30f3,
    .Data2 = 0xf624,
    .Data3 = 0x4c6f,
    .Data4 = .{ 0xa8, 0x28, 0xac, 0xe9, 0x48, 0x62, 0x24, 0x45 },
};
pub const IID_IDescriptorHeap = GUID{
    .Data1 = 0x8efb471d,
    .Data2 = 0x616c,
    .Data3 = 0x4f49,
    .Data4 = .{ 0x90, 0xf7, 0x12, 0x7b, 0xb7, 0x63, 0xfa, 0x51 },
};
pub const IID_IResource = GUID{
    .Data1 = 0x696442be,
    .Data2 = 0xa72e,
    .Data3 = 0x4059,
    .Data4 = .{ 0xbc, 0x79, 0x5b, 0x5c, 0x98, 0x04, 0x0f, 0xad },
};
pub const IID_IRootSignature = GUID{
    .Data1 = 0xc54a6b66,
    .Data2 = 0x72df,
    .Data3 = 0x4ee8,
    .Data4 = .{ 0x8b, 0xe5, 0xa9, 0x46, 0xa1, 0x42, 0x92, 0x14 },
};
pub const IID_IQueryHeap = GUID{
    .Data1 = 0x0d9658ae,
    .Data2 = 0xed45,
    .Data3 = 0x469e,
    .Data4 = .{ 0xa6, 0x1d, 0x97, 0x0e, 0xc5, 0x83, 0xca, 0xb4 },
};
pub const IID_IHeap = GUID{
    .Data1 = 0x6b3b2502,
    .Data2 = 0x6e51,
    .Data3 = 0x45b3,
    .Data4 = .{ 0x90, 0xee, 0x98, 0x84, 0x26, 0x5e, 0x8d, 0xf3 },
};

// Error return codes from:
// https://docs.microsoft.com/en-us/windows/win32/direct3d12/d3d12-graphics-reference-returnvalues
pub const ERROR_ADAPTER_NOT_FOUND = @as(HRESULT, @bitCast(@as(c_ulong, 0x887E0001)));
pub const ERROR_DRIVER_VERSION_MISMATCH = @as(HRESULT, @bitCast(@as(c_ulong, 0x887E0002)));

// Error set corresponding to the above error return codes
pub const Error = error{
    ADAPTER_NOT_FOUND,
    DRIVER_VERSION_MISMATCH,
};

test {
    std.testing.refAllDecls(@This());
}
