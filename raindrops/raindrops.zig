const std = @import("std");

pub fn convert(buffer: []u8, n: u32) []const u8 {
    var idx: usize = 0;

    if (n % 3 == 0) {
        for ("Pling") |c| {
            buffer[idx] = c;
            idx += 1;
        }
    }
    if (n % 5 == 0) {
        for ("Plang") |c| {
            buffer[idx] = c;
            idx += 1;
        }
    }
    if (n % 7 == 0) {
        for ("Plong") |c| {
            buffer[idx] = c;
            idx += 1;
        }
    }

    if (idx == 0) {
        const end = std.fmt.printInt(buffer, n, 10, .lower, .{});
        return buffer[0..end];
    } else {
        return buffer[0..idx];
    }
}
