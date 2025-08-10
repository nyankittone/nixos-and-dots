# TODO: set up automatic GC, lsd, and fixing the trash utils.

{ config, pkgs, pkgsUnstable, usingNixOS, inputs, ... }:
let
  meta = import ./meta_config.nix;
  lib = pkgs.lib;

  cursorName = "miku-cursor-linux";
  cursorPackage = pkgs.runCommand "ligmaBalls" {} ''
    mkdir -p $out/share/icons
    ln -s ${pkgs.fetchzip {
      url = "https://github.com/supermariofps/hatsune-miku-windows-linux-cursors/releases/download/1.2.6/miku-cursor-linux.tar.xz";
      hash = "sha256-qxWhzTDzjMxK7NWzpMV9EMuF5rg9gnO8AZlc1J8CRjY=";
    }} $out/share/icons/${cursorName}
  '';
in
{
  home.username = meta.username;
  home.homeDirectory = "/home/${meta.username}";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages =
  let
    glNameBin = name: path: package: (pkgs.writeShellScriptBin name ''
      exec ${pkgs.lib.getExe pkgs.nixgl.auto.nixGLDefault} "${package}/${path}" "$@"
    '');
    gl = package: (glNameBin package.meta.mainProgram "bin/${package.meta.mainProgram}"
        package);
  in
  (with pkgs; [
    libnotify

    gnumake
    gdb

    man-pages
    man-pages-posix
    tealdeer

    lua-language-server
    bash-language-server
    nil
    htmx-lsp
    pyright

    nixgl.auto.nixGLDefault
    (lib.mkIf (!usingNixOS) neovim) # Neovim is installed system-wide if we're on NixOS
    vifm-full
    trash-cli
    rmtrash
    autotrash
    bluetuith
    whois

    wineWowPackages.full
    prismlauncher

    (gl blobdrop)
    vesktop
    inputs.zen-browser.packages."${system}".default # TODO: Override this to customize the package

    (st.overrideAttrs {src = ./program_sources/st; buildInputs = st.buildInputs ++ [xorg.libXcursor];})
    (dmenu.overrideAttrs {src = ./program_sources/dmenu;})
    # (callPackage ./program_sources/dwm {})
    i3status

    (callPackage ./program_sources/fortunate {})
    (runCommand "dwmScripts" {} ''
      set -eu
      mkdir -p $out/bin
      install ${program_sources/dwm_scripts}/* $out/bin
    '')
  ] ++ (let n = nerd-fonts; in [
    minecraftia
    noto-fonts
    noto-fonts-color-emoji
    libertine
    liberation_ttf # Might remove this package tbh
    corefonts
    vista-fonts

    n.zed-mono
    n.ubuntu
    n.ubuntu-mono
    n.overpass
    n.jetbrains-mono
    n.iosevka
    n.hack
    n.departure-mono
    n.caskaydia-mono
    n.bigblue-terminal
  ])) ++ (with pkgsUnstable; [
    go
    gopls
    air
    gimp3
    krita
    openrct2
  ]);

  home.pointerCursor = {
    package = cursorPackage;
    gtk.enable = true;
    x11.enable = true;
    name = cursorName;
    size = 64; # TODO: Have the size here be controllable by a separate config file
  };

  gtk = {
    enable = true;
    theme = {
      package = (pkgs.colloid-gtk-theme.override {themeVariants = ["pink"]; tweaks = ["catppuccin"];});
      name = "Colloid-Pink-Dark-Catppuccin";
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-pink";
    };
  };

  # xsession.enable = true;
  # xsession.windowManager.command = "dwm-manager";

  fonts.fontconfig.enable = true;

  # TODO: Theme Qt apps!

  home.sessionVariables = {
  };

# TODO: Consider having this configuration be a normal cava dotfile that is then sourced by HM
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 144;
        autosens = 0;
        sensitivity = 260;
        bar_width = 1;

        lower_cutoff_freq = 32;
        higher_cutoff_freq = 15000;
        sleep_timer = 0;
      };

      input = {
        method = "pipewire";
        source = "auto";
      };

      output = {
        method = "noncurses";
        orientation = "bottom";
        channels = "mono";
        mono_option = "average";

        disable_blanking = 1;
        show_idle_bar_heads = 1;
        waveform = 0;
      };

      color = {
        background = "default";
        foreground = "default";

        gradient = 1;
        gradient_count = 8;
        gradient_color_1 = "'#89b4fa'";
        gradient_color_2 = "'#f59ab8'";
        gradient_color_3 = "'#d6d6d6'";
        gradient_color_4 = "'#f59ab8'";
        gradient_color_5 = "'#89b4fa'";
        gradient_color_6 = "'#f59ab8'";
        gradient_color_7 = "'#d6d6d6'";
        gradient_color_8 = "'#f59ab8'";
      };

      smoothing = {
        monstercat = 1;
        waves = 0;
        noise_reduction = 10;
      };

      eq = {
        "1" = 1.5;
        "2" = 1.4;
        "3" = 1.1;
        "4" = 1;
        "5" = 1;
        "6" = 1;
        "7" = 0.95;
        "8" = 0.78;
      };
    };
  };

  # TODO: Rice my htop a bit more to make it cute and pretty
  # TODO: Try btop
  programs.htop = {
    enable = true;
    settings = {
      delay = 5;
      screen_tabs = 1;
    };
  };
  
  programs.fastfetch = {
    enable = true;
    settings = 
    let
      redText = "3;38;2;255;60;60";
      purpleText = "3;38;2;210;100;190";
      separatorColor = "1;38;2;194;148;255";
      baseColor = "38;2;141;130;170";

      withRightColors = firstColor: sets: (
        if (sets == []) then
          []
        else
          [((lib.lists.findFirst (_: true) 69 sets) // {keyColor = firstColor; outputColor =
            baseColor;})] ++ (withRightColors (
              if (firstColor == purpleText) then redText else purpleText
            ) (lib.lists.drop 1 sets))
      );
    in
    {
      logo.source = "${./misc-data/badeline_ascii}";
      modules = [
        {
          type = "title";
          color = {
            user = redText;
            at = "1";
            host = purpleText;
          };
        }
        {
          type = "separator";
          outputColor = separatorColor;
        }
      ] ++ (withRightColors purpleText [
        { type = "uptime"; }
        { type = "packages"; }
        { type = "loadavg"; key = "Load Average"; }
        { type = "processes"; }
        { type = "memory"; }
        { type = "swap"; }
        { type = "disk"; folders = "/"; }
        { type = "disk"; folders = "/mnt/HDD"; }
        { type = "wifi"; }
        { type = "media"; key = "Playing"; }
        { type = "terminalsize"; }
        { type = "datetime"; key = "Current Time"; }
      ]) ++ [ "break" ];
    };
  };

  # TODO: Experiment with direnv for nix-shell integration.
  programs.direnv = {
    enable = false;
    enableBashIntegration = false;
    nix-direnv.enable = false;
  };

  # TODO: Consider switching away from tmux for terminal multiplexing in favor of Neovim or Emacs. If
  # that fails, try out Kakoune ig. gdsfgsdfgsdfggsfdgbsdfgsdfggsdfgs
  programs.tmux = {
    enable = true;

    aggressiveResize = true; # TODO: Play around with this setting.
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    historyLimit = 69420;
    keyMode = "vi";
    mouse = true;
    prefix = "C-Space";
    resizeAmount = 8;
    secureSocket = false;
    sensibleOnTop = false;
    terminal = "xterm-256color";

    tmuxinator.enable = true; # I don't know if I'll like this too much tbh... I have my own system

    extraConfig = 
    let
      lavender = "#b4befe";
      pink = "#f5c2e7";
      subtext0 = "#a6adc8";
      mantle = "#181825";
      surface1 = "#45475a";
      surface0 = "#313244";
      overlay2 = "#9399b2";
      subtext1 = "#bac2de";
    in ''
      set -as terminal-features ",xterm-256color:RGB"

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded tmux config! :3"

      set-option -g renumber-windows on

      unbind v
      unbind h
      unbind %
      unbind '"'
      bind b split-window -h -c "#{pane_current_path}"
      bind v split-window -v -c "#{pane_current_path}"

      unbind -T copy-mode-vi Space
      unbind -T copy-mode-vi Enter
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -selection clipboard"

      # Smart pane switching with awareness of Vim splits.
      # Modified snippet from https://github.com/christoomey/vim-tmux-navigator
      vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +$vim_pattern$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      bind-key -n 'C-H' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-J' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-K' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-L' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      # Adjusting colors :3
      set -g status-style 'fg=${subtext0} bg=${mantle}'

      set -g pane-border-style 'fg=${surface1}'
      set -g pane-active-border-style 'fg=${lavender}'
      
      setw -g window-status-current-style 'fg=black'
      setw -g window-status-current-format '#[bg=${pink},bold] #I #[none]#[bg=${surface0} fg=${lavender}] #W #F '
      setw -g window-status-format ' #[fg=${lavender},bold]#I #[none]#[fg=${overlay2}]#W #F '

      set -g status-left-length 20
      set -g status-left '#[fg=${subtext1},bold][#S] '

      set -g status-right-length 100
      set -g status-right '#T  #[fg=${subtext1},bold]%m/%d/%Y %H:%M'
    '';
  };

  # programs.bash.enable = (!usingNixOS);

  programs.lsd.enable = (!usingNixOS);
  programs.bat.enable = (!usingNixOS);

  xdg.configFile = {
    "lsd/config.yml".source = lib.mkIf (!usingNixOS) ./dotfiles-managed/lsd/config.yml;
    "lsd/colors.yml".source = lib.mkIf (!usingNixOS) ./dotfiles-managed/lsd/colors.yml;
    "fortunate".source = ./dotfiles-managed/fortunate;
    "emoji".source = ./misc-data/emoji;
    "i3status".source = ./dotfiles-managed/i3status;
  };


  systemd.user = {
    timers = {
      autotrash = {
        Install.WantedBy = ["timers.target"];
        Unit.Description = "Timer for auto-clearing the user's trash";
        Timer = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };

      user-gc = lib.mkIf (!usingNixOS) {
        Install.WantedBy = ["timers.target"];
        Unit.Description = "Timer for cleaning up old home-manager generations and GC'ing them";
        Timer = {
          OnCalendar = "weekly";
          RandomizedDelaySec = 600;
          FixedRandomDelay = true;
          Persistent = true;
        };
      };

      tldr-update = {
        Install.WantedBy = ["timers.target"];
        Unit.Description = "Timer for updating the tldr cache";
        Timer = {
          OnCalendar = "weekly";
          RandomizedDelaySec = 800;
          FixedRandomDelay = true;
          Persistent = true;
        };
      };
    };

    services = {
      autotrash = {
        Unit = {
          Description = "Clear the user's trash";
          Documentation = "https://github.com/bneijt/autotrash";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "\"${pkgs.autotrash}/bin/autotrash\" -d 42 -t";
        };
      };

      # TODO: Do improved error handling for this here
      user-gc = lib.mkIf (!usingNixOS) {
        Unit.Description = "Clean up old home-manager generations and garbage-collect Nix";
        Service = {
          Type = "oneshot";
          ExecStart = let # TODO: refer to Nix store path for the rest of the programs in this...
            p = pkgs;
            exe = lib.getExe;
            exeBin = package: binary: "${package}/bin/${binary}";
          in "${p.writeShellScript "hm-gc" ''
            #!/usr/bin/env bash
            set -euo pipefail
            app_name='nix-gc'

            ${exe p.libnotify} -a "$app_name" 'Starting Nix garbage collection' 'Hold on tight!'
            generations_to_delete=$(home-manager generations | ${exe p.gawk} '
              BEGIN {the_time = systime()}
              NR > 3 {
                split($1, date, "-")
                split($2, time, ":")

                if(the_time - mktime(date[1]" "date[2]" "date[3]" "time[1]" "time[2]" 00") > 2592000) {
                  print $5
                }
              }
            ')

            generation_count=$(${exeBin p.coreutils "wc"} -w <<< "$generations_to_delete")
            if [ "$generation_count" -gt 0 ]; then
              home-manager remove-generations $generations_to_delete
            fi

            gc_end_line=$(nix-collect-garbage 2>&1 | tail -1)

            ${exe p.libnotify} -a "$app_name" 'Nix garbage collection done; Now optimizing Nix store' "$gc_end_line"'<br>'"$generation_count HM generations removed"

            optimize_message=$(nix-store --optimise)
            ${exe p.libnotify} -a "$app_name" 'Nix store optimization complete!' "$optimize_message"
          ''}";
        };
      };

      tldr-update = {
        Unit = {
          Description = "Update the tldr cache";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${lib.getExe pkgs.tealdeer} -u";
        };
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  targets.genericLinux.enable = (!usingNixOS);
}
