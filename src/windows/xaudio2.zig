const std = @import("std");
const windows = @import("../windows.zig");
const IUnknown = windows.IUnknown;
const ULONG = windows.ULONG;
const BYTE = windows.BYTE;
const UINT = windows.UINT;
const UINT32 = windows.UINT32;
const UINT64 = windows.UINT64;
const WINAPI = windows.WINAPI;
const LPCWSTR = windows.LPCWSTR;
const BOOL = windows.BOOL;
const DWORD = windows.DWORD;
const GUID = windows.GUID;
const HRESULT = windows.HRESULT;
const WAVEFORMATEX = @import("wasapi.zig").WAVEFORMATEX;

// NOTE(mziulek):
// xaudio2redist.h uses tight field packing so we need align each field with `align(1)`
// in all non-interface structure definitions.

pub const COMMIT_NOW = 0;
pub const COMMIT_ALL = 0;
pub const INVALID_OPSET = 0xffff_ffff;
pub const NO_LOOP_REGION = 0;
pub const LOOP_INFINITE = 255;
pub const DEFAULT_CHANNELS = 0;
pub const DEFAULT_SAMPLERATE = 0;

pub const MAX_BUFFER_BYTES = 0x8000_0000;
pub const MAX_QUEUED_BUFFERS = 64;
pub const MAX_BUFFERS_SYSTEM = 2;
pub const MAX_AUDIO_CHANNELS = 64;
pub const MIN_SAMPLE_RATE = 1000;
pub const MAX_SAMPLE_RATE = 200000;
pub const MAX_VOLUME_LEVEL = 16777216.0;
pub const MIN_FREQ_RATIO = 1.0 / 1024.0;
pub const MAX_FREQ_RATIO = 1024.0;
pub const DEFAULT_FREQ_RATIO = 2.0;
pub const MAX_FILTER_ONEOVERQ = 1.5;
pub const MAX_FILTER_FREQUENCY = 1.0;
pub const MAX_LOOP_COUNT = 254;
pub const MAX_INSTANCES = 8;

pub const FLAGS = packed struct(UINT32) {
    DEBUG_ENGINE: bool = false,
    VOICE_NOPITCH: bool = false,
    VOICE_NOSRC: bool = false,
    VOICE_USEFILTER: bool = false,
    __unused4: bool = false,
    PLAY_TAILS: bool = false,
    END_OF_STREAM: bool = false,
    SEND_USEFILTER: bool = false,
    VOICE_NOSAMPLESPLAYED: bool = false,
    __unused9: bool = false,
    __unused10: bool = false,
    __unused11: bool = false,
    __unused12: bool = false,
    STOP_ENGINE_WHEN_IDLE: bool = false,
    __unused14: bool = false,
    @"1024_QUANTUM": bool = false,
    NO_VIRTUAL_AUDIO_CLIENT: bool = false,
    __unused: u15 = 0,
};

pub const VOICE_DETAILS = extern struct {
    CreationFlags: FLAGS align(1),
    ActiveFlags: FLAGS align(1),
    InputChannels: UINT32 align(1),
    InputSampleRate: UINT32 align(1),
};

pub const SEND_DESCRIPTOR = extern struct {
    Flags: FLAGS align(1),
    pOutputVoice: *IVoice align(1),
};

pub const VOICE_SENDS = extern struct {
    SendCount: UINT32 align(1),
    pSends: [*]SEND_DESCRIPTOR align(1),
};

pub const EFFECT_DESCRIPTOR = extern struct {
    pEffect: *IUnknown align(1),
    InitialState: BOOL align(1),
    OutputChannels: UINT32 align(1),
};

pub const EFFECT_CHAIN = extern struct {
    EffectCount: UINT32 align(1),
    pEffectDescriptors: [*]EFFECT_DESCRIPTOR align(1),
};

pub const FILTER_TYPE = enum(UINT32) {
    LowPassFilter,
    BandPassFilter,
    HighPassFilter,
    NotchFilter,
    LowPassOnePoleFilter,
    HighPassOnePoleFilter,
};

pub const AUDIO_STREAM_CATEGORY = enum(UINT32) {
    Other = 0,
    ForegroundOnlyMedia = 1,
    Communications = 3,
    Alerts = 4,
    SoundEffects = 5,
    GameEffects = 6,
    GameMedia = 7,
    GameChat = 8,
    Speech = 9,
    Movie = 10,
    Media = 11,
};

pub const FILTER_PARAMETERS = extern struct {
    Type: FILTER_TYPE align(1),
    Frequency: f32 align(1),
    OneOverQ: f32 align(1),
};

