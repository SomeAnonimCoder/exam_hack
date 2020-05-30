# exam_hack

## idea

Proctoring is a method of online exam organisation, aimed to prevent cheating. 
Usually AI or the LB(leather bastard) has acess to your screen and/or mic and/or camera. 
Sometimes proctoring systems also detect double keyboards, double screens, double mouses, 
etc.

## Implementation

In all this cases this solution will probably work fine. It starts a browser and minimal 
graphic environment(xfce for now, but this can be changed easily), and forwards mic and 
camera to container. So the browser thinks that it runs in real pc with XFCE desktop, 
and shows the real camera and microphone data. Also this container has a remote acess by 
ssh and X2GO protocols.

## how to rock

First get this code; than run 
    
    #build a container from source
    docker build -t chromium:x2go .
    #run a container. key --privileged is needed for correct webcam and mic works
    docker run --privileged --shm-size=512m -v /dev:/dev -d -p 2222:22 --name=exam chromium:x2go -v /Images:/Images
    #to get login and passwd
    docker logs exam 

Then you will need to connect to this container by x2go. There are a lot of clients, 
for windows, mac, linux, even android. So, you need to install this client, and enter 
login and password from `docker logs`, port is 2222, host is 127.0.0.1, 
gui(or session type) is XFCE.

You will see a window, where you can launch chromium, and start your exam. That's it!

Now you can launch another browser outside the container and google, or read the book, etc.
The proctoring system will not see anything around the container.


