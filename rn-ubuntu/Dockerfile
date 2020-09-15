FROM ubuntu:focal AS base_image

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/chain-ed-reaction/r-nlogo" \
      org.label-schema.vendor="BEE Lab" \
      maintainer="Bevan Stanely <bevanstanely@outlook.com>"

ENV NETLOGO_VERSION=6.1.1
ENV R_BASE_VERSION=4.0.2-1.2004.0

WORKDIR project/


RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		software-properties-common \
		openjdk-11-jre-headless \
		wget \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

# Install NetLogo

RUN wget -c https://ccl.northwestern.edu/netlogo/${NETLOGO_VERSION}/NetLogo-${NETLOGO_VERSION}-64.tgz -O - \
	&& tar -xz NetLogo-${NETLOGO_VERSION}-64.tgz \
	&& rm NetLogo-${NETLOGO_VERSION}-64.tgz

RUN add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0" \
	&& add-apt-repository --enable-source --yes "ppa:c2d4u.team/c2d4u4.0+" \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		r-base=${R_BASE_VERSION} \
		r-base-dev=${R_BASE_VERSION} \
		libudunits2-dev \
		libgdal-dev \
		libproj-dev \
		libgeos-dev \
	&& apt-get clean

# Install R packages. (Note ggplot2 is also installed)

RUN R -e "install.packages(c('nlrx', 'future', 'future.batchtools', 'debugme', 'batchtools'))" \
	&& rm -rf /tmp/*

# Remove build dependencies

RUN apt-get remove --purge -y \
		software-properties-common \
		libudunits2-dev \
		libgdal-dev \
		libproj-dev \
		libgeos-dev \
	&& apt-get autoremove -y \
	&& apt-get autoclean -y \
	&& rm -rf /var/lib/apt/lists/*

# Multi-stage build to reduce image size

FROM scratch
COPY --from=base_image /. /.

WORKDIR project/

CMD ["bash"]
