{ pkgs ? import <nixpkgs> {} }:

with pkgs;
let

  su_exec = pkgs.stdenv.mkDerivation {
    name = "su-exec-0.2";
    src = fetchurl {
      url = https://github.com/ncopa/su-exec/archive/v0.2.tar.gz;
      sha256 = "09ayhm4w7ahvwk6wpjimvgv8lx89qx31znkywqmypkp6rpccnjpc";
    };
    preBuild = ''
      makeFlagsArray=(CC="${musl}/bin/musl-gcc -static"
                      CFLAGS="-I${musl}/include"
                      LDFLAGS="-L${musl}/lib")
    '';
    buildFlags = "su-exec-static";
    installPhase = ''mkdir -p $out/bin && cp su-exec-static $out/bin/su-exec'';
  };

  redis_2_8_23 = pkgs.redis.overrideDerivation (attrs: rec {
    version = "2.8.23";
    name = "redis-${version}";
    src = fetchurl {
      url = "http://download.redis.io/releases/${name}.tar.gz";
      sha256 = "1kjsx79jhhssh5k9v17s9mifaclkl6mfsrsv0cvi583qyiw9gizk";
    };
  });

  redis_3_0_7 = pkgs.redis.overrideDerivation (attrs: rec {
    version = "3.0.7";
    name = "redis-${version}";
    src = fetchurl {
      url = "http://download.redis.io/releases/${name}.tar.gz";
      sha256 = "08vzfdr67gp3lvk770qpax2c5g2sx8hn6p64jn3jddrvxb2939xj";
    };

    postInstall = ''
      rm -f $out/bin/redis-{benchmark,check-aof,check-dump,cli}
    '';
  });

  redis_3_0_7_musl = redis_3_0_7.overrideDerivation (attrs: rec {
    version = "3.0.7-mini";
    preBuild = ''
      makeFlagsArray=(PREFIX="$out"
                      CC="${musl}/bin/musl-gcc -static"
                      CFLAGS="-I${musl}/include"
                      LDFLAGS="-L${musl}/lib")
    '';
  });

  redisImage = redis: baseImage: dockerTools.buildImage {
    name = "redis";
    tag = redis.version;
    fromImage = baseImage;

    runAsRoot = ''
      #!${stdenv.shell}
      export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
      ${if baseImage == null then dockerTools.shadowSetup else ""}
      groupadd -r redis
      useradd -r -g redis -d /data -M redis
      mkdir /data
      chown redis:redis /data
    '';

    config = {
      Cmd = [ "${su_exec}/bin/su-exec" "redis" "${redis}/bin/redis-server" ];
      ExposedPorts = {
        "6379/tcp" = {};
      };
      WorkingDir = "/data";
      Volumes = {
        "/data" = {};
      };
    };
  };

#  debianImage = dockerTools.pullImage {
#    imageName = "debian";
#    sha256 = "08w22gx6hmmq75rybqzrxs03nzq2k39lrcj291yhsc08p9d9l9cj";
#  };

in {
  redisDocker_3_0_7  = redisImage redis_3_0_7 null;
  redisDocker_2_8_23 = redisImage redis_2_8_23 null;
#  redisOnDebian = redisImage redis_3_0_7 debianImage;
  redisMini = redisImage redis_3_0_7_musl null;
}
