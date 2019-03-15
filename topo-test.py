#!/usr/bin/python

# Add mininet's directory to path.
import sys
import re
sys.path.append('/home/mininet/mininet')

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.link import Intf, TCLink
from mininet.node import RemoteController
from mininet.cli import CLI
from mininet.log import setLogLevel, info, error
from mininet.util import quietRun


class FVTopo(Topo):
# Based on:
# normals://github.com/onstutorial/onstutorial/blob/master/flowvisor_scripts/flowvisor_topo.py.

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
            hconfig = {'inNamespace':True, 'ip':"0.0.0.0"}
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

def checkIntf(intf):
    """Make sure intf exists and is not configured."""

    config = quietRun('ifconfig %s 2>/dev/null' % intf, shell=True)
    if not config:
        error('Error:', intf, 'does not exist!\n')
        exit(1)

    ips = re.findall(r'\d+\.\d+\.\d+\.\d+', config)
    if ips:
        error('Error:', intf, 'has an IP address, and is probably in use!\n')
        exit(1)


def run_fvtopo():
    # Create topology.
    net = Mininet(topo = FVTopo(), controller = RemoteController, autoSetMacs = True,
                  autoStaticArp = True, link = TCLink)

    # Add external interface.
    intfName = 'eth1'
    info('*** Checking', intfName, '\n')
    checkIntf(intfName)

    switch = net.switches[0]
    info('*** Adding hardware interface', intfName, 'to switch', switch.name, '\n')
    _intf = Intf(intfName, node=switch)

    # Run it.
    net.start()
    h1.cmdPrint('dhclient '+h1.defaultIntf().name)
    h2.cmdPrint('dhclient '+h2.defaultIntf().name)
    h3.cmdPrint('dhclient '+h3.defaultIntf().name)
    h4.cmdPrint('dhclient '+h4.defaultIntf().name)
    CLI(net)
    net.stop()


if __name__ == '__main__':
    setLogLevel('info')
    run_fvtopo()


# Preserve the --custom functionality.
topos = { 'fvtopo': FVTopo}
