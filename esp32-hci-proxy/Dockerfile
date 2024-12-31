ARG BUILD_FROM
FROM $BUILD_FROM as builder

RUN apk add --no-cache git gcc make libc-dev

# install serial-udp
RUN git clone https://github.com/BogdanDIA/serial-udp.git /serial-udp
WORKDIR /serial-udp
#RUN git checkout tags/v0.0.1
RUN make

FROM $BUILD_FROM
#COPY --from=builder /app/run.sh /app/

# install dependencies
RUN apk add --no-cache \
  bluez \
  bluez-deprecated

COPY app /app/
COPY libproduct.sh /app/
RUN chmod a+x /app/run.sh
RUN sed -i 's|#!/bin/ash.*|#!/command/with-contenv bashio|' /app/run.sh

CMD [ "/app/run.sh" ]
