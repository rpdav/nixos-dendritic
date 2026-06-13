{
  self,
  inputs,
  ...
}: {
  #imports = [inputs.home-manager.flakeModules.home-manager];
  flake.nixosModules.userRyan = {pkgs, ...}: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    users.users.ryan = {
      # the hash below is for the password `changeme` - obviously only use this for this bare-bones installl config
      hashedPassword = "$6$7y9RbBEMGo1Fx.Pr$rM1PReeNvbKM1QCQvrNJ5BAYY3SlYDr49MTT0j6wv7cz5p0ezPz8ddihkyutowzEie1.NGFxzSpfawY0s9L2q1";
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keys = ["sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILygGVzteEOsvhdTTP+guA4Fq0TeJM/R2tDYXXbHvhLFAAAABHNzaDo= ryan@yubinano"];
    };

    environment.systemPackages = with pkgs; [home-manager];

    #home-manager = {
    #  #useUserPackages = true;
    #  users.ryan = {
    #    home.username = "ryan";
    #    home.homeDirectory = "/home/ryan";
    #    home.stateVersion = "26.05";
    #    home.packages = with pkgs; [cowsay];
    #  };

    #  ## From
    #  #users.ryan = import (configLib.relativeToRoot "home/ryan/${config.networking.hostName}.nix");
    #  #extraSpecialArgs = {
    #  #  inherit nixpkgs-stable;
    #  #  inherit secrets;
    #  #  inherit inputs;
    #  #  inherit outputs;
    #  #  inherit configLib;
    #  #};
    #};
  };
  flake.homeConfigurations.ryanDendritic = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    modules = [
      self.homeModules.starship
      ({pkgs, ...}: {
        home.username = "ryan";
        home.homeDirectory = "/home/ryan";

        home.stateVersion = "26.05"; # don't change without reading release notes
        home.packages = with pkgs; [
          cowsay
          lolcat
        ];
      })
    ];
  };
}
