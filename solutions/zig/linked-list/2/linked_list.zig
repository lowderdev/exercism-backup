const std = @import("std");

pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        pub fn push(self: *Self, new_tail: *Node) void {
            if (self.last) |old_tail| {
                old_tail.*.next = new_tail;
                new_tail.*.prev = old_tail;
            } else {
                self.first = new_tail;
            }

            self.last = new_tail;
            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            if (self.last) |tail| {
                self.last = tail.*.prev;
                if (self.last) |t| {
                    t.*.next = null;
                } else {
                    // tail was the first node
                    self.first = null;
                }
                self.len -= 1;

                return tail;
            } else {
                return null;
            }
        }

        pub fn shift(self: *Self) ?*Node {
            if (self.first) |head| {
                self.first = head.*.next;
                if (self.first) |h| {
                    h.*.prev = null;
                } else {
                    // head was the last node
                    self.last = null;
                }
                self.len -= 1;

                return head;
            } else {
                return null;
            }
        }

        pub fn unshift(self: *Self, new_head: *Node) void {
            if (self.first) |old_head| {
                old_head.*.prev = new_head;
                new_head.next = old_head;
                self.first = new_head;
            } else {
                self.first = new_head;
                self.last = new_head;
            }

            self.len += 1;
        }

        pub fn delete(self: *Self, target: *Node) void {
            var current = self.first;
            var to_delete: ?*Node = null;

            while (current != null) {
                if (current == target) {
                    to_delete = current;
                    break;
                } else {
                    current = current.?.next;
                }
            }

            if (to_delete) |t| {
                const prev = t.*.prev;
                const next = t.*.next;

                // remove pointers;
                t.*.prev = null;
                t.*.next = null;

                if (prev) |pr| {
                    pr.*.next = next;
                } else {
                    self.first = next;
                }
                if (next) |n| {
                    n.*.prev = prev;
                } else {
                    self.last = prev;
                }

                self.len -= 1;
            }
        }
    };
}
