const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

pub fn get_browser() ?[]u8 {
    try stdout.print("[1/7] Browser");
    try stdout.print("Please select one of the option bellow: \n", .{});
    try stdout.print("1 - Firefox");
    try stdout.print("2 - Google Chrome [AUR]");
    try stdout.print("3 - Brave [AUR]");
    try stdout.print("0 - Other");
    try stdout.flush(); // Ensure prompt shows

    var buffer: u8 = undefined;
    const input = try stdin.readUntilDelimiterOrEOL(&buffer, '\n'); // Fixed buffer, no alloc
    switch (input) {
        0 => {
            try stdout.print("Please introduce the browser package name: ", .{});
            var buff: []u8 = undefined;
            return try stdin.readUntilDelimiterOrEOL(&buff, '\n');
        },
        1 => return "firefox",
        2 => return "google-chrome",
        3 => return "brave",
        else => null,
    }
}

pub fn check_browsers_installed() ?[][]8 {}
