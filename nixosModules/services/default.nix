{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./forgejo
    ./navidrome
    ./plexMediaServer
  ];
}
