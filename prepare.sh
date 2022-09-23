#!/bin/bash
# Set current user in nss_wrapper
# Based on changes linked from https://access.redhat.com/articles/4859371
# which discusses safe ways to add user to /etc/passwd at runtime

USER_ID=$(id -u)
GROUP_ID=$(id -g)

if [ x"$USER_ID" != x"0" ]; then

    NSS_WRAPPER_PASSWD=/tmp/nss_passwd
    NSS_WRAPPER_GROUP=/etc/group

    cat /etc/passwd > $NSS_WRAPPER_PASSWD

    echo "default:x:${USER_ID}:${GROUP_ID}:Default Application User:/tmp:/bin/bash" >> $NSS_WRAPPER_PASSWD

    export NSS_WRAPPER_PASSWD
    export NSS_WRAPPER_GROUP
    export LD_PRELOAD=libnss_wrapper.so
fi
exec "$@"
