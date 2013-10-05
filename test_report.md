# Introduction

This is a perfomance test using iperf, the test was between 2 Xperia Z phones
operating inside of an RF chamber.

The iperf test was performed on the following channel configurations:

- 2.4 GHz, channel 11, legacy
- 2.4 GHz, channel 11, HT20
- 5.0 GHz, channel 36, legacy
- 5.0 GHz, channel 36, HT20

## Test results

```text
Changing to 5 GHz, channel 36, HT20
(PARALLEL) adb -s BX903J8X12 reboot
(PARALLEL) adb -s BX903J8AWV reboot
Serial: BX903J8X12, last uptime: 18.53
Got new uptime: 7
Serial: BX903J8AWV, last uptime: 18.51
Got new uptime: 9
adb -s BX903J8X12 wait-for-device
adb -s BX903J8AWV wait-for-device
adb -s BX903J8X12 shell iw reg set US
adb -s BX903J8AWV shell iw reg set US
adb -s BX903J8X12 shell iw phy phy0 interface add mesh0 type mp
adb -s BX903J8AWV shell iw phy phy0 interface add mesh0 type mp
adb -s BX903J8X12 shell iw dev mesh0 set channel 36 HT20
adb -s BX903J8AWV shell iw dev mesh0 set channel 36 HT20
adb -s BX903J8X12 shell ip link set mesh0 up
adb -s BX903J8AWV shell ip link set mesh0 up
adb -s BX903J8X12 shell iw dev mesh0 mesh join xz
adb -s BX903J8AWV shell iw dev mesh0 mesh join xz
adb -s BX903J8X12 shell ifconfig mesh0 10.88.49.50
adb -s BX903J8AWV shell ifconfig mesh0 10.65.87.86
adb -s BX903J8X12 shell getprop ro.serialno
adb -s BX903J8AWV shell getprop ro.serialno
Starting server on BX903J8X12/10.88.49.50
Starting client on BX903J8AWV/10.65.87.86
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.88.49.50 port 5001 connected with 10.65.87.86 port 59961
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0- 1.0 sec  2.49 MBytes  20.9 Mbits/sec   0.681 ms 1566/ 3344 (47%)
[  3]  0.0- 1.0 sec  330 datagrams received out-of-order
[  3]  1.0- 2.0 sec  3.62 MBytes  30.3 Mbits/sec   0.290 ms 2579/ 5158 (50%)
[  3]  2.0- 3.0 sec  3.61 MBytes  30.3 Mbits/sec   0.317 ms 2573/ 5149 (50%)
[  3]  3.0- 4.0 sec  3.61 MBytes  30.3 Mbits/sec   0.556 ms 2573/ 5146 (50%)
[  3]  4.0- 5.0 sec  3.62 MBytes  30.3 Mbits/sec   0.650 ms 2578/ 5157 (50%)
[  3]  5.0- 6.0 sec  3.61 MBytes  30.3 Mbits/sec   0.701 ms 2514/ 5090 (49%)
[  3]  6.0- 7.0 sec  3.55 MBytes  29.8 Mbits/sec   0.811 ms 2533/ 5066 (50%)
[  3]  7.0- 8.0 sec  3.62 MBytes  30.4 Mbits/sec   0.311 ms 2584/ 5168 (50%)
[  3]  8.0- 9.0 sec  3.61 MBytes  30.3 Mbits/sec   0.579 ms 2569/ 5145 (50%)
[  3]  8.0- 9.0 sec  321 datagrams received out-of-order
[  3]  9.0-10.0 sec  3.58 MBytes  30.0 Mbits/sec   0.625 ms 2579/ 5132 (50%)
[  3]  0.0-10.1 sec  35.2 MBytes  29.3 Mbits/sec   0.843 ms 24854/49969 (50%)
[  3]  0.0-10.1 sec  652 datagrams received out-of-order
Waiting for server threads to complete. Interrupt again to force quit.
------------------------------------------------------------
Client connecting to 10.88.49.50, UDP port 5001
Sending 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.65.87.86 port 59961 connected with 10.88.49.50 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  5.29 MBytes  44.3 Mbits/sec
[  3]  1.0- 2.0 sec  7.21 MBytes  60.5 Mbits/sec
[  3]  2.0- 3.0 sec  7.23 MBytes  60.6 Mbits/sec
[  3]  3.0- 4.0 sec  7.22 MBytes  60.6 Mbits/sec
[  3]  4.0- 5.0 sec  7.25 MBytes  60.8 Mbits/sec
[  3]  5.0- 6.0 sec  7.10 MBytes  59.6 Mbits/sec
[  3]  6.0- 7.0 sec  7.13 MBytes  59.8 Mbits/sec
[  3]  7.0- 8.0 sec  7.23 MBytes  60.7 Mbits/sec
[  3]  8.0- 9.0 sec  7.21 MBytes  60.5 Mbits/sec
[  3]  9.0-10.0 sec  7.19 MBytes  60.3 Mbits/sec
[  3]  0.0-10.0 sec  70.1 MBytes  58.8 Mbits/sec
[  3] Sent 49971 datagrams
[  3] Server Report:
[  3]  0.0-10.1 sec  35.2 MBytes  29.3 Mbits/sec   0.842 ms 24854/49969 (50%)
[  3]  0.0-10.1 sec  652 datagrams received out-of-order
Changing to 5 GHz, channel 36, legacy
(PARALLEL) adb -s BX903J8X12 reboot
(PARALLEL) adb -s BX903J8AWV reboot
Serial: BX903J8X12, last uptime: 24.16
Got new uptime: 7
Serial: BX903J8AWV, last uptime: 24.22
Got new uptime: 8
adb -s BX903J8X12 wait-for-device
adb -s BX903J8AWV wait-for-device
adb -s BX903J8X12 shell iw reg set US
adb -s BX903J8AWV shell iw reg set US
adb -s BX903J8X12 shell iw phy phy0 interface add mesh0 type mp
adb -s BX903J8AWV shell iw phy phy0 interface add mesh0 type mp
adb -s BX903J8X12 shell iw dev mesh0 set channel 36
adb -s BX903J8AWV shell iw dev mesh0 set channel 36
adb -s BX903J8X12 shell ip link set mesh0 up
adb -s BX903J8AWV shell ip link set mesh0 up
adb -s BX903J8X12 shell iw dev mesh0 mesh join xz
adb -s BX903J8AWV shell iw dev mesh0 mesh join xz
adb -s BX903J8X12 shell ifconfig mesh0 10.88.49.50
adb -s BX903J8AWV shell ifconfig mesh0 10.65.87.86
adb -s BX903J8X12 shell getprop ro.serialno
adb -s BX903J8AWV shell getprop ro.serialno
Starting server on BX903J8X12/10.88.49.50
Starting client on BX903J8AWV/10.65.87.86
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.88.49.50 port 5001 connected with 10.65.87.86 port 55795
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0- 1.0 sec   370 KBytes  3.03 Mbits/sec   5.651 ms   64/  322 (20%)
[  3]  0.0- 1.0 sec  4 datagrams received out-of-order
[  3]  1.0- 2.0 sec   353 KBytes  2.89 Mbits/sec   7.592 ms  246/  492 (50%)
[  3]  2.0- 3.0 sec   455 KBytes  3.73 Mbits/sec   8.323 ms  317/  634 (50%)
[  3]  3.0- 4.0 sec   429 KBytes  3.52 Mbits/sec   5.002 ms  299/  598 (50%)
[  3]  4.0- 5.0 sec   464 KBytes  3.80 Mbits/sec   5.373 ms  323/  646 (50%)
[  3]  5.0- 6.0 sec   446 KBytes  3.66 Mbits/sec   4.358 ms  311/  622 (50%)
[  3]  6.0- 7.0 sec   469 KBytes  3.85 Mbits/sec   5.327 ms  320/  647 (49%)
[  3]  7.0- 8.0 sec   441 KBytes  3.61 Mbits/sec   7.725 ms  307/  614 (50%)
[  3]  8.0- 9.0 sec   469 KBytes  3.85 Mbits/sec   5.360 ms  328/  655 (50%)
[  3]  9.0-10.0 sec   461 KBytes  3.77 Mbits/sec  11.134 ms  401/  722 (56%)
[  3]  9.0-10.0 sec  203 datagrams received out-of-order
[  3] 10.0-11.0 sec   238 KBytes  1.95 Mbits/sec   6.453 ms  112/  278 (40%)
[  3] 10.0-11.0 sec  118 datagrams received out-of-order
[  3] 11.0-12.0 sec  0.00 Bytes  0.00 bits/sec   6.453 ms    0/    0 (NaN%)
[  3]  0.0-12.3 sec  4.49 MBytes  3.07 Mbits/sec  101.144 ms 3073/ 6276 (49%)
[  3]  0.0-12.3 sec  325 datagrams received out-of-order
Waiting for server threads to complete. Interrupt again to force quit.
------------------------------------------------------------
Client connecting to 10.88.49.50, UDP port 5001
Sending 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.65.87.86 port 55795 connected with 10.88.49.50 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  12.0 GBytes   103 Gbits/sec
[  3]  1.0- 2.0 sec   709 KBytes  5.81 Mbits/sec
[  3]  2.0- 3.0 sec   930 KBytes  7.62 Mbits/sec
[  3]  3.0- 4.0 sec   818 KBytes  6.70 Mbits/sec
[  3]  4.0- 5.0 sec   936 KBytes  7.67 Mbits/sec
[  3]  5.0- 6.0 sec   883 KBytes  7.23 Mbits/sec
[  3]  6.0- 7.0 sec   939 KBytes  7.69 Mbits/sec
[  3]  7.0- 8.0 sec   930 KBytes  7.62 Mbits/sec
[  3]  8.0- 9.0 sec   883 KBytes  7.23 Mbits/sec
[  3]  9.0-10.0 sec   890 KBytes  7.29 Mbits/sec
[  3]  0.0-10.0 sec  12.0 GBytes  10.3 Gbits/sec
[  3] Sent 6278 datagrams
[  3] Server Report:
[  3]  0.0-12.3 sec  4.49 MBytes  3.07 Mbits/sec  101.143 ms 3073/ 6276 (49%)
[  3]  0.0-12.3 sec  325 datagrams received out-of-order
Changing to 2.4 GHz, channel 11, HT20
(PARALLEL) adb -s BX903J8X12 reboot
(PARALLEL) adb -s BX903J8AWV reboot
Serial: BX903J8X12, last uptime: 26.03
Got new uptime: 8
Serial: BX903J8AWV, last uptime: 25.96
Got new uptime: 9
adb -s BX903J8X12 wait-for-device
adb -s BX903J8AWV wait-for-device
adb -s BX903J8X12 shell iw reg set US
adb -s BX903J8AWV shell iw reg set US
adb -s BX903J8X12 shell iw phy phy0 interface add mesh0 type mp
adb -s BX903J8AWV shell iw phy phy0 interface add mesh0 type mp
adb -s BX903J8X12 shell iw dev mesh0 set channel 11 HT20
adb -s BX903J8AWV shell iw dev mesh0 set channel 11 HT20
adb -s BX903J8X12 shell ip link set mesh0 up
adb -s BX903J8AWV shell ip link set mesh0 up
adb -s BX903J8X12 shell iw dev mesh0 mesh join xz
adb -s BX903J8AWV shell iw dev mesh0 mesh join xz
adb -s BX903J8X12 shell ifconfig mesh0 10.88.49.50
adb -s BX903J8AWV shell ifconfig mesh0 10.65.87.86
adb -s BX903J8X12 shell getprop ro.serialno
adb -s BX903J8AWV shell getprop ro.serialno
Starting server on BX903J8X12/10.88.49.50
Starting client on BX903J8AWV/10.65.87.86
killall: iperf: no process killed
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.88.49.50 port 5001 connected with 10.65.87.86 port 39845
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0- 1.0 sec  66.0 KBytes   541 Kbits/sec  20.056 ms   12/   58 (21%)
[  3]  0.0- 1.0 sec  28 datagrams received out-of-order
[  3]  1.0- 2.0 sec  57.4 KBytes   470 Kbits/sec  20.257 ms    0/   40 (0%)
[  3]  2.0- 3.0 sec  74.6 KBytes   612 Kbits/sec  14.541 ms    0/   52 (0%)
[  3]  3.0- 4.0 sec  84.7 KBytes   694 Kbits/sec  18.858 ms    1/   60 (1.7%)
[  3]  4.0- 5.0 sec   543 KBytes  4.45 Mbits/sec   2.941 ms  378/  756 (50%)
[  3]  5.0- 6.0 sec   736 KBytes  6.03 Mbits/sec   2.689 ms  513/ 1026 (50%)
[  3]  6.0- 7.0 sec   719 KBytes  5.89 Mbits/sec   4.509 ms  501/ 1002 (50%)
[  3]  7.0- 8.0 sec   718 KBytes  5.88 Mbits/sec   3.667 ms  500/ 1000 (50%)
[  3]  8.0- 9.0 sec   715 KBytes  5.86 Mbits/sec   4.691 ms  499/  997 (50%)
[  3]  9.0-10.0 sec   739 KBytes  6.06 Mbits/sec   2.875 ms  515/ 1030 (50%)
[  3]  0.0-10.5 sec  4.66 MBytes  3.74 Mbits/sec   5.433 ms 3140/ 6465 (49%)
[  3]  0.0-10.5 sec  29 datagrams received out-of-order
read failed: Connection refused
------------------------------------------------------------
Client connecting to 10.88.49.50, UDP port 5001
Sending 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.65.87.86 port 39845 connected with 10.88.49.50 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec   521 KBytes  4.27 Mbits/sec
[  3]  1.0- 2.0 sec   109 KBytes   894 Kbits/sec
[  3]  2.0- 3.0 sec   164 KBytes  1.34 Mbits/sec
[  3]  3.0- 4.0 sec   164 KBytes  1.34 Mbits/sec
[  3]  4.0- 5.0 sec  1.01 MBytes  8.51 Mbits/sec
[  3]  5.0- 6.0 sec  1.44 MBytes  12.1 Mbits/sec
[  3]  6.0- 7.0 sec  1.44 MBytes  12.1 Mbits/sec
[  3]  7.0- 8.0 sec  1.40 MBytes  11.7 Mbits/sec
[  3]  8.0- 9.0 sec  1.37 MBytes  11.5 Mbits/sec
[  3]  9.0-10.0 sec  1.47 MBytes  12.3 Mbits/sec
[  3]  0.0-10.0 sec  9.07 MBytes  7.58 Mbits/sec
[  3] Sent 6467 datagrams
[  3] Server Report:
[  3]  0.0-10.5 sec  4.66 MBytes  3.74 Mbits/sec   5.432 ms 3140/ 6465 (49%)
[  3]  0.0-10.5 sec  29 datagrams received out-of-order
Changing to 2.4 GHz, channel 11, legacy
(PARALLEL) adb -s BX903J8X12 reboot
(PARALLEL) adb -s BX903J8AWV reboot
Serial: BX903J8X12, last uptime: 24.59
Got new uptime: 8
Serial: BX903J8AWV, last uptime: 24.43
Got new uptime: 8
adb -s BX903J8AWV wait-for-device
adb -s BX903J8X12 wait-for-device
adb -s BX903J8AWV shell iw reg set US
adb -s BX903J8X12 shell iw reg set US
adb -s BX903J8AWV shell iw phy phy0 interface add mesh0 type mp
adb -s BX903J8X12 shell iw phy phy0 interface add mesh0 type mp
adb -s BX903J8AWV shell iw dev mesh0 set channel 11
adb -s BX903J8X12 shell iw dev mesh0 set channel 11
adb -s BX903J8AWV shell ip link set mesh0 up
adb -s BX903J8X12 shell ip link set mesh0 up
adb -s BX903J8AWV shell iw dev mesh0 mesh join xz
adb -s BX903J8X12 shell iw dev mesh0 mesh join xz
adb -s BX903J8AWV shell ifconfig mesh0 10.65.87.86
adb -s BX903J8X12 shell ifconfig mesh0 10.88.49.50
adb -s BX903J8AWV shell getprop ro.serialno
adb -s BX903J8X12 shell getprop ro.serialno
Starting server on BX903J8AWV/10.65.87.86
Starting client on BX903J8X12/10.88.49.50
killall: iperf: no process killed
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.65.87.86 port 5001 connected with 10.88.49.50 port 40403
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0- 1.0 sec   347 KBytes  2.85 Mbits/sec  15.380 ms   59/  301 (20%)
[  3]  1.0- 2.0 sec   688 KBytes  5.63 Mbits/sec   4.408 ms  479/  958 (50%)
[  3]  2.0- 3.0 sec   699 KBytes  5.73 Mbits/sec   3.101 ms  487/  974 (50%)
[  3]  3.0- 4.0 sec   560 KBytes  4.59 Mbits/sec   4.964 ms  390/  780 (50%)
[  3]  4.0- 5.0 sec   571 KBytes  4.68 Mbits/sec   4.026 ms  398/  796 (50%)
[  3]  5.0- 6.0 sec   561 KBytes  4.60 Mbits/sec   6.276 ms  391/  782 (50%)
[  3]  6.0- 7.0 sec   544 KBytes  4.46 Mbits/sec   3.441 ms  379/  758 (50%)
[  3]  7.0- 8.0 sec   535 KBytes  4.39 Mbits/sec   3.399 ms  373/  746 (50%)
[  3]  8.0- 9.0 sec   550 KBytes  4.50 Mbits/sec   7.435 ms  399/  782 (51%)
[  3]  8.0- 9.0 sec  117 datagrams received out-of-order
[  3]  9.0-10.0 sec   478 KBytes  3.92 Mbits/sec   5.950 ms  370/  703 (53%)
[  3]  9.0-10.0 sec  204 datagrams received out-of-order
[  3]  0.0-10.6 sec  5.71 MBytes  4.53 Mbits/sec  10.228 ms 3884/ 7960 (49%)
[  3]  0.0-10.6 sec  322 datagrams received out-of-order
read failed: Connection refused
------------------------------------------------------------
Client connecting to 10.65.87.86, UDP port 5001
Sending 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.88.49.50 port 40403 connected with 10.65.87.86 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  1.04 MBytes  8.73 Mbits/sec
[  3]  1.0- 2.0 sec  1.35 MBytes  11.4 Mbits/sec
[  3]  2.0- 3.0 sec  1.34 MBytes  11.3 Mbits/sec
[  3]  3.0- 4.0 sec  1.08 MBytes  9.08 Mbits/sec
[  3]  4.0- 5.0 sec  1.12 MBytes  9.43 Mbits/sec
[  3]  5.0- 6.0 sec  1.12 MBytes  9.43 Mbits/sec
[  3]  6.0- 7.0 sec  1.04 MBytes  8.75 Mbits/sec
[  3]  7.0- 8.0 sec  1.05 MBytes  8.84 Mbits/sec
[  3]  8.0- 9.0 sec  1.04 MBytes  8.73 Mbits/sec
[  3]  9.0-10.0 sec   976 KBytes  8.00 Mbits/sec
[  3]  0.0-10.0 sec  11.2 MBytes  9.33 Mbits/sec
[  3] Sent 7961 datagrams
[  3] Server Report:
[  3]  0.0-10.6 sec  5.71 MBytes  4.53 Mbits/sec  10.228 ms 3884/ 7960 (49%)
[  3]  0.0-10.6 sec  322 datagrams received out-of-order
```
