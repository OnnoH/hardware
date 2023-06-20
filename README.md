# Hardware

As a development environment **PlatformIO IDE** (https://platformio.org) is used,
an extension to Visual Studio Code (https://code.visualstudio.com)

In order to access the devices from a Mac you'll need to install the appropriate drivers. As most of them use the CH340 chipset you can install those following the instructions on this page:

https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver

If the board doesn't come with its own USB interface, a USB to serial converter is needed. The Prolific PL2303 is such a device and the drivers (for MacOS) are here:

https://www.prolific.com.tw/US/ShowProduct.aspx?p_id=229&pcid=41

## Components

### Resistors

Getting the value of a resistor based on colors:
https://resistorcolorcodecalc.com

## Raspberry Pi

Identifying a Raspberry Pi model : https://www.raspberrypi-spy.co.uk/2012/09/checking-your-raspberry-pi-board-version/

```shell
cat /proc/device-tree/model
```

### Raspberry Pi Pico W

[Instructions](https://github.com/OnnoH/Hardware/tree/main/Raspberry%20Pi%20Pico%20W)

### Raspberry Pi Zero W

[Instructions](https://github.com/OnnoH/Hardware/tree/main/Raspberry%20Pi%20Zero%20W)

## Arduino

All different types of Arduino clones collected over the years.

### Wemos ESP32 OLED

[Instructions](https://github.com/OnnoH/Hardware/tree/main/Wemos%20ESP32%20OLED)

### Arduino Pro Micro

[Instructions](https://github.com/OnnoH/Hardware/tree/main/Arduino%20Pro%20Micro)

### Arduino Pro Mini

[Instructions](https://github.com/OnnoH/Hardware/tree/main/Arduino%20Pro%20Mini)

### Arduino Nano

[Instructions](https://github.com/OnnoH/Hardware/tree/main/Arduino%20Nano)

## Olimex ESP8266 EVB

[Instructions](https://github.com/OnnoH/Hardware/tree/main/Olimex%20ESP8266-EVB)
