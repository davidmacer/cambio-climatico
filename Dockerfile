FROM islasgeci/base:13fe
RUN pip install Pillow
RUN git clone https://github.com/IslasGECI/misctools.git && \
    cd misctools && \
    make install && \
    make tests && \
    cd .. && \
    rm --recursive misctools
