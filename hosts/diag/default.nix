{
  config,
  pkgs,
  lib,
  modulesPath,
  inputs,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  isoImage.isoName = lib.mkForce "nixos-diag.iso";
  isoImage.isoBaseName = lib.mkForce "nixos-diag";

  services.getty.autologinUser = lib.mkForce "root";

  boot.kernelModules = [
    "coretemp"
    "k10temp"
    "nct6775"
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.etc."xdg/nvim".source = inputs.nvim-lazy-config;
  environment.variables.XDG_CONFIG_DIRS = "/etc/xdg";

  environment.systemPackages = with pkgs; [
    stress-ng
    memtester
    smartmontools
    lm_sensors
    dmidecode
    pciutils
    usbutils
    nvme-cli
    hdparm
    e2fsprogs
    lshw
    ethtool
    gcc
    ripgrep
    lua-language-server
    stylua
    pyright
    ruff
  ];

  environment.etc."diag.sh" = {
    source = ./diag.sh;
    mode = "0755";
  };

  programs.tmux = {
    enable = true;
    historyLimit = 50000;
    extraConfig = "setw -g mode-keys vi";
  };

  programs.bash.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ] && [ ! -f /tmp/.diag-ran ]; then
      touch /tmp/.diag-ran
      exec tmux new-session -s diag "/etc/diag.sh 2>&1 | tee /tmp/diag-results.log; exec bash"
    fi
  '';

  system.stateVersion = "24.11";
}
