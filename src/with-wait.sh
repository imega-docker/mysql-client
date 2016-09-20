#!/usr/bin/env sh
set -e

for i in "$@"
do
case $i in
    -h=*|--host=*)
    HOST="$i"
    mysqladmin --silent $HOST --wait=5 ping
    ;;
esac
done

exec "$@"
