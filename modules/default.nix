{ ... }:

{
  imports = [
    ./nix.nix
    ./boot.nix
    ./networking.nix
    ./desktop.nix
    ./audio.nix
    ./users.nix
    ./packages.nix
    ./hardware.nix
  ];
}
