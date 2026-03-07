{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    # enablePlasmaBrowserIntegration = true;
    commandLineArgs = [
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
    ];
    dictionaries = [
      pkgs.hunspellDictsChromium.de_DE
      pkgs.hunspellDictsChromium.en_US
    ];
    extensions = [
      # Bitwarden Password Manager
      # https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb
      "nngceckbapebfimnlniiiahkandclblb"

      # uBlock Origin Lite
      # https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh
      "ddkjiahejlhfcafbddmgiahcphecmpfh"

    ];
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
  };
}
