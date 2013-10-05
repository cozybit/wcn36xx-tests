# External STA + Xperia Z devices

This demostrates Xperia Z devices on a mesh network, with an external STA.
Each device pinging all the other devices.  This test can be reproduced by
running the `run_extsta_ping_test` script.

## Mesh configuration

This test was *not* performed in an RF chamber.

```text
Interface mesh0
	ifindex 17
	wdev 0x400000002
	addr 00:27:19:f2:61:e8
	type mesh point
	wiphy 4
	channel 11 (2462 MHz), width: 20 MHz (no HT), center1: 2462 MHz
```

## Address configuration

Mesh on external STA:
```text
$ ip addr show mesh0
17: mesh0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether 00:27:19:f2:61:e8 brd ff:ff:ff:ff:ff:ff
    inet 10.9.9.5/8 brd 10.255.255.255 scope global mesh0
    inet6 fe80::227:19ff:fef2:61e8/64 scope link 
       valid_lft forever preferred_lft forever
```

Mesh on device BX903J8X12:

```text
root@android:/ # getprop ro.serialno
BX903J8X12
root@android:/ # ip addr show mesh0
18: mesh0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether b4:52:7d:46:21:de brd ff:ff:ff:ff:ff:ff
    inet 10.9.9.1/8 brd 10.255.255.255 scope global mesh0
    inet6 fe80::b652:7dff:fe46:21de/64 scope link 
       valid_lft forever preferred_lft forever
```

Mesh on device BX903J8AWV:

```text
root@android:/ # getprop ro.serialno
BX903J8AWV
root@android:/ # ip addr show mesh0
18: mesh0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether b4:52:7d:45:bf:08 brd ff:ff:ff:ff:ff:ff
    inet 10.9.9.2/8 brd 10.255.255.255 scope global mesh0
    inet6 fe80::b652:7dff:fe45:bf08/64 scope link 
       valid_lft forever preferred_lft forever
```

Mesh on device CB5A1TKGX8:
```text
root@android:/ # getprop ro.serialno
CB5A1TKGX8
root@android:/ # ip addr show mesh0
18: mesh0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether 1c:7b:21:14:01:2b brd ff:ff:ff:ff:ff:ff
    inet 10.9.9.3/8 brd 10.255.255.255 scope global mesh0
    inet6 fe80::1e7b:21ff:fe14:12b/64 scope link 
       valid_lft forever preferred_lft forever
```

# Ping results

Mesh creation

```text
adb -s CB5A1TKGX8 shell iw phy0 interface add mesh0 type mp
adb -s BX903JMD8R shell iw phy0 interface add mesh0 type mp
adb -s BX903J8X12 shell iw phy0 interface add mesh0 type mp
adb -s BX903J8AWV shell iw phy0 interface add mesh0 type mp
adb -s CB5A1TKGX8 shell iw mesh0 set channel 11
adb -s BX903JMD8R shell iw mesh0 set channel 11
adb -s BX903J8X12 shell iw mesh0 set channel 11
adb -s BX903J8AWV shell iw mesh0 set channel 11
adb -s CB5A1TKGX8 shell ip link set mesh0 up
adb -s BX903JMD8R shell ip link set mesh0 up
adb -s BX903J8X12 shell ip link set mesh0 up
adb -s BX903J8AWV shell ip link set mesh0 up
adb -s CB5A1TKGX8 shell iw mesh0 mesh join xz
adb -s BX903JMD8R shell iw mesh0 mesh join xz
adb -s BX903J8X12 shell iw mesh0 mesh join xz
adb -s BX903J8AWV shell iw mesh0 mesh join xz
```

From external STA

```text
PING 10.9.9.1 (10.9.9.1) from 10.9.9.5 mesh0: 56(84) bytes of data.
64 bytes from 10.9.9.1: icmp_req=1 ttl=64 time=22.4 ms

--- 10.9.9.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 22.449/22.449/22.449/0.000 ms
PING 10.9.9.2 (10.9.9.2) from 10.9.9.5 mesh0: 56(84) bytes of data.
64 bytes from 10.9.9.2: icmp_req=1 ttl=64 time=8.24 ms

--- 10.9.9.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 8.243/8.243/8.243/0.000 ms
PING 10.9.9.3 (10.9.9.3) from 10.9.9.5 mesh0: 56(84) bytes of data.
64 bytes from 10.9.9.3: icmp_req=1 ttl=64 time=37.3 ms

--- 10.9.9.3 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 37.308/37.308/37.308/0.000 ms
PING 10.9.9.4 (10.9.9.4) from 10.9.9.5 mesh0: 56(84) bytes of data.
64 bytes from 10.9.9.4: icmp_req=1 ttl=64 time=8.44 ms

--- 10.9.9.4 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 8.445/8.445/8.445/0.000 ms
PING 10.9.9.2 (10.9.9.2) 56(84) bytes of data.
64 bytes from 10.9.9.2: icmp_seq=1 ttl=64 time=6.44 ms
```

