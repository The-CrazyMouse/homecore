const std = @import("std");
const homecore = @import("homecore.zig");

pub fn main() !void {

    // Getting Command Line Arguments, there is not much to see here move along
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    // Alright so here is starts
    // Checks for the only flag that can be used alone. help
    if (args.len > 1 and args.len < 3) {
        const first_arg = args[1];
        if (std.mem.eql(u8, first_arg, "-h") or std.mem.eql(u8, first_arg, "--help")) {
            homecore.help();
            return;
        }
    }

    // Now that we excuded the first argument being a flag we check number of arguments
    // to know if is worth checking the rest
    switch (args.len) {
        1 => homecore.help(), // No user args: help
        2...4 => homecore.process(args), // 1-3 user args: process
        0 => unreachable, // Impossible
        else => std.process.exit(2), // the command is wrong is not even worth checking
    }

    std.process.exit(0); // Success
}
