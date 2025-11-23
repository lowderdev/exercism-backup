const std = @import("std");

pub const BufferError = error{BufferOverflow};

pub fn CircularBuffer(comptime T: type, comptime capacity: usize) type {
    return struct {
        const Self = @This();
        buffer: []T,
        head: usize,
        tail: usize,
        empty: bool,

        pub fn init() Self {
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            const allocator = gpa.allocator();

            return Self{
                .buffer = allocator.alloc(T, capacity) catch unreachable,
                .head = 0,
                .tail = 0,
                .empty = true,
            };
        }

        pub fn clear(self: *Self) void {
            for (self.buffer) |*b| {
                b.* = undefined;
            }
            self.head = 0;
            self.tail = 0;
            self.empty = true;
        }

        pub fn read(self: *Self) ?T {
            if (self.empty) return null;

            const val = self.buffer[self.tail];
            self.buffer[self.tail] = undefined;
            self.tail = (self.tail + 1) % capacity;

            if (self.head == self.tail) self.empty = true;

            return val;
        }

        pub fn write(self: *Self, item: T) BufferError!void {
            if (!self.empty and (self.head == self.tail)) return BufferError.BufferOverflow;

            self.buffer[self.head] = item;
            self.head = (self.head + 1) % capacity;
            self.empty = false;
        }

        pub fn overwrite(self: *Self, item: T) void {
            self.buffer[self.head] = item;
            if (self.head == self.tail) {
                self.tail = (self.tail + 1) % capacity;
            }
            self.head = (self.head + 1) % capacity;
        }
    };
}
