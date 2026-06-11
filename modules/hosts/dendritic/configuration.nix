{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.dendriticSystem = {
    pkgs,
    inputs,
    ...
  }: {
    ## This is a bare-bones config used only for provisioning a new host. See system/hosts/fw13/default.nix for the main config.

    imports = [
      self.nixosModules.ext4Disk
      self.nixosModules.dendriticHardware
    ];

    # Enable flakes
    nix = {
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    # Boot
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    # Networking
    networking.hostName = "dendritic";

    # Create ssh host keys to import into sops if they don't already exist in backup
    services.openssh = {
      enable = true;
      ports = [22];
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
      openssh.authorizedKeys.keys = ["sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILygGVzteEOsvhdTTP+guA4Fq0TeJM/R2tDYXXbHvhLFAAAABHNzaDo= ryan@yubinano"];
    };
    users.users.root = {
      hashedPassword = "$6$7y9RbBEMGo1Fx.Pr$rM1PReeNvbKM1QCQvrNJ5BAYY3SlYDr49MTT0j6wv7cz5p0ezPz8ddihkyutowzEie1.NGFxzSpfawY0s9L2q1";
      openssh.authorizedKeys.keys = ["sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILygGVzteEOsvhdTTP+guA4Fq0TeJM/R2tDYXXbHvhLFAAAABHNzaDo= ryan@yubinano"];
    };

    # Change this to match installer version
    system.stateVersion = "25.11";
  };
}
