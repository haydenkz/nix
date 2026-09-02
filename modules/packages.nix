{ pkgs, ... }:

let
  cli = with pkgs; [
    git
    github-cli
    neovim
    fastfetch
    wget
    codex
    whois
    nodejs
    hyprpaper
    net-tools
    python3
    bluetui
    gcc
    bun
    pnpm
    nmap
    netcat
    dig
  ];

  shells = with pkgs; [
    zsh
  ];

  terminals = with pkgs; [
    ghostty
  ];

  desktop = with pkgs; [
    google-chrome
    nautilus
    vscode
    thunderbird
    bibata-cursors
    kicad
    freecad

    # Hyprland
    hyprlauncher
    playerctl
    waybar
    brightnessctl
    grim
    slurp
    wl-clipboard
    nwg-displays
    wl-screenrec
    libnotify
  ];
in
{
  virtualisation.docker.enable = true;
  services.flatpak.enable = true;

  environment.systemPackages =
    cli
    ++ shells
    ++ terminals
    ++ desktop;
}
