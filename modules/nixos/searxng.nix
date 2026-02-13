{ config, pkgs, lib, ... }:

{
  services.searx = {
    enable = true;
    environmentFile = "/var/lib/secrets/searxng.env";

    redisCreateLocally = true;
    runInUwsgi = true;

    uwsgiConfig = {
      http = ":8080";
      "buffer-size" = 65535;
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
        image_proxy = true;
        limiter = false;
      };

      engines = [
        { name = "google";     disabled = false; }
        { name = "duckduckgo"; disabled = false; }
        { name = "brave";      disabled = false; }
        { name = "wikipedia";  disabled = false; }
      ];

      search = {
        safe_search = 2;
        autocomplete_min = 2;
        autocomplete = "duckduckgo";
        ban_time_on_fail = 5;
        max_ban_time_on_fail = 120;
      };

      outgoing = {
        request_timeout = 5.0;
        max_request_timeout = 15.0;
        pool_connections = 100;
        pool_maxsize = 15;
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
}
