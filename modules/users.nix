{ ... }:

{
  users.users.hayden = {
    isNormalUser = true;
    description = "Hayden";

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
