{ config, lib, pkgs, ... }:

let
  retainedGenerations = 3;

  pruneGenerations = pkgs.writeShellApplication {
    name = "prune-system-generations";
    runtimeInputs = [
      config.nix.package
      pkgs.coreutils
      pkgs.gawk
      pkgs.util-linux
    ];
    text = builtins.readFile ../scripts/prune-system-generations.sh;
  };

  pruneCommand = "${lib.getExe pruneGenerations} /nix/var/nix/profiles/system ${toString retainedGenerations}";
in
{
  boot.loader.systemd-boot.configurationLimit = retainedGenerations;

  # Prune profile references on activation; skip dry activation entirely.
  system.activationScripts.pruneSystemGenerations = {
    deps = [ "etc" ];
    supportsDryActivation = false;
    text = pruneCommand;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    # Retention is based on generation count, not age.
    options = "";
  };
  systemd.services.nix-gc.preStart = pruneCommand;

  # Deduplicate identical store files without changing their contents.
  nix.optimise.automatic = true;
}
