{
  description = "Nix modules for raffauflabs.com";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

  outputs = inputs @ {self, ...}: {
    formatter = inputs.nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ] (system: inputs.nixpkgs.legacyPackages.${system}.alejandra);

    nixosModules.raffauflabs =
      import ./nixosModules inputs;

    nixosModules.default = self.nixosModules.raffauflabs;
  };
}
