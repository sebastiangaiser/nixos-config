# https://nix-community.github.io/home-manager/options.xhtml
{unstable}: {
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./modules/atuin.nix
    ./modules/bat.nix
    ./modules/catppuccin.nix
    ./modules/chromium.nix
    ./modules/direnv.nix
    ./modules/firefox.nix
    ./modules/fonts.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/k9s.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/plasma.nix
    ./modules/ssh.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    (pkgs.wrapHelm pkgs.kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-diff
        helm-s3
        helm-secrets
        helm-unittest
      ];
    })
    age
    amdgpu_top
    bats
    bitwarden-cli
    btop
    cilium-cli
    cmctl
    claude-code
    cowsay
    curl
    dart-sass
    direnv
    dmidecode
    dnsutils
    envsubst
    ethtool
    eza
    file
    fzf
    gawk
    gcc
    gh
    git-absorb
    glab
    gnumake
    gnupg
    gnused
    gnutar
    go
    go-jsonnet
    go-task
    gofumpt
    gojsontoyaml
    unstable.golangci-lint
    gopls
    hcloud
    helm-docs
    htop
    hugo
    iftop
    iotop
    ipcalc
    iperf3
    ipv6calc
    iw
    jetbrains.goland
    jq
    k9s
    kdePackages.kate
    kdePackages.kde-cli-tools
    kdePackages.ksshaskpass
    kdePackages.oxygen
    killall
    kitty
    kitty-themes
    ko
    kubebuilder
    kubectl
    kubectl-cnpg
    kubectl-neat
    kubectl-validate
    kubectx
    kubelogin-oidc
    kustomize
    ldns
    lf
    libcap
    unstable.librepods
    libva-utils
    lm_sensors
    lsof
    ltrace
    materia-kde-theme
    moreutils
    mtr
    nix-direnv
    nix-output-monitor
    nixfmt
    nmap
    nvd
    openssl
    openvpn
    papirus-icon-theme
    pciutils
    postgresql
    pre-commit
    pv-migrate
    ripgrep
    rocketchat-desktop
    shellcheck
    signal-desktop
    socat
    sops
    spotify
    stern
    strace
    sysstat
    unstable.talhelper
    talosctl
    telegram-desktop
    thunderbird
    tmate
    tmux
    tree
    unstable.fluxcd
    unstable.kyverno
    unzip
    upterm
    usbutils
    wget
    which
    xclip
    xz
    yq-go
    yubikey-manager
    yubioath-flutter
    zip
    zsh-powerlevel10k
    zstd
  ];

  home = {
    username = "sebastian";
    homeDirectory = "/home/sebastian";
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;
}
