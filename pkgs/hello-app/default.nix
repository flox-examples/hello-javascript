{self, system, inputs}:

let
  # This can be a builder
  mkDream = {system, src, inputs, ...}: 
# {{{
  let
   l = inputs.d2n.inputs.nixpkgs.lib // builtins;
   pkgs = inputs.d2n.inputs.nixpkgs.legacyPackages.${system};

   initD2N = pkgs:
inputs.d2n.lib.init {
        inherit pkgs;
        config.projectRoot = ../..;
      };

   makeOutputs = pkgs: let
      outputs = (initD2N pkgs).dream2nix-interface.makeOutputs {
        source = self;
        settings = [
          {
            builder = "granular-nodejs";
            translator = "package-lock";
          }
        ];
      };
    in rec {
      packages.${pkgs.system} = outputs.packages;
    };
  outputs = makeOutputs pkgs;
in
  outputs.packages.${system}.default;
in  # }}}

  mkDream {
    inherit system inputs;
    src = self;
  }

