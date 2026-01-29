{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [
      "x86_64-linux"
      "aarch64-linux"
    ]
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
          graalVMHome = "/home/self/graals/graalvm-svm-java17-linux-gluon-22.1.0.1-Final";
        in
        {
          devShells.default = pkgs.mkShell {
            name = "";

            buildInputs = [
              pkgs.clojure
            ];

            GRAALVM_HOME = graalVMHome;
            JAVA_CMD = "${graalVMHome}/bin/java"; # so that `clojure` picks GraalVM's java
            shellHook = ''
              export PATH="${graalVMHome}/bin:$PATH"
            '';
          };
        }
      );
}
