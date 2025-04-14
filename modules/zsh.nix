{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    # relative to ~
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;
    history.size = 100000000;
    history.share = true;
    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

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
      extraConfig = ''
        # Display red dots whilst waiting for completion.
        COMPLETION_WAITING_DOTS="true"
      '';
    };
  };
}
