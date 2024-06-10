{ config, pkgs, hyprswitch, ... }:

{

  home.file = {
    ".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/sebastorama/.config/home-manager/dotfiles/hyprland.conf";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  home.packages = [
    hyprswitch.packages."x86_64-linux".default
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      background = [{
        color = "rgba(0, 0, 0, 1.0)";
      }];

      input-field = [
        {
          size = "400, 100";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          shadow_passes = 2;
        }
      ];

    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = (pkgs.catppuccin-papirus-folders.override { flavor = "mocha"; accent = "peach"; });
      name  = "Papirus-Dark";
    };
    theme = {
      package = (pkgs.catppuccin-gtk.override { accents = [ "peach" ]; size = "standard"; variant = "mocha"; });
      name = "Catppuccin-Mocha-Standard-Peach-Dark";
    };
  };

  imports = [ ./waybar.nix ];

  services.blueman-applet.enable = true;
  services.dunst.enable = true;
}
