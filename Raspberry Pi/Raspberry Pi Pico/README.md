# Raspberry Pi Pico

![Raspberry Pi Pico Pinout](raspberry-pi-pico-pinout.png)

https://pico.pinout.xyz

The Raspberry Pi Pico is based on the RP2040 microcontroller. The main differences between this board and it's W-less counterpart are of course the large silver WLAN chip, the location of the debug connector and the pin assignment for the builtin LED (WL_GPIO0 vs GPIO25)

## Getting started

- https://projects.raspberrypi.org/en/projects/getting-started-with-the-pico
- https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html
- https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf
- https://tutoduino.fr/en/pico-platformio/
- https://www.schaerens.ch/pico-developing-for-raspberry-pi-pico-w-with-platformio-and-c-c/
- https://github.com/earlephilhower/arduino-pico
- https://thonny.org
- https://github.com/raspberrypi/picotool

## MicroPython

One popular way of programming the Pico is using MicroPython. The firmware can be found here: https://micropython.org/download/RPI_PICO/

1. Push and hold the BOOTSEL button and plug your Pico into the USB port of your Raspberry Pi or other computer. Release the BOOTSEL button after your Pico is connected.

2. It will mount as a Mass Storage Device called RPI-RP2.

3. Drag and drop the MicroPython UF2 file onto the RPI-RP2 volume. Your Pico will reboot. You are now running MicroPython.

4. You can access the REPL via USB Serial.

On MacOS the 'disk' is not unmounted as it should, so this error appears:
![MacOS disk not ejected properly error](disk-not-ejected-properly.png)
This is common behavior and doesn't harm the Pico or your Mac. The only annoying thing about is that you'll have to dismiss the error.
