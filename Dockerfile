FROM alpine:3.6

RUN apk add --no-cache fuse libstdc++
ADD rar2fs /rar2fs
RUN chmod +x /rar2fs

ENV TARGET=/rar2fs

VOLUME ["/media", "${TARGET}"]

CMD /rar2fs $dir_source $dir_target && \
    # make this into a deamon
    # see: "Starting a long-running worker process"
    # https://docs.docker.com/engine/quickstart/
    while true; do echo DEAMON; sleep 1; done

# docker run -d -it --privileged --cap-add SYS_ADMIN --device /dev/fuse -v "$PWD/source":/media --name rar2fs <image id>