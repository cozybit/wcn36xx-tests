# External mesh STA throughput test

This is a test between the Xperia Z and an external STA demostrating higher
throughput, as long as the receiver (the iperf server) is on the Xperia Z.  The
client (the external STA) must initiated the block ACK session to see higher
throughput numbers.

## External mesh STA

External mesh STA is a `TP-LINK WDN3200`, or via `lsusb` it shows up as:

```text
Bus 001 Device 019: ID 148f:5572 Ralink Technology, Corp. 
```

## Test configuration

Performed inside an RF chamber.

- Channel 36 (HT20)
- Mesh ID: xz

Mesh info from external STA:

```text
$ iw mesh0 info
Interface mesh0
	ifindex 13
	wdev 0x200000004
	addr 64:70:02:0b:33:db
	type mesh point
	wiphy 2
	channel 36 (5180 MHz), width: 20 MHz, center1: 5180 MHz
```

External mesh STA interface:

```text
$ ip addr show mesh0 
13: mesh0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether 64:70:02:0b:33:db brd ff:ff:ff:ff:ff:ff
    inet 10.99.99.99/8 brd 10.255.255.255 scope global mesh0
    inet6 fe80::6670:2ff:fe0b:33db/64 scope link 
       valid_lft forever preferred_lft forever
```

Xperia Z mesh STA interface:

```text
root@android:/ # ip addr show mesh0                                            
18: mesh0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether b4:52:7d:46:21:de brd ff:ff:ff:ff:ff:ff
    inet 10.88.49.50/8 brd 10.255.255.255 scope global mesh0
    inet6 fe80::b652:7dff:fe46:21de/64 scope link 
       valid_lft forever preferred_lft forever
```

## Perfmance results on Xperia Z (iperf server)

Output from iperf:

```bash
root@android:/ # iperf -s -u -i 1
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 10.88.49.50 port 5001 connected with 10.99.99.99 port 36421
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0- 1.0 sec  6.51 MBytes  54.6 Mbits/sec   0.270 ms  389/ 5036 (7.7%)
[  3]  0.0- 1.0 sec  9 datagrams received out-of-order
[  3]  1.0- 2.0 sec  7.13 MBytes  59.8 Mbits/sec   0.209 ms  198/ 5282 (3.7%)
[  3]  2.0- 3.0 sec  7.40 MBytes  62.0 Mbits/sec   0.613 ms   16/ 5291 (0.3%)
[  3]  3.0- 4.0 sec  7.37 MBytes  61.8 Mbits/sec   0.099 ms   34/ 5290 (0.64%)
[  3]  4.0- 5.0 sec  7.34 MBytes  61.6 Mbits/sec   0.306 ms   38/ 5272 (0.72%)
[  3]  5.0- 6.0 sec  7.37 MBytes  61.8 Mbits/sec   0.098 ms   25/ 5283 (0.47%)
[  3]  6.0- 7.0 sec  7.35 MBytes  61.7 Mbits/sec   0.275 ms   17/ 5260 (0.32%)
[  3]  7.0- 8.0 sec  7.34 MBytes  61.6 Mbits/sec   0.467 ms   52/ 5289 (0.98%)
[  3]  8.0- 9.0 sec  7.40 MBytes  62.0 Mbits/sec   0.130 ms   13/ 5288 (0.25%)
[  3]  9.0-10.0 sec  7.36 MBytes  61.7 Mbits/sec   0.126 ms   41/ 5289 (0.78%)
[  3]  0.0-10.0 sec  72.6 MBytes  60.9 Mbits/sec   0.721 ms  822/52609 (1.6%)
[  3]  0.0-10.0 sec  10 datagrams received out-of-order
```

## Perfmance results on external mesh STA

Output from iperf:

