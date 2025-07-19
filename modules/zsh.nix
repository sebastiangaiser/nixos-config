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
    history = {
      expireDuplicatesFirst = true;
      share = true;
      size = 1000000000;
    };
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

    initContent = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    shellAliases = {
      cat = "bat";
      k = "kubectl";
      kx = "kubectx";
      nfzf = "fzf --preview '\''bat --color=always --style=numbers --line-range=:500 {}'\'";
      v = "velero";

      # Nix related
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#framework13 && show-changes";
      update = "nix flake update --flake ~/nixos-config --impure && rebuild";
      cleanup = "sudo nix store optimise && sudo nix-collect-garbage -d";
      pm-reset = "rm ~/.local/share/plasma-manager/last_run_* && ~/.local/share/plasma-manager/run_all.sh";
      pm-rebuild = "rebuild && pm-reset";
      show-changes = "nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        # https://github.com/ohmyzsh/ohmyzsh/wiki/plugins
        "fancy-ctrl-z" # Ctrl-z
        "fluxcd"
        "fzf"
        "git"
        "golang"
        "helm"
        "history" # hs
        "kind"
        "kubectl"
        "kubectx"
        "pip"
        "ssh"
        "ssh-agent"
        "tailscale"
        "tmux"
      ];
      extraConfig = ''
        # Display red dots whilst waiting for completion.
        COMPLETION_WAITING_DOTS="true"

        # https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/ssh-agent/README.md
        zstyle :omz:plugins:ssh-agent agent-forwarding yes
        # maybe use `zstyle :omz:plugins:ssh-agent helper ksshaskpass` or extract the PW from Bitwarden?
        zstyle :omz:plugins:ssh-agent lifetime 12h
        zstyle :omz:plugins:ssh-agent quiet yes
        zstyle :omz:plugins:ssh-agent lazy yes
      '';
    };
  };
}
