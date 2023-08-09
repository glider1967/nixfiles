{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "wofi --show run";
      startup = [
        {command = "fcitx5 -d";}
        {command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway";}
      ];
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

      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
      bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
      bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
    '';

    systemd.enable = true;
    systemd.xdgAutostart = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar = {
    enable = true;
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
