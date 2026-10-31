const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    _ = limit;

    var set = std.AutoHashMap(u32, void).init(allocator);
    defer set.deinit();

    for (factors) |factor| set.put(factor, {});
    var iterator = set.keyIterator();

    var total: u64 = 0;
    while (iterator.next()) |item| {
        total += item.*;
    }
    return total;
}
