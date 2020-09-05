FROM ubuntu:focal

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/chain-ed-reaction/r-nlogo" \
      org.label-schema.vendor="BEE Lab" \
      maintainer="Bevan Stanely <bevanstanely@outlook.com>"

# Install R, JAVA and nlrx package. (Note ggplot2 is also installed)
      
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		software-properties-common \
		wget \
    && add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0" \
    && add-apt-repository --enable-source --yes "ppa:c2d4u.team/c2d4u4.0+" \
	&& apt-get update \
    && apt-get install -y --no-install-recommends \
        r-base \
        r-base-dev \
        libudunits2-dev \
        libgdal-dev \
        libproj-dev \
		libgeos-dev \
		libzmq3-dev \
        openjdk-11-jre-headless \
 	&& apt-get clean

# Install R packages

RUN R -e "install.packages(c('nlrx', 'clustermq'))" \
 	&& rm -rf /tmp/Rtmp* /tmp/*.rds \
 	&& rm -rf /var/lib/apt/lists/*

WORKDIR project/

# Install NetLogo

RUN wget -c https://ccl.northwestern.edu/netlogo/6.1.1/NetLogo-6.1.1-64.tgz -O - | tar -xz

CMD ["bash"]
