{
  config,
  pkgs,
  lib,
  modulesPath,
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
  ];

  environment.etc."diag.sh" = {
    source = ./diag.sh;
    mode = "0755";
  };

  programs.bash.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ] && [ ! -f /tmp/.diag-ran ]; then
      touch /tmp/.diag-ran
      /etc/diag.sh 2>&1 | tee /tmp/diag-results.log
    fi
  '';

  system.stateVersion = "24.11";
}