From BX903J8X12

```text
--- 10.9.9.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 6.440/6.440/6.440/0.000 ms
PING 10.9.9.3 (10.9.9.3) 56(84) bytes of data.
64 bytes from 10.9.9.3: icmp_seq=1 ttl=64 time=7.35 ms

--- 10.9.9.3 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 7.356/7.356/7.356/0.000 ms
PING 10.9.9.4 (10.9.9.4) 56(84) bytes of data.
64 bytes from 10.9.9.4: icmp_seq=1 ttl=64 time=17.8 ms

--- 10.9.9.4 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 17.824/17.824/17.824/0.000 ms
PING 10.9.9.5 (10.9.9.5) 56(84) bytes of data.
64 bytes from 10.9.9.5: icmp_seq=1 ttl=64 time=4.36 ms

--- 10.9.9.5 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 4.365/4.365/4.365/0.000 ms
PING 10.9.9.3 (10.9.9.3) 56(84) bytes of data.
64 bytes from 10.9.9.3: icmp_seq=1 ttl=64 time=29.2 ms
```

From BX903J8AWV

```
--- 10.9.9.3 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 29.239/29.239/29.239/0.000 ms
PING 10.9.9.4 (10.9.9.4) 56(84) bytes of data.
64 bytes from 10.9.9.4: icmp_seq=1 ttl=64 time=8.27 ms

--- 10.9.9.4 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 8.271/8.271/8.271/0.000 ms
PING 10.9.9.5 (10.9.9.5) 56(84) bytes of data.
64 bytes from 10.9.9.5: icmp_seq=1 ttl=64 time=2.96 ms

--- 10.9.9.5 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 2.961/2.961/2.961/0.000 ms
PING 10.9.9.1 (10.9.9.1) 56(84) bytes of data.
64 bytes from 10.9.9.1: icmp_seq=1 ttl=64 time=5.40 ms

--- 10.9.9.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 5.403/5.403/5.403/0.000 ms
PING 10.9.9.4 (10.9.9.4) 56(84) bytes of data.
64 bytes from 10.9.9.4: icmp_seq=1 ttl=64 time=6.95 ms
```

From CB5A1TKGX8

```
--- 10.9.9.4 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 6.959/6.959/6.959/0.000 ms
PING 10.9.9.5 (10.9.9.5) 56(84) bytes of data.
64 bytes from 10.9.9.5: icmp_seq=1 ttl=64 time=1.37 ms

--- 10.9.9.5 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 1ms
rtt min/avg/max/mdev = 1.373/1.373/1.373/0.000 ms
PING 10.9.9.1 (10.9.9.1) 56(84) bytes of data.
64 bytes from 10.9.9.1: icmp_seq=1 ttl=64 time=13.5 ms

--- 10.9.9.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 13.551/13.551/13.551/0.000 ms
PING 10.9.9.2 (10.9.9.2) 56(84) bytes of data.
64 bytes from 10.9.9.2: icmp_seq=1 ttl=64 time=5.18 ms

--- 10.9.9.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 5.188/5.188/5.188/0.000 ms
PING 10.9.9.5 (10.9.9.5) 56(84) bytes of data.
64 bytes from 10.9.9.5: icmp_seq=1 ttl=64 time=58.6 ms
```

From BX903JMD8R

```
--- 10.9.9.5 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 58.691/58.691/58.691/0.000 ms
PING 10.9.9.1 (10.9.9.1) 56(84) bytes of data.
64 bytes from 10.9.9.1: icmp_seq=1 ttl=64 time=6.13 ms

--- 10.9.9.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 6.134/6.134/6.134/0.000 ms
PING 10.9.9.2 (10.9.9.2) 56(84) bytes of data.
64 bytes from 10.9.9.2: icmp_seq=1 ttl=64 time=1.77 ms

--- 10.9.9.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.770/1.770/1.770/0.000 ms
PING 10.9.9.3 (10.9.9.3) 56(84) bytes of data.
64 bytes from 10.9.9.3: icmp_seq=1 ttl=64 time=2.50 ms

--- 10.9.9.3 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 2.502/2.502/2.502/0.000 ms
```
