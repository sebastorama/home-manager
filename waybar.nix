{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/submap"];
        modules-right = ["wireplumber" "power-profiles-daemon" "custom/duo" "battery" "clock" "tray"];

        "hyprland/workspaces" = {
          format = "{name}";
        };

        battery = {
          format = "{icon} {capacity}%";
          interval = 1;
          format-icons = ["󰂎"];
        };

        tray = {
          spacing = 10;
        };

        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "";
          on-click = "pavucontrol";
          format-icons = ["" "" ""];
        };

        power-profiles-daemon = {
          format = "{icon}  {profile}";
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        "custom/duo" = {
          format = "{} ";
          exec = "echo $(/home/sebastorama/.local/hm-bins/duo/display_ck)";
          return-type = "text";
          restart-interval = 1;
          interval = 1;
          on-click = "echo \"top\nboth\nbottom\" | fuzzel -d | xargs -I {} /home/sebastorama/.local/hm-bins/duo/display_toggle {}";
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
        background-color: rgba(34, 36, 54, 0.8);
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

      #wireplumber {
        margin-right: 1.5rem;
      }

      #power-profiles-daemon {
        margin-right: 1rem;
      }

      #power-profiles-daemon.power-saver {
        color: #9ece6a;
      }

      #power-profiles-daemon.balanced {
        color: #e0af68;
      }

      #power-profiles-daemon.performance {
        color: #bb9af7;
      }

      #tray {
        padding-right: 1.5rem;
      }

      #tray menu menuitem:hover {
        background-color: #333333;
      }

      #workspaces button {
        padding: 0 0.2rem;
        margin: 0 0.1rem;
        border-top: 2px solid rgba(0, 0, 0, 0);
      }

      #workspaces button.active {
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
