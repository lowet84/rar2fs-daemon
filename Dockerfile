FROM alpine:3.6

ADD rar2fs /usr/bin/rar2fs
RUN apk add --no-cache libstdc++ && \
    chmod +x /usr/bin/rar2fs && \
    mkdir -p /rar2fs

ENV TARGET=/rar2fs

VOLUME /data

CMD /usr/bin/rar2fs -o allow_other /data /rar2fs --seek-length=1 && \
    # make this into a deamon
    # see: "Starting a long-running worker process"
    # https://docs.docker.com/engine/quickstart/
    while true; do echo DEAMON; sleep 1; done

# docker run -d -it --privileged --cap-add SYS_ADMIN --device /dev/fuse -v "$PWD/source":/data --name rar2fs <image id>