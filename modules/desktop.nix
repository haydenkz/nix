{ lib, pkgs, ... }:

let
  hyprlandSession = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
in

{
  services.xserver.enable = false;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --user-menu --cmd ${lib.escapeShellArg hyprlandSession}";
      user = "greeter";
    };
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
