ARG BUILD_FROM
FROM $BUILD_FROM as builder

RUN apk add --no-cache git bluez gcc make

# install serial-udp
#RUN git submodule update --init
#RUN git clone https://github.com/BogdanDIA/serial-udp.git /serial-udp
#WORKDIR /serial-udp
#RUN git checkout tags/v0.0.1
#RUN make

FROM $BUILD_FROM
COPY --from=builder /app/run.sh /app/

#COPY app /app/
COPY libproduct.sh /app/
RUN chmod a+x /app/run.sh

CMD [ "/app/run.sh" ]
