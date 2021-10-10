const std = @import("std");
const testing = std.testing;

pub const terminfo = @import("terminfo.zig");
const History = @import("history.zig");
const terminal = @import("terminal.zig");
const Self = @This();

alloc: *std.mem.Allocator,
file: std.fs.File,
history: History,
terminfo: terminfo.TermInfo,

buffer: std.ArrayList(u8),
message: ?[]const u8,

pub fn init(allocator: *std.mem.Allocator, file: std.fs.File) !Self {
    const tinfo = try terminfo.loadTerm(allocator);
    return Self{
        .alloc = allocator,
        .file = file,
        .history = .{},
        .terminfo = tinfo,
        .buffer = std.ArrayList(u8).init(allocator),
        .message = null,
    };
}

fn redraw(self: *Self) !void {
    const writer = self.file.writer();

    try writer.writeAll(self.terminfo.getString(.carriage_return).?);
    try writer.writeAll(self.terminfo.getString(.clr_eol).?);
    if (self.message) |msg| {
        try writer.writeAll(msg);
    }
    try writer.writeAll(self.buffer.items);
}

pub fn prompt(self: *Self, message: []const u8) ![]u8 {
    self.message = message;
    const raw_context = terminal.RawContext.enter(self.file.handle);
    defer raw_context.exit();

    const reader = self.file.reader();
    const writer = self.file.writer();

    self.buffer.clearRetainingCapacity();
    while (true) {
        try self.redraw();

        const c = try reader.readByte();
        if (!std.ascii.isCntrl(c)) {
            try self.buffer.append(c);
            try writer.writeByte(c);
        } else if (c == 0x7f) {
            _ = self.buffer.pop();
        } else {
            std.debug.print("unknown character: {x}\n", .{c});
        }
        if (c == '\n') break;
    }

    try writer.writeAll(self.terminfo.getString(.carriage_return).?);
    try writer.writeAll(self.terminfo.getString(.newline).?);

    self.history.add(self.buffer.items);
    return self.buffer.items;
}

pub fn get(self: *Self) ![]u8 {
    return self.prompt("");
}

pub fn destroy(self: *Self) void {
    self.buffer.deinit();
}
