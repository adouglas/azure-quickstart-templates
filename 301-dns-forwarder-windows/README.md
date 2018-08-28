# DNS Forwarder VM

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F301-dns-forwarder-windows%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F301-dns-forwarder-windows%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template shows how to create a number of Windows based DNS forwarders in an Availability Set. These can be used to forward DNS queries to any set of DNS servers, by default queries are forwarded to Azure's internal DNS servers. This is useful for enabling the resolution of hostnames for VMs in the virtual network from outside the network (through a Gateway for example).  The bellow example show where this might be useful.

## Example usage

![Peered VNet AD DS DNS](https://github.com/adouglas/azure-quickstart-templates/raw/301-dns-forwarder-windows/301-dns-forwarder-windows/images/peered-vnet-dns-forwarding.png)


## More information
- https://azure.microsoft.com/documentation/articles/virtual-networks-name-resolution-for-vms-and-role-instances/#name-resolution-using-your-own-dns-server - for more details of how DNS resolution work in Azure
