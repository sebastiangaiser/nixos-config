{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    # TODO: replace manual extension + nativeMessagingHosts workaround once enablePlasmaBrowserIntegration
    # lands in release-25.11 (https://github.com/nix-community/home-manager/issues/5412, PR #9161)
    enablePlasmaBrowserIntegration = true;
    package = pkgs.chromium;
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
  };
}
