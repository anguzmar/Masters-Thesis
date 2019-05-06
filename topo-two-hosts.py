#!/usr/bin/python

# Add mininet's directory to path.
import sys
import re
sys.path.append('/home/mininet/mininet')

from mininet.net import Mininet
from mininet.cli import CLI
from mininet.log import setLogLevel, info


def myNetwork():

    net = Mininet( topo=None,
                   build=False)

    info( '*** Add hosts\n')
    h1 = net.addHost('h1', ip='10.0.0.1')
    h2 = net.addHost('h2', ip='10.0.0.2')

    info( '*** Add links\n')
    net.addLink(h1, h2)

    info( '*** Starting network\n')
    net.start()
    CLI(net)
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    myNetwork()
