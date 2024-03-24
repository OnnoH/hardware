# Hardware

As a development environment **PlatformIO IDE** (https://platformio.org) is used,
an extension to Visual Studio Code (https://code.visualstudio.com)

In order to access the devices from a Mac you'll need to install the appropriate drivers. As most of them use the CH340 chipset you can install those following the instructions on this page:

https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver

Also make sure you have a USB data cable (4 connected wires instead of 2) as some cables are suitable for charging only. Since you'll need to transfer your code to the board, the TX and RX (or D+/D-) wires need to be connected as well. (https://en.wikipedia.org/wiki/USB)

If the board doesn't come with its own USB interface, a USB to serial converter is needed. The Prolific PL2303 is such a device and the drivers (for MacOS) are here:

https://www.prolific.com.tw/US/ShowProduct.aspx?p_id=229&pcid=41

(Here the TX/RX are taken care of by the converter, so a power-only USB cable will suffice.)

## Components

### Resistors

Getting the value of a resistor based on colors:
https://resistorcolorcodecalc.com

## Micro Controllers

- [Raspberry Pi](./Raspberry%20Pi/README.md)
- [Arduino](./Arduino/README.md)
- [ESP](./ESP/README.md)
- [micro:bit](./MicroBit/README.md)

## Smart-Home

- [Lights](./Lights/README.md)
- [Switches](./Switches/)
- [Sensors](./Sensors/README.md)

## Other

- [Printers](./Printers/README.md)
