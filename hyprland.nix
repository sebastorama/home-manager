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
        vfr = true
      }

      xwayland {
        force_zero_scaling = true
      }

      monitor=,highres,auto,2

      env = GDK_SCALE, 2
      env = XCURSOR_SIZE, 32

      decoration {
        rounding = 5
        drop_shadow = false
        blur {
          enabled = false
        }
      }

      animations {
        enabled = false
        # animation = windows, 1, 1, default
        # animation = workspaces, 1, 1, default
      }

      input {
        kb_layout = us
        kb_variant = mac
        kb_options = ctrl:nocaps
        repeat_delay = 250
        repeat_rate = 40
      }

      workspace = 11,monitor:eDP-2
      workspace = 12,monitor:eDP-2
      workspace = 13,monitor:eDP-2
      workspace = 14,monitor:eDP-2

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

      bind = $mainMod CTRL, 1, workspace, 11
      bind = $mainMod CTRL, 2, workspace, 12
      bind = $mainMod CTRL, 3, workspace, 13
      bind = $mainMod CTRL, 4, workspace, 14

      bind = $mainMod CTRL SHIFT, 1, movetoworkspace, 11
      bind = $mainMod CTRL SHIFT, 2, movetoworkspace, 12
      bind = $mainMod CTRL SHIFT, 3, movetoworkspace, 13
      bind = $mainMod CTRL SHIFT, 4, movetoworkspace, 14

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9

      windowrulev2 = opacity 0.9,class:^(kitty)$
      windowrule = size 80% 80%,class:^(kittyf)$
      windowrulev2 = float,class:^(kittyf)$
      windowrulev2 = opacity 0.9,class:^(kittyf)$
      windowrulev2 = xray on,class:^(kittyf)$
      layerrule = blur,waybar
    '';
  };

  imports = [ ./waybar.nix ];
}
