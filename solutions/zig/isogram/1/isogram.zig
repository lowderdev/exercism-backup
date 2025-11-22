const std = @import("std");

pub fn main() !void {
    // print the return value
    std.debug.print("Is isogram: {}\n", .{isIsogram("foobar")});
    std.debug.print("Is isogram: {}\n", .{isIsogram("asdf")});
}

pub fn isIsogram(str: []const u8) bool {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const lowerStr = allocator.alloc(u8, str.len) catch unreachable;
    defer allocator.free(lowerStr);

    var seen: [256]bool = [_]bool{false} ** 256;

    _ = std.ascii.lowerString(lowerStr, str);

    for (lowerStr) |char| {
        if (!(char >= 'a' and char <= 'z') and !(char >= 'A' and char <= 'Z')) {
            continue;
        }
        if (seen[char]) {
            return false;
        }
        seen[char] = true;
    }

    return true;
}
