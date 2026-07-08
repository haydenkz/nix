{ pkgs, ... }:

let
  cli = with pkgs; [
    git
    github-cli
    neovim
    fastfetch
    wget
  ];

  shells = with pkgs; [
    zsh
  ];

  terminals = with pkgs; [
    ghostty
    kitty
  ];

  desktop = with pkgs; [
    kdePackages.plasma-browser-integration
    google-chrome
    moonlight-qt
    thunderbird
    winboat
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