pub const BUFFER = extern struct {
    Flags: FLAGS align(1),
    AudioBytes: UINT32 align(1),
    pAudioData: [*]const BYTE align(1),
    PlayBegin: UINT32 align(1),
    PlayLength: UINT32 align(1),
    LoopBegin: UINT32 align(1),
    LoopLength: UINT32 align(1),
    LoopCount: UINT32 align(1),
    pContext: ?*anyopaque align(1),
};

pub const BUFFER_WMA = extern struct {
    pDecodedPacketCumulativeBytes: *const UINT32 align(1),
    PacketCount: UINT32 align(1),
};

pub const VOICE_STATE = extern struct {
    pCurrentBufferContext: ?*anyopaque align(1),
    BuffersQueued: UINT32 align(1),
    SamplesPlayed: UINT64 align(1),
};

pub const PERFORMANCE_DATA = extern struct {
    AudioCyclesSinceLastQuery: UINT64 align(1),
    TotalCyclesSinceLastQuery: UINT64 align(1),
    MinimumCyclesPerQuantum: UINT32 align(1),
    MaximumCyclesPerQuantum: UINT32 align(1),
    MemoryUsageInBytes: UINT32 align(1),
    CurrentLatencyInSamples: UINT32 align(1),
    GlitchesSinceEngineStarted: UINT32 align(1),
    ActiveSourceVoiceCount: UINT32 align(1),
    TotalSourceVoiceCount: UINT32 align(1),
    ActiveSubmixVoiceCount: UINT32 align(1),
    ActiveResamplerCount: UINT32 align(1),
    ActiveMatrixMixCount: UINT32 align(1),
    ActiveXmaSourceVoices: UINT32 align(1),
    ActiveXmaStreams: UINT32 align(1),
};

pub const LOG_FLAGS = packed struct(UINT32) {
    ERRORS: bool = false,
    WARNINGS: bool = false,
    INFO: bool = false,
    DETAIL: bool = false,
    API_CALLS: bool = false,
    FUNC_CALLS: bool = false,
    TIMING: bool = false,
    LOCKS: bool = false,
    MEMORY: bool = false,
    __unused9: bool = false,
    __unused10: bool = false,
    __unused11: bool = false,
    STREAMING: bool = false,
    __unused: u19 = 0,
};

pub const DEBUG_CONFIGURATION = extern struct {
    TraceMask: LOG_FLAGS align(1),
    BreakMask: LOG_FLAGS align(1),
    LogThreadID: BOOL align(1),
    LogFileline: BOOL align(1),
    LogFunctionName: BOOL align(1),
    LogTiming: BOOL align(1),
};

