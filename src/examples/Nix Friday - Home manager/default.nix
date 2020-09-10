let
    pkgs = import (builtins.fetchTarball { url = "channel:nixpkgs-unstable"; } ) {};
    inherit (pkgs) runCommand;

    img_orig = "ubuntu-18.04-server-cloudimg-amd64.img";
in
rec {
    image = pkgs.fetchurl {
        url = "https://cloud-images.ubuntu.com/releases/18.04/release/${img_orig}";
        sha256 = "1i2yxndxb6yc9l6c99pypbd92lfq5aac4klq7y2v93c9qvx2cgpc";
    };
    # this is the cloud-init config
    cloudInit = {
        ssh_authorized_keys = [
            (builtins.readFile ./id_rsa.pub)
        ];
        password = "ubuntu";
        chpasswd = {
            list = [
                "root:root"
                "ubuntu:ubuntu"
            ];
            expire = false;
        };
        ssh_pwauth = true;
        mounts = [
            [ "hostshare" "/mnt" "9p" "defaults,trans=virtio,version=version=9p2000.L"]
        ];
    };

    # Generate the initial user data disk. This contains extra configuration
    # for the VM.
    userdata = runCommand
        "userdata.qcow2"
        { buildInputs = [ pkgs.cloud-utils pkgs.yj pkgs.qemu ]; }
        ''
            {
                echo '#cloud-config'
                echo '${builtins.toJSON cloudInit}' | yj -jy
            } > cloud-init.yaml
            cloud-localds user-data.raw cloud-init.yaml
            qemu-img convert -p -f raw user-data.raw -O qcow2 "$out"
        '';

     # Prepare the VM snapshot for faster resume.
     prepare = runCommand "prepare"
        { buildInputs = [ pkgs.qemu (pkgs.python.withPackages (p: [ p.pexpect ])) ]; }
        ''
            export LANG=C.UTF-8
            export LC_ALL=C.UTF-8

            # Copy the images to work on them
            cp --reflink=auto ${image} disk.qcow2
            cp --reflink=auto ${userdata} userdata.qcow2
            chmod +w disk.qcow2 userdata.qcow2

            # Make some room on the root image
            qemu-img resize disk.qcow2 +64G

            # Run the automated installer
            python ${./prepare.py} disk.qcow2 userdata.qcow2

            # At this point the disk should have a named snapshot
            qemu-img snapshot -l disk.qcow2 | grep prepare

            mkdir $out
            mv disk.qcow2 userdata.qcow2 $out/
        '';
}

