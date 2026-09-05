{ pkgs, ... }:

let
 
  plasticityOptimized = pkgs.symlinkJoin {
    name = "plasticity-optimized";
    paths = [ pkgs.plasticity ];

    nativeBuildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      rm $out/bin/Plasticity

      makeWrapper ${pkgs.plasticity}/bin/Plasticity $out/bin/Plasticity \
        --add-flags "--ozone-platform=x11" \
        --add-flags "--high-dpi-support=1" \
        --add-flags "--force-device-scale-factor=1.25" \
        --add-flags "--use-angle=gl" \
        --add-flags "--enable-gpu-rasterization" \
        --add-flags "--enable-zero-copy"
      '';
  };
  
  cli = with pkgs; [
    git
    github-cli
    neovim
    fastfetch
    wget
    whois
    nodejs
    hyprpaper
    net-tools
    python3
    bluetui
    gcc
    bun
    pnpm
    nmap
    netcat
    dig
    bubblewrap
    meshtastic
  ];

  terminals = with pkgs; [
    ghostty
  ];

  desktop = with pkgs; [
    google-chrome
    nautilus
    vscode
    thunderbird
    bibata-cursors
    kicad
    freecad

    # Run Plasticity through XWayland with the flags configured above.
    plasticityOptimized

    # Hyprland
    hyprlauncher
    playerctl
    waybar
    brightnessctl
    grim
    slurp
    wl-clipboard
    nwg-displays
    wl-screenrec
    libnotify
    imagemagick
  ];
in
{
  services.flatpak.enable = true;

  environment.systemPackages =
    cli
    ++ terminals
    ++ desktop;
}
