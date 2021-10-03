const std = @import("std");
const testing = std.testing;

const History = @import("history.zig");
const terminal = @import("terminal.zig");
const Self = @This();

alloc: *std.mem.Allocator,
handle: std.os.fd_t,
history: History,

pub fn init(allocator: *std.mem.Allocator, handle: std.os.fd_t) Self {
    return .{
        .alloc = allocator,
        .handle = handle,
        .history = .{},
    };
}

pub fn get(self: *Self) ![]u8 {
    const raw_context = terminal.RawContext.enter(self.handle);
    defer raw_context.exit();

    const dims = try terminal.get_dimensions(self.handle);
    _ = dims;

    const reader = std.io.getStdIn().reader();
    const writer = std.io.getStdOut().writer();
    while (true) {
        const c = try reader.readByte();
        if (!std.ascii.isCntrl(c)) {
            try writer.writeByte(c);
        }
        if (c == '\n') break;
    }
    try writer.writeByte('\n');

    //self.history.add(entry);
    return "";
}

pub fn prompt(self: *Self, message: []const u8) ![]u8 {
    const writer = std.io.getStdOut().writer();
    try writer.writeAll(message);
    return try self.get();
}

pub fn destroy(self: *Self, buffer: []const u8) void {
    self.alloc.free(buffer);
}
