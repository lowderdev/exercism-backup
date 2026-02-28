const std = @import("std");

pub const NucleotideError = error{Invalid};

pub const Counts = struct {
    a: u32,
    c: u32,
    g: u32,
    t: u32,
};

pub fn countNucleotides(s: []const u8) NucleotideError!Counts {
    var a_count: u32 = 0;
    var c_count: u32 = 0;
    var g_count: u32 = 0;
    var t_count: u32 = 0;

    for (s) |char| {
        switch (char) {
            'A' => a_count += 1,
            'C' => c_count += 1,
            'G' => g_count += 1,
            'T' => t_count += 1,
            else => return NucleotideError.Invalid,
        }
    }

    return Counts{ .a = a_count, .c = c_count, .g = g_count, .t = t_count };
}
