ARG BUILD_FROM
FROM $BUILD_FROM as builder

RUN apk add --no-cache git gcc make libc-dev

# install serial-udp
RUN rm -rf esp32-hci-proxy-addon
RUN git clone --recursive https://github.com/BogdanDIA/esp32-hci-proxy-addon.git
#RUN git checkout tags/v0.0.1
WORKDIR esp32-hci-proxy-addon/esp32-hci-proxy/app
RUN make

FROM $BUILD_FROM
COPY --from=builder /esp32-hci-proxy-addon/esp32-hci-proxy/app/sudp-forwarder /app/

# install dependencies
RUN apk add --no-cache \
  bluez \
  bluez-deprecated

COPY /app/run.sh /app/
COPY libproduct.sh /app/
COPY /app/set-link/ /app/

RUN chmod a+x /app/run.sh
RUN chmod a+x /app/sudp-forwarder
RUN chmod a+x /app/set-link/set-btattach.sh
RUN sed -i 's|#!/bin/ash.*|#!/command/with-contenv bashio|' /app/run.sh

CMD [ "/app/run.sh" ]

