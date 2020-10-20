#!/bin/bash

if [ "$(id --user)" = "0" ]; then
    echo "Running the fix-perms script."
    fix-perms -r -u app_user -g app_group /app

    echo "Running: gosu app_user "$@""
    exec gosu app_user "$@"
fi

exec "$@"