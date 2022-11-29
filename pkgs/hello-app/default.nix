{
  self,
  system,
  inputs,
  pkgs,
}:
(inputs.d2n.lib.makeFlakeOutputs {
  pkgs = pkgs;
  source = self;
  settings = [
    {
      builder = "granular-nodejs";
      translator = "package-lock";
    }
  ];
}).packages.${system}.default
