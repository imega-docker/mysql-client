FROM scratch

LABEL maintainer="Dmitry Stoletoff <i n f o @ i m e g a . r u>" \
    description="This is docker image to run a MySQL client."

ADD build/rootfs.tar.gz /

ENTRYPOINT ["/with-wait.sh"]
