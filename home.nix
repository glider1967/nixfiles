{pkgs, ...}: {
  imports = [
    ./sway/sway.nix
    ./nvim/nvim.nix
  ];

  home = rec {
    username = "glider";
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    exa
    fd
    ripgrep
    zoxide
    navi
    fzf
    pastel
    du-dust
    bottom
    sd
    procs

    nushell
    vscode

    gcc
    deno
    python312
    rust-bin.stable.latest.default

    lua-language-server
    nodePackages.typescript-language-server
    rust-analyzer
    nixd
];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    XDG_CURRENT_DESKTOP = "sway";
    XDG_CURRENT_SESSION = "sway";
    XDG_SESSION_TYPE = "wayland";
    WINIT_UNIX_BACKEND = "x11";
    QT_QPA_PLATFORM = "wayland";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
      grep = "rg";
      ls = "exa --icons --classify";
      la = "exa --all --icons --classify";
      ll = "exa --long --all --git --icons";
      tree = "exa --icons --classify --tree";
    };
    profileExtra = ''
      export PATH="$HOME/.npm-global:$PATH"
    '';
  };
  programs.starship.enable = true;

  programs.git = {
    enable = true;
    userName = "glider";
    userEmail = "glider1967@protonmail.com";
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview];
    settings = {
      editor = "nvim";
    };
  };
}
