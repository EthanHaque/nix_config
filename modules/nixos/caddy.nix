{ config, pkgs, ... }:

{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "*.home.arpa" = {
        extraConfig = ''
          tls internal

          @omada host omada.home.arpa
          handle @omada {
            reverse_proxy https://localhost:8043 {
              transport http {
                tls_insecure_skip_verify
              }
            }
          }


          @searxng host search.home.arpa
          handle @searxng {
            reverse_proxy 10.50.20.10:8080
          }


          @vaultwarden host vault.home.arpa
          handle @vaultwarden {
            reverse_proxy 10.50.25.10:8322 {
              header_up X-Real-IP {remote_host}
            }
          }


          # Useful for debugging resolution issues
          handle {
            respond "Service not found or Caddy is working!" 404
          }
        '';
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
