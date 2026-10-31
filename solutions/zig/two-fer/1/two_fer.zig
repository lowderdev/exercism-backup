// const std = @import("std");
const TwoFerError = error{BufferTooShort};

pub fn twoFer(buffer: []u8, name: ?[]const u8) ![]u8 {
    const addressee = if (name) |n| n else "you";
    // return std.mem.print(buffer, "One for {s}, one for me.", .{addressee});
    const start = "One for ";
    const end = ", one for me.";

    const msgLength = start.len + addressee.len + end.len;
    if (buffer.len < msgLength) return TwoFerError.BufferTooShort;

    var cursor: usize = 0;
    @memcpy(buffer[cursor .. cursor + start.len], start);
    cursor += start.len;
    @memcpy(buffer[cursor .. cursor + addressee.len], addressee);
    cursor += addressee.len;
    @memcpy(buffer[cursor .. cursor + end.len], end);
    cursor += end.len;

    return buffer[0..msgLength];
}
