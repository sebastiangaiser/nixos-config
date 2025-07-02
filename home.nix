{ config, pkgs, lib, ... }:{
  imports = [
    ./modules/bat.nix
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
    dnsutils
    envsubst
    ethtool
    eza
    file
    firefox-wayland
    fluxcd
    fzf
    gawk
    gcc
    gnupg
    gnused
    gnutar
    go
    hcloud
    iftop
    iotop
    ipcalc
    iperf3
    iw
    jetbrains.goland
    jq
    k9s
    kdePackages.ksshaskpass
    kdePackages.oxygen
    kitty
    kitty-themes
    kubectl
    kubectl-cnpg
    kubectl-neat
    kubectl-validate
    kubectx
    kubelogin-oidc
    kyverno
    ldns
    lf
    libcap
    lm_sensors
    lsof
    ltrace
    materia-kde-theme
    mtr
    nix-output-monitor
    nmap
    nvd
    openssl
    openvpn
    papirus-icon-theme
    pciutils
    pre-commit
    pv-migrate
    ripgrep
    rocketchat-desktop
    signal-desktop
    socat
    sops
    spotify
    strace
    sysstat
    talosctl
    telegram-desktop
    tmate
    tmux
    tree
    unzip
    usbutils
    which
    xz
    yq-go
    yubikey-manager
    yubioath-flutter
    zip
    zsh-powerlevel10k
    zstd
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
