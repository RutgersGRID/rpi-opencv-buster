FROM balenalib/rpi-raspbian:latest
#FROM arm32v7/debian
#FROM resin/rpi-raspian:latest

ARG OPENCV_VER=4.1.1 

RUN apt-get update && apt-get install -y --no-install-recommends \
   wget unzip build-essential cmake pkg-config apt-utils \
   libjpeg-dev libtiff5-dev libjasper-dev libpng-dev \
   libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
   libxvidcore-dev libx264-dev \
   libfontconfig1-dev libcairo2-dev \
   libgdk-pixbuf2.0-dev libpango1.0-dev \
   libgtk2.0-dev libgtk-3-dev \
   libatlas-base-dev gfortran \
   libhdf5-dev libhdf5-serial-dev libhdf5-103 \
   libqtgui4 libqtwebkit4 libqt4-test python3 python3-pyqt5 \
   python3-dev python3-pip


WORKDIR opencv
RUN apt-get install python3

RUN pip3 install numpy

RUN wget -O opencv.zip https://github.com/Itseez/opencv/archive/${OPENCV_VER}.zip
RUN unzip opencv.zip

RUN wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/${OPENCV_VER}.zip
RUN unzip opencv_contrib.zip
RUN mv opencv-${OPENCV_VER} opencv
RUN mv opencv_contrib-${OPENCV_VER} opencv_contrib

#Open your /etc/dphys-swapfile  and then edit the CONF_SWAPSIZE  variable:
#CONF_SWAPSIZE=102
RUN apt-get install -y dphys-swapfile
# Just in case the default is too small adjust it size
RUN sed -i 's/CONF_SWAPSIZE=100$/CONF_SWAPSIZE=1024/' /etc/dphys-swapfile
RUN /etc/init.d/dphys-swapfile stop
RUN /etc/init.d/dphys-swapfile start


WORKDIR opencv
RUN mkdir build
WORKDIR build
RUN  cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=/opencv/opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D CMAKE_SHARED_LINKER_FLAGS=-latomic \
    -D BUILD_EXAMPLES=OFF ..


RUN make -j4
RUN pwd
RUN make install
RUN ldconfig
# TODO: Test that opencv is installed properly

#RUN cd /usr/local/lib/python3.7/site-packages/cv2/python-3.7
#RUN sudo cp cv2.cpython-37m-arm-linux-gnueabihf.so cv2.so
#RUN cd ~/.virtualenvs/cv/lib/python3.7/site-packages/
#RUN ln -s /usr/local/lib/python3.7/site-packages/cv2/python-3.7/cv2.so cv2.so


RUN find /usr/local/  -name cv2.cpython-*
RUN ls /usr/local/lib/python3.7/dist-packages/cv2/
RUN tar cvzf rpi-opencv-${OPENCV_VER}.tar.gz -C /usr/local/lib/python3.7/dist-packages/  cv2 
 

RUN echo "\
$ dockercp  rianders/rpi-opencv:/usr/local/lib/python3.7/dist-packages/cv2/python-3.7/cv2.cpython-37m-arm-linux-gnueabihf.so . \
$ sudo cp  cv2.cpython-37m-arm-linux-gnueabihf.so /usr/local/lib/python3.7/site-packages/cv2/python-3.7/cv2.so \
$ cd ~/.virtualenvs/cv/lib/python3.7/site-packages/ \
$ ln -s /usr/local/lib/python3.7/site-packages/cv2/python-3.7/cv2.so cv2.so \
"

RUN echo "DONE"
