const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) !void {
    checkGitLfsContent() catch {
        try ensureGit(b.allocator);
        try ensureGitLfs(b.allocator, "install");
        try ensureGitLfs(b.allocator, "pull");
        try checkGitLfsContent();
    };

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const options = .{
        .zxaudio2_debug_layer = b.option(
            bool,
            "zxaudio2_debug_layer",
            "Enable XAudio2 debug layer",
        ) orelse false,
        .zd3d12_debug_layer = b.option(
            bool,
            "zd3d12_debug_layer",
            "Enable DirectX 12 debug layer",
        ) orelse false,
        .zd3d12_gbv = b.option(
            bool,
            "zd3d12_gbv",
            "Enable DirectX 12 GPU-Based Validation (GBV)",
        ) orelse false,
    };

    const options_step = b.addOptions();
    inline for (std.meta.fields(@TypeOf(options))) |field| {
        options_step.addOption(field.type, field.name, @field(options, field.name));
    }

    const zwindows_module = b.addModule("zwindows", .{
        .root_source_file = b.path("src/windows.zig"),
        .target = target,
        .optimize = optimize,
    });

    const options_module = options_step.createModule();

    const zd3d12_module = b.addModule("zd3d12", .{
        .root_source_file = b.path("src/zd3d12.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "options", .module = options_module },
            .{ .name = "zwindows", .module = zwindows_module },
        },
    });

    const zxaudio2_module = b.addModule("zxaudio2", .{
        .root_source_file = b.path("src/zxaudio2.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "options", .module = options_module },
            .{ .name = "zwindows", .module = zwindows_module },
        },
    });

    { // Tests
        const test_step = b.step("test", "Run library tests");

        const tests = b.addTest(.{
            .root_source_file = b.path("src/tests.zig"),
            .target = target,
            .optimize = optimize,
        });
        tests.root_module.addImport("zwindows", zwindows_module);
        tests.root_module.addImport("zd3d12", zd3d12_module);
        tests.root_module.addImport("zxaudio2", zxaudio2_module);

        const run_tests = b.addRunArtifact(tests);
        test_step.dependOn(&run_tests.step);
    }
}

pub fn activateSdk(b: *std.Build, zwindows: *std.Build.Dependency) *std.Build.Step {
    const step = b.allocator.create(std.Build.Step) catch unreachable;
    step.* = std.Build.Step.init(.{
        .id = .custom,
        .name = "Activate zwindows",
        .owner = b,
        .makeFn = &struct {
            fn make(_: *std.Build.Step, _: std.Build.Step.MakeOptions) anyerror!void {}
        }.make,
    });
    switch (builtin.target.os.tag) {
        .windows => {
            const dxc_path = zwindows.path("bin/x64/dxc.exe").getPath(b);
            step.dependOn(&b.addSystemCommand(&.{ "takeown", "/f", dxc_path }).step);
        },
        .linux => {
            const dxc_path = zwindows.path("bin/x64/dxc").getPath(b);
            step.dependOn(&b.addSystemCommand(&.{ "chmod", "+x", dxc_path }).step);
        },
        else => @panic("Unsupported host OS."),
    }
    return step;
}

pub fn install_xaudio2(
    step: *std.Build.Step,
    zwindows: *std.Build.Dependency,
    install_dir: std.Build.InstallDir,
) void {
    const b = step.owner;
    step.dependOn(
        &b.addInstallFileWithDir(
            .{ .dependency = .{
                .dependency = zwindows,
                .sub_path = "bin/x64/xaudio2_9redist.dll",
            } },
            install_dir,
            "xaudio2_9redist.dll",
        ).step,
    );
}

pub fn install_d3d12(
    step: *std.Build.Step,
    zwindows: *std.Build.Dependency,
    install_dir: std.Build.InstallDir,
) void {
    const b = step.owner;
    step.dependOn(
        &b.addInstallFileWithDir(
            .{ .dependency = .{
                .dependency = zwindows,
                .sub_path = "bin/x64/D3D12Core.dll",
            } },
            install_dir,
            "d3d12/D3D12Core.dll",
        ).step,
    );
    step.dependOn(
        &b.addInstallFileWithDir(
            .{ .dependency = .{
                .dependency = zwindows,
                .sub_path = "bin/x64/D3D12SDKLayers.dll",
            } },
            install_dir,
            "d3d12/D3D12SDKLayers.dll",
        ).step,
    );
}

pub fn install_directml(
    step: *std.Build.Step,
    zwindows: *std.Build.Dependency,
    install_dir: std.Build.InstallDir,
) void {
    const b = step.owner;
    step.dependOn(
        &b.addInstallFileWithDir(
            .{ .dependency = .{
                .dependency = zwindows,
                .sub_path = "bin/x64/DirectML.dll",
            } },
            install_dir,
            "DirectML.dll",
        ).step,
    );
    step.dependOn(
        &b.addInstallFileWithDir(
            .{ .dependency = .{
                .dependency = zwindows,
                .sub_path = "bin/x64/DirectML.Debug.dll",
            } },
            install_dir,
            "DirectML.Debug.dll",
        ).step,
    );
}

