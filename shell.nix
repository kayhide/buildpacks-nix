{ overlays ? []
}@args:

let
  inherit (nixpkgs) pkgs;

  env-overlay = self: super: {
    my-env = super.buildEnv {
      name = "my-env";
      paths = with self; [
        buildpack
      ];
    };
  };

  nixpkgs = import <nixpkgs> (args // {
    overlays = overlays ++ [
      env-overlay
    ];
  });

in

pkgs.mkShell {
  buildInputs = with pkgs; [
    my-env
  ];
}
