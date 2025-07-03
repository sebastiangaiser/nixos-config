{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrains Mono";
      font-size = 10;
    };
    # https://github.com/ghostty-org/ghostty/discussions/7720
    package = pkgs.ghostty.overrideAttrs (_: {
       preBuild = ''
         shopt -s globstar
         sed -i 's/^const xev = @import("xev");$/const xev = @import("xev").Epoll;/' **/*.zig
         shopt -u globstar
       '';
     });
  };
}
