FROM scratch

LABEL maintainer="Dmitry Stoletoff info@imega<dot>ru" \
    description="This is docker image to run a MySQL client."

ADD build/rootfs.tar.gz /

ENTRYPOINT ["/with-wait.sh"]
