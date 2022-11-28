{
  self,
  system,
  inputs,
  pkgs,
}:
let
  # This can be a builder
  mkDream = args @ { # {{{
    pkgs,
    src,
    inputs,
    ...
  }:
  let
    makeOutputs = pkgs: let
      initD2N = pkgs:
        inputs.d2n.lib.init {
          inherit pkgs;
          config.projectRoot = src;
        };

      outputs = (initD2N pkgs).dream2nix-interface.makeOutputs ({
          source = src;
          settings = [
            {
              builder = "granular-nodejs";
              translator = "package-lock";
            }
          ];
        }
        // (builtins.removeAttrs args ["src" "inputs" "pkgs"]));
    in
      outputs.packages.default;
    outputs = makeOutputs pkgs;
  in
    makeOutputs pkgs;
in
  # }}}
  mkDream {
    inherit inputs pkgs;
    src = self;
    # packageOverrides = {};
  }
