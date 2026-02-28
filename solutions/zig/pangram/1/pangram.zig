const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    var seen: [26]bool = [_]bool{false} ** 26;
    var count: usize = 0;

    for (str) |c| {
        const lower = std.ascii.toLower(c);
        if (lower >= 'a' and lower <= 'z') {
            const idx = lower - 'a';
            if (!seen[idx]) {
                seen[idx] = true;
                count += 1;
                if (count == 26) return true;
            }
        }
    }

    for (seen) |val| {
        if (!val) return false;
    }
    return true;
}
