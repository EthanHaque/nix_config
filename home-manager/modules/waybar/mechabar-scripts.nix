# mechabar-scripts.nix
{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "mechabar-scripts";
  src = pkgs.fetchFromGitHub {
    owner = "sejjy";
    repo = "mechabar";
    rev = "522f6ea4f05e699f53f076abe6c6f007d526ad3b";
    sha256 = "sha256-4g8L+Q22R6g9H1B+y4D4d8F2w3B8Z6H7w0L5r7Z6N3A=";
  };

  buildInputs = with pkgs; [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/scripts/* $out/bin/
    chmod +x $out/bin/*

    # Replace hardcoded paths and make scripts use Nix-managed packages
    for script in $out/bin/*; do
      substituteInPlace $script \
        --replace '/usr/bin/env bash' '#!${pkgs.bash}/bin/bash' \
        --replace 'notify-send' '${pkgs.libnotify}/bin/notify-send' \
        --replace 'upower' '${pkgs.upower}/bin/upower' \
        --replace 'brightnessctl' '${pkgs.brightnessctl}/bin/brightnessctl' \
        --replace 'rofi' '${pkgs.rofi-wayland}/bin/rofi' \
        --replace 'nmcli' '${pkgs.networkmanager}/bin/nmcli' \
        --replace 'bluetoothctl' '${pkgs.bluez}/bin/bluetoothctl' \
        --replace 'bluetui' '${pkgs.bluetui}/bin/bluetui' \
        --replace 'pactl' '${pkgs.pulseaudio}/bin/pactl' \
        --replace 'playerctl' '${pkgs.playerctl}/bin/playerctl' \
        --replace 'kitty' '${pkgs.kitty}/bin/kitty' \
        --replace 'systemctl' '/run/current-system/sw/bin/systemctl' \
        --replace 'loginctl' '/run/current-system/sw/bin/loginctl'
    done

    # NixOS update script logic (placeholder)
    substituteInPlace $out/bin/system-update \
      --replace 'checkupdates | wc -l' 'echo 0 # Implement Nix update check' \
      --replace '${aur_helper} -Syu' 'echo "Run nixos-rebuild switch"'
  '';
}
