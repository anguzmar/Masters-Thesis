# This script creates two slices: LoRa and Non-LoRa traffic. To distinguish between LoRa and
# Non-LoRa traffic we make use of the "Type of Service" IPv4 header.

# Additionally, this script only works for the topology displayed at:
# https://github.com/onstutorial/onstutorial/wiki/Flowvisor-Exercise.

# Create both slices.
fvctl -n add-slice LoRa tcp:localhost:10001 admin@LoRaSlice
fvctl -n add-slice Normal tcp:localhost:10002 admin@NormalSlice

# Add flowspaces for switch 1.
fvctl -n add-flowspace dpid1_port1 1 1 in_port=1 Normal=7
fvctl -n add-flowspace dpid1_port2 1 100 in_port=2 LoRa=7
fvctl -n add-flowspace dpid1_port3-LoRa 1 100 in_port=3,nw_tos=4 LoRa=7
fvctl -n add-flowspace dpid1_port3-Normal 1 1 in_port=3 Normal=7
fvctl -n add-flowspace dpid1_port4-LoRa 1 100 in_port=4,nw_tos=4 LoRa=7
fvctl -n add-flowspace dpid1_port4-Normal 1 1 in_port=4 Normal=7
# External interface on switch 1.
fvctl -n add-flowspace dpid1_port5-LoRa 1 100 in_port=5,nw_tos=4 LoRa=7
fvctl -n add-flowspace dpid1_port5-Normal 1 1 in_port=5 Normal=7

# Add flowspaces for switch 2.
fvctl -n add-flowspace dpid2 2 1 any Normal=7

# Add flowspaces for switch 3.
fvctl -n add-flowspace dpid3 3 100 any LoRa=7

# Add flowspaces for switch 4.
fvctl -n add-flowspace dpid4_port1 4 1 in_port=1 Normal=7
fvctl -n add-flowspace dpid4_port2 4 100 in_port=2 LoRa=7
fvctl -n add-flowspace dpid4_port3-LoRa 4 100 in_port=3,nw_tos=4 LoRa=7
fvctl -n add-flowspace dpid4_port3-Normal 4 1 in_port=3 Normal=7
fvctl -n add-flowspace dpid4_port4-LoRa 4 100 in_port=4,nw_tos=4 LoRa=7
fvctl -n add-flowspace dpid4_port4-Normal 4 1 in_port=4 Normal=7
