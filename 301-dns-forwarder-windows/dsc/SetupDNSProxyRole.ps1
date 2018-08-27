# Powershell DSC file to set up:
# - DNS server role
# - DNS forwarding to a comma separated list of IPs
#
Configuration SetupDNSProxyRole
{
  param(
        # The name of the node on whcih to setup the DNS proxy
        [Parameter(Mandatory=$true)]
        [string] $MachineName,

        # A comma separated list of IPs (V4 or V6) to forward DNS queries to
        [Parameter(Mandatory=$true)]
        [string] $UpstreamDNSServerIPs
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

  Node $MachineName
  {

    #Install the DNS Role
    WindowsFeature DNS
    {
      Ensure = "Present"
      Name = "DNS"
      IncludeAllSubFeature = $true
    }

    #Setup Basic DNS Forwarding
    Script SetupDNSForwarding
    {
        # Return the current list of forwarder IPs
        GetScript = {
            $ReturnString = ""

            # Fetch current forwarding IPs
            $CurrentForwarderIPs = Get-DnsServerForwarder | Select -ExpandProperty IPAddress

            # Convert to a comma separated string
            If($CurrentForwarderIPs.Count -gt 0){
            $CurrentForwarderIPs | ForEach {
                    If($ReturnString.Length -gt 0){
                        $ReturnString = $ReturnString + ","
                    }
                    $ReturnString = $ReturnString + $_.IPAddressToString
                }
            }

            return @{ "Result" = "$ReturnString" }
        }

        # Test that the current forwarders are the same as the desired ones
        TestScript = {
            $CurrentForwarderIPsString = ""

            # Fetch current forwarding IPs
            $CurrentForwarderIPs = Get-DnsServerForwarder | Select -ExpandProperty IPAddress

            # Convert to a comma separated string
            If($CurrentForwarderIPs.Count -gt 0){
            $CurrentForwarderIPs | ForEach {
                    If($CurrentForwarderIPsString.Length -gt 0){
                        $CurrentForwarderIPsString = $CurrentForwarderIPsString + ","
                    }
                    $CurrentForwarderIPsString = $CurrentForwarderIPsString + $_.IPAddressToString
                }
            }

            # Remove any extra whitespace from the UpstreamDNSServerIPs string
            $UpstreamDNSServerIPs = $using:UpstreamDNSServerIPs -replace '\s',''

            # Compare the current forwarder IP config with the desired config
            If($UpstreamDNSServerIPs -eq $CurrentForwarderIPsString){
                return $true
            }
            Else{
                return $false
            }
        }

        # Sets the forwarder IPs
        SetScript = {
            # Convert the comma separated string into an array of IPs
            $ForwarderIPs = $using:UpstreamDNSServerIPs -Split ','
            # Forward DNS queries to the IPs
            Set-DnsServerForwarder -IPAddress $ForwarderIPs 
        }
        DependsOn = @("[WindowsFeature]DNS")
    }
  }
} 