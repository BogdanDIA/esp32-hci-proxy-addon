ARG BUILD_FROM
FROM $BUILD_FROM as builder

RUN apk add --no-cache git gcc make libc-dev

# install serial-udp
COPY app /app/
WORKDIR app
RUN make

FROM $BUILD_FROM
COPY --from=builder /app/sudp-forwarder /app/

# install dependencies
RUN apk add --no-cache \
  bluez \
  bluez-deprecated

COPY run.sh /app/
COPY libproduct.sh /app/
COPY /app/set-link/serial-udp.conf /app/set-link/
COPY /app/set-link/set-btattach.sh /app/set-link/
COPY /app/set-link/set-udp.sh /app/set-link/

RUN chmod a+x /app/run.sh
RUN chmod a+x /app/sudp-forwarder
RUN chmod a+x /app/set-link/set-btattach.sh
RUN chmod a+x /app/set-link/set-udp.sh
RUN sed -i 's|#!/bin/ash.*|#!/command/with-contenv bashio|' /app/run.sh

CMD [ "/app/run.sh" ]
