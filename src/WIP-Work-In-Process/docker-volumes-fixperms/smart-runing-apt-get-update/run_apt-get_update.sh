#!/bin/bash


# Base ideia from:
# https://serverfault.com/a/670812



function get_last_apt_get_update()
{
    local aptDate="$(stat -c %Y '/var/cache/apt')"
    local nowDate="$(date +'%s')"

    echo $((nowDate - aptDate))
}

function run_apt_get_update()
{
    local update_interval="${1}"

    local last_apt_get_update="$(get_last_apt_get_update)"

#    if [[ "$(isEmptyString "${update_interval}")" = 'true' ]]
#    then
        # Default To 24 hours
    update_interval="$((24 * 60 * 60))"
#    fi

    if [[ "${last_apt_get_update}" -gt "${update_interval}" ]]
    then
        echo "apt-get update"
        apt-get update
        touch '/var/cache/apt'
    else
        local last_update="$(date -u -d @"${last_apt_get_update}" +'%-Hh %-Mm %-Ss')"

        echo "Skip apt-get update because its last run was '${last_update}' ago."
    fi
}


#last_apt_get_update="$(get_last_apt_get_update)"
#
#echo 'get_last_apt_get_update='$(get_last_apt_get_update)

run_apt_get_update

#echo 'get_last_apt_get_update='$(get_last_apt_get_update)
#
#echo  "$(date -u -d @"${last_apt_get_update}" +'%-Hh %-Mm %-Ss')"
#echo  "$(date -u -d @"${last_apt_get_update}" +'%s')"
#
#echo "$(date +'%s')"
#echo "$(date +'%-Hh %-Mm %-Ss')"
#
#
#dt=$(date -u '+%d/%m/%Y %H:%M:%S')
#echo "$dt"
#
#https://stackoverflow.com/a/4182381
#aptDate="$(stat -c %Y '/var/cache/apt')"
#
#echo "$aptDate"


# https://unix.stackexchange.com/a/85987
