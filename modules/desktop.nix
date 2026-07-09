{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.ly.enable = true;
  
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
    	swaylock
	swayidle
	foot
	rofi
	dmenu
    ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