pub const IXAudio2 = extern struct {
    __v: *const VTable,
    pub inline fn QueryInterface(self: *IXAudio2, guid: *const GUID, outobj: ?*?*anyopaque) HRESULT {
        return IUnknown.QueryInterface(@ptrCast(self), guid, outobj);
    }
    pub inline fn AddRef(self: *IXAudio2) ULONG {
        return IUnknown.AddRef(@ptrCast(self));
    }
    pub inline fn Release(self: *IXAudio2) ULONG {
        return IUnknown.Release(@ptrCast(self));
    }
    pub inline fn RegisterForCallbacks(self: *IXAudio2, cb: *IEngineCallback) HRESULT {
        return self.__v.RegisterForCallbacks(self, cb);
    }
    pub inline fn UnregisterForCallbacks(self: *IXAudio2, cb: *IEngineCallback) void {
        self.__v.UnregisterForCallbacks(self, cb);
    }
    pub inline fn CreateSourceVoice(self: *IXAudio2, source_voice: *?*ISourceVoice, source_format: *const WAVEFORMATEX, flags: FLAGS, max_frequency_ratio: f32, callback: ?*IVoiceCallback, send_list: ?*const VOICE_SENDS, effect_chain: ?*const EFFECT_CHAIN) HRESULT {
        return self.__v.CreateSourceVoice(self, source_voice, source_format, flags, max_frequency_ratio, callback, send_list, effect_chain);
    }
    pub inline fn CreateSubmixVoice(self: *IXAudio2, submix_voice: *?*ISubmixVoice, input_channels: UINT32, input_sample_rate: UINT32, flags: FLAGS, processing_stage: UINT32, send_list: ?*const VOICE_SENDS, effect_chain: ?*const EFFECT_CHAIN) HRESULT {
        return self.__v.CreateSubmixVoice(self, submix_voice, input_channels, input_sample_rate, flags, processing_stage, send_list, effect_chain);
    }
    pub inline fn CreateMasteringVoice(self: *IXAudio2, mastering_voice: *?*IMasteringVoice, input_channels: UINT32, input_sample_rate: UINT32, flags: FLAGS, device_id: ?LPCWSTR, effect_chain: ?*const EFFECT_CHAIN, stream_category: AUDIO_STREAM_CATEGORY) HRESULT {
        return self.__v.CreateMasteringVoice(self, mastering_voice, input_channels, input_sample_rate, flags, device_id, effect_chain, stream_category);
    }
    pub inline fn StartEngine(self: *IXAudio2) HRESULT {
        return self.__v.StartEngine(self);
    }
    pub inline fn StopEngine(self: *IXAudio2) void {
        self.__v.StopEngine(self);
    }
    pub inline fn CommitChanges(self: *IXAudio2, operation_set: UINT32) HRESULT {
        return self.__v.CommitChanges(self, operation_set);
    }
    pub inline fn GetPerformanceData(self: *IXAudio2, data: *PERFORMANCE_DATA) void {
        self.__v.GetPerformanceData(self, data);
    }
    pub inline fn SetDebugConfiguration(self: *IXAudio2, config: ?*const DEBUG_CONFIGURATION, reserved: ?*anyopaque) void {
        self.__v.SetDebugConfiguration(self, config, reserved);
    }
    pub const VTable = extern struct {
        const T = IXAudio2;
        base: IUnknown.VTable,
        RegisterForCallbacks: *const fn (*T, *IEngineCallback) callconv(WINAPI) HRESULT,
        UnregisterForCallbacks: *const fn (*T, *IEngineCallback) callconv(WINAPI) void,
        CreateSourceVoice: *const fn (
            *T,
            *?*ISourceVoice,
            *const WAVEFORMATEX,
            FLAGS,
            f32,
            ?*IVoiceCallback,
            ?*const VOICE_SENDS,
            ?*const EFFECT_CHAIN,
        ) callconv(WINAPI) HRESULT,
        CreateSubmixVoice: *const fn (
            *T,
            *?*ISubmixVoice,
            UINT32,
            UINT32,
            FLAGS,
            UINT32,
            ?*const VOICE_SENDS,
            ?*const EFFECT_CHAIN,
        ) callconv(WINAPI) HRESULT,
        CreateMasteringVoice: *const fn (
            *T,
            *?*IMasteringVoice,
            UINT32,
            UINT32,
            FLAGS,
            ?LPCWSTR,
            ?*const EFFECT_CHAIN,
            AUDIO_STREAM_CATEGORY,
        ) callconv(WINAPI) HRESULT,
        StartEngine: *const fn (*T) callconv(WINAPI) HRESULT,
        StopEngine: *const fn (*T) callconv(WINAPI) void,
        CommitChanges: *const fn (*T, UINT32) callconv(WINAPI) HRESULT,
        GetPerformanceData: *const fn (*T, *PERFORMANCE_DATA) callconv(WINAPI) void,
        SetDebugConfiguration: *const fn (
            *T,
            ?*const DEBUG_CONFIGURATION,
            ?*anyopaque,
        ) callconv(WINAPI) void,
    };
};

