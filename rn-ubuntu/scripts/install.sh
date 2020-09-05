# Install R, JAVA

apt-get update
apt-get install -y --no-install-recommends \
	software-properties-common \
	wget
add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0"
add-apt-repository --enable-source --yes "ppa:c2d4u.team/c2d4u4.0+"
apt-get update
apt-get install -y --no-install-recommends \
	r-base \
	r-base-dev \
	libudunits2-dev \
	libgdal-dev \
	libproj-dev \
	libgeos-dev \
	libzmq3-dev \
	openjdk-11-jre-headless
apt-get clean

# Install Netlogo

wget -c https://ccl.northwestern.edu/netlogo/${NETLOGO_VERSION}/NetLogo-${NETLOGO_VERSION}-64.tgz -O -
tar -xz NetLogo-${NETLOGO_VERSION}-64.tgz
rm NetLogo-${NETLOGO_VERSION}-64.tgz

# Install R packages. (Note ggplot2 is also installed)

R -e "install.packages(c('nlrx', 'clustermq'))"
rm -rf /tmp/*

# Remove build dependencies

apt-get remove --purge -y \
	software-properties-common \
	libudunits2-dev \
	libgdal-dev \
	libproj-dev \
	libgeos-dev
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
