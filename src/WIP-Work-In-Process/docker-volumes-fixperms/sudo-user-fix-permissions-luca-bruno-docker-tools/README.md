#


cat /etc/group

cat /etc/group

cat /etc/gshadow

cat /etc/sudoers

ls -al /sbin/sudo

https://github.com/NixOS/nixpkgs/pull/1076/files
description = ''
        The (hashed) password for the root account set on initial
        The (hashed) password for the root account set on initial
        installation.  The empty string denotes that root can login
        installation. The empty string denotes that root can login
        locally without a password (but not via remote services such
        locally without a password (but not via remote services such
        as SSH, or indirectly via <command>su</command> or
        as SSH, or indirectly via <command>su</command> or
        <command>sudo</command>).  The string <literal>!</literal>
        <command>sudo</command>). The string <literal>!</literal>
        prevents root from logging in using a password.
        prevents root from logging in using a password.
        Note, setting this option sets
        <literal>users.extraUsers.root.hashedPassword</literal>.
        Note, if <literal>users.mutableUsers</literal> is false
        you cannot change the root password manually, so in that case
        the name of this option is a bit misleading, since it will define
        the root password beyond the user initialisation phase.
      '';
      '';