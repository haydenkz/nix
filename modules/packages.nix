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
  ];

  shells = with pkgs; [
    zsh
  ];

  terminals = with pkgs; [
    ghostty
    kitty
  ];

  desktop = with pkgs; [
    google-chrome
    nautilus
    moonlight-qt
    thunderbird 
    bibata-cursors
    hyprlauncher
    playerctl
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
