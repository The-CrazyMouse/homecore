const std = @import("std");
const print = std.debug.print;
const install = @import("install/root.zig");

// This is all the Action you can do, most of this will be covered by the UI but
// is good too know
const Actions = enum { VERSION, INSTALL, UPDATE, COMMAND };

// This is pretty obvious, it makes pancakes ...
// I wish, just prints the version, desapointing
pub fn version() void {
    print("HomeCore - Dev Version\n", .{});
    print("hcore - Dev Version\n", .{});
    print("HomeCore config - Dev Version\n", .{});
}

// HELP!!! I need somebody. HELP!!!
// Do I need to say something ??? Pretty self explanatory
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

// now we getting somewhere , this make your text for the action into the enum in
// the begining of the page
fn parseCommand(arg: [:0]u8) ?Actions {
    if (std.mem.eql(u8, arg, "version")) return .VERSION;
    if (std.mem.eql(u8, arg, "install")) return .INSTALL;
    if (std.mem.eql(u8, arg, "update")) return .UPDATE;
    if (std.mem.eql(u8, arg, "command")) return .COMMAND;
    return null;
}

// this grabs you action, and does it
pub fn process(args: [][:0]u8) void {
    // this gets the action
    const cmd_opt: ?Actions = parseCommand(args[1]);
    // checks if it is a valid action
    if (cmd_opt) |cmd| {
        // this is the fork on the road
        switch (cmd) {
            //this goes to the function above that shows that makes pancakes ...
            //shows the version
            .VERSION => version(),

            //this leads to the place where hcore installs and configures everything
            //real exiting things...
            .INSTALL => {
                std.debug.print("Installing...\n", .{});
                install.install();
            },
            //this leads to the place where hcore updates stuff
            //this means the zig program, bash scripts and even your config, will be updated
            //unfortunatelly doesn't update my PC's hardware...
            .UPDATE => std.debug.print("Updating...\n", .{}),
            //this is the manual way to run one of the few tuis and other things with zig
            //this wont be importand unless you are twiking stuff, probably ...
            .COMMAND => std.debug.print("Command mode...\n", .{}),
        }
    } else {
        // if it isnt a valid action, it will tell you, I wish it could just ignore you but...
        // apparently that is rude or something
        std.debug.print("Error: Command not recognized: {s}\n", .{args[1]});
    }
}
