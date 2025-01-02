ARG BUILD_FROM
FROM $BUILD_FROM as builder

RUN apk add --no-cache git go gcc make libc-dev

# install serial-udp
RUN rm -rf esp32-hci-proxy-addon
RUN git clone --recursive https://github.com/BogdanDIA/esp32-hci-proxy-addon.git
#RUN git checkout tags/0.0.1
WORKDIR esp32-hci-proxy-addon/esp32-hci-proxy/app
RUN make

# install, patch and build Tesla vehicle-command
RUN rm -rf /vehicle-command
RUN rm -rf /tesla-ble
RUN git clone https://github.com/teslamotors/vehicle-command.git /vehicle-command
RUN git clone -b ha_addon https://github.com/BogdanDIA/tesla-ble.git /tesla-ble
# apply patch
RUN cp /tesla-ble/patches/vehicle-command/device_linux.go /vehicle-command/pkg/connector/ble/
WORKDIR /vehicle-command
RUN go get ./... && \
  go build ./... && \
  go install ./...

FROM $BUILD_FROM
COPY --from=builder /esp32-hci-proxy-addon/esp32-hci-proxy/app/sudp-forwarder /app/
COPY --from=builder /root/go/bin/tesla-control /root/go/bin/
COPY --from=builder /tesla-ble /root/go/bin/tesla-ble
COPY --from=builder /tesla-ble/tesla-ble.conf /root/go/bin/         
                        
# install dependencies  
RUN apk add --no-cache \
  bluez \         
  bluez-deprecated    
                        
COPY /app/run.sh /app/    
COPY libproduct.sh /app/                         
RUN mkdir -p /app/set-link                       
COPY /app/set-link/set-btattach.sh /app/set-link/
COPY /app/set-link/set-udp.sh /app/set-link/
                                 
RUN chmod a+x /app/run.sh                  
RUN chmod a+x /app/sudp-forwarder          
RUN chmod a+x /app/set-link/set-btattach.sh       
RUN chmod a+x /app/set-link/set-udp.sh     
RUN sed -i 's|#!/bin/ash.*|#!/command/with-contenv bashio|' /app/run.sh
                                                                       
CMD [ "/app/run.sh" ]
