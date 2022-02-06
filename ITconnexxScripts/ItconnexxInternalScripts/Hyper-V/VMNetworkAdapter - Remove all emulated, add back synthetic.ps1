# Title: VMNetworkAdapter - Remove all emulated, add back synthetic
# Author: Bryan Willacker
# Purpose: This script removes all the network adapters from the Hyper-V hosts and
# then adds them back with the configurations noted below

# NOTE: All guest VM's must be shutdown to run this script

# Delete all the network adapters for the VM's on the Hyper-V hosts
Remove-VMNetworkAdapter -VMName * -ComputerName CMSVMH1
Remove-VMNetworkAdapter -VMName * -ComputerName CMSVMH2

# Add back the network adatpers for all VM guests
Add-VMNetworkAdapter -VMName CMSAPP1 -ComputerName CMSVMH1 -SwitchName vSwitch
Add-VMNetworkAdapter -VMName CMSFS1 -ComputerName CMSVMH1 -SwitchName vSwitch
Add-VMNetworkAdapter -VMName CMSHVAC1 -ComputerName CMSVMH1 -SwitchName vSwitch
Add-VMNetworkAdapter -VMName CMSDC1 -ComputerName CMSVMH2 -SwitchName vSwitch
Add-VMNetworkAdapter -VMName CMSMAIL1 -ComputerName CMSVMH2 -SwitchName vSwitch

# Configure the static IP address for the VM guests
$netadapter = Get-NetAdapter -Name Ethernet
$netadapter | Set-NetIPInterface -Dhcp Disabled
$netadapter | New-NetIPAddress -IPAddress 192.168.1.53 -PrefixLength 24 -DefaultGateway 192.168.1.22
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.1.101","192.168.1.11"
