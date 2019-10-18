# rpi-opencv Buster

Opencv Docker for Raspberry PI

# Lessons Learned
* Virtual environments for Python not as important
* Pipenv fails when you can't guarantee a python version
* Everything is now done as a root user which is normal in Docker
* Maybe, for Python specific projects "poetry" would work better

Based on build process documented at PyimageSearch.com

https://www.pyimagesearch.com/2019/09/16/install-opencv-4-on-raspberry-pi-4-and-raspbian-buster/

Set up Docker on the PI

https://blog.docker.com/2019/03/happy-pi-day-docker-raspberry-pi/

`sudo apt-get install apt-transport-https ca-certificates software-properties-common -y`

`curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh`

`sudo usermod -aG docker pi`

`sudo curl https://download.docker.com/linux/raspbian/gpg`

`vim /etc/apt/sources.list`

`deb https://download.docker.com/linux/raspbian/ buster stable`

`sudo apt-get update && sudo apt-get upgrade`

`systemctl start docker.service`

`docker info`
 ====

`docker pull rianders/rpi-opencv:latest`

Clean up the intermediary builds:
`docker system prune`

`docker build -t rianders/rpi-opencv .`

`docker run -it rianders/rpi-opencv /bin/bash`

Copy the files from the docker:
`docker cp $1:./rpi-openv-*.tar.gz  .`


## Extract and Install
`sudo tar xvzf OpenCV-unknown-armv7l.tar.gz -C /usr/local/ --strip=1`

