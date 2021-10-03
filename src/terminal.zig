const std = @import("std");
const linux = std.os.linux;

const c = @cImport({
    @cInclude("termcap.h");
});

pub const RawContext = struct {
    saved_termios: linux.termios,
    handle: linux.fd_t,

    pub fn enter(handle: linux.fd_t) RawContext {
        var old_termios: linux.termios = undefined;
        _ = linux.tcgetattr(handle, &old_termios);

        const x = c.tgetent(null, "alacritty");
        _ = x;
        //std.debug.print("{*}", .{buffer});

        var new_termios = old_termios;
        //new_termios.iflag &= ~@as(u32, linux.BRKINT | linux.ICRNL | linux.INPCK | linux.ISTRIP | linux.IXON);
        new_termios.oflag &= ~@as(u32, linux.OPOST);
        new_termios.cflag |= (linux.CS8);
        //new_termios.lflag &= ~@as(u32, linux.ECHO | linux.ICANON | linux.IEXTEN | linux.ISIG);
        new_termios.lflag &= ~@as(u32, linux.ECHO | linux.ICANON);
        new_termios.cc[6] = 1;
        new_termios.cc[5] = 1;
        _ = linux.tcsetattr(handle, .FLUSH, &new_termios);

        return .{
            .saved_termios = old_termios,
            .handle = handle,
        };
    }

    pub fn exit(self: @This()) void {
        _ = linux.tcsetattr(self.handle, .FLUSH, &self.saved_termios);
    }
};

pub const TermSize = struct {
    rows: u16,
    cols: u16,
};

pub const TermError = error{TermError};

pub fn get_dimensions(handle: linux.fd_t) !TermSize {
    var wsz: linux.winsize = undefined;
    const fd = @bitCast(usize, @as(isize, handle));
    while (true) {
        const rc = linux.syscall3(.ioctl, fd, linux.T.IOCGWINSZ, @ptrToInt(&wsz));
        switch (linux.getErrno(rc)) {
            .SUCCESS => break,
            .INTR => continue,
            else => return TermError.TermError,
        }
    }
    return TermSize{
        .rows = wsz.ws_row,
        .cols = wsz.ws_col,
    };
}
