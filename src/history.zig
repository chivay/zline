const Self = @This();
pub fn clear() void {}
pub fn add(self: *Self, message: []const u8) void {
    _ = self;
    _ = message;
}

const HistoryIterator = struct {
    pub fn next() ?[]const u8 {
        return null;
    }
};
pub fn iter() HistoryIterator {
    return .{};
}
