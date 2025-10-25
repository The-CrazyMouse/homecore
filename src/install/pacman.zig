const std = @import("std");
const print = std.debug.print;

pub fn check_install_pacman(name: []u8) !bool {
    print("name, {}", .{name});
}

pub fn check_exist_pacman(name: []u8) !bool {
    print("name, {}", .{name});
}

pub fn install_pacman(name: []u8) !bool {
    print("name, {}", .{name});
}
