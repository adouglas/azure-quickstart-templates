# Radius VM

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F301-radius-vm-domain-joined%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F301-radius-vm-domain-joined%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template shows how to create a Windows-based NPS RADIUS server which could provide authentication to an Azure Virtual Network Gateway. The VM is domain joined to an AD tenant, allowing users contained within that tenant to be authenticated. To use this template an existing VNet is required, as is an AS domain controller (or AAD DS instance). Once the VM is deployed, the VM IP and RADIUS secret need to be set on the Virtual Network Gateway.

## Example usage
In this example use a VM is deployed to vnet-a with the NPS role installed. Users access the VNet via an Azure Virtual Network Gateway. Authentication is provided through the Gateway via RADIUS. The NPS VM is joined to the domain contoso.com via an AD DS instance hosted in vnet-a.

![Peered AD DS RADIUS](https://github.com/adouglas/azure-quickstart-templates/raw/301-radius-server-ad-joined/301-radius-vm-domain-joined/images/vnet-gateway-radius-auth-adds.png)


## More information
- https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-radiuis-mfa-nsp - Integrate Azure VPN gateway RADIUS authentication with NPS server