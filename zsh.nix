{ config, pkgs, ... }:
{
  environment.etc."lsd/config.yaml".text = ''
    ---
    classic: false
    blocks:
      - permission
      - user
      - group
      - size
      - date
      - name
    color:
      when: auto
      theme: custom
    date: date
    dereference: false
    icons:
      when: auto
      theme: fancy
      separator: " "
    indicators: false
    layout: grid
    recursion:
      enabled: false
    size: default
    sorting:
      column: name
      reverse: false
      dir-grouping: none
    no-symlink: false
    total-size: false
    hyperlink: never
    symlink-arrow: ⇒
    header: false
    literal: false
    truncate-owner:
      after:
      marker: ""
  '';
  environment.etc."lsd/colors.yaml".text = ''
    ---
    user: cyan
    group: blue
    permission:
      read: green
      write: yellow
      exec: red
      exec-sticky: 13
      no-access: 245
      octal: 6
      acl: cyan
      context: cyan
    date:
      hour-old: green
      day-old: green
      older: green
    size:
      none: white
      small: 13
      medium: yellow
      large: red
    inode:
      valid: 13
      invalid: 245
    links:
      valid: 13
      invalid: 245
    tree-edge: 245
    git-status:
      default: 245
      unmodified: 245
      ignored: 245
      new-in-index: green
      new-in-workdir: green
      typechange: yellow
      deleted: red
      renamed: green
      modified: yellow
      conflicted: red
  '';
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    shellAliases = {
      ls = "lsd -alh --color=always --config-file /etc/lsd/config.yaml";
      grep = "grep --color=auto";
      gs = "git status";
      ga = "git add .";
      gc = "git commit -m";
      gp = "git pull";
      cn = "sudo nano /etc/nixos/configuration.nix";
      rs = "sudo nixos-rebuild switch";
      cat = "bat --theme ansi -pp";
    };
    interactiveShellInit = ''
      export EDITOR=nano
      export VISUAL=nano
      export PAGER=less
      gacp() {
        git add .
        git commit -m "$*"
        branch=$(git rev-parse --abbrev-ref HEAD)
        git push origin "$branch"
      }
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      eval "$(${pkgs.atuin}/bin/atuin init zsh)"
    '';
  };
  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = false;
      scan_timeout = 1000;
      format = ''$os$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$python$character'';
      os = {
        format = ''[$symbol]($style)'';
        style = "bold white";
        disabled = false;
        symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          AOSC = " ";
          Arch = " ";
          Artix = " ";
          CachyOS = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          Nobara = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };
      };
      username = {
        style_user = "bold cyan";
        style_root = "bold magenta";
        format = ''[$user]($style)[@](bold blue)'';
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        format = ''[$hostname](bold green) '';
        disabled = false;
      };
      directory = {
        style = "blue";
      };
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch = {
        format = ''[$branch]($style)'';
        style = "bright-black";
      };
      git_status = {
        format = ''[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)'';
        style = "cyan";
        conflicted = "​";
        untracked  = "​";
        modified   = "​";
        staged     = "​";
        renamed    = "​";
        deleted    = "​";
        stashed = "≡";
      };
      git_state = {
        format = ''\([$state( $progress_current/$progress_total)]($style)\) '';
        style = "bright-black";
      };
      cmd_duration = {
        format = ''[$duration]($style) '';
        style = "yellow";
      };
      python = {
        format = ''[$virtualenv]($style) '';
        style = "bright-black";
        detect_extensions = [ ];
        detect_files = [ ];
      };
    };
  };
}
