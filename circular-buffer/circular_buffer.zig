const std = @import("std");

pub const BufferError = error{BufferOverflow};

pub fn CircularBuffer(comptime T: type, comptime capacity: usize) type {
    return struct {
        const Self = @This();
        buffer: [capacity]T = undefined,
        write_index: usize = 0,
        read_index: usize = 0,
        empty: bool = true,

        pub fn init() Self {
            return .{};
        }

        pub fn clear(self: *Self) void {
            self.write_index = 0;
            self.read_index = 0;
            self.empty = true;
        }

        pub fn read(self: *Self) ?T {
            if (self.empty) return null;

            const val = self.buffer[self.read_index];
            self.buffer[self.read_index] = undefined;
            self.read_index = (self.read_index + 1) % capacity;

            if (self.write_index == self.read_index) self.empty = true;

            return val;
        }

        pub fn write(self: *Self, item: T) BufferError!void {
            if (!self.empty and (self.write_index == self.read_index)) return BufferError.BufferOverflow;

            self.overwrite(item);
        }

        pub fn overwrite(self: *Self, item: T) void {
            self.buffer[self.write_index] = item;
            if (!self.empty and self.write_index == self.read_index) {
                self.read_index = (self.read_index + 1) % capacity;
            }
            self.write_index = (self.write_index + 1) % capacity;
            self.empty = false;
        }
    };
}
