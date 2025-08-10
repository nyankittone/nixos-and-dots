{
  description = "Home Manager configuration of tiffany";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixgl.url = "github:nix-community/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "stable";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = { nixgl, stable, unstable, home-manager, ... }@inputs:
    let
      pkgsUnstable = unstable.legacyPackages.x86_64-linux;
      usingNixOS = false;
      meta = import ./meta_config.nix;
    in
    {
      homeConfigurations."${meta.username}" = home-manager.lib.homeManagerConfiguration {
        pkgs = stable.legacyPackages.x86_64-linux;

        # Specify your home configuration modules here, for example, the path to your home.nix.
        modules = [
          ./home.nix
          {nixpkgs.overlays = [nixgl.overlays.default];}
        ];

        # Optionally use extraSpecialArgs to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgsUnstable;
          inherit usingNixOS;
        };
      };
    };
}
