{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  environment.localBinInPath = true;

  programs.appimage = {
    enable = true;
    # Allow executable AppImages to run directly.
    binfmt = true;
  };

  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      stdenv.cc.cc
      glib
      gtk3
      gdk-pixbuf
      cairo
      webkitgtk_4_1
      libsoup_3
      alsa-lib
    ];
  };
}
