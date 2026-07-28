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
    moonlight-qt
    thunderbird 
    bibata-cursors

    #Hyprland
    hyprlauncher
    playerctl
    waybar
    playerctl
    brightnessctl
    grim
    slurp
    wl-clipboard
  ];
in
{
  virtualisation.docker.enable = true;
  environment.systemPackages =
    cli
    ++ shells
    ++ terminals
    ++ desktop;
}