pub const IVoice = extern struct {
    __v: *const VTable,
    pub inline fn GetVoiceDetails(self: *IVoice, details: *VOICE_DETAILS) void {
        self.__v.GetVoiceDetails(self, details);
    }
    pub inline fn SetOutputVoices(self: *IVoice, send_list: ?*const VOICE_SENDS) HRESULT {
        return self.__v.SetOutputVoices(self, send_list);
    }
    pub inline fn SetEffectChain(self: *IVoice, effect_chain: ?*const EFFECT_CHAIN) HRESULT {
        return self.__v.SetEffectChain(self, effect_chain);
    }
    pub inline fn EnableEffect(self: *IVoice, effect_index: UINT32, operation_set: UINT32) HRESULT {
        return self.__v.EnableEffect(self, effect_index, operation_set);
    }
    pub inline fn DisableEffect(self: *IVoice, effect_index: UINT32, operation_set: UINT32) HRESULT {
        return self.__v.DisableEffect(self, effect_index, operation_set);
    }
    pub inline fn GetEffectState(self: *IVoice, effect_index: UINT32, enabled: *BOOL) void {
        self.__v.GetEffectState(self, effect_index, enabled);
    }
    pub inline fn SetEffectParameters(self: *IVoice, effect_index: UINT32, params: *const anyopaque, params_size: UINT32, operation_set: UINT32) HRESULT {
        return self.__v.SetEffectParameters(self, effect_index, params, params_size, operation_set);
    }
    pub inline fn GetEffectParameters(self: *IVoice, effect_index: UINT32, params: *anyopaque, params_size: UINT32) HRESULT {
        return self.__v.GetEffectParameters(self, effect_index, params, params_size);
    }
    pub inline fn SetFilterParameters(self: *IVoice, params: *const FILTER_PARAMETERS, operation_set: UINT32) HRESULT {
        return self.__v.SetFilterParameters(self, params, operation_set);
    }
    pub inline fn GetFilterParameters(self: *IVoice, params: *FILTER_PARAMETERS) void {
        self.__v.GetFilterParameters(self, params);
    }
    pub inline fn SetOutputFilterParameters(self: *IVoice, dst_voice: ?*IVoice, params: *const FILTER_PARAMETERS, operation_set: UINT32) HRESULT {
        return self.__v.SetOutputFilterParameters(self, dst_voice, params, operation_set);
    }
    pub inline fn GetOutputFilterParameters(self: *IVoice, dst_voice: ?*IVoice, params: *FILTER_PARAMETERS) void {
        self.__v.GetOutputFilterParameters(self, dst_voice, params);
    }
    pub inline fn SetVolume(self: *IVoice, volume: f32) HRESULT {
        return self.__v.SetVolume(self, volume);
    }
    pub inline fn GetVolume(self: *IVoice, volume: *f32) void {
        self.__v.GetVolume(self, volume);
    }
    pub inline fn SetChannelVolumes(self: *IVoice, num_channels: UINT32, volumes: [*]const f32, operation_set: UINT32) HRESULT {
        return self.__v.SetChannelVolumes(self, num_channels, volumes, operation_set);
    }
    pub inline fn GetChannelVolumes(self: *IVoice, num_channels: UINT32, volumes: [*]f32) void {
        self.__v.GetChannelVolumes(self, num_channels, volumes);
    }
    pub inline fn DestroyVoice(self: *IVoice) void {
        self.__v.DestroyVoice(self);
    }
    pub const VTable = extern struct {
        const T = IVoice;
        GetVoiceDetails: *const fn (*T, *VOICE_DETAILS) callconv(WINAPI) void,
        SetOutputVoices: *const fn (*T, ?*const VOICE_SENDS) callconv(WINAPI) HRESULT,
        SetEffectChain: *const fn (*T, ?*const EFFECT_CHAIN) callconv(WINAPI) HRESULT,
        EnableEffect: *const fn (*T, UINT32, UINT32) callconv(WINAPI) HRESULT,
        DisableEffect: *const fn (*T, UINT32, UINT32) callconv(WINAPI) HRESULT,
        GetEffectState: *const fn (*T, UINT32, *BOOL) callconv(WINAPI) void,
        SetEffectParameters: *const fn (
            *T,
            UINT32,
            *const anyopaque,
            UINT32,
            UINT32,
        ) callconv(WINAPI) HRESULT,
        GetEffectParameters: *const fn (*T, UINT32, *anyopaque, UINT32) callconv(WINAPI) HRESULT,
        SetFilterParameters: *const fn (
            *T,
            *const FILTER_PARAMETERS,
            UINT32,
        ) callconv(WINAPI) HRESULT,
        GetFilterParameters: *const fn (*T, *FILTER_PARAMETERS) callconv(WINAPI) void,
        SetOutputFilterParameters: *const fn (
            *T,
            ?*IVoice,
            *const FILTER_PARAMETERS,
            UINT32,
        ) callconv(WINAPI) HRESULT,
        GetOutputFilterParameters: *const fn (*T, ?*IVoice, *FILTER_PARAMETERS) callconv(WINAPI) void,
        SetVolume: *const fn (*T, f32) callconv(WINAPI) HRESULT,
        GetVolume: *const fn (*T, *f32) callconv(WINAPI) void,
        SetChannelVolumes: *const fn (*T, UINT32, [*]const f32, UINT32) callconv(WINAPI) HRESULT,
        GetChannelVolumes: *const fn (*T, UINT32, [*]f32) callconv(WINAPI) void,
        SetOutputMatrix: *anyopaque,
        GetOutputMatrix: *anyopaque,
        DestroyVoice: *const fn (*T) callconv(WINAPI) void,
    };
};

