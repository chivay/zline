const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("zline", "src/main.zig");
    lib.setBuildMode(mode);
    lib.install();

    var main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);

    const simple_example = b.addExecutable("simple-example", "examples/simple.zig");
    simple_example.linkSystemLibrary("ncurses");
    simple_example.linkLibC();
    simple_example.addPackage(.{
        .name = "zline",
        .path = .{ .path = "src/main.zig" },
    });
    simple_example.setBuildMode(mode);
    simple_example.install();

    const terminfo_example = b.addExecutable("terminfo-example", "examples/terminfo.zig");
    terminfo_example.linkSystemLibrary("ncurses");
    terminfo_example.linkLibC();
    terminfo_example.addPackage(.{
        .name = "zline",
        .path = .{ .path = "src/main.zig" },
    });
    terminfo_example.setBuildMode(mode);
    terminfo_example.install();
}
