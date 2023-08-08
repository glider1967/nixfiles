{
  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-utils.url = "github:numtide/flake-utils";
    # Others
    rust-overlay.url = "github:oxalica/rust-overlay";
    # xremap.url = "github:xremap/nix-flake";
  };

  outputs = inputs: {
    nixosConfigurations = {
      myNixOS = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        specialArgs = {inherit inputs;};
      };
    };

    homeConfigurations = {
      myHome = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = [(import inputs.rust-overlay)];
        };
        extraSpecialArgs = {inherit inputs;};
        modules = [./home.nix];
      };
    };

    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    defaultPackage.x86_64-linux = inputs.home-manager.defaultPackage.x86_64-linux;
  };
}
