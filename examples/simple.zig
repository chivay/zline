const std = @import("std");

const zline = @import("zline");

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(!gpa.deinit());

    var line: zline = zline.init(&gpa.allocator, std.os.linux.STDIN_FILENO);

    {
        while (true) {
            const x = line.prompt("> ") catch |err| {
                std.debug.print("\nPrompt failed with error {}\n", .{err});
                return;
            };
            defer line.destroy(x);
            std.debug.print("Received: {s}\n", .{x});
        }
    }
}
