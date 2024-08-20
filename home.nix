{ pkgs, ... }:

{
  home.username = "tyschlichenmeyer";
  home.homeDirectory = "/Users/tyschlichenmeyer";
  targets.darwin.defaults.NSGlobalDomain.AppleLocale = "en_US";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    gh
    nixd
    jira-cli-go
    pijul
    pyright
    pylyzer
    lua
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "sql" ''
      harlequin -a adbc "TSCHLIC:ketniC-fajdi7-bantik@fanakvy-mfb29890/collage_dev" --driver-type snowflake
    '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # "$env.XDG_CONFIG_HOME/nushell/nupm".source = /Users/tyschlichenmeyer/.config/nushell/nupm;
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
  programs.helix.enable = true;
  programs.nushell = {
    enable = true;
    shellAliases = {
      pj = "pijul";
      gst = "git status";
      hme = "home-manager edit";
      hms = "home-manager switch";
      lg = "lazygit";
     };
    extraConfig = ''
      $env.config = ($env.config | upsert show_banner false)
      $env.config = ($env.config | upsert edit_mode vi)

      $env.config = ($env.config | upsert hooks.env_change.PWD {
          [
              {
                  condition: {|_, after|
                      ('.venv/bin/activate.nu' | path exists)
                  }
                  code: "overlay use .venv/bin/activate.nu"
              }
          ]
      })
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
      $env.PATH = $env.PATH | prepend '/Users/tyschlichenmeyer/.nix-profile/bin'
    '';
  };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      aws.disabled = true;
      nodejs.disabled = true;
      package.disabled = true;
      python.disabled = true;
      git_metrics.disabled = false;
      git_status.disabled = true;
      nix_shell.disabled = true;
      pijul_channel.disabled = true;
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
  # programs.wezterm.enable = true;
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.keychain = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.zellij = {
    enable = true;
  };
  programs.ruff = {
    enable = true;
    settings = {};
  };
  programs.poetry.enable = true;
  home.preferXdgDirectories = true;
  xdg.enable = true;
}
