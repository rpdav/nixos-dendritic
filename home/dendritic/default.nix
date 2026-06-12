{
  self,
  inputs,
  pkgs,
  ...
}: {
  flake.homeConfigurations.ryanDendritic = {...}: {
    home.username = "ryan";
    home.homeDirectory = "/home/ryan";

    home.stateVersion = "26.05"; # don't change without reading release notes
    home.packages = with pkgs; [cowsay];
  };
}
