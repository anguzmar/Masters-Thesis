#!/usr/bin/python

# Add mininet's directory to path.
import sys
sys.path.append('/home/mininet/mininet')

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.link import Intf, TCLink
from mininet.node import RemoteController
from mininet.cli import CLI
from mininet.log import setLogLevel, info


class FVTopo(Topo):
	"""Based on:
	https://github.com/onstutorial/onstutorial/blob/master/flowvisor_scripts/flowvisor_topo.py"""

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
		for i in range(1, N_switches + 1):
			sconfig = {'dpid': "%016x" % (i)}
			self.addSwitch('s%d' % (i), **sconfig)

		# Create host nodes.
		for i in range(1, N_hosts + 1):
			if i%2 == 0:
				hconfig = {'inNamesapce':True, 'ip': "192.168.0.%d" % (i)}
				self.addHost('h%d' % (i), **hconfig)
			if i%2 != 0:
				hconfig = {'inNamesapce':True, 'ip': "10.0.0.%d" % (i)}
				self.addHost('h%d' % (i), **hconfig)

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


def run_fvtopo():
	# Create topology.
	net = Mininet(topo = FVTopo(), controller = RemoteController, autoSetMacs = True,
				  autoStaticArp = True, link = TCLink)

	# Add external interface.
	intfName = 'eth0'
	info('*** Checking', intfName, '\n')

	switch = net.switches[0]
	info('*** Adding hardware interface', intfName, 'to switch', switch.name, '\n')
	_intf = Intf(intfName, node=switch)

	# Run it.
	net.start()
	CLI(net)
	net.stop()


if __name__ == '__main__':
	setLogLevel('info')
	run_fvtopo()


# Preserve the --custom functionality.
topos = {'fvtopo': FVTopo}
