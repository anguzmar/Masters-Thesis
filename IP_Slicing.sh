# This script creates three slices: LoRa, Regular traffic and a DevNull slice to drop packets.

# Create both slices.
fvctl -n add-slice LoRa tcp:localhost:10001 admin@LoRaSlice
fvctl -n add-slice Regular tcp:localhost:10002 admin@RegularSlice
fvctl -n add-slice DevNull tcp:localhost:666 admin@DevNull


# Add flowspaces for switch 1.
fvctl -n add-flowspace dpid1_LoRa_h1 1 100 nw_src=10.0.0.1 LoRa=6
fvctl -n add-flowspace dpid1_LoRa_h3 1 100 nw_src=10.0.0.3 LoRa=6

fvctl -n add-flowspace dpid1_DevNull_2to1 1 100 nw_src=10.0.0.2,nw_dst=10.0.0.1 DevNull=2
fvctl -n add-flowspace dpid1_DevNull_2to3 1 100 nw_src=10.0.0.2,nw_dst=10.0.0.3 DevNull=2
fvctl -n add-flowspace dpid1_DevNull_1to2 1 100 nw_src=10.0.0.1,nw_dst=10.0.0.2 DevNull=2
fvctl -n add-flowspace dpid1_DevNull_1to4 1 100 nw_src=10.0.0.1,nw_dst=10.0.0.4 DevNull=2

fvctl -n add-flowspace dpid1_default 1 1 any Regular=6

fvctl -n add-flowspace dpid1_Regular_port1 1 1 in_port=1 Regular=6

fvctl -n add-flowspace dpid1_LoRa_port2_h1 1 100 in_port=2,nw_src=10.0.0.1 LoRa=6
fvctl -n add-flowspace dpid1_LoRa_port2_h3 1 100 in_port=2,nw_src=10.0.0.3 LoRa=6
fvctl -n add-flowspace dpid1_LoRa_port2 1 1 in_port=2 DevNull=2


# Add flowspaces for switch 2.
fvctl -n add-flowspace dpid2 2 1 any Regular=6


# Add flowspaces for switch 3.
fvctl -n add-flowspace dpid3_h1 3 100 nw_src=10.0.0.1 LoRa=6
fvctl -n add-flowspace dpid3_h3 3 100 nw_src=10.0.0.3 LoRa=6
fvctl -n add-flowspace dpid3_drop 3 1 any DevNull=2


# Add flowspaces for switch 4.
fvctl -n add-flowspace dpid4_LoRa_h1 4 100 nw_src=10.0.0.1 LoRa=6
fvctl -n add-flowspace dpid4_LoRa_h3 4 100 nw_src=10.0.0.3 LoRa=6

fvctl -n add-flowspace dpid4_DevNull_4to3 4 100 nw_src=10.0.0.4,nw_dst=10.0.0.3 DevNull=2
fvctl -n add-flowspace dpid4_DevNull_4to1 4 100 nw_src=10.0.0.4,nw_dst=10.0.0.1 DevNull=2
fvctl -n add-flowspace dpid4_DevNull_3to4 4 100 nw_src=10.0.0.3,nw_dst=10.0.0.4 DevNull=2
fvctl -n add-flowspace dpid4_DevNull_3to2 4 100 nw_src=10.0.0.3,nw_dst=10.0.0.2 DevNull=2

fvctl -n add-flowspace dpid4_default 4 1 any Regular=6

fvctl -n add-flowspace dpid4_Regular_port1 4 1 in_port=1 Regular=6

fvctl -n add-flowspace dpid4_LoRa_port2_h1 4 100 in_port=2,nw_src=10.0.0.1 LoRa=6
fvctl -n add-flowspace dpid4_LoRa_port2_h3 4 100 in_port=2,nw_src=10.0.0.3 LoRa=6
fvctl -n add-flowspace dpid4_LoRa_port2 4 1 in_port=2 DevNull=2
