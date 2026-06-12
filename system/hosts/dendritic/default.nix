{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.dendritic = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.dendriticSystem
    ];
  };
}
