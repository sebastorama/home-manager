{ config, pkgs, hyprswitch, ... }:

{

  home.file = {
    ".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/hyprland/hyprland.conf";
    ".config/waybar/config".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/hyprland/waybar/config";
    ".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/hyprland/waybar/style.css";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  home.packages = [
    hyprswitch.packages."x86_64-linux".default
    pkgs.waybar
    pkgs.hypridle
    pkgs.lxqt.lxqt-qtplugin
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.papirus-icon-theme
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      background = [{
        path = "screenshot";
        color = "rgba(0, 0, 0, 1.0)";
        blur_passes = 3;
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
          shadow_passes = 3;
        }
      ];

    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };


  services.blueman-applet.enable = true;
  services.dunst.enable = true;

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        before_sleep_cmd = "hyprlock";
        lock_cmd = "pidof hyprlock || hyprlock";
      };
    };
  };
}
