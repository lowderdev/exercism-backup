const std = @import("std");

pub fn score(s: []const u8) u32 {
    var map = [_]u8{0} ** 256;
    for ("aeioulnrst") |char| {
        map[char] = 1;
    }
    for ("dg") |char| {
        map[char] = 2;
    }
    for ("bcmp") |char| {
        map[char] = 3;
    }
    for ("fhvwy") |char| {
        map[char] = 4;
    }
    map['k'] = 5;
    for ("jx") |char| {
        map[char] = 8;
    }
    for ("qz") |char| {
        map[char] = 10;
    }

    var total: u32 = 0;
    for (s) |char| {
        total += map[std.ascii.toLower(char)];
    }

    return total;
}
