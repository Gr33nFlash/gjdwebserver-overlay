Gentoo overlay: GJDWebserver

This is a personal overlay I use for my PinePhone and other computers.
This is also an overylay for PinePhone Packages for Gentoo that I maintain in Gentoo Guru.


**Setup**

Add the following content to /etc/portage/repos.conf/gjdwebserver.conf

```
[gjdwebserver]
location = /var/db/repos/gjdwebserver
sync-type = git
sync-uri = https://github.com/gr33nflash/gjdwebserver-overlay
auto-sync = yes
```