```bash
$ iperf -c 10.88.49.50 -u -i 1 -b 100M -t 10
------------------------------------------------------------
Client connecting to 10.88.49.50, UDP port 5001
Sending 1470 byte datagrams
UDP buffer size:  208 KByte (default)
------------------------------------------------------------
[  3] local 10.99.99.99 port 36421 connected with 10.88.49.50 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  7.14 MBytes  59.9 Mbits/sec
[  3]  1.0- 2.0 sec  7.42 MBytes  62.2 Mbits/sec
[  3]  2.0- 3.0 sec  7.40 MBytes  62.0 Mbits/sec
[  3]  3.0- 4.0 sec  7.43 MBytes  62.3 Mbits/sec
[  3]  4.0- 5.0 sec  7.35 MBytes  61.6 Mbits/sec
[  3]  5.0- 6.0 sec  7.47 MBytes  62.6 Mbits/sec
[  3]  6.0- 7.0 sec  7.36 MBytes  61.7 Mbits/sec
[  3]  7.0- 8.0 sec  7.39 MBytes  62.0 Mbits/sec
[  3]  8.0- 9.0 sec  7.46 MBytes  62.5 Mbits/sec
[  3]  9.0-10.0 sec  7.36 MBytes  61.7 Mbits/sec
[  3]  0.0-10.0 sec  73.8 MBytes  61.9 Mbits/sec
[  3] Sent 52610 datagrams
[  3] Server Report:
[  3]  0.0-10.0 sec  72.6 MBytes  60.9 Mbits/sec   0.720 ms  822/52609 (1.6%)
[  3]  0.0-10.0 sec  10 datagrams received out-of-order
```

## Internal-STA

Internal-STA 

## Appendix: external STA wiphy information

