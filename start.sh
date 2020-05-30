docker run \
--privileged --shm-size=512m\
 -v /dev:/dev -v /home/someanonimcoder/Images /home/dockerx/Images -d \
-p 2222:22 \
--name=exam chromium:x2go 

