{
  config,
  pkgs,
  user,
  ...
}: {
  config = {
    users.users."${user}".packages = with pkgs; [
      google-chrome
      signal-desktop
      openconnect
    ];
  };
}
