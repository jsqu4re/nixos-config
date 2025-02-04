{ pkgs, config, ... }:
let
  color = {
    background = "2E3440";
    lightbackground = "3E4656";
    foreground = "D8DEE9";
    black = "3B4252";
    red = "BF616A";
    green = "A3BE8C";
    yellow = "EBCB8B";
    blue = "81A1C1";
    magenta = "B48EAD";
    cyan = "88C0D0";
    white = "E5E9F0";
  };
in
{
  home.packages = with pkgs; [
    hyprland-qtutils
    vlc-blu-ray
  ];

  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 200;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # default variables
      "$mainMod" = "SUPER";
      "$terminal" = "${pkgs.lib.getExe config.programs.kitty.package}";
      "$editor" = "${pkgs.lib.getExe config.programs.nixvim.package}";
      "$browser" = "${pkgs.lib.getExe pkgs.zen-browser}";
      "$launcher" = "${pkgs.lib.getExe pkgs.fuzzel} -b ${color.background}F5 -t ${color.foreground}FF -s ${color.cyan}AF -m ${color.yellow}90 -S ${color.black}FF -M ${color.green}FF -r 40 -B 2 -C ${color.white}F5 -y 30 -P 20";
      "$fileManager" = "${pkgs.lib.getExe pkgs.nemo-with-extensions}";

      env = [
        # use igpu for hyprland
        # "WLR_DRM_DEVICES,/dev/dri/card1"
        "WLR_NO_HARDWARE_CURSORS,1"

        # xdg
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        # "XDG_SCREENSHOTS_DIR,${config.screenshotsDir}"

        # qt
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        # utilities
        "TERMINAL,$terminal"
        "EDITOR,$editor"
        "BROWSER,$browser"
      ];

      windowrulev2 = [
        # steam
	      "stayfocused, title:^()$,class:^(steam)$"
	      "minsize 1 1, title:^()$,class:^(steam)$"
        "float, class:(steam), title:(Steam)"
        "float, class:(steam), title:(Friends List)"
        "nofocus, class:^(steam)$, title:^()$"

        # zen-browser
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "move 66% 1%, title:^(Picture-in-Picture)$"
        "size 33% 28%, title:^(Picture-in-Picture)$"

        "noanim, class:(com.gabm.satty)"
        "float, class:(com.gabm.satty)"

        "opacity 0.9 0.9, class:^(.*)$"
      ];

      layerrule = [
        "blur, rofi"
        "ignorezero, rofi"

        # ags
        "blur, ags-*"
        "ignorezero, ags-*"
      ];

      monitor = ["HDMI-A-3,3840x2160@60,0x0,1" "Unknown-1,disable"];

      input = {
        sensitivity = "-0.25";
        accel_profile = "flat";

        follow_mouse = "1";
      };

      general = {
        gaps_in = "8";
        gaps_out = "24";

        layout = "dwindle";
      };

      decoration = {
        rounding = "10";

        # drop_shadow = "false";
        # shadow_range = "4";
        # shadow_render_power = "3";
        # "col.shadow" = "rgba(1a1a1aee)";

        # dim_inactive = "true";

        blur = {
          enabled = "true";
          size = "8";
          passes = "4";
          # popups = "true";
        };
      };

      #device = {
      #  name = "elan1300:00-04f3:3057-touchpad";
      #  enabled = false;
      #};

      bind = [
        # apps
        "$mainMod, return, exec, $terminal"
        "$mainMod, q, exec, $browser"
        "$mainMod, d, exec, $launcher"
        "$mainMod, e, exec, $fileManager"

        # toggle floating window
        "$mainMod, SPACE, togglefloating"

        # close active window
        "$mainMod SHIFT, q, killactive"

        "$mainMod, f, fullscreen"

        # close hyprland session
        "$mainMod SHIFT, e, exit"

        "$mainMod, o, exec, pkill -SIGUSR1 waybar"

        # move focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, r, resizeactive"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # scroll through workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        
        # scroll through workspaces
        "CTRL $mainMod, right, workspace, e+1"
        "CTRL $mainMod, left, workspace, e-1"

        # obs studio pass
        "$mainMod, F10, pass, ^(com\.obsproject\.Studio)$"

        # screenshotting
        ", PRINT, exec, grimblast copysave screen"
        "CTRL, PRINT, exec, grimblast copysave area"
        "ALT, PRINT, exec, grimblast save area - | satty -f -"
        "SHIFT, PRINT, exec, grimblast copysave active"
      ];

      bindm = [
        # move & resize windows
        "$mainMod, mouse:272, movewindow"
        "CTRL $mainMod, mouse:272, resizewindow"
      ];

      binde = [
        # pipewire volume control
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # brightness control
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 2.5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +2.5%" ];

      misc = {
        disable_hyprland_logo = true;
      };
    };
  };
  
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 10;
        modules-left = [
          "hyprland/workspaces"
          "pulseaudio"
          "cpu"
          "memory"
          "disk"
        ];
        "cpu" = {
          interval=1;
          format=" &#xf2db; {icon} ";
          format-icons={
            default= [
              "          "
              "|         "
              "||        "
              "|||       "
              "||||      "
              "|||||     "
              "||||||    "
              "|||||||   "
              "||||||||  "
              "||||||||| "
              "||||||||||"
            ];
          };
        };
        "memory" = {
          interval=1;
          format=" &#xf3ff; {icon} ";
          format-icons={
            default= [
              "          "
              "|         "
              "||        "
              "|||       "
              "||||      "
              "|||||     "
              "||||||    "
              "|||||||   "
              "||||||||  "
              "||||||||| "
              "||||||||||"
            ];
          };
        };
        "disk" = {
          interval=1;
          format=" &#xf1c0; {free} ";
        };
        "pulseaudio"= {
          format="{icon}";
          format-muted="&#xF6A9;        ";
          format-icons={
            default= [
              "&#xF026;        "
              "&#xF027;        "
              "&#xF028;        "
              "&#xF028; )      "
              "&#xF028; )|     "
              "&#xF028; )||    "
              "&#xF028; )|||   "
              "&#xF028; )||||  "
              "&#xF028; )||||| "];
          };
          on-click="wpctl set-mute @DEFAULT_SINK@ toggle";
          on-click-right="pavucontrol";
        };
        "clock"= {
          format = "{:%H:%M}";
          format-alt = "{:%A   %d. %B %Y   %R}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#${color.foreground}'><b>{}</b></span>";
              days = "<span color='#${color.foreground}'><b>{}</b></span>";
              weeks = "<span color='#${color.cyan}'><b>W{}</b></span>";
              weekdays = "<span color='#${color.cyan}'><b>{}</b></span>";
              today = "<span color='#${color.yellow}'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        modules-center = ["hyprland/window"];
        modules-right = ["tray" "clock"];
      };
    };
    # font-family: Source Code Pro;
    # #workspaces button {
    #   padding: 0 5px;
    # }
    # margin-left: 5px;
    # margin-right: 5px;
    style = ''
      * {
        border: none;
        border-radius: 20;
        font-size: 16px;
        font-family: "Arimo Nerd Font", "Font Awesome 5 Free", "Font Awesome 6 Free";
      }
      window#waybar {
        background: transparent;
        color: #${color.foreground};
      }

      #workspaces button {        
        padding-left: 10px;
        padding-right: 10px;
        margin-top: 8px;
        margin-left: 5px;
        /*padding-top: 5px;
        padding-bottom: 5px;*/

        background-color: #${color.background};
        color: inherit;
        font-weight: 600;
        border-top: 2px solid #${color.lightbackground};
        border-bottom: 1px solid #${color.lightbackground};
        border-right: 2px solid #${color.background};
        border-left: 2px solid #${color.yellow};
      }

      #workspaces button:hover {
        background: #${color.black};
        box-shadow: inherit;
        text-shadow: inherit;
        border-bottom: 2px solid #${color.yellow};
        border-top: 2px solid #${color.yellow};
        border-right: 2px solid #${color.yellow};
      }

      #workspaces button.focused {
        background: #${color.green};

        /*border-top: 3px solid #${color.cyan};
        border-bottom: 3px solid #${color.cyan};
        border-left: 2px solid #${color.cyan};*/

        color: #${color.cyan};
      }

      #workspaces button.active {
        border-top: 2px solid #${color.yellow};
        border-bottom: 2px solid #${color.yellow};
        border-right: 2px solid #${color.yellow};
        border-left: 2px solid #${color.yellow};
        background: #${color.yellow};
        color: #${color.black};
      }

      #workspaces button:first-child {
        margin-left: 20px;
        /*border-left: 0;*/
      }
      #workspaces button.focused + button {
        border-left: 2px solid #${color.cyan};
      }

      /*#workspaces button.focused:first-child {
        border-left: none;
      }

      #workspaces button.focused:last-child {
        border-right: none;
      }*/

      #workspaces button.urgent {
        background-color: #${color.red};
      }

      #pulseaudio, #cpu, #memory, #disk{
        margin-left: 5px;
        border-left: 2px solid #${color.cyan};
      }

      #window, #disk, #mpd, #pulseaudio, #network, #cpu, #memory, #temperature, #clock {
        padding-left: 8px;
        padding-right: 8px;
        margin-top: 8px;
        border-top: 2px solid #${color.lightbackground};
        border-bottom: 1px solid #${color.lightbackground};
        /*
        padding-top: 5px;
        padding-bottom: 5px;
        */

        background-color: #${color.background};
        color: inherit;
        font-weight: 600;
        /*border-top: 4px solid transparent;
        border-bottom: 3px solid transparent;*/
      }

      #disk, #clock {
        border-left: 2px solid #${color.cyan};
        border-right: 2px solid #${color.yellow};
      }
      
      #window {
        border-left: 2px solid #${color.yellow};
        border-right: 2px solid #${color.cyan};
      }

      #tray {
        background-color: #${color.background};
        padding-left: 8px;
        padding-right:8px;
        min-width: 40px;
        border-left: 2px solid #${color.cyan};
        font-size: 20px;
      }

      #clock {
        font-size: 18px;
        margin-right: 20px;
      }

      @keyframes blink {
        to {
            background-color: #ffffff;
            color: black;
        }
      }
    '';
    systemd.enable = true;
  };
}
