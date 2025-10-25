const std = @import("std");
const print = std.debug.print;
const install = @import("install/root.zig");

const Actions = enum { VERSION, INSTALL, UPDATE, COMMAND };

pub fn version() void {
    print("HomeCore Dev Version\n", .{});
}

pub fn help() void {
    print(
        \\usage: hcore [action] [arg] [flags]
        \\
        \\Actions:
        \\    version          → Print program version
        \\
        \\    install          → Installs and configures everything.
        \\                       Flags:
        \\                         -v, --verbose   Show detailed output of each step
        \\                         -s, --silent    Suppress all output (logs only)
        \\
        \\    update           → Updates an existing setup.
        \\                       Updates Zig if needed, then packages and configs.
        \\                       Skips steps already up-to-date.
        \\                       Flags:
        \\                         -v, --verbose   Show detailed output of each step
        \\                         -s, --silent    Suppress all output (logs only)
        \\
        \\    command          → Executes internal TUI/CLI commands not supported by
        \\                       shell or walker.
        \\                       Flags:
        \\                         -l, --list      Show detailed list of commands
        \\                         -v, --verbose   Show detailed output of each step
        \\                         -s, --silent    Suppress all output (logs only)
        \\                       Run `hcore command --list` to see available commands.
        \\                       Run `hcore command xyz` to run a command
        \\
        \\flags:
        \\    -h, --help        → Show help message
        \\
        \\examples:
        \\    hcore install --verbose
        \\    hcore update -s
        \\    hcore command --list
        \\    hcore command xyz
        \\
    , .{});
}

fn parseCommand(arg: [:0]u8) ?Actions {
    if (std.mem.eql(u8, arg, "version")) return .VERSION;
    if (std.mem.eql(u8, arg, "install")) return .INSTALL;
    if (std.mem.eql(u8, arg, "update")) return .UPDATE;
    if (std.mem.eql(u8, arg, "command")) return .COMMAND;
    return null;
}

pub fn process(args: [][:0]u8) void { // Non-const to match argsAlloc
    const cmd_opt: ?Actions = parseCommand(args[1]);
    if (cmd_opt) |cmd| {
        switch (cmd) {
            .VERSION => version(),
            .INSTALL => {
                std.debug.print("Installing...\n", .{});
                install.install();
            },
            .UPDATE => std.debug.print("Updating...\n", .{}),
            .COMMAND => std.debug.print("Command mode...\n", .{}),
        }
    } else {
        std.debug.print("Error: Command not recognized: {s}\n", .{args[1]});
    }
}
