# This script creates two slices: LoRa and Regular traffic, based on IP addresses.

# Additionally, this script only works for the topology displayed at:
# https://github.com/onstutorial/onstutorial/wiki/Flowvisor-Exercise.

# Create both slices.
fvctl -n add-slice LoRa tcp:localhost:10001 admin@LoRaSlice
fvctl -n add-slice Regular tcp:localhost:10002 admin@RegularSlice

# Add flowspaces for switch 1.
fvctl -n add-flowspace dpid1_port1 1 1 in_port=1 Regular=6
fvctl -n add-flowspace dpid1_port2 1 1 in_port=2 LoRa=6

fvctl -n add-flowspace dpid1_port3-LoRa 1 10 in_port=3,nw_src=10.0.0.1 LoRa=6
fvctl -n add-flowspace dpid1_port3-Regular 1 1 in_port=3 Regular=6

fvctl -n add-flowspace dpid1_port4-LoRa 1 10 in_port=4,nw_src=10.0.0.1 LoRa=6
fvctl -n add-flowspace dpid1_port4-Regular 1 1 in_port=4 Regular=6


# Add flowspaces for switch 2.
fvctl -n add-flowspace dpid2 2 1 any Regular=6


# Add flowspaces for switch 3.
fvctl -n add-flowspace dpid3 3 1 any LoRa=6


# Add flowspaces for switch 4.
fvctl -n add-flowspace dpid4_port1 4 1 in_port=1 Regular=6
fvctl -n add-flowspace dpid4_port2 4 1 in_port=2 LoRa=6

fvctl -n add-flowspace dpid4_port3-LoRa 4 10 in_port=3,nw_src=10.0.0.3 LoRa=6
fvctl -n add-flowspace dpid4_port3-Regular 4 1 in_port=3 Regular=6

fvctl -n add-flowspace dpid4_port4-LoRa 4 10 in_port=4,nw_src=10.0.0.3 LoRa=6
fvctl -n add-flowspace dpid4_port4-Regular 4 1 in_port=4 Regular=6
