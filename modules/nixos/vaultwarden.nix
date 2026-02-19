{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "vaultwarden" ];
    ensureUsers = [{
      name = "vaultwarden";
      ensureDBOwnership = true;
    }];
  };

  services.vaultwarden = {
    enable = true;
    dbBackend = "postgresql";

    environmentFile = "/var/lib/secrets/vaultwarden.env";

    config = {
      DOMAIN = "https://vault.home.arpa";
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8322;
      ROCKET_LOG = "critical";

      WEB_VAULT_ENABLED = true;

      DATABASE_URL = "postgresql://vaultwarden@%2Frun%2Fpostgresql/vaultwarden";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8322 ];
}
