{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sebastorama";
  home.homeDirectory = "/home/sebastorama";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bemenu
    cargo
    foot
    fzf
    gcc
    lsd
    neovim
    nodejs_22
    nil
    postgresql
    stdenv
    tldr
    tmux
    vim
    wl-clipboard
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/kitty/kitty.conf" = {
      source = dotfiles/kitty.conf;
    };

    ".local/hm-bins/duo" = {
      source = hosts/duo;
    };

    ".npmrc" = {
      source = dotfiles/npmrc;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = [
    "$HOME/.local/hm-bins/duo"
    "$HOME/.npm-packages/bin"
  ];

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
  #  /etc/profiles/per-user/sebastorama/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    BEMENU_BACKEND = "curses";
    EDITOR = "nvim";
    LC_CTYPE = "en_US.UTF-8";
    XDG_DATA_DIRS="/home/sebastorama/.nix-profile/share:$XDG_DATA_DIRS";
  };

  xdg = {
   enable = true;
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "rust"
      ];
    };

    shellAliases = {
      ta = "tmux new-session -As";
      ls = "lsd";
    };
  };

  programs.git = {
   enable = true;
   userEmail = "sebastorama@gmail.com";
   userName = "Sebastião Giacheto Ferreira Júnior";

   extraConfig = {
     init.defaultBranch = "main";
     core.editor = "nvim";
     merge.tool = "nvimdiff";
     mergetool."nvimdiff".cmd = "nvim -d \"$LOCAL\" \"$MERGED\" \"$BASE\" \"$REMOTE\" -c \"wincmd w\" -c \"wincmd J\"";
     diff.tool = "nvimdiff";
     difftool."nvimdiff".cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
   };

   aliases = {
     st = "status";
     ci = "commit";
     co = "checkout";
     lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%ae>%Creset' --abbrev-commit";
   };
   diff-so-fancy = {
     enable = true;
   };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    mouse = true;
    newSession = true;
    keyMode = "vi";
    extraConfig = ''
      set -g message-style bg='#222436'
      set -g status-style fg='#624C6F',bg='#222436'
      set -g window-status-current-style fg='#ff0000',bg='#222436'
    '';
  };

  dconf.settings = {
    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "kitty super";
      command = "kitty -e tmux new-session -As g";
      binding = "<Super>Return";
    };
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
