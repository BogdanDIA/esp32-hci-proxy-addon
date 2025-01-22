# HomeAssistant esp32-hci-proxy 
An experimental project aiming at creating virtual Bluetooth Controllers using remote ESP32 devices. It uses IP network to communicate between Host and Controller. Basicaly it creates a Bluetooth Proxy. A serial port looback is needed so that HCI communication is exchanged over IP network, see below.  

<b>Host:btattach(Virtual BT HCI)<->Serial0<->Serial1<->Serial-UDP<->UDP/IPnetwork<->Target:ESP32</b>

## HW Installation
### Serial port loopback with external adapters
For this option, two USB-to-Serial adapters should be plugged into the host. An USB2.0 hub can be used in case not enough USB ports are available on the system. On the physical layer side a null modem connection should be done bwetween the two adapters, three wires are needed plus additional 2 wires if HW flow control is to be used:
```
TX<->RX
RX<->TX
GND<->GND <-this is not reall necessary

and if HW flow control is used:
RTS<->CTS
CTS<->RTS
```
## Host link setup 
For instalation in HA, copy the link https://github.com/BogdanDIA/esp32-hci-proxy-addon.git and add it to a new repository in add-on repositories page. This will show new addon named `ESP32 HCI Proxy`.
Use `Configuration` tab to add needed parameters. The important parameters are:
```
Mandatory - Serial ports:
- ble_btattach_device - set to /dev/serial/by-path/PORT0
- ble_sudpfwd_device - set to /dev/serial/by-path/PORT1
Mandatory - Server IP(ESP32 IP):
- ble_sudpfwd_device 
Not mandatory - HW Flow(in case it can be configured e.g. the RTS/CTS were connected between USB-serial ports):
- ble_btattach_hwflow = 1
- ble_sudpfwd_hwflow = 1
Not mandatory - debug options
- debug - shows debug information
- debug_tests - runs RTT tests when addon is started giving results in the log
```

Identifying the serial ports could be done easily using HA ssh addon to list `/dev/serial/by-path/` directory
```
cd /dev/serial/by-path
ls -al
lrwxrwxrwx 1 root root  13 Sep 14 21:24 <b>platform-xhci-hcd.0-usb-0:2:1.0-port0</b> -> ../../ttyUSB0
lrwxrwxrwx 1 root root  13 Sep 14 21:24 <b>platform-xhci-hcd.1-usb-0:2:1.0-port0</b> -> ../../ttyUSB1
```

If HA ssh addon is not available, user can build and subsequenty run first time the addon with only `debug switch` configuration enabled. The log will show the list of the serial ports existing on the system.

Once addon is configured and built, run the addon. When `debug switch` is enabled, user would see the list of BT controllers existing in the system.

```
hci1:	Type: Primary  Bus: UART
	BD Address: 08:3A:F2:13:35:C2  ACL MTU: 1021:9  SCO MTU: 255:4
	<b>UP RUNNING</b>
	RX bytes:7809687 acl:0 sco:0 events:369222 errors:0
	TX bytes:5040449 acl:26036 sco:0 commands:292446 errors:0

hci0:	Type: Primary  Bus: UART
	BD Address: D8:3A:DD:C2:67:D7  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING 
	RX bytes:7213 acl:0 sco:0 events:592 errors:0
	TX bytes:69142 acl:0 sco:0 commands:561 errors:0
```
When <b>UP RUNNING</b> is seen on the last added controller (hci1 in ourt case), everything is working as expected. The BD address is the MAC address of the ESP32 and it can be seen in ESP32's serial console upon boot.

From HA ssh addon console user could execute `bluetoothctl` and use it:
```
[bluetooth]# list
Controller 08:3A:F2:13:35:C2 homeassistant #2 [default]
Controller E4:5F:01:F5:FE:37 homeassistant 
[bluetooth]# 
```

## ESP32 setup 
This is explayned here: https://github.com/BogdanDIA/esp32-hci-proxy-target.git
