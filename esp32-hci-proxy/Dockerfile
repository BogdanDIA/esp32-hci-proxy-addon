ARG BUILD_FROM
FROM $BUILD_FROM as builder

RUN apk add --no-cache git bluez gcc make

# install serial-udp
RUN git clone https://github.com/teslamotors/serial-udp.git /serial-udp
WORKDIR /serial-udp
#RUN git checkout tags/v0.1.0
RUN make

COPY --from=builder /serial-udp /serial-udp
COPY app /app/
COPY libproduct.sh /app/
RUN chmod a+x /app/set-link.sh

CMD [ "/app/set-link.sh" ]
