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
    google-chrome
    moonlight-qt
  ];
in
{
  environment.systemPackages =
    cli
    ++ shells
    ++ terminals
    ++ desktop;
}
