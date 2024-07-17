{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./audiobookshelf
    ./forgejo
    ./navidrome
    ./plexMediaServer
    ./transmission
  ];
}
