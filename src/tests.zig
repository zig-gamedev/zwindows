const std = @import("std");
const zwindows = @import("zwindows");
const zd3d12 = @import("zd3d12");
const zxaudio2 = @import("zxaudio2");

test {
    std.testing.refAllDeclsRecursive(zwindows);
    std.testing.refAllDeclsRecursive(zd3d12);
    std.testing.refAllDeclsRecursive(zxaudio2);
}
