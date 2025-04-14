{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      k = "kubectl";
      kx = "kubectx";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#dell-xps13 && show-changes";
      update = "nix flake update --flake ~/nixos-config --impure && rebuild";
      cleanup = "sudo nix store optimise && sudo nix-collect-garbage -d";
      pm-reset = "rm ~/.local/share/plasma-manager/last_run_* && ~/.local/share/plasma-manager/run_all.sh";
      pm-rebuild = "rebuild && pm-reset";
      show-changes = "nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
    };
    history.size = 100000000;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "golang"
        "kind"
        "kubectl"
        "kubectx"
        "pip"
        "ssh"
        "tailscale"
        "tmux"
      ];
      theme = "linuxonly";
    };
  };
}
