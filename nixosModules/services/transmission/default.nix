{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.raffauflabs.services.transmission;
in {
  config = lib.mkIf cfg.enable {
    services.transmission = {
      enable = true;
      openFirewall = true;

      settings = {
        download-dir = cfg.mediaDirectory;
        peer-port = cfg.bitTorrentPort;
        rpc-port = cfg.port;
      };
    };
  };
}
