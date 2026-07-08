# gitrocket — a rocket animation on every git commit, à la the old Hyper plugin.
#
# Ghostty has no plugin API (it's a native terminal), so instead of hooking the
# terminal we hook git itself: init.templateDir seeds a post-commit hook into
# every repo you init/clone. This coexists with the pre-commit framework, which
# manages the separate `pre-commit` hook — using core.hooksPath would break that.
{ config, ... }:
let
  templateDir = "${config.home.homeDirectory}/.config/git/template";
in
{
  programs.git.settings.init.templateDir = templateDir;

  home.file.".config/git/template/hooks/post-commit" = {
    source = ./gitrocket/post-commit;
    executable = true;
  };
}
