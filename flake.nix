{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      build_input_pkgs = [ pkgs.ffmpeg pkgs.gnumake ];
    in {

      defaultPackage.x86_64-linux = pkgs.stdenv.mkDerivation {
        name = "whisper.cpp";
        buildInputs = build_input_pkgs;
        src = ./.;
        buildPhase = ''
          make -j
        '';
        installPhase = ''
          mkdir -p $out
          mv main $out
        '';
      };

      devShell.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        buildInputs = build_input_pkgs;
        shellHook = "";
      };

    };
}
