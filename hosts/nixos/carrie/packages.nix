{ config, pkgs, user, ... }:
{
  config = {
    users.users."${user}".packages = [pkgs.google-chrome];
  };
}