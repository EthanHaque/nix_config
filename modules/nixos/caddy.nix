{ config, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "omada.home.arpa" = {
        extraConfig = ''
              tls internal
              reverse_proxy https://localhost:8043 {
              transport http {
                tls_insecure_skip_verify
              }
          }
        '';
      };

      "search.home.arpa" = {
        extraConfig = ''
          tls internal
          reverse_proxy 10.50.20.10:8080
        '';
      };

      "vault.home.arpa" = {
        extraConfig = ''
          tls internal
          reverse_proxy 10.50.25.10:8322 {
            header_up X-Real-IP {remote_host}
          }
        '';
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
