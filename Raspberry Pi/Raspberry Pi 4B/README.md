# Raspberry Pi 4B

## HDMI Output

Sometimes there's no video output on the Pi's HDMI ports. With regular monitors this is probably no issue, but attaching it to e.g. a 4K OLED TV, might leave you with a blank screen.

To overcome this some settings can be added to the `config.txt`:

```
hdmi_force_hotplug=1
config_hdmi_boost=4
```

To edit this file, just insert the micro SD card into a reader connected to computer. A `bootfs` volume should be visible and the file can be opened in your editor of choice.

## Troubleshooting

https://elinux.org/R-Pi_Troubleshooting

## Bluetooth

Building Bluepy might not succeed. Be sure to have the latest Python 3 (the one on the bootimage should do) and Python 2 is removed.

```shell
$ sudo apt-get update
$ sudo apt-get install python-pip build-essential libglib2.0-dev python-dev libssl-dev libffi-dev
$ sudo pip install bluepy
```
