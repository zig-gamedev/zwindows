const windows = @import("../windows.zig");
const IUnknown = windows.IUnknown;
const ULONG = windows.ULONG;
const UINT = windows.UINT;
const WINAPI = windows.WINAPI;
const GUID = windows.GUID;
const HRESULT = windows.HRESULT;
const d3d = @import("d3dcommon.zig");
const d3d11 = @import("d3d11.zig");
const RESOURCE_STATES = @import("d3d12.zig").RESOURCE_STATES;

pub const RESOURCE_FLAGS = extern struct {
    BindFlags: d3d11.BIND_FLAG,
    MiscFlags: d3d11.RESOURCE_MISC_FLAG,
    CPUAccessFlags: d3d11.CPU_ACCCESS_FLAG,
    StructureByteStride: UINT,
};

pub const IDevice = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IDevice, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IDevice) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IDevice) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn CreateWrappedResource(self: *IDevice, resource12: *IUnknown, flags11: *const RESOURCE_FLAGS, in_state: RESOURCE_STATES, out_state: RESOURCE_STATES, guid: *const GUID, resource11: ?*?*anyopaque) HRESULT {
        return self.__v.CreateWrappedResource(self, resource12, flags11, in_state, out_state, guid, resource11);
    }
    pub inline fn ReleaseWrappedResources(self: *IDevice, resources: [*]const *d3d11.IResource, num_resources: UINT) void {
        self.__v.ReleaseWrappedResources(self, resources, num_resources);
    }
    pub inline fn AcquireWrappedResources(self: *IDevice, resources: [*]const *d3d11.IResource, num_resources: UINT) void {
        self.__v.AcquireWrappedResources(self, resources, num_resources);
    }
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        CreateWrappedResource: *const fn (
            *IDevice,
            *IUnknown,
            *const RESOURCE_FLAGS,
            RESOURCE_STATES,
            RESOURCE_STATES,
            *const GUID,
            ?*?*anyopaque,
        ) callconv(WINAPI) HRESULT,
        ReleaseWrappedResources: *const fn (*IDevice, [*]const *d3d11.IResource, UINT) callconv(WINAPI) void,
        AcquireWrappedResources: *const fn (*IDevice, [*]const *d3d11.IResource, UINT) callconv(WINAPI) void,
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
    pub inline fn CreateWrappedResource(self: *IDevice1, resource12: *IUnknown, flags11: *const RESOURCE_FLAGS, in_state: RESOURCE_STATES, out_state: RESOURCE_STATES, guid: *const GUID, resource11: ?*?*anyopaque) HRESULT {
        return IDevice.CreateWrappedResource(@ptrCast(self), resource12, flags11, in_state, out_state, guid, resource11);
    }
    pub inline fn ReleaseWrappedResources(self: *IDevice1, resources: [*]const *d3d11.IResource, num_resources: UINT) void {
        IDevice.ReleaseWrappedResources(@ptrCast(self), resources, num_resources);
    }
    pub inline fn AcquireWrappedResources(self: *IDevice1, resources: [*]const *d3d11.IResource, num_resources: UINT) void {
        IDevice.AcquireWrappedResources(@ptrCast(self), resources, num_resources);
    }
    pub const VTable = extern struct {
        base: IDevice.VTable,
        GetD3D12Device: *anyopaque,
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
    pub inline fn CreateWrappedResource(self: *IDevice2, resource12: *IUnknown, flags11: *const RESOURCE_FLAGS, in_state: RESOURCE_STATES, out_state: RESOURCE_STATES, guid: *const GUID, resource11: ?*?*anyopaque) HRESULT {
        return IDevice1.CreateWrappedResource(@ptrCast(self), resource12, flags11, in_state, out_state, guid, resource11);
    }
    pub inline fn ReleaseWrappedResources(self: *IDevice2, resources: [*]const *d3d11.IResource, num_resources: UINT) void {
        IDevice1.ReleaseWrappedResources(@ptrCast(self), resources, num_resources);
    }
    pub inline fn AcquireWrappedResources(self: *IDevice2, resources: [*]const *d3d11.IResource, num_resources: UINT) void {
        IDevice1.AcquireWrappedResources(@ptrCast(self), resources, num_resources);
    }
    pub const VTable = extern struct {
        base: IDevice1.VTable,
        UnwrapUnderlyingResource: *anyopaque,
        ReturnUnderlyingResource: *anyopaque,
    };
};

pub const IID_IDevice2 = GUID{
    .Data1 = 0xdc90f331,
    .Data2 = 0x4740,
    .Data3 = 0x43fa,
    .Data4 = .{ 0x86, 0x6e, 0x67, 0xf1, 0x2c, 0xb5, 0x82, 0x23 },
};

pub extern "d3d11" fn D3D11On12CreateDevice(
    device12: *IUnknown,
    flags11: d3d11.CREATE_DEVICE_FLAG,
    feature_levels: ?[*]const d3d.FEATURE_LEVEL,
    num_feature_levels: UINT,
    cmd_queues: [*]const *IUnknown,
    num_cmd_queues: UINT,
    node_mask: UINT,
    device11: ?*?*d3d11.IDevice,
    device_ctx11: ?*?*d3d11.IDeviceContext,
    ?*d3d.FEATURE_LEVEL,
) callconv(WINAPI) HRESULT;
