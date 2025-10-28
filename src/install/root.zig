const std = @import("std");
const print = std.debug.print;
const browser = @import("browser.zig");

pub fn install_homecore() void {
    const browser: ?[]u8 = browser.get_browser();
    
    const pacman_core_packs: [][]u8 = {
aether
asdcontrol // use full elsewhere
avahi
bash-completion
bat
blueberry
brightnessctl
btop
cups // maybe create a printer suport step
cups-browsed
cups-filters
cups-pdf
// docker // docker step
// docker-buildx
// docker-compose
// lazydocker
dust
elephant  // never used gotta check
elephant-bluetooth
elephant-calc
elephant-clipboard
elephant-desktopapplications
elephant-files
elephant-menus
elephant-providerlist
elephant-runner
elephant-symbols
elephant-todo
elephant-unicode
elephant-websearch
evince // gotta check too
expac
eza
fastfetch
onefetch
fcitx5
fcitx5-gtk
fcitx5-qt
fd
plocate
fontconfig
fzf
github-cli
gnome-calculator
gnome-keyring
gnome-themes-extra
grim
gpu-screen-recorder
gum
hypridle
hyprland
hyprland-qtutils
hyprlock
hyprpicker
hyprsunset
imagemagick // check if omarchy uses if not check it out if good leave
impala
imv
inetutils
inxi
iwd
kvantum-qt5
lazygit
less
libsecret
libqalculate
libreoffice // may chnge for other
llvm // check wtf is this
mako
man
mariadb-libs
mise
mpv
nautilus
gnome-disk-utility
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
noto-fonts-extra
nss-mdns
nvim
obs-studio
obsidian
omarchy-chromium
omarchy-nvim
pamixer
pinta
playerctl
plocate
plymouth
polkit-gnome
postgresql-libs
power-profiles-daemon
python-gobject
python-poetry-core
python-terminaltexteffects
qt5-wayland
ripgrep
satty
sddm
signal-desktop
slurp
spotify
starship
sushi
swaybg
swayosd
system-config-printer
tldr
tree-sitter-cli
ttf-cascadia-mono-nerd
ttf-ia-writer
ttf-jetbrains-mono-nerd
typora
tzupdate
ufw
ufw-docker
unzip
uwsm
walker
waybar
wayfreeze
whois
wireless-regdb
wiremix
wireplumber
wl-clipboard
woff2-font-awesome
xdg-desktop-portal-gtk
xdg-desktop-portal-hyprland
xmlstarlet
xournalpp
yaru-icon-theme
yay
zoxide
    }
}
