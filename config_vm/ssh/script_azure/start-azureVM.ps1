$connectionName = "AzureRunAsConnection"
$servicePrincipalConnection = Get-AutomationConnection -Name $connectionName
$null = Add-AzureRmAccount -ServicePrincipal -TenantId $servicePrincipalConnection.TenantId -ApplicationId $servicePrincipalConnection.ApplicationId -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint
$VMs = Get-AzureRmResource|Where-Object {$_.Tags.Keys -eq "owner" -and $_.Tags.Values -eq "filtox"}
foreach ($VM in $VMs) {
    if ($VM.ResourceType -eq "Microsoft.Compute/virtualMachines") {
        Start-AzureRmVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name -Verbose
    }
}