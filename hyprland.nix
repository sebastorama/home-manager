{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    settings = {
      exec-once = [
        "swww init &"
        "nm-applet --indicator &"
        "blueman-applet"
        "waybar &"
        "dunst &"
        "dropbox &"
        "find /home/sebastorama/.config/wallpapers/* | xargs swaybg -m fill -i &"
        "hyprctl keyword monitor \"eDP-2, disable\""
      ];
    };

    systemd.enable = true;

    extraConfig = ''
      $mainMod = SUPER

      bind = $mainMod, Return, exec, kitty
      bind = $mainMod, D, exec, rofi -show combi
      bind = $mainMod, Q, killactive
      bind = $mainMod, B, exec, firefox
      bind = $mainMod, F, fullscreen
      bind = $mainMod, V, togglefloating

      bind = $mainMod SHIFT, Return, exec, kitty --class kittyf --title kitty tmux new-session -As gen

      general {
        gaps_in = 3
        gaps_out = 3
        border_size = 1

        col.active_border = rgba(bb9af7ff)
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
      }

      xwayland {
        force_zero_scaling = true
      }

      monitor=,highres,auto,2

      env = GDK_SCALE, 2
      env = XCURSOR_SIZE, 32

      decoration {
        rounding = 5

        drop_shadow = true
        shadow_range = 5
        shadow_render_power = 3
      }

      animations {
        enabled = true
        animation = windows, 1, 1, default
        animation = workspaces, 1, 1, default
      }

      input {
        kb_layout = us
        kb_variant = mac
        kb_options = ctrl:nocaps
        repeat_delay = 250
        repeat_rate = 40
      }

      windowrulev2=float,class:^(org.telegram.desktop|telegramdesktop)$,title:^(Media viewer)$

      # will switch to a submap called resize
      bind=$mainMod,R,submap,resize
      submap=resize
        binde=,l,resizeactive,40 0
        binde=,h,resizeactive,-40 0
        binde=,k,resizeactive,0 -40
        binde=,j,resizeactive,0 40

        binde=ALT,l,resizeactive,10 0
        binde=ALT,h,resizeactive,-10 0
        binde=ALT,k,resizeactive,0 -10
        binde=ALT,j,resizeactive,0 10

        bind=,escape,submap,reset
      submap=reset


      # keybinds further down will be global again...

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bind = $mainMod, code:21, exec, brillo -s intel_backlight -q -A 10
      bind = $mainMod, code:20, exec, brillo -s intel_backlight -q -U 10

      bind = $mainMod, h, movefocus, l
      bind = $mainMod, j, movefocus, d
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, l, movefocus, r

      bind = $mainMod SHIFT, h, movewindow, l
      bind = $mainMod SHIFT, j, movewindow, d
      bind = $mainMod SHIFT, k, movewindow, u
      bind = $mainMod SHIFT, l, movewindow, r

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 1, workspace, 1

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9

      windowrulev2 = opacity 0.8,class:^(kitty)$
      windowrule = size 80% 80%,class:^(kittyf)$
      windowrulev2 = float,class:^(kittyf)$
      windowrulev2 = opacity 0.8,class:^(kittyf)$
      windowrulev2 = xray on,class:^(kittyf)$
      layerrule = blur,waybar
    '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/submap"];
        modules-right = ["custom/duo" "sndio" "battery" "bluetooth" "clock" "tray"];

        "hyprland/workspaces" = {
          format = "{name}";
        };

        battery = {
          format = "{icon} {capacity}%";
          interval = 1;
          format-icons = ["󰂎"];
        };

        "custom/duo" = {
          format = "{}";
          exec = "display_ck";
          interval = 1;
        };

        clock = {
          format = "󰚭 {:%H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode          = "year";
            mode-mon-col  = 3;
            weeks-pos     = "right";
            on-scroll     = 1;
            format= {
              months=     "<span color='#ffead3'><b>{}</b></span>";
              days=       "<span color='#ecc6d9'><b>{}</b></span>";
              weeks=      "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays=   "<span color='#ffcc66'><b>{}</b></span>";
              today=      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };

        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: JetBrainsMono Nerd Font;
        background-color: rgba(34, 36, 54, 0.1);
      }

      tooltip {
        background-color: #1a1b26;
      }

      #submap.resize {
        color: #ffcc66;
        font-weight: 700;
      }

      #battery.charging {
        color: #9ece6a;
      }

      #battery.discharging {
        color: #c0caf5;
      }

      #workspaces button {
        padding: 0rem;
        color: #c0caf5;
      }

      #workspaces button.active {
        padding: 0 0.2rem;
        margin: 0 0.1rem;
        font-weight: 700;
        color: #bb9af7;
        border-top: 2px solid #bb9af7;
      }

      #battery, #bluetooth, #clock, #tray {
        padding-left: 1.3rem;
        color: #c0caf5;
      }
    '';
  };
}
