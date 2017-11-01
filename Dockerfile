FROM alpine:3.6

ADD rar2fs /usr/bin/rar2fs
RUN apk add --no-cache fuse libstdc++ && \
    chmod +x /usr/bin/rar2fs

ENV dir_source=${SOURCE:-/data}
ENV dir_target=${TARGET:-/rar2fs}

VOLUME ["$dir_source", "$dir_target"]

CMD umount /rar2fs || { echo "rar2fs folder was not mounted (this is intended)" ; : ; }  && \
    /usr/bin/rar2fs -o allow_other $dir_source $dir_target --seek-length=1 && \
    # make this into a deamon
    # see: "Starting a long-running worker process"
    # https://docs.docker.com/engine/quickstart/
    while true; do echo DEAMON; sleep 1; done

# docker run -d -it --privileged --cap-add SYS_ADMIN --device /dev/fuse -v "$PWD/source":/data --name rar2fs <image id>