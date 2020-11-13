{ pkgs, config, ... }: {

    users = {
        extraUsers.root.initialHashedPassword = "";
        mutableUsers = false;
    };
}