pub const ISourceVoice = extern struct {
    __v: *const VTable,
    pub inline fn GetVoiceDetails(self: *ISourceVoice, details: *VOICE_DETAILS) void {
        IVoice.GetVoiceDetails(@ptrCast(self), details);
    }
    pub inline fn SetOutputVoices(self: *ISourceVoice, send_list: ?*const VOICE_SENDS) HRESULT {
        return IVoice.SetOutputVoices(@ptrCast(self), send_list);
    }
    pub inline fn SetEffectChain(self: *ISourceVoice, effect_chain: ?*const EFFECT_CHAIN) HRESULT {
        return IVoice.SetEffectChain(@ptrCast(self), effect_chain);
    }
    pub inline fn EnableEffect(self: *ISourceVoice, effect_index: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.EnableEffect(@ptrCast(self), effect_index, operation_set);
    }
    pub inline fn DisableEffect(self: *ISourceVoice, effect_index: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.DisableEffect(@ptrCast(self), effect_index, operation_set);
    }
    pub inline fn GetEffectState(self: *ISourceVoice, effect_index: UINT32, enabled: *BOOL) void {
        IVoice.GetEffectState(@ptrCast(self), effect_index, enabled);
    }
    pub inline fn SetEffectParameters(self: *ISourceVoice, effect_index: UINT32, params: *const anyopaque, params_size: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.SetEffectParameters(@ptrCast(self), effect_index, params, params_size, operation_set);
    }
    pub inline fn GetEffectParameters(self: *ISourceVoice, effect_index: UINT32, params: *anyopaque, params_size: UINT32) HRESULT {
        return IVoice.GetEffectParameters(@ptrCast(self), effect_index, params, params_size);
    }
    pub inline fn SetFilterParameters(self: *ISourceVoice, params: *const FILTER_PARAMETERS, operation_set: UINT32) HRESULT {
        return IVoice.SetFilterParameters(@ptrCast(self), params, operation_set);
    }
    pub inline fn GetFilterParameters(self: *ISourceVoice, params: *FILTER_PARAMETERS) void {
        IVoice.GetFilterParameters(@ptrCast(self), params);
    }
    pub inline fn SetOutputFilterParameters(self: *ISourceVoice, dst_voice: ?*IVoice, params: *const FILTER_PARAMETERS, operation_set: UINT32) HRESULT {
        return IVoice.SetOutputFilterParameters(@ptrCast(self), dst_voice, params, operation_set);
    }
    pub inline fn GetOutputFilterParameters(self: *ISourceVoice, dst_voice: ?*IVoice, params: *FILTER_PARAMETERS) void {
        IVoice.GetOutputFilterParameters(@ptrCast(self), dst_voice, params);
    }
    pub inline fn SetVolume(self: *ISourceVoice, volume: f32) HRESULT {
        return IVoice.SetVolume(@ptrCast(self), volume);
    }
    pub inline fn GetVolume(self: *ISourceVoice, volume: *f32) void {
        IVoice.GetVolume(@ptrCast(self), volume);
    }
    pub inline fn SetChannelVolumes(self: *ISourceVoice, num_channels: UINT32, volumes: [*]const f32, operation_set: UINT32) HRESULT {
        return IVoice.SetChannelVolumes(@ptrCast(self), num_channels, volumes, operation_set);
    }
    pub inline fn GetChannelVolumes(self: *ISourceVoice, num_channels: UINT32, volumes: [*]f32) void {
        IVoice.GetChannelVolumes(@ptrCast(self), num_channels, volumes);
    }
    pub inline fn DestroyVoice(self: *ISourceVoice) void {
        IVoice.DestroyVoice(@ptrCast(self));
    }
    pub inline fn Start(self: *ISourceVoice, flags: FLAGS, operation_set: UINT32) HRESULT {
        return self.__v.Start(self, flags, operation_set);
    }
    pub inline fn Stop(self: *ISourceVoice, flags: FLAGS, operation_set: UINT32) HRESULT {
        return self.__v.Stop(self, flags, operation_set);
    }
    pub inline fn SubmitSourceBuffer(self: *ISourceVoice, buffer: *const BUFFER, wmabuffer: ?*const BUFFER_WMA) HRESULT {
        return self.__v.SubmitSourceBuffer(self, buffer, wmabuffer);
    }
    pub inline fn FlushSourceBuffers(self: *ISourceVoice) HRESULT {
        return self.__v.FlushSourceBuffers(self);
    }
    pub inline fn Discontinuity(self: *ISourceVoice) HRESULT {
        return self.__v.Discontinuity(self);
    }
    pub inline fn ExitLoop(self: *ISourceVoice, operation_set: UINT32) HRESULT {
        return self.__v.ExitLoop(self, operation_set);
    }
    pub inline fn GetState(self: *ISourceVoice, state: *VOICE_STATE, flags: FLAGS) void {
        self.__v.GetState(self, state, flags);
    }
    pub inline fn SetFrequencyRatio(self: *ISourceVoice, ratio: f32, operation_set: UINT32) HRESULT {
        return self.__v.SetFrequencyRatio(self, ratio, operation_set);
    }
    pub inline fn GetFrequencyRatio(self: *ISourceVoice, ratio: *f32) void {
        self.__v.GetFrequencyRatio(self, ratio);
    }
    pub inline fn SetSourceSampleRate(self: *ISourceVoice, sample_rate: UINT32) HRESULT {
        return self.__v.SetSourceSampleRate(self, sample_rate);
    }
    pub const VTable = extern struct {
        const T = ISourceVoice;
        base: IVoice.VTable,
        Start: *const fn (*T, FLAGS, UINT32) callconv(WINAPI) HRESULT,
        Stop: *const fn (*T, FLAGS, UINT32) callconv(WINAPI) HRESULT,
        SubmitSourceBuffer: *const fn (
            *T,
            *const BUFFER,
            ?*const BUFFER_WMA,
        ) callconv(WINAPI) HRESULT,
        FlushSourceBuffers: *const fn (*T) callconv(WINAPI) HRESULT,
        Discontinuity: *const fn (*T) callconv(WINAPI) HRESULT,
        ExitLoop: *const fn (*T, UINT32) callconv(WINAPI) HRESULT,
        GetState: *const fn (*T, *VOICE_STATE, FLAGS) callconv(WINAPI) void,
        SetFrequencyRatio: *const fn (*T, f32, UINT32) callconv(WINAPI) HRESULT,
        GetFrequencyRatio: *const fn (*T, *f32) callconv(WINAPI) void,
        SetSourceSampleRate: *const fn (*T, UINT32) callconv(WINAPI) HRESULT,
    };
};

