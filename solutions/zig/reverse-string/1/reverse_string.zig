const std = @import("std");

pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    var i: usize = 0;
    var j = s.len;

    while (j > 0) {
        buffer[i] = s[j - 1];
        i += 1;
        j -= 1;
    }
    return buffer[0..i];
}
