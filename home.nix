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
    ./modules/fonts.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/k9s.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/plasma.nix
    ./modules/tmux.nix
    ./modules/vscode.nix
    ./modules/zsh.nix
  ];

  home.username = "sebastian";
  home.homeDirectory = "/home/sebastian";

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    (pkgs.wrapHelm pkgs.kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-diff
        helm-secrets
        helm-s3
      ];
    })
    age
    bats
    bitwarden-cli
    bitwarden-desktop
    btop
    chromium
    cilium-cli
    cmctl
    cowsay
    curl
    direnv
    dmidecode
    dnsutils
    envsubst
    ethtool
    eza
    file
    firefox
    fzf
    gawk
    gcc
    gnumake
    gnupg
    gnused
    gnutar
    go
    go-task
    gopls
    hcloud
    iftop
    iotop
    ipcalc
    iperf3
    ipv6calc
    iw
    jetbrains.goland
    jq
    unstable.k9s
    kdePackages.kde-cli-tools
    kdePackages.ksshaskpass
    kdePackages.oxygen
    killall
    kitty
    kitty-themes
    kubectl
    kubectl-cnpg
    kubectl-neat
    kubectl-validate
    kubectx
    kubelogin-oidc
    ldns
    lf
    libcap
    lm_sensors
    lsof
    ltrace
    materia-kde-theme
    moreutils
    mtr
    nix-output-monitor
    nixfmt-rfc-style
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
    talosctl
    telegram-desktop
    tmate
    tmux
    tree
    unstable.fluxcd
    unstable.kyverno
    unzip
    upterm
    usbutils
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

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