pub const ISubmixVoice = extern struct {
    __v: *const VTable,
    pub inline fn GetVoiceDetails(self: *ISubmixVoice, details: *VOICE_DETAILS) void {
        IVoice.GetVoiceDetails(@ptrCast(self), details);
    }
    pub inline fn SetOutputVoices(self: *ISubmixVoice, send_list: ?*const VOICE_SENDS) HRESULT {
        return IVoice.SetOutputVoices(@ptrCast(self), send_list);
    }
    pub inline fn SetEffectChain(self: *ISubmixVoice, effect_chain: ?*const EFFECT_CHAIN) HRESULT {
        return IVoice.SetEffectChain(@ptrCast(self), effect_chain);
    }
    pub inline fn EnableEffect(self: *ISubmixVoice, effect_index: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.EnableEffect(@ptrCast(self), effect_index, operation_set);
    }
    pub inline fn DisableEffect(self: *ISubmixVoice, effect_index: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.DisableEffect(@ptrCast(self), effect_index, operation_set);
    }
    pub inline fn GetEffectState(self: *ISubmixVoice, effect_index: UINT32, enabled: *BOOL) void {
        IVoice.GetEffectState(@ptrCast(self), effect_index, enabled);
    }
    pub inline fn SetEffectParameters(self: *ISubmixVoice, effect_index: UINT32, params: *const anyopaque, params_size: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.SetEffectParameters(@ptrCast(self), effect_index, params, params_size, operation_set);
    }
    pub inline fn GetEffectParameters(self: *ISubmixVoice, effect_index: UINT32, params: *anyopaque, params_size: UINT32) HRESULT {
        return IVoice.GetEffectParameters(@ptrCast(self), effect_index, params, params_size);
    }
    pub inline fn SetFilterParameters(self: *ISubmixVoice, params: *const FILTER_PARAMETERS, operation_set: UINT32) HRESULT {
        return IVoice.SetFilterParameters(@ptrCast(self), params, operation_set);
    }
    pub inline fn GetFilterParameters(self: *ISubmixVoice, params: *FILTER_PARAMETERS) void {
        IVoice.GetFilterParameters(@ptrCast(self), params);
    }
    pub inline fn SetOutputFilterParameters(self: *ISubmixVoice, dst_voice: ?*IVoice, params: *const FILTER_PARAMETERS, operation_set: UINT32) HRESULT {
        return IVoice.SetOutputFilterParameters(@ptrCast(self), dst_voice, params, operation_set);
    }
    pub inline fn GetOutputFilterParameters(self: *ISubmixVoice, dst_voice: ?*IVoice, params: *FILTER_PARAMETERS) void {
        IVoice.GetOutputFilterParameters(@ptrCast(self), dst_voice, params);
    }
    pub inline fn SetVolume(self: *ISubmixVoice, volume: f32) HRESULT {
        return IVoice.SetVolume(@ptrCast(self), volume);
    }
    pub inline fn GetVolume(self: *ISubmixVoice, volume: *f32) void {
        IVoice.GetVolume(@ptrCast(self), volume);
    }
    pub inline fn SetChannelVolumes(self: *ISubmixVoice, num_channels: UINT32, volumes: [*]const f32, operation_set: UINT32) HRESULT {
        return IVoice.SetChannelVolumes(@ptrCast(self), num_channels, volumes, operation_set);
    }
    pub inline fn GetChannelVolumes(self: *ISubmixVoice, num_channels: UINT32, volumes: [*]f32) void {
        IVoice.GetChannelVolumes(@ptrCast(self), num_channels, volumes);
    }
    pub inline fn DestroyVoice(self: *ISubmixVoice) void {
        IVoice.DestroyVoice(@ptrCast(self));
    }
    pub const VTable = extern struct {
        base: IVoice.VTable,
    };
};

