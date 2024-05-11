# nextdns-catchall

## Overview

An Ubiquiti UDM/Unifi Dream Machine (Pro, SE, etc) service + management script for redirecting all plaintext DNS traffic to a local NextDNS daemon

## Prerequisites

1. The NextDNS client should be installed and running on your UDM device. If not, follow the instructions in their Wiki:

   https://github.com/nextdns/nextdns/wiki/UnifiOS

2. Your UDM device should be running a Unifi OS version of 2.x or 3.x and have `on_boot.d` support installed already. If not, proceed according to the README at the following repo/directory:

   https://github.com/unifi-utilities/unifios-utilities/tree/main/on-boot-script-2.x

## Install steps

1. Place the `10-nextdns-catchall.sh` script in `/data/on_boot.d`, and give it execute permissions (a+rx):

   ``` bash
   curl -L -o /data/on_boot.d/10-nextdns-catchall.sh "https://raw.githubusercontent.com/vt0r/nextdns-catchall/main/10-nextdns-catchall.sh"
   chmod 0755 /data/on_boot.d/10-nextdns-catchall.sh
   ```

2. Place the `nextdns-catchall.service` systemd unit file in `/data` and you can make the permissions world readable (a+r). This is probably the default, so the second command will likely do nothing. **NOTE: If you run this again after making any local changes, they will be reverted, so repeat the next step if so**:

   ``` bash
   curl -L -o /data/nextdns-catchall.service "https://raw.githubusercontent.com/vt0r/nextdns-catchall/main/nextdns-catchall.service"
   chmod 0644 /data/nextdns-catchall.service
   ```

3. Modify the service's unit file (`/data/nextdns-catchall.service`) to suit your needs - you'll probably need to use `vim` to do so. Examples for most changes you may want/need to make are included and commented. You can uncomment the ones you need (remove the preceeding `#`) and save this file and exit (tap `ESC`, then hold `Shift` and press `ZZ`)

4. Execute the script in `/data/on_boot.d/10-nextdns-catchall.sh` to ensure the service gets installed and started:

   ``` bash
   /data/on_boot.d/10-nextdns-catchall.sh
   ```

## Interacting with the service

### Check status

``` bash
systemctl status nextdns-catchall
```

### Start/stop/restart

``` bash
systemctl start nextdns-catchall
systemctl stop nextdns-catchall
systemctl restart nextdns-catchall
```

## Credits

Inspired by the original gist located here:

https://gist.github.com/Belphemur/f5f5afd19116ee17d4498f5ad87386a3

Big thanks to @Belphemur for the original!
