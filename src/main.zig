const std = @import("std");
const homecore = @import("homecore.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args); // Fixed: No extra }

    if (args.len > 1) {
        const first_arg = args[1]; // [:0]u8 — direct access
        if (std.mem.eql(u8, first_arg, "-h") or std.mem.eql(u8, first_arg, "--help")) {
            homecore.help();
            return;
        }
    }

    switch (args.len) {
        1 => homecore.help(), // No user args: help
        2...4 => homecore.process(args), // 1-3 user args: process
        0 => unreachable, // Impossible
        else => std.process.exit(2),
    }

    std.process.exit(0); // Success
}
