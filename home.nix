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

  imports = [
    ./hyprland.nix
    ./host_duo.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    bemenu
    btop
    cargo
    dropbox
    dunst
    fd
    fzf
    gcc
    gcolor3
    google-chrome
    grim
    jetbrains.datagrip
    (writeScriptBin "sdatagrip" (builtins.readFile ./hosts/duo/scripts/sdatagrip))
    jq
    kitty
    localsend
    lsd
    mpv
    neovim
    nil
    networkmanagerapplet
    nodejs_22
    normcap
    obsidian
    pavucontrol
    postgresql
    python3
    ripgrep
    ruby
    stdenv
    swaybg
    tldr
    tmux
    vim
    vlc
    wl-clipboard
    (nerdfonts.override { fonts = [ "JetBrainsMono" "IntelOneMono" ]; })

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

    ".config/wallpapers/" = {
      source = ./wallpapers;
    };

    ".config/hypr/pyprland.toml" = {
      source = dotfiles/pyprland.toml;
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
    "$HOME/.local/scripts"
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
    EDITOR = "nvim";
    LC_CTYPE = "en_US.UTF-8";
  };

  xdg = {
   enable = true;
   mime.enable = true;
  };

  programs.bash = {
    enable = true;
  };

  programs.foot = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;

    settings.colors = {
      background="1e1e2edd";
      text = "cdd6f4ff";
      match = "f38ba8ff";
      selection = "585b70ff";
      selection-match = "f38ba8ff";
      selection-text = "cdd6f4ff";
      border = "b4befeff";
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
     dc = "diff --cached";
     df = "diff";
     lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%ae>%Creset' --abbrev-commit";
   };

   diff-so-fancy = {
     enable = true;
   };
  };

  programs.tmux = {
    enable = true;
    catppuccin.enable = false;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    mouse = true;
    newSession = true;
    keyMode = "vi";
    extraConfig = ''
      set -g message-style bg='#222436'
      set -g status-style fg='#624C6F',bg='#222436'
      set -g window-status-current-style fg='#ff0000',bg='#222436'
      set-window-option -g window-status-current-style fg=red
      set-option -g status-position top

      # Use v to trigger selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      # Use y to yank current selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind-key -n C-M-PageUp swap-window -t -1\; select-window -t -1
      bind-key -n C-M-PageDown swap-window -t +1\; select-window -t +1
      bind-key -n C-PageUp previous-window
      bind-key -n C-PageDown next-window
      bind-key -n M-9 previous-window
      bind-key -n S-F1 swap-window -t -1\; select-window -t -1
      bind-key -n M-0 next-window
      bind-key -n S-F2 swap-window -t +1\; select-window -t +1
      bind-key -n F3 choose-window
      bind-key ! break-pane -d -n _hidden_pane
      bind-key @ join-pane -s $.1
    '';
  };

  programs.vscode.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
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

    autosuggestion = {
      enable = true;
      highlight = "fg=#ff00ff,bold";
    };

    history.ignoreAllDups = true;

    autocd = true;

    plugins = [{
      name = "zsh-fzf-history-search";
      src = pkgs.fetchFromGitHub {
        owner = "joshskidmore";
        repo = "zsh-fzf-history-search";
        rev = "d5a9730b5b4cb0b39959f7f1044f9c52743832ba";
        sha256 = "tQqIlkgIWPEdomofPlmWNEz/oNFA1qasILk4R5RWobY=";
      };
    }];
  };

  pam.sessionVariables = config.home.sessionVariables // {
    LANGUAGE = "en_US:en";
    LANG = "en_US.UTF-8";
  };

  home.keyboard.variant = "us-mac";

  catppuccin.enable = true;

  fonts.fontconfig.enable = true;
  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;
}
