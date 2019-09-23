#!/bin/bash 
if [ "$#" -ne 1 ]; then
    echo "Enter Docker Container ID: docker ps"
    exit 2
fi
echo "Container id: $1 "
echo "docker cp $1:/usr/local/lib/python3.7/dist-packages/cv2/python-3.7/cv2.cpython-37m-arm-linux-gnueabihf.so ."

docker cp $1:/usr/local/lib/python3.7/dist-packages/cv2/python-3.7/cv2.cpython-37m-arm-linux-gnueabihf.so .

