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

  services.nginx = {
    enable = true;
    virtualHosts."_" = {
      root = ./src;
      locations = {
        "/".index = "index.php";
        "~ \\.php$" = {
          tryFiles = "$uri =404";
          extraConfig = ''
            fastcgi_pass unix:/run/phpfpm/golden-book;
          '';
        };
      };
    };
  };
}
