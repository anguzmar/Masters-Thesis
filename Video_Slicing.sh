# This script creates two slices: video and Non-video traffic.

# Additionally, this script only works for the topology displayed at:
# https://github.com/onstutorial/onstutorial/wiki/Flowvisor-Exercise.

# Create both slices.
fvctl -n add-slice video tcp:localhost:10001 admin@videoSlice
fvctl -n add-slice non-video tcp:localhost:10002 admin@non-videoSlice

# Add flowspaces for switch 1.
fvctl -n add-flowspace dpid1_port3-video 1 100 in_port=3,dl_type=0x0800,nw_proto=6,tp_src=9999 video=7  # Priority 100.
fvctl -n add-flowspace dpid1_port3-video 1 100 in_port=3,dl_type=0x0800,nw_proto=6,tp_dst=9999 video=7
fvctl -n add-flowspace dpid1_port3-non-video 1 1 in_port=3 non-video=7
fvctl -n add-flowspace dpid1_port4-video 1 100 in_port=4,dl_type=0x0800,nw_proto=6,tp_src=9999 video=7
fvctl -n add-flowspace dpid1_port4-video 1 100 in_port=4,dl_type=0x0800,nw_proto=6,tp_dst=9999 video=7
fvctl -n add-flowspace dpid1_port4-non-video 1 1 in_port=4 non-video=7  # Priority 1.
fvctl -n add-flowspace dpid1_port2-video 1 100 in_port=2 video=7
fvctl -n add-flowspace dpid1_port1-video 1 1 in_port=1 non-video=7

# Add flowspaces for switch 2.
fvctl -n add-flowspace dpid2 2 1 any non-video=7  # Priority 1.

# Add flowspaces for switch 3.
fvctl -n add-flowspace dpid3 3 100 any video=7  # Priority 100.

# Add flowspaces for switch 4.
fvctl -n add-flowspace dpid4_port3-video 4 100 in_port=3,dl_type=0x0800,nw_proto=6,tp_src=9999 video=7  # Priority 100.
fvctl -n add-flowspace dpid4_port3-video 4 100 in_port=3,dl_type=0x0800,nw_proto=6,tp_dst=9999 video=7
fvctl -n add-flowspace dpid4_port3-non-video 4 1 in_port=3 non-video=7
fvctl -n add-flowspace dpid4_port4-video 4 100 in_port=4,dl_type=0x0800,nw_proto=6,tp_src=9999 video=7
fvctl -n add-flowspace dpid4_port4-video 4 100 in_port=4,dl_type=0x0800,nw_proto=6,tp_dst=9999 video=7
fvctl -n add-flowspace dpid4_port4-non-video 4 1 in_port=4 non-video=7  # Priority 4.
fvctl -n add-flowspace dpid4_port2-video 4 100 in_port=2 video=7
fvctl -n add-flowspace dpid4_port4-video 4 1 in_port=1 non-video=7
