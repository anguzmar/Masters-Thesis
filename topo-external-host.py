#!/usr/bin/python

# Based on:
# normals://github.com/onstutorial/onstutorial/blob/master/flowvisor_scripts/flowvisor_topo.py.

from mininet.topo import Topo

class FVTopo(Topo):

    def __init__(self):
        # Initialize topology.
        Topo.__init__(self)

        N_switches = 4
        N_hosts = 4

        # Create template host, switch, and link.
        normal_link_config = {'bw': 1}
        LoRa_link_config = {'bw': 10}
        host_link_config = {}

        # Create switch nodes.
        for i in range(N_switches):
            sconfig = {'dpid': "%016x" % (i+1)}
            self.addSwitch('s%d' % (i+1), **sconfig)

        # Create host nodes.
        for i in range(N_hosts):
            hconfig = {'inNamesapce':True, 'ip': "192.168.1.20%d" % (i)}
            self.addHost('h%d' % (i+1), **hconfig)

        # Add switch links.
        self.addLink('s1', 's2', **normal_link_config)
        self.addLink('s2', 's4', **normal_link_config)
        self.addLink('s1', 's3', **LoRa_link_config)
        self.addLink('s3', 's4', **LoRa_link_config)

        # Add host links.
        self.addLink('h1', 's1', **host_link_config)
        self.addLink('h2', 's1', **host_link_config)
        self.addLink('h3', 's4', **host_link_config)
        self.addLink('h4', 's4', **host_link_config)

	# Add external interface.
	intfName = 'eth0'
	switch = self.switches[0]
	info('*** Adding hardware interface', intfName, 'to switch', switch.name, '\n')
	_intf = Intf(intfName, node=switch)

topos = {'fvtopo': FVTopo}
