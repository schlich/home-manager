{ pkgs, ... }:

{
  home.username = "tyschlichenmeyer";
  home.homeDirectory = "/Users/tyschlichenmeyer";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    rye
    gh
    nixd
    sampler
    jira-cli-go
    just
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".config/kitty/kitty.conf".source = dotfiles/kitty/kitty.conf;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tyschlichenmeyer/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };
  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config = ($env.config | upsert show_banner false)
      $env.config = ($env.config | upsert edit_mode vi)
      $env.EDITOR = 'hx'
      $env.ENV_CONVERSIONS = {
        "PATH": {
            from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
            to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
        "Path": {
            from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
            to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
      }

    '';
  };
  programs.helix.enable = true;
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      aws.disabled = true;
    };
  };
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.lazygit = {
    enable = true;
  };
  programs.bat.enable = true;
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.wezterm.enable = true;
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.keychain = {
    enable = true;
    enableNushellIntegration = true;
    keys = ["jira-cli"];
  };
  home.preferXdgDirectories = true;
  xdg.enable = true;

}
