{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations.testvm = nixpkgs.legacyPackages.x86_64-linux.nixos [
      ./configuration.nix
    ];
  };
}
