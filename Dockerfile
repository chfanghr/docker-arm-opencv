FROM multiarch/debian-debootstrap:armhf-buster

# COPY sources.list /etc/apt/

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    yasm \
    pkg-config \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavformat-dev \
    libpq-dev \
    python3 \
    python3-pip \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1\
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

ENV OPENCV_VERSION="4.0.1"
RUN git clone --branch ${OPENCV_VERSION} --depth 1 https://github.com/opencv/opencv_contrib.git /opencv_contrib-${OPENCV_VERSION}
RUN git clone --branch ${OPENCV_VERSION} --depth 1 https://github.com/opencv/opencv.git /opencv-${OPENCV_VERSION}

# RUN pip install -i https://pypi.douban.com/simple --upgrade pip\
#     && pip install -i https://pypi.douban.com/simple numpy\
#     && pip install -i https://pypi.douban.com/simple ipython\
#     && pip install -i https://pypi.douban.com/simple scipy\
#     && pip install -i https://pypi.douban.com/simple jupyter

# RUN pip install --upgrade pip\
#     && pip install numpy\
#     && pip install ipython\
#     && pip install scipy\
#     && pip install jupyter

WORKDIR /
# RUN mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
#     && cd /opencv-${OPENCV_VERSION}/cmake_binary \
#     && cmake -DBUILD_TIFF=ON \
#     -DBUILD_opencv_java=OFF \
#     -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-${OPENCV_VERSION}/modules \
#     -DWITH_CUDA=OFF \
#     -DWITH_OPENGL=ON \
#     -DWITH_OPENCL=ON \
#     -DWITH_IPP=ON \
#     -DWITH_TBB=ON \
#     -DWITH_EIGEN=ON \
#     -DWITH_V4L=ON \
#     -DBUILD_TESTS=OFF \
#     -DBUILD_PERF_TESTS=OFF \
#     -DCMAKE_BUILD_TYPE=RELEASE \
#     -DCMAKE_INSTALL_PREFIX=$(python3.7 -c "import sys; print(sys.prefix)") \
#     -DPYTHON_EXECUTABLE=$(which python3.7) \
#     -DPYTHON_INCLUDE_DIR=$(python3.7 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
#     -DPYTHON_PACKAGES_PATH=$(python3.7 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
#     .. \
#     && make -j8 install \
#     && rm -r /opencv-${OPENCV_VERSION} 

RUN mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
    && cd /opencv-${OPENCV_VERSION}/cmake_binary \
    && cmake -DBUILD_TIFF=ON \
    -DBUILD_opencv_java=OFF \
    -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-${OPENCV_VERSION}/modules \
    -DWITH_CUDA=OFF \
    -DWITH_OPENGL=ON \
    -DWITH_OPENCL=ON \
    -DWITH_IPP=ON \
    -DWITH_TBB=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    .. \
    && make -j8 install 

# RUN ln -s \
#     /usr/local/python/cv2/python-3.7/cv2.cpython-37m-x86_64-linux-gnu.so \
#     /usr/local/lib/python3.7/site-packages/cv2.so