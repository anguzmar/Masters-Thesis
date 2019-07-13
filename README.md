# Master's Thesis
This repository hols the different scripts used for my Master's thesis, as well as the final
document itself.

### Overview
In summary, in this thesis we perform two types of network slicing on top of a **Software Defined
Network** (SDN):
	1. TCP port slicing.
	2. IP address slicing.

#### TCP Port Slicing.
![alt text](https://github.com/anguzmar/TFM/blob/master/Images_Readme/mininet_topology_port_slicing.png "Logo Title Text 1")

#### IP Address Slicing.
![alt text](https://github.com/anguzmar/TFM/blob/master/Images_Readme/mininet_topology_IP_slicing.png "Logo Title Text 1")

### Tools Used
Main tools involved in the making of the project.
	+ **Mininet**. I did not have OpenFlow switches I had to rely on emulation.
	+ **FlowVisor**. Open source OpenFlow hipervisor used for the slicing. Pretty outdated but I could not find another open source alternative.
	+ **POX**. OpenFlow controller.


