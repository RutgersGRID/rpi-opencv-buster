#!/bin/bash 
if [ "$#" -ne 2 ]; then
    echo "Enter Docker Container ID: OPENCV_VER: " 
    echo "Hint: docker ps"
    exit 2
fi
echo "Container id: $1 "
echo "docker cp $1:/usr/local/lib/python3.7/dist-packages/cv2/python-3.7/cv2.cpython-37m-arm-linux-gnueabihf.so ."

#docker cp $1:/usr/local/lib/python3.7/dist-packages/cv2/python-3.7/cv2.cpython-37m-arm-linux-gnueabihf.so .

docker cp $1:/opencv/opencv/build/rpi-opencv-$2.tar.gz  .
