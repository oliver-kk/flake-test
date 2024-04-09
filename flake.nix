{
  inputs = { utils.url = "github:numtide/flake-utils"; };
  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        defaultPackages = with pkgs; [ cowsay devbox direnv ];
      in {
        devShell = pkgs.mkShell { buildInputs = defaultPackages; };
        packages = rec {
          default = pkgs.buildEnv {
            name = "devTools";
            paths = defaultPackages;
          };
        };
      });
}
