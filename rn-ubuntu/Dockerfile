FROM ubuntu:focal

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/chain-ed-reaction/r-nlogo" \
      org.label-schema.vendor="BEE Lab" \
      maintainer="Bevan Stanely <bevanstanely@outlook.com>"

ENV NETLOGO_VERSION=6.1.1

WORKDIR project/

COPY scripts /project/scripts

# Install NetLogo

RUN ./scripts/install.sh

CMD ["bash"]
