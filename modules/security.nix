{ ... }:

{

  services.fprintd.enable = true;

  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.polkit-1.fprintAuth = true;

  # security.pam.services.sddm.fprintAuth = true;
  
  networking.firewall = {
    enable = true;
    allowPing = false;
  };

  services.openssh = {
    enable = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = true;
  };

  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 1;
    "kernel.kptr_restrict" = 2;
    "kernel.unprivileged_bpf_disabled" = 1;

    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;

    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
  };

  nix.settings = {
    sandbox = true;
    require-sigs = true;

    trusted-users = [
      "root"
    ];
  };
}
