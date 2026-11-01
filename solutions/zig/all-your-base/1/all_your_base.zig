const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base < 2) return ConversionError.InvalidInputBase;
    if (output_base < 2) return ConversionError.InvalidOutputBase;
    if (digits.len == 0) {
        const slice = try allocator.alloc(u32, 1);
        slice[0] = 0;
        return slice;
    }

    var total: u32 = 0;
    for (digits) |digit| {
        if (digit >= input_base) return ConversionError.InvalidDigit;
        total *= input_base;
        total += digit;
    }

    if (total == 0) {
        const slice = try allocator.alloc(u32, 1);
        slice[0] = 0;
        return slice;
    }

    var out_digits = try std.ArrayListUnmanaged(u32).initCapacity(allocator, 10);

    while (total > 0) {
        const x = total % output_base;
        try out_digits.append(allocator, x);
        total /= output_base;
    }

    const final_slice = try out_digits.toOwnedSlice(allocator);
    std.mem.reverse(u32, final_slice);
    return final_slice;
}
