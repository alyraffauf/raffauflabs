{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.raffauflabs.services.transmission;
in {
  config = lib.mkIf cfg.enable {
    networking.extraHosts = ''
      127.0.0.1 ${cfg.subDomain}.${config.raffauflabs.domain}
    '';

    services = {
      ddclient.domains = ["${cfg.subDomain}.${config.raffauflabs.domain}"];

      nginx.virtualHosts."${cfg.subDomain}.${config.raffauflabs.domain}" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString cfg.port}";
          proxyWebsockets = true;

          extraConfig = ''
            proxy_buffering off;
          '';
        };
      };

      transmission = {
        enable = true;
        openFirewall = true;

        settings = {
          download-dir = cfg.mediaDirectory;
          peer-port = cfg.bitTorrentPort;
          rpc-port = cfg.port;
        };
      };
    };
  };
}
