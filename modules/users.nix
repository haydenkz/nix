{ pkgs, ... }:

{
  programs.zsh.enable = true;
  
  users.users.hayden = {
    isNormalUser = true;
    description = "Hayden";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "dialout"
    ];
  };
}
