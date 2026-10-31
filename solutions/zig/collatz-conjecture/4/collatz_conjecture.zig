pub const ComputationError = error{IllegalArgument};

// If it's even, divide it by 2.
// If it's odd, multiply it by 3 and add 1.

pub fn steps(number: usize) anyerror!usize {
    return switch (number) {
        0 => ComputationError.IllegalArgument,
        1 => 0,
        else => 1 + try steps(switch (number % 2) {
            0 => number / 2,
            else => number * 3 + 1,
        }),
    };
}