pub const CompileShaders = struct {
    step: *std.Build.Step,
    zwindows: *std.Build.Dependency,
    shader_ver: []const u8,

    pub fn addVsShader(
        self: CompileShaders,
        input_path: []const u8,
        entry_point: []const u8,
        output_filename: []const u8,
        define: []const u8,
    ) void {
        self.addShader(
            input_path,
            entry_point,
            output_filename,
            "vs",
            define,
        );
    }
    pub fn addPsShader(
        self: CompileShaders,
        input_path: []const u8,
        entry_point: []const u8,
        output_filename: []const u8,
        define: []const u8,
    ) void {
        self.addShader(
            input_path,
            entry_point,
            output_filename,
            "ps",
            define,
        );
    }

    pub fn addCsShader(
        self: CompileShaders,
        input_path: []const u8,
        entry_point: []const u8,
        output_filename: []const u8,
        define: []const u8,
    ) void {
        self.addShader(
            input_path,
            entry_point,
            output_filename,
            "cs",
            define,
        );
    }

    pub fn addMsShader(
        self: CompileShaders,
        input_path: []const u8,
        entry_point: []const u8,
        output_filename: []const u8,
        define: []const u8,
    ) void {
        self.addShader(
            input_path,
            entry_point,
            output_filename,
            "ms",
            define,
        );
    }

    pub fn addShader(
        self: CompileShaders,
        input_path: []const u8,
        entry_point: []const u8,
        output_filename: []const u8,
        profile: []const u8,
        define: []const u8,
    ) void {
        const b = self.step.owner;

        const dxc_path = switch (builtin.target.os.tag) {
            .windows => self.zwindows.path("bin/x64/dxc.exe").getPath(b),
            .linux => self.zwindows.path("bin/x64/dxc").getPath(b),
            else => @panic("Unsupported host OS."),
        };

        const dxc_command = [9][]const u8{
            dxc_path,
            input_path,
            b.fmt("/E {s}", .{entry_point}),
            b.fmt("/Fo {s}", .{output_filename}),
            b.fmt("/T {s}_{s}", .{ profile, self.shader_ver }),
            if (define.len == 0) "" else b.fmt("/D {s}", .{define}),
            "/WX",
            "/Ges",
            "/O3",
        };

        const cmd_step = b.addSystemCommand(&dxc_command);
        if (builtin.target.os.tag == .linux) {
            cmd_step.setEnvironmentVariable(
                "LD_LIBRARY_PATH",
                self.zwindows.path("bin/x64").getPath(b),
            );
        }

        self.step.dependOn(&cmd_step.step);
    }
};

pub fn addCompileShaders(
    b: *std.Build,
    comptime name: []const u8,
    zwindows: *std.Build.Dependency,
    options: struct { shader_ver: []const u8 },
) CompileShaders {
    return .{
        .step = b.step(name ++ "-dxc", "Build shaders for '" ++ name ++ "'"),
        .zwindows = zwindows,
        .shader_ver = options.shader_ver,
    };
}

fn ensureGit(allocator: std.mem.Allocator) !void {
    const printErrorMsg = (struct {
        fn impl() void {
            std.log.err("\n" ++
                \\---------------------------------------------------------------------------
                \\
                \\'git version' failed. Is Git not installed?
                \\
                \\---------------------------------------------------------------------------
                \\
            , .{});
        }
    }).impl;
    const argv = &[_][]const u8{ "git", "version" };
    const result = std.process.Child.run(.{
        .allocator = allocator,
        .argv = argv,
    }) catch { // e.g. FileNotFound
        printErrorMsg();
        return error.GitNotFound;
    };
    defer {
        allocator.free(result.stderr);
        allocator.free(result.stdout);
    }
    if (result.term.Exited != 0) {
        printErrorMsg();
        return error.GitNotFound;
    }
}

fn ensureGitLfs(allocator: std.mem.Allocator, cmd: []const u8) !void {
    const printNoGitLfs = (struct {
        fn impl() void {
            std.log.err("\n" ++
                \\---------------------------------------------------------------------------
                \\
                \\Please install Git LFS (Large File Support) extension and run 'zig build' again.
                \\
                \\For more info about Git LFS see: https://git-lfs.github.com/
                \\
                \\---------------------------------------------------------------------------
                \\
            , .{});
        }
    }).impl;
    const argv = &[_][]const u8{ "git", "lfs", cmd };
    const result = std.process.Child.run(.{
        .allocator = allocator,
        .argv = argv,
    }) catch { // e.g. FileNotFound
        printNoGitLfs();
        return error.GitLfsNotFound;
    };
    defer {
        allocator.free(result.stderr);
        allocator.free(result.stdout);
    }
    if (result.term.Exited != 0) {
        printNoGitLfs();
        return error.GitLfsNotFound;
    }
}

fn checkGitLfsContent() !void {
    const expected_contents =
        \\DO NOT EDIT OR DELETE
        \\This file is used to check if Git LFS content has been downloaded
    ;
    var buf: [expected_contents.len]u8 = undefined;
    _ = std.fs.cwd().readFile(".lfs-content-token", &buf) catch {
        return error.GitLfsContentTokenNotFound;
    };
    if (!std.mem.eql(u8, expected_contents, &buf)) {
        return error.GitLfsContentCheckFailed;
    }
}
