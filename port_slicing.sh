# This script creates two slices: fast and slow traffic.


# Create both slices.
fvctl -n add-slice fast tcp:localhost:10001 admin@fastSlice
fvctl -n add-slice slow tcp:localhost:10002 admin@slowSlice

# Add flowspaces for switch 1.
fvctl -n add-flowspace dpid1_port3-fast_src 1 100 in_port=3,dl_type=0x0800,nw_proto=6,tp_src=9999 fast=7  # Priority 100.
fvctl -n add-flowspace dpid1_port3-fast_dst 1 100 in_port=3,dl_type=0x0800,nw_proto=6,tp_dst=9999 fast=7
fvctl -n add-flowspace dpid1_port3-slow 1 1 in_port=3 slow=7
fvctl -n add-flowspace dpid1_port4-fast_src 1 100 in_port=4,dl_type=0x0800,nw_proto=6,tp_src=9999 fast=7
fvctl -n add-flowspace dpid1_port4-fast_dst 1 100 in_port=4,dl_type=0x0800,nw_proto=6,tp_dst=9999 fast=7
fvctl -n add-flowspace dpid1_port4-slow 1 1 in_port=4 slow=7
fvctl -n add-flowspace dpid1_port2-fast 1 100 in_port=2 fast=7
fvctl -n add-flowspace dpid1_port1-fast 1 1 in_port=1 slow=7

# Add flowspaces for switch 2.
fvctl -n add-flowspace dpid2 2 1 any slow=7

# Add flowspaces for switch 3.
fvctl -n add-flowspace dpid3 3 100 any fast=7 

# Add flowspaces for switch 4.
fvctl -n add-flowspace dpid4_port3-fast_src 4 100 in_port=3,dl_type=0x0800,nw_proto=6,tp_src=9999 fast=7
fvctl -n add-flowspace dpid4_port3-fast_dst 4 100 in_port=3,dl_type=0x0800,nw_proto=6,tp_dst=9999 fast=7
fvctl -n add-flowspace dpid4_port3-slow 4 1 in_port=3 slow=7
fvctl -n add-flowspace dpid4_port4-fast_src 4 100 in_port=4,dl_type=0x0800,nw_proto=6,tp_src=9999 fast=7
fvctl -n add-flowspace dpid4_port4-fast_dst 4 100 in_port=4,dl_type=0x0800,nw_proto=6,tp_dst=9999 fast=7
fvctl -n add-flowspace dpid4_port4-slow 4 1 in_port=4 slow=7
fvctl -n add-flowspace dpid4_port2-fast 4 100 in_port=2 fast=7
fvctl -n add-flowspace dpid4_port4-fast 4 1 in_port=1 slow=7
