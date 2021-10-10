const std = @import("std");

const zline = @import("zline");

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(!gpa.deinit());

    var line: zline = try zline.init(&gpa.allocator, std.io.getStdOut());
    defer line.destroy();

    {
        while (true) {
            const x = line.prompt("> ") catch |err| {
                std.debug.print("Prompt failed with error {}\n", .{err});
                return;
            };
            std.debug.print("Received: {s}\n", .{x});
            if (std.mem.eql(u8, "exit", x)) {
                break;
            }
        }
    }
}
