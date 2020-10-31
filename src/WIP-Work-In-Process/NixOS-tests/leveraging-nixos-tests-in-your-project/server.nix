{ pkgs, ... }: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    initialDatabases = [
      { name = "goldenbook";
        schema = pkgs.writeText "init.sql" ''
          CREATE TABLE entries (text TEXT);
        '';
      }
    ];
    ensureUsers = [
      { name = "goldenuser";
        ensurePermissions = {
          "goldenbook.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  users.extraUsers.goldenuser.isSystemUser = true;
}
