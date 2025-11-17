{
  description = "My system configuration";
  inputs = {
    # monorepo w/ recipes ("derivations")
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # manages configs
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # system-level software and settings (macOS)
    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # declarative homebrew management
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # firefox anddons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Format + linter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";

  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      treefmt-nix,
      systems,
      ...
    }@inputs:
    let
      # TODO: replace with your username
      primaryUser = "fpalen";
      primaryMail = "fpalen@gmail.com";
        eachSystem = f:
    nixpkgs.lib.genAttrs
      (import systems)  # esto suele ser una lista de systems
      (system: f system);
          forAllSystems = nixpkgs.lib.genAttrs (import systems);
    # Eval Treefmt para cada sistema
    treefmtEval = forAllSystems (system:
      treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix
    );
    in
    {
          # ---- Formatter visible para nix fmt ----
    formatter = forAllSystems (system:
      treefmtEval.${system}.config.build.wrapper
    );

    # ---- Checks para CI / nix flake check ----
    checks = forAllSystems (system: {
      formatting = treefmtEval.${system}.config.build.check self;
    });
      darwinConfigurations = {
        my-macbook = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./hosts/my-macbook/darwin
            ./hosts/my-macbook/configuration.nix
          ];
          specialArgs = { inherit inputs self primaryUser; };
        };
      };

    };
}
