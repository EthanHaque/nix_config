{ config, pkgs, lib, ... }:

{
  users.groups.omada = {
    gid = 508;
  };

  users.users.omada = {
    isSystemUser = true;
    group = "omada";
    uid = 508;
    description = "Omada Controller Service User";
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/omada/data 0750 omada omada -"
    "d /var/lib/omada/logs 0750 omada omada -"
  ];

  virtualisation.oci-containers.containers.omada-controller = {
    image = "mbentley/omada-controller:6.1";
    autoStart = true;

    extraOptions = [
      "--network=host"
      "--stop-timeout=60"
      "--cap-drop=ALL"
      "--cap-add=NET_BIND_SERVICE"
      "--cap-add=CHOWN"
      "--cap-add=SETGID"
      "--cap-add=SETUID"
      "--cap-add=DAC_OVERRIDE"
    ];

    volumes = [
      "/var/lib/omada/data:/opt/tplink/EAPController/data"
      "/var/lib/omada/logs:/opt/tplink/EAPController/logs"
    ];

    environment = {
      TZ = "America/New_York";
      PUID = "508";
      PGID = "508";
      MANAGE_HTTPS_PORT = "8043";
      MANAGE_HTTP_PORT = "8088";
      SHOW_SERVER_LOGS = "true";
      SHOW_MONGODB_LOGS = "false";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      8088 8043 8843       # Web UI & Captive Portal
      29811 29812 29813    # V1 Mgmt/Adoption
      29814 29815 29816    # V2 Mgmt/Transfer/RTTY
      29817                # Device Monitor
    ];
    allowedUDPPorts = [
      29810                # Device Discovery
      27001                # App Discovery
    ];
  };
}
