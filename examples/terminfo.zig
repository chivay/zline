const std = @import("std");

const zline = @import("zline");

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(!gpa.deinit());

    var def = try zline.terminfo.loadTerm(&gpa.allocator);
    defer def.deinit();

    std.debug.print("{s}", .{(def.getString(.key_backspace).?)});
}
