#
#  This PowerShell script shows how to deploy the "DNS forwarder Windows" resource template.
#  As storage account names need to be unique, please edit storageAccName to a value that's available.
#


# parameters 
$rgname = "DnsForwarder"

$params = @{
    "adminUsername"="azureuser";
    "adminPassword"="AdminPass1234!";
    "virtualNetworkName"="";
    "virtualNetworkResourceGroupName"="";
    "virtualNetworkSubnetName"="";
    "upstreamDNSServerIPs"="";
}

#  script folder
$scriptDir = Split-Path $MyInvocation.MyCommand.Path

# import the AzureRM modules
Import-Module AzureRM.Resources

#  login
Login-AzureRmAccount

# create the resource from the template
New-AzureRmResourceGroup -Name $rgname -Location "northeurope"
New-AzureRmResourceGroupDeployment -Name $rgname -ResourceGroupName $rgname -TemplateFile "$scriptDir\azuredeploy.json" -TemplateParameterObject $params

