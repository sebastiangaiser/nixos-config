{ config, pkgs, lib, ... }:{
  imports = [
    ./modules/direnv.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/k9s.nix
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
    ansible
    bitwarden-cli
    bitwarden-desktop
    btop
    cilium-cli
    cmctl
    cowsay
    curl
    direnv
    dnsutils
    ethtool
    eza
    file
    firefox-wayland
    fluxcd
    fzf
    gawk
    gnupg
    gnused
    gnutar
    google-chrome
    hcloud
    iftop
    iotop
    ipcalc
    iperf3
    iw
    jetbrains.goland
    jq
    k9s
    kdePackages.oxygen
    ksshaskpass
    kubectl
    kubectl-cnpg
    kubectl-neat
    kubectl-validate
    kubectx
    kubelogin-oidc
    kyverno
    # TODO
    #unstable.kyverno
    ldns
    lf
    lm_sensors
    lsof
    ltrace
    materia-kde-theme
    mtr
    nix-output-monitor
    nmap
    openvpn
    pciutils
    pre-commit
    ripgrep
    rocketchat-desktop
    signal-desktop
    socat
    sops
    spaceship-prompt
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
    yubikey-manager-qt
    zip
    zstd
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
