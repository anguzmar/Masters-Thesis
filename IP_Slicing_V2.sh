# This script creates two slices: LoRa and Regular traffic, based on IP addresses.

# Additionally, this script only works for the topology displayed at:
# https://github.com/onstutorial/onstutorial/wiki/Flowvisor-Exercise.

# Create both slices.
fvctl -n add-slice LoRa tcp:localhost:10001 admin@LoRaSlice
fvctl -n add-slice Regular tcp:localhost:10002 admin@RegularSlice

# Add flowspaces for switch 1.
fvctl -n add-flowspace dpid1_LoRa 1 100 nw_src=10.0.0.1 LoRa=7
fvctl -n add-flowspace dpid1_LoRa 1 100 nw_dst=10.0.0.1 LoRa=7
fvctl -n add-flowspace dpid1_Regular 1 1 any Regular=7
fvctl -n add-flowspace dpid1_Regular_port1 1 1 in_port=1 Regular=7
fvctl -n add-flowspace dpid1_LoRa_port2 1 1 in_port=2 LoRa=7

# Add flowspaces for switch 2.
fvctl -n add-flowspace dpid2 2 1 any Regular=7

# Add flowspaces for switch 3.
fvctl -n add-flowspace dpid3 3 1 any LoRa=7

# Add flowspaces for switch 4.
fvctl -n add-flowspace dpid4_LoRa 4 100 nw_src=10.0.0.1 LoRa=7
fvctl -n add-flowspace dpid4_LoRa 4 100 nw_dst=10.0.0.1 LoRa=7
fvctl -n add-flowspace dpid4_Regular 4 1 any Regular=7
fvctl -n add-flowspace dpid4_Regular_port1 4 1 in_port=1 Regular=7
fvctl -n add-flowspace dpid4_LoRa_port2 4 1 in_port=2 LoRa=7

