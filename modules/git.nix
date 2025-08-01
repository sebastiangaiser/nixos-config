{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Sebastian Gaiser";
    userEmail = lib.mkDefault "sebastiangaiser@users.noreply.github.com";
    attributes = [
      "**/*.sops.yaml diff=sopsdiffer"
    ];
    ignores = [
      ".vscode/"
      ".idea/"
      ".env"
      ".envrc"
      "shell.nix"
      "*.iml"
    ];

    includes = [
      {
        condition = "gitdir:~/github.com/**";
        contents = {
          user.email = "sebastiangaiser@users.noreply.github.com";
        };
      }
    ];

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
      tag = {
        sort = "version:refname";
      };
      diff = {
        sopsdiffer.textconv = "${pkgs.sops}/bin/sops -d --config /dev/null";
      };
    };
  };
}
