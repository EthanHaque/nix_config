{ config, pkgs, lib, ... }:

{
  services.searx = {
    enable = true;
    environmentFile = "/var/lib/secrets/searxng.env";

    redisCreateLocally = true;
    configureUwsgi = true;

    uwsgiConfig = {
      http = ":8080";
      "buffer-size" = 65535;
      processes = 16;
      threads = 4;
      "enable-threads" = true;
      "offload-threads" = 4;
      "disable-logging" = true;
    };

    settings = {
      general = {
        debug = false;
        instance_name = "Home Search";
        donation_url = false;
        contact_url = false;
        privacypolicy_url = false;
        enable_metrics = false;
      };

      server = {
        base_url = "https://search.home.arpa";
        image_proxy = false;
        limiter = false;
      };

      engines = [
        { name = "google";     disabled = true; }
        { name = "duckduckgo"; disabled = false; }
        { name = "brave";      disabled = false; }
        { name = "wikipedia";  disabled = false; }
        { name = "bing";       disabled = false; }
      ];

      search = {
        safe_search = 2;
        autocomplete_min = 2;
        autocomplete = "duckduckgo";
        ban_time_on_fail = 5;
        max_ban_time_on_fail = 120;
      };

      outgoing = {
        request_timeout = 1.0;
        max_request_timeout = 2.0;
        pool_connections = 100;
        pool_maxsize = 20;
        enable_http2 = true;
      };

      ui = {
        static_use_hash = true;
        default_locale = "en";
        query_in_title = true;
        infinite_scroll = true;
        hotkeys = "vim";
      };

      enabled_plugins = [
        "Basic Calculator"
        "Hash plugin"
        "Tor check plugin"
        "Open Access DOI rewrite"
        "Hostnames plugin"
        "Unit converter plugin"
        "Tracker URL remover"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
  systemd.services.uwsgi.serviceConfig.EnvironmentFile = "/var/lib/secrets/searxng.env";
}
