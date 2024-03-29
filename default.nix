# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs, nixpkgs, mvn2nix, system, ... }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  test-app = pkgs.libsForQt5.callPackage ./pkgs/test-app { };
  mathematica = pkgs.callPackage ./pkgs/mathematica/default.nix { inherit pkgs; version = "13.1.0"; lang = "cn"; };
  understand = pkgs.callPackage ./pkgs/understand/default.nix { inherit pkgs; wrapQtAppsHook = pkgs.qt6Packages.wrapQtAppsHook; };
  understand-fhs = pkgs.callPackage ./pkgs/understand-fhs/default.nix { inherit pkgs; };
  vita3k = pkgs.callPackage ./pkgs/vita3k {
    stdenv = pkgs.llvmPackages_14.stdenv;
  };
  NetAnim = pkgs.libsForQt5.callPackage ./pkgs/NetAnim { stdenv = pkgs.gcc12Stdenv; gcc = pkgs.gcc12; };
  mutangxiang =
    pkgs.callPackage ./pkgs/mutangxiang {
      #     lib
      # , stdenv
      buildMavenRepositoryFromLockFile = mvn2nix.legacyPackages.${system}.buildMavenRepositoryFromLockFile;
      # , makeWrapper
      # , maven
      # , jdk11_headless
      # , nix-gitignore
    };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