pub const IMasteringVoice = extern struct {
    __v: *const VTable,
    pub inline fn GetVoiceDetails(self: *IMasteringVoice, details: *VOICE_DETAILS) void {
        IVoice.GetVoiceDetails(@ptrCast(self), details);
    }
    pub inline fn SetOutputVoices(self: *IMasteringVoice, send_list: ?*const VOICE_SENDS) HRESULT {
        return IVoice.SetOutputVoices(@ptrCast(self), send_list);
    }
    pub inline fn SetEffectChain(self: *IMasteringVoice, effect_chain: ?*const EFFECT_CHAIN) HRESULT {
        return IVoice.SetEffectChain(@ptrCast(self), effect_chain);
    }
    pub inline fn EnableEffect(self: *IMasteringVoice, effect_index: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.EnableEffect(@ptrCast(self), effect_index, operation_set);
    }
    pub inline fn DisableEffect(self: *IMasteringVoice, effect_index: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.DisableEffect(@ptrCast(self), effect_index, operation_set);
    }
    pub inline fn GetEffectState(self: *IMasteringVoice, effect_index: UINT32, enabled: *BOOL) void {
        IVoice.GetEffectState(@ptrCast(self), effect_index, enabled);
    }
    pub inline fn SetEffectParameters(self: *IMasteringVoice, effect_index: UINT32, params: *const anyopaque, params_size: UINT32, operation_set: UINT32) HRESULT {
        return IVoice.SetEffectParameters(@ptrCast(self), effect_index, params, params_size, operation_set);
    }
    pub inline fn GetEffectParameters(self: *IMasteringVoice, effect_index: UINT32, params: *anyopaque, params_size: UINT32) HRESULT {
        return IVoice.GetEffectParameters(@ptrCast(self), effect_index, params, params_size);
    }
    pub inline fn SetFilterParameters(self: *IMasteringVoice, params: *const FILTER_PARAMETERS, operation_set: UINT32) HRESULT {
        return IVoice.SetFilterParameters(@ptrCast(self), params, operation_set);
    }
    pub inline fn GetFilterParameters(self: *IMasteringVoice, params: *FILTER_PARAMETERS) void {
        IVoice.GetFilterParameters(@ptrCast(self), params);
    }
    pub inline fn SetOutputFilterParameters(self: *IMasteringVoice, dst_voice: ?*IVoice, params: *const FILTER_PARAMETERS, operation_set: UINT32) HRESULT {
        return IVoice.SetOutputFilterParameters(@ptrCast(self), dst_voice, params, operation_set);
    }
    pub inline fn GetOutputFilterParameters(self: *IMasteringVoice, dst_voice: ?*IVoice, params: *FILTER_PARAMETERS) void {
        IVoice.GetOutputFilterParameters(@ptrCast(self), dst_voice, params);
    }
    pub inline fn SetVolume(self: *IMasteringVoice, volume: f32) HRESULT {
        return IVoice.SetVolume(@ptrCast(self), volume);
    }
    pub inline fn GetVolume(self: *IMasteringVoice, volume: *f32) void {
        IVoice.GetVolume(@ptrCast(self), volume);
    }
    pub inline fn SetChannelVolumes(self: *IMasteringVoice, num_channels: UINT32, volumes: [*]const f32, operation_set: UINT32) HRESULT {
        return IVoice.SetChannelVolumes(@ptrCast(self), num_channels, volumes, operation_set);
    }
    pub inline fn GetChannelVolumes(self: *IMasteringVoice, num_channels: UINT32, volumes: [*]f32) void {
        IVoice.GetChannelVolumes(@ptrCast(self), num_channels, volumes);
    }
    pub inline fn DestroyVoice(self: *IMasteringVoice) void {
        IVoice.DestroyVoice(@ptrCast(self));
    }
    pub inline fn GetChannelMask(self: *IMasteringVoice, channel_mask: *DWORD) HRESULT {
        return self.__v.GetChannelMask(self, channel_mask);
    }
    pub const VTable = extern struct {
        base: IVoice.VTable,
        GetChannelMask: *const fn (*IMasteringVoice, *DWORD) callconv(WINAPI) HRESULT,
    };
};