```text
$ iw phy 
Wiphy phy2
	Band 1:
		Capabilities: 0x2f2
			HT20/HT40
			Static SM Power Save
			RX Greenfield
			RX HT20 SGI
			RX HT40 SGI
			TX STBC
			RX STBC 2-streams
			Max AMSDU length: 3839 bytes
			No DSSS/CCK HT40
		Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
		Minimum RX AMPDU time spacing: 2 usec (0x04)
		HT RX MCS rate indexes supported: 0-15, 32
		TX unequal modulation not supported
		HT TX Max spatial streams: 2
		HT TX MCS rate indexes supported may differ
		Frequencies:
			* 2412 MHz [1] (27.0 dBm)
			* 2417 MHz [2] (27.0 dBm)
			* 2422 MHz [3] (27.0 dBm)
			* 2427 MHz [4] (27.0 dBm)
			* 2432 MHz [5] (27.0 dBm)
			* 2437 MHz [6] (27.0 dBm)
			* 2442 MHz [7] (27.0 dBm)
			* 2447 MHz [8] (27.0 dBm)
			* 2452 MHz [9] (27.0 dBm)
			* 2457 MHz [10] (27.0 dBm)
			* 2462 MHz [11] (27.0 dBm)
			* 2467 MHz [12] (disabled)
			* 2472 MHz [13] (disabled)
			* 2484 MHz [14] (disabled)
		Bitrates (non-HT):
			* 1.0 Mbps
			* 2.0 Mbps (short preamble supported)
			* 5.5 Mbps (short preamble supported)
			* 11.0 Mbps (short preamble supported)
			* 6.0 Mbps
			* 9.0 Mbps
			* 12.0 Mbps
			* 18.0 Mbps
			* 24.0 Mbps
			* 36.0 Mbps
			* 48.0 Mbps
			* 54.0 Mbps
	Band 2:
		Capabilities: 0x2f2
			HT20/HT40
			Static SM Power Save
			RX Greenfield
			RX HT20 SGI
			RX HT40 SGI
			TX STBC
			RX STBC 2-streams
			Max AMSDU length: 3839 bytes
			No DSSS/CCK HT40
		Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
		Minimum RX AMPDU time spacing: 2 usec (0x04)
		HT RX MCS rate indexes supported: 0-15, 32
		TX unequal modulation not supported
		HT TX Max spatial streams: 2
		HT TX MCS rate indexes supported may differ
		Frequencies:
			* 5180 MHz [36] (17.0 dBm)
			* 5190 MHz [38] (17.0 dBm)
			* 5200 MHz [40] (17.0 dBm)
			* 5210 MHz [42] (17.0 dBm)
			* 5220 MHz [44] (17.0 dBm)
			* 5230 MHz [46] (17.0 dBm)
			* 5240 MHz [48] (17.0 dBm)
			* 5250 MHz [50] (disabled)
			* 5260 MHz [52] (20.0 dBm) (radar detection)
			* 5270 MHz [54] (20.0 dBm) (radar detection)
			* 5280 MHz [56] (20.0 dBm) (radar detection)
			* 5290 MHz [58] (20.0 dBm) (radar detection)
			* 5300 MHz [60] (20.0 dBm) (radar detection)
			* 5310 MHz [62] (20.0 dBm) (radar detection)
			* 5320 MHz [64] (20.0 dBm) (radar detection)
			* 5500 MHz [100] (20.0 dBm) (radar detection)
			* 5510 MHz [102] (20.0 dBm) (radar detection)
			* 5520 MHz [104] (20.0 dBm) (radar detection)
			* 5530 MHz [106] (20.0 dBm) (radar detection)
			* 5540 MHz [108] (20.0 dBm) (radar detection)
			* 5550 MHz [110] (20.0 dBm) (radar detection)
			* 5560 MHz [112] (20.0 dBm) (radar detection)
			* 5570 MHz [114] (20.0 dBm) (radar detection)
			* 5580 MHz [116] (20.0 dBm) (radar detection)
			* 5590 MHz [118] (20.0 dBm) (radar detection)
			* 5600 MHz [120] (disabled)
			* 5610 MHz [122] (disabled)
			* 5620 MHz [124] (disabled)
			* 5630 MHz [126] (disabled)
			* 5640 MHz [128] (disabled)
			* 5650 MHz [130] (disabled)
			* 5660 MHz [132] (20.0 dBm) (radar detection)
			* 5670 MHz [134] (20.0 dBm) (radar detection)
			* 5680 MHz [136] (20.0 dBm) (radar detection)
			* 5690 MHz [138] (20.0 dBm) (radar detection)
			* 5700 MHz [140] (20.0 dBm) (radar detection)
			* 5745 MHz [149] (30.0 dBm)
			* 5755 MHz [151] (30.0 dBm)
			* 5765 MHz [153] (30.0 dBm)
			* 5775 MHz [155] (30.0 dBm)
			* 5785 MHz [157] (30.0 dBm)
			* 5795 MHz [159] (30.0 dBm)
			* 5805 MHz [161] (30.0 dBm)
			* 5825 MHz [165] (30.0 dBm)
			* 4920 MHz [-16] (disabled)
			* 4940 MHz [-12] (disabled)
			* 4960 MHz [-8] (disabled)
			* 4980 MHz [-4] (disabled)
		Bitrates (non-HT):
			* 6.0 Mbps
			* 9.0 Mbps
			* 12.0 Mbps
			* 18.0 Mbps
			* 24.0 Mbps
			* 36.0 Mbps
			* 48.0 Mbps
			* 54.0 Mbps
	max # scan SSIDs: 4
	max scan IEs length: 2257 bytes
	Coverage class: 0 (up to 0m)
	Supported Ciphers:
		* WEP40 (00-0f-ac:1)
		* WEP104 (00-0f-ac:5)
		* TKIP (00-0f-ac:2)
		* CCMP (00-0f-ac:4)
	Available Antennas: TX 0 RX 0
	Supported interface modes:
		 * IBSS
		 * managed
		 * AP
		 * AP/VLAN
		 * WDS
		 * monitor
		 * mesh point
	software interface modes (can always be added):
		 * AP/VLAN
		 * monitor
	valid interface combinations:
		 * #{ AP, mesh point } <= 8,
		   total <= 8, #channels <= 1
	Supported commands:
		 * new_interface
		 * set_interface
		 * new_key
		 * new_beacon
		 * new_station
		 * new_mpath
		 * set_mesh_params
		 * set_bss
		 * authenticate
		 * associate
		 * deauthenticate
		 * disassociate
		 * join_ibss
		 * join_mesh
		 * set_tx_bitrate_mask
		 * action
		 * frame_wait_cancel
		 * set_wiphy_netns
		 * set_channel
		 * set_wds_peer
		 * Unknown command (84)
		 * Unknown command (87)
		 * Unknown command (85)
		 * Unknown command (89)
		 * Unknown command (92)
		 * connect
		 * disconnect
	Supported TX frame types:
		 * IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
		 * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
		 * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
		 * AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
		 * mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
		 * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
		 * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
		 * Unknown mode (10): 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
	Supported RX frame types:
		 * IBSS: 0x40 0xb0 0xc0 0xd0
		 * managed: 0x40 0xd0
		 * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
		 * AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
		 * mesh point: 0xb0 0xc0 0xd0
		 * P2P-client: 0x40 0xd0
		 * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
		 * Unknown mode (10): 0x40 0xd0
	Device supports RSN-IBSS.
	HT Capability overrides:
		 * MCS: ff ff ff ff ff ff ff ff ff ff
		 * maximum A-MSDU length
		 * supported channel width
		 * short GI for 40 MHz
		 * max A-MPDU length exponent
		 * min MPDU start spacing
	Device supports TX status socket option.
	Device supports HT-IBSS.
```
