{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    # enablePlasmaBrowserIntegration = true;
    # extraOpts = {
    #   "BrowserSignin" = 0;
    #   "SyncDisabled" = true;
    #   "PasswordManagerEnabled" = false;
    #   "SpellcheckEnabled" = true;
    #   "SpellcheckLanguage" = [
    #     "de"
    #     "en-US"
    #   ];
    # };
    commandLineArgs = [
      # TODO somehow producing an error...
      # "--enable-logging=stderr"
      # "--ignore-gpu-blocklist"
      # "--disable-features=AutofillSavePaymentMethods"
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
