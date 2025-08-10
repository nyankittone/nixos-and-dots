{pkgs, stdenv}:
pkgs.buildGoModule {
  pname = "fortunate";
  version = "0.0.69.420.1337";

  vendorHash = null;

  src = ./.;
}
