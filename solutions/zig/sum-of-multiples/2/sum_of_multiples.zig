const std = @import("std");
const mem = std.mem;
const testing = std.testing;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var set = std.AutoHashMap(u32, void).init(allocator);
    defer set.deinit();

    for (factors) |factor| {
        if (factor == 0) break;
        var multiple = factor;
        while (multiple < limit) {
            try set.put(multiple, {});
            multiple = multiple + factor;
        }
    }
    var iterator = set.keyIterator();

    var total: u64 = 0;
    while (iterator.next()) |item| {
        total += item.*;
    }
    return total;
}
