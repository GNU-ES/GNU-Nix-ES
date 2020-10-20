let
    pkgs = import <nixpkgs> {};

  su_exec = pkgs.stdenv.mkDerivation {
    name = "su-exec-0.2";
    src = pkgs.fetchurl {
      url = https://github.com/ncopa/su-exec/archive/v0.2.tar.gz;
      sha256 = "09ayhm4w7ahvwk6wpjimvgv8lx89qx31znkywqmypkp6rpccnjpc";
    };
    preBuild = ''
      makeFlagsArray=(CC="${pkgs.musl.dev}/bin/musl-gcc -static"
                      CFLAGS="-I${pkgs.musl}/include"
                      LDFLAGS="-L${pkgs.musl}/lib")
    '';
    buildFlags = "su-exec-static";
    installPhase = ''mkdir -p $out/bin && cp su-exec-static $out/bin/su-exec'';
  };

  redis_2_8_23 = pkgs.redis.overrideDerivation (attrs: rec {
    version = "6.0.8";
    name = "redis-${version}";
    src = pkgs.fetchurl {
      url = "http://download.redis.io/releases/${name}.tar.gz";
      sha256 = "1kjsx79jhhssh5k9v17s9mifaclkl6mfsrsv0cvi583qyiw9gizk";
    };
  });

  redis_3_0_7 = pkgs.redis.overrideDerivation (attrs: rec {
    version = "3.0.7";
    name = "redis-${version}";
    src = pkgs.fetchurl {
      url = "http://download.redis.io/releases/${name}.tar.gz";
      sha256 = "08vzfdr67gp3lvk770qpax2c5g2sx8hn6p64jn3jddrvxb2939xj";
    };

    postInstall = ''
      rm -f $out/bin/redis-{benchmark,check-aof,check-dump,cli}
    '';
  });



  redisImage = redis: baseImage: pkgs.dockerTools.buildImage {
    name = "redis-yann-hodique-docker-tools";
    tag = "0.0.1";
    created = "now";
    fromImage = baseImage;

    runAsRoot = ''
      #!${pkgs.stdenv.shell}
      export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
      ${if baseImage == null then pkgs.dockerTools.shadowSetup else ""}
      groupadd -r redis
      useradd -r -g redis -d /data -M redis
      ${pkgs.coreutils}/bin/mkdir /data
      ${pkgs.coreutils}/bin/chown redis:redis /data
    '';

#    config = {
#      Cmd = [ "${su_exec}/bin/su-exec" "redis" "${redis}/bin/redis-server" ];
#      ExposedPorts = {
#        "6379/tcp" = {};
#      };
#      WorkingDir = "/data";
#      Volumes = {
#        "/data" = {};
#      };
#    };
  };

#  debianImage = dockerTools.pullImage {
#    imageName = "debian";
#    sha256 = "08w22gx6hmmq75rybqzrxs03nzq2k39lrcj291yhsc08p9d9l9cj";
#    imageDigest = "08w22gx6hmmq75rybqzrxs03nzq2k39lrcj291yhsc08p9d9l9cj";
#  };

in {
 # redisDocker_3_0_7  = redisImage redis_3_0_7 null;
  redisDocker_2_8_23 = redisImage redis_2_8_23 null;
 # redisOnDebian = redisImage redis_3_0_7 debianImage;
 # redisMini = redisImage redis_3_0_7_musl null;
}