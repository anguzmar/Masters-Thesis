# This script creates three slices: LoRa, Regular traffic and a DevNull slice to drop packets.

# Create both slices.
fvctl -n add-slice LoRa tcp:localhost:10001 admin@LoRaSlice
fvctl -n add-slice Regular tcp:localhost:10002 admin@RegularSlice
fvctl -n add-slice DevNull tcp:localhost:666 admin@DevNull


# Add flowspaces for switch 1.
fvctl -n add-flowspace dpid1_LoRa 1 100 nw_src=10.0.0.0/16 LoRa=6

fvctl -n add-flowspace dpid1_DevNull_LoRa2Regular 1 200 nw_src=10.0.0.0/16,nw_dst=192.168.0.0/16 DevNull=2
fvctl -n add-flowspace dpid1_DevNull_Regular2LoRa 1 200 nw_dst=192.168.0.0/16,nw_src=10.0.0.0/16 DevNull=2

fvctl -n add-flowspace dpid1_default 1 1 any Regular=6

fvctl -n add-flowspace dpid1_DevNull_port1_ARP 1 300 in_port=1,nw_src=10.0.0.0/16,dl_type=0x0806 DevNull=6
fvctl -n add-flowspace dpid1_Regular_port1 1 1 in_port=1 Regular=6

fvctl -n add-flowspace dpid1_LoRa_port2 1 200 in_port=2,nw_src=10.0.0.0/16 LoRa=6
fvctl -n add-flowspace dpid1_DevNull_port2 1 1 in_port=2 DevNull=2


# Add flowspaces for switch 2.
fvctl -n add-flowspace dpid2_DevNull_ARP 2 300 nw_src=10.0.0.0/16,dl_type=0x0806 DevNull=6
fvctl -n add-flowspace dpid2 2 1 any Regular=6


# Add flowspaces for switch 3.
fvctl -n add-flowspace dpid3_DevNull_ARP 3 300 nw_src=192.168.0.0/16,dl_type=0x0806 DevNull=6
fvctl -n add-flowspace dpid3 3 100 nw_src=10.0.0.0/16 LoRa=6
fvctl -n add-flowspace dpid3_DevNull 3 1 any DevNull=2


# Add flowspaces for switch 4.
fvctl -n add-flowspace dpid4_LoRa 4 100 nw_src=10.0.0.0/16 LoRa=6

fvctl -n add-flowspace dpid4_DevNull_LoRa2Regular 4 200 nw_src=10.0.0.0/16,nw_dst=192.168.0.0/16 DevNull=2
fvctl -n add-flowspace dpid4_DevNull_Regular2LoRa 4 200 nw_dst=192.168.0.0/16,nw_src=10.0.0.0/16 DevNull=2

fvctl -n add-flowspace dpid4_default 4 1 any Regular=6

fvctl -n add-flowspace dpid4_DevNull_port1_ARP 4 300 in_port=1,nw_src=10.0.0.0/16,dl_type=0x0806 DevNull=6
fvctl -n add-flowspace dpid4_Regular_port4 4 1 in_port=1 Regular=6

fvctl -n add-flowspace dpid4_LoRa_port2 4 200 in_port=2,nw_src=10.0.0.0/16 LoRa=6
fvctl -n add-flowspace dpid4_DevNull_port2 4 1 in_port=2 DevNull=2
