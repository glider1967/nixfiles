{pkgs, ...}: {
  wayland.windowManager.sway = rec {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "wofi -G --show run";
      bars = [
        {
          position = "top";
          command = "waybar";
        }
      ];
      window = {
        titlebar = false;
      };
      gaps = {
        inner = 5;
        outer = 5;
      };
      input = {
        "*" = {
          xkb_layout = "jp";
          xkb_options = "ctrl:swapcaps";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
        };
      };
    };

    extraConfig = ''
      exec fcitx5
      exec dbus-sway-environment
      exec configure-gtk

      for_window [app_id="firefox" title="Firefox — 共有インジケータ"] {
          floating enable
          sticky enable
          move up 330 px
          move right 330 px
      }
      for_window [app_id="firefox" title="ピクチャーインピクチャー"] {
          floating enable
          sticky enable
      }

      bindsym ${config.modifier}+c exec grim -g "$(slurp)" - | wl-copy

      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    '';

    systemd.enable = true;
    systemd.xdgAutostart = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "sway-session.target";
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
        ];
        modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
        modules-center = [ "clock" "network" ];
        modules-right = [
          "cpu" "memory" "disk" "backlight"
          "pulseaudio" "battery" "temperature"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "cpu" = {
          format = "{}% ";
          interval = 10;
        };
        "memory" = {
          format = "{}% ";
          interval = 30;
        };
        "disk" = {
          format = "{used}/{total}";
          interval = 30;
        };
        "battery" = {
          format = "{capacity}% {icon}";
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format-icons = ["" "" "" "" ""];
        };
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-icons = {
            default = ["" "" ""];
          };
        };
        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = ["" ""];
        };
      };
    };
    style = ''
* {
  /* `otf-font-awesome` is required to be installed for icons */
  font-family: JetBrainsMono Nerd Font;
  font-size: 17px;
}

window#waybar {
  background-color: #1f2530;
  color: #ffffff;
  transition-property: background-color;
  transition-duration: 0.5s;
  border-top: 8px transparent;
  border-radius: 8px;
  transition-duration: 0.5s;
  margin: 16px 16px;
}

window#waybar.hidden {
  opacity: 0.2;
}

#workspaces button {
  padding: 0 5px;
  color: #7984A4;
  background-color: transparent;
  /* Use box-shadow instead of border so the text isn't offset */
  box-shadow: inset 0 -3px transparent;
  /* Avoid rounded borders under each workspace name */
  border: none;
  border-radius: 0;
}

#workspaces button.focused {
  color: #bf616a;
}

#workspaces button.active {
  color: #6a92d7;
}

#workspaces button.urgent {
  background-color: #eb4d4b;
}

#window {
  /* border-radius: 20px; */
  /* padding-left: 10px; */
  /* padding-right: 10px; */
  color: #64727d;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#disk,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#mpd,
#bluetooth,
#temperature,
#custom-weather.default {
  padding: 0 10px;
  color: #e5e5e5;
  /* color: #bf616a; */
  border-radius: 9.5px;
  background-color: #1f2530;
}

#window,
#workspaces {
  margin: 0 4px;
  border-radius: 7.8px;
  background-color: #1f2530;
}

#cpu {
  color: #fb958b;
  background-color: #1f2530;
}

#memory {
  color: #ebcb8b;
  background-color: #1f2530;
}

#custom-power-menu {
  border-radius: 9.5px;
  background-color: #1b242b;
  border-radius: 7.5px;
  padding: 0 5px;
}

#custom-launcher {
  background-color: #1b242b;
  color: #6a92d7;
  border-radius: 7.5px;
  padding: 0 3px;
}

#custom-weather.severe {
  color: #eb937d;
}

#custom-weather.sunnyDay {
  color: #c2ca76;
}

#custom-weather.clearNight {
  color: #cad3f5;
}

#custom-weather.cloudyFoggyDay,
#custom-weather.cloudyFoggyNight {
  color: #c2ddda;
}

#custom-weather.rainyDay,
#custom-weather.rainyNight {
  color: #5aaca5;
}

#custom-weather.showyIcyDay,
#custom-weather.snowyIcyNight {
  color: #d6e7e5;
}

#custom-weather.default {
  color: #dbd9d8;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
  margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
  margin-right: 0;
}

#pulseaudio {
  color: #7d9bba;
}

#backlight {
  color: #8fbcbb;
}

#clock {
  color: #c8d2e0;
}

#battery {
  color: #c0caf5;
}

#battery.charging,
#battery.full,
#battery.plugged {
  color: #26a65b;
  /* background-color: #26a65b; */
}

@keyframes blink {
  to {
    background-color: rgba(30, 34, 42, 0.5);
    color: #abb2bf;
  }
}

#battery.critical:not(.charging) {
  color: #f53c3c;
  animation-name: blink;
  animation-duration: 0.5s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

label:focus {
  background-color: #000000;
}

#bluetooth {
  color: #707d9d;
}

#bluetooth.disconnected {
  color: #f53c3c;
}

#network.disconnected {
  color: #f53c3c;
}

#temperature.critical {
  background-color: #eb4d4b;
}

#mpd {
  color: #2a5c45;
}

#mpd.disconnected {
  color: #f53c3c;
}

#mpd.stopped {
  color: #90b1b1;
}

#mpd.paused {
  color: #51a37a;
}

#language {
  background: #00b093;
  color: #740864;
  padding: 0 5px;
  margin: 0 5px;
  min-width: 16px;
}

#keyboard-state {
  background: #97e1ad;
  color: #000000;
  padding: 0 0px;
  margin: 0 5px;
  min-width: 16px;
}
    '';
  };
  programs.wofi.enable = true;
  services.swayidle.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    wf-recorder
    mako
    grim
    slurp
  ];
}