pub const IEngineCallback = extern struct {
    __v: *const VTable,
    pub inline fn OnProcessingPassStart(self: *IEngineCallback) void {
        self.__v.OnProcessingPassStart(self);
    }
    pub inline fn OnProcessingPassEnd(self: *IEngineCallback) void {
        self.__v.OnProcessingPassEnd(self);
    }
    pub inline fn OnCriticalError(self: *IEngineCallback, err: HRESULT) void {
        self.__v.OnCriticalError(self, err);
    }
    pub const VTable = extern struct {
        OnProcessingPassStart: *const fn (*IEngineCallback) callconv(WINAPI) void = _onProcessingPassStart,

        OnProcessingPassEnd: *const fn (*IEngineCallback) callconv(WINAPI) void = _onProcessingPassEnd,

        OnCriticalError: *const fn (*IEngineCallback, HRESULT) callconv(WINAPI) void = _onCriticalError,
    };

    // Default implementations
    fn _onProcessingPassStart(_: *IEngineCallback) callconv(WINAPI) void {}
    fn _onProcessingPassEnd(_: *IEngineCallback) callconv(WINAPI) void {}
    fn _onCriticalError(_: *IEngineCallback, _: HRESULT) callconv(WINAPI) void {}
};

pub const IVoiceCallback = extern struct {
    __v: *const VTable,
    pub inline fn OnVoiceProcessingPassStart(self: *IVoiceCallback, bytes_required: UINT32) void {
        self.__v.OnVoiceProcessingPassStart(self, bytes_required);
    }
    pub inline fn OnVoiceProcessingPassEnd(self: *IVoiceCallback) void {
        self.__v.OnVoiceProcessingPassEnd(self);
    }
    pub inline fn OnStreamEnd(self: *IVoiceCallback) void {
        self.__v.OnStreamEnd(self);
    }
    pub inline fn OnBufferStart(self: *IVoiceCallback, context: ?*anyopaque) void {
        self.__v.OnBufferStart(self, context);
    }
    pub inline fn OnBufferEnd(self: *IVoiceCallback, context: ?*anyopaque) void {
        self.__v.OnBufferEnd(self, context);
    }
    pub inline fn OnLoopEnd(self: *IVoiceCallback, context: ?*anyopaque) void {
        self.__v.OnLoopEnd(self, context);
    }
    pub inline fn OnVoiceError(self: *IVoiceCallback, context: ?*anyopaque, err: HRESULT) void {
        self.__v.OnVoiceError(self, context, err);
    }
    pub const VTable = extern struct {
        OnVoiceProcessingPassStart: *const fn (*IVoiceCallback, UINT32) callconv(WINAPI) void =
            _onVoiceProcessingPassStart,

        OnVoiceProcessingPassEnd: *const fn (*IVoiceCallback) callconv(WINAPI) void =
            _onVoiceProcessingPassEnd,

        OnStreamEnd: *const fn (*IVoiceCallback) callconv(WINAPI) void = _onStreamEnd,

        OnBufferStart: *const fn (*IVoiceCallback, ?*anyopaque) callconv(WINAPI) void = _onBufferStart,

        OnBufferEnd: *const fn (*IVoiceCallback, ?*anyopaque) callconv(WINAPI) void = _onBufferEnd,

        OnLoopEnd: *const fn (*IVoiceCallback, ?*anyopaque) callconv(WINAPI) void = _onLoopEnd,

        OnVoiceError: *const fn (*IVoiceCallback, ?*anyopaque, HRESULT) callconv(WINAPI) void = _onVoiceError,
    };

    // Default implementations
    fn _onVoiceProcessingPassStart(_: *IVoiceCallback, _: UINT32) callconv(WINAPI) void {}
    fn _onVoiceProcessingPassEnd(_: *IVoiceCallback) callconv(WINAPI) void {}
    fn _onStreamEnd(_: *IVoiceCallback) callconv(WINAPI) void {}
    fn _onBufferStart(_: *IVoiceCallback, _: ?*anyopaque) callconv(WINAPI) void {}
    fn _onBufferEnd(_: *IVoiceCallback, _: ?*anyopaque) callconv(WINAPI) void {}
    fn _onLoopEnd(_: *IVoiceCallback, _: ?*anyopaque) callconv(WINAPI) void {}
    fn _onVoiceError(_: *IVoiceCallback, _: ?*anyopaque, _: HRESULT) callconv(WINAPI) void {}
};

pub fn create(
    ppv: *?*IXAudio2,
    flags: FLAGS, // .{}
    processor: UINT32, // 0
) HRESULT {
    var xaudio2_dll = windows.GetModuleHandleA("xaudio2_9redist.dll");
    if (xaudio2_dll == null) {
        xaudio2_dll = windows.LoadLibraryA("xaudio2_9redist.dll");
    }

    var xaudio2Create: *const fn (*?*IXAudio2, FLAGS, UINT32) callconv(WINAPI) HRESULT = undefined;
    xaudio2Create = @as(
        @TypeOf(xaudio2Create),
        @ptrCast(windows.GetProcAddress(xaudio2_dll.?, "XAudio2Create").?),
    );

    return xaudio2Create(ppv, flags, processor);
}
