{
  pkgs,
  inputs,
  ...
}: {
  ## This is a bare-bones config used only for provisioning a new host. See system/hosts/fw13/default.nix for the main config.

  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
  ];

  # Enable flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Enable support for encrypted partition
  # Remove any other auto-generated boot.loader lines
  #TODO: replace this with systemdboot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "testvm";

  # Create ssh host keys to import into sops if they don't already exist in backup
  services.openssh = {
    enable = true;
    ports = [22];
    settings.PasswordAuthentication = true;
    hostKeys = [
      {
        comment = "server key";
        path = "/etc/ssh/ssh_host_ed25519_key";
        rounds = 100;
        type = "ed25519";
      }
    ];
  };

  # Timezone
  time.timeZone = "America/Indiana/Indianapolis";

  # Useful packages for intial reinstall
  environment.systemPackages = with pkgs; [
    firefox
    git
    vim
    borgbackup
    tree
    sops
    ssh-to-age
  ];

  # Define primary user
  users.users.ryan = {
    # the hash below is for the password `changeme` - obviously only use this for this bare-bones installl config
    hashedPassword = "$6$7y9RbBEMGo1Fx.Pr$rM1PReeNvbKM1QCQvrNJ5BAYY3SlYDr49MTT0j6wv7cz5p0ezPz8ddihkyutowzEie1.NGFxzSpfawY0s9L2q1";
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  # Change this to match installer version
  system.stateVersion = "25.11";
}
