const std = @import("std");

pub const Planet = enum {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        const fseconds: f64 = @floatFromInt(seconds);
        const orbital: f64 = switch (self) {
            Planet.mercury => 0.2408467,
            Planet.venus => 0.61519726,
            Planet.earth => 1.0,
            Planet.mars => 1.8808158,
            Planet.jupiter => 11.862615,
            Planet.saturn => 29.447498,
            Planet.uranus => 84.016846,
            Planet.neptune => 164.79132,
        };
        const earthOrbitalInSeconds: f64 = 31_557_600;
        const earthYears = fseconds / earthOrbitalInSeconds;
        if (self == Planet.earth) return earthYears;

        return earthYears * orbital;
    }
};

test "planet age" {
    try std.testing.expectEqual(1, Planet.earth.age(31_557_600));
    try std.testing.expectEqual(36, Planet.earth.age(1_136_073_600));
    try std.testing.expectEqual(8.6704812, Planet.mercury.age(1_136_073_600));
    try std.testing.expectEqual(5932.487520000001, Planet.neptune.age(1_136_073_600));
}
