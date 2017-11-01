# rar2fs-daemon

adapted for Alpine from 
https://hub.docker.com/r/andreklang/rar2fs/~/dockerfile/

run using:
```
docker run -it --cap-add SYS_ADMIN --privileged \
--name rar2fs-daemon -d --device /dev/fuse \
-v {media_folder}:/data \
-v {rar2fs_mount_folder}:/rar2fs:shared lowet84/rar2fs-daemon
```
&nbsp;
Create a folder for mount and secure it using:
```
chattr +i {rar2fs_mount_folder}
```
This makes sure nothing can be written to the folder when it is unmounted