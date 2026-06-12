{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.userRyan = {...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];
    users.users.ryan = {
      # the hash below is for the password `changeme` - obviously only use this for this bare-bones installl config
      hashedPassword = "$6$7y9RbBEMGo1Fx.Pr$rM1PReeNvbKM1QCQvrNJ5BAYY3SlYDr49MTT0j6wv7cz5p0ezPz8ddihkyutowzEie1.NGFxzSpfawY0s9L2q1";
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keys = ["sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILygGVzteEOsvhdTTP+guA4Fq0TeJM/R2tDYXXbHvhLFAAAABHNzaDo= ryan@yubinano"];
    };
    home-manager = {
      #useUserPackages = true;
      users.ryan = self.homeConfigurations.ryanDendritic;
      #users.ryan = import (configLib.relativeToRoot "home/ryan/${config.networking.hostName}.nix");
      #extraSpecialArgs = {
      #  inherit nixpkgs-stable;
      #  inherit secrets;
      #  inherit inputs;
      #  inherit outputs;
      #  inherit configLib;
      #};
    };
  };
}
