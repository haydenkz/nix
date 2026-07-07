{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = "26.05";
}
