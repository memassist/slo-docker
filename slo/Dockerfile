FROM ubuntu:14.04 as base

# Never interact with the user and make the default answers be used for all questions
ENV DEBIAN_FRONTEND noninteractive

ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu
ENV LIBRARY_PATH /usr/lib/x86_64-linux-gnu
ENV C_INCLUDE_PATH /usr/include/x86_64-linux-gnu
ENV CPLUS_INCLUDE_PATH /usr/include/x86_64-linux-gnu
#ENV RDLIB_MEASURE_TRUE_REUSE_DISTANCE=1
#ENV RDLIB_EXPORT_TRACE=trace.txt
#ENV RDLIB_EXPORT_TRACE_FLUSH_AFTER_EACH_ACCESS=0

# Get user id and group id from arguments
ARG UID
ARG GID

# Create the 'slo' user and 'slo' group
RUN groupadd -r slo -g ${GID} \
 && useradd --create-home --shell /bin/bash slo -u ${UID} -g ${GID} \
# && mv /tmp/gcc-slo /home/slo/gcc-slo \
# && chown -R slo:slo /home/slo/gcc-slo \
# && chmod 755 /home/slo/gcc-slo \
# Install general dependencies
 && apt-get update --no-install-recommends \
 && apt-get install -yq \
    apt-utils \
    binutils \
    build-essential \
    zip \
    #nano \
    #vim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# =============================================================================
# =============================================================================
FROM base AS builder

#USER root

# Install GCC-SLO dependencies
RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    #mpc libmpc-dev libmpfr-dev libppl0.10-dev libcloog-ppl-dev zlib1g zlib1g-dev libc6-dev-i386 m4 flex bison libgmp3-dev libgmp3c2
    #mpc libmpc-dev libmpfr-dev libppl0.12-dev libcloog-ppl-dev zlib1g zlib1g-dev libc6-dev-i386 m4 flex bison libgmp3-dev
    mpc libmpc-dev libmpfr-dev libcloog-ppl-dev zlib1g zlib1g-dev libc6-dev-i386 m4 flex bison libgmp3-dev \
    autogen \
 && apt-get install -yq \
    g++ \
 && apt-get install -yq \
    curl \
    wget \
# RUN apt-get install -yq \
    ## x32 compilation on x64 systems
    # gcc-multilib g++-multilib
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER slo
WORKDIR /tmp

COPY --chown=slo:slo ./build-gcc-slo.sh /tmp/build-gcc-slo.sh

RUN wget -c ftp://ftp.gmplib.org/pub/gmp-5.1.3/gmp-5.1.3.tar.bz2 \
 #&& wget -c http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.bz2 \
 && wget -c https://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.bz2 \
 #&& wget -c http://www.multiprecision.org/mpc/download/mpc-1.0.1.tar.gz \
 && wget -c https://ftp.gnu.org/gnu/mpc/mpc-1.0.1.tar.gz \
 && wget -c https://master.dl.sourceforge.net/project/slo/gcc-slo/1.1.0-4.1.1/gcc-slo-1.1.0-4.1.0.tar.gz \
# Install GMP
#RUN sudo mkdir /opt/gmp-5.1.3 \
 && mkdir -p $HOME/gcc-slo-deps/gmp-5.1.3 \
 && chmod a+x gmp-5.1.3.tar.bz2 \
 && tar -jxvf gmp-5.1.3.tar.bz2 \
 && cd gmp-5.1.3 \
 && ./configure --prefix=$HOME/gcc-slo-deps/gmp-5.1.3 \
 #&& make && make check && sudo make install \
 && make && make check && make install \
 && cd .. \
 && rm -rf gmp-5.1.3.tar.bz2 \
 && rm -rf gmp-5.1.3 \
# Install MPFR
#RUN sudo mkdir /opt/mpfr-3.1.2 \
 && mkdir -p $HOME/gcc-slo-deps/mpfr-3.1.2 \
 && chmod a+x mpfr-3.1.2.tar.bz2 \
 && tar -jxvf mpfr-3.1.2.tar.bz2 \
 && cd mpfr-3.1.2 \
 && ./configure --prefix=$HOME/gcc-slo-deps/mpfr-3.1.2 --with-gmp=$HOME/gcc-slo-deps/gmp-5.1.3 \
 #&& make && make check && sudo make install \
 && make && make check && make install \
 && cd .. \
 && rm -rf mpfr-3.1.2.tar.bz2 \
 && rm -rf mpfr-3.1.2 \
# Install MPC
#RUN sudo mkdir /opt/mpc-1.0.1 \
 && mkdir -p $HOME/gcc-slo-deps/mpc-1.0.1 \
 && chmod a+x mpc-1.0.1.tar.gz \
 && tar -zxvf mpc-1.0.1.tar.gz \
 && cd mpc-1.0.1 \
 && ./configure --prefix=$HOME/gcc-slo-deps/mpc-1.0.1 --with-gmp=$HOME/gcc-slo-deps/gmp-5.1.3 --with-mpfr=$HOME/gcc-slo-deps/mpfr-3.1.2 \
 #&& make && make check && sudo make install \
 && make && make check && make install \
 && cd .. \
 && rm -rf mpc-1.0.1.tar.gz \
 && rm -rf mpc-1.0.1 \
# Install GCC-SLO
 && chmod a+x gcc-slo-1.1.0-4.1.0.tar.gz \
 && tar -zxvf gcc-slo-1.1.0-4.1.0.tar.gz \
 && cd gcc-slo-1.1.0-4.1.0 \
 && mv /tmp/build-gcc-slo.sh build-gcc-slo.sh \
 && chmod a+x build-gcc-slo.sh \
 && ./build-gcc-slo.sh \
 && cd .. \
 && rm -rf gcc-slo-1.1.0-4.1.0.tar.gz \
 && rm -rf gcc-slo-1.1.0-4.1.0 \
 && ls -la \
 && ls -la $HOME \
 && ls -la /home/slo


# =============================================================================
# =============================================================================
FROM base

USER slo
WORKDIR /home/slo

COPY --from=builder --chown=slo:slo /home/slo/gcc-slo-deps /home/slo/gcc-slo-deps
COPY --from=builder --chown=slo:slo /home/slo/gcc-slo /home/slo/gcc-slo

#EXPOSE 8080
#CMD /home/run.sh
#CMD ["sleep", "300"]
#CMD["sleep", "1d"]
ENTRYPOINT ["tail", "-f", "/dev/null"]
