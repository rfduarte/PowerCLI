function Add-RDMDisk {
    [CmdletBinding()]
    param ([string]$VMName,
        [string]$CSVPath,
        [ValidateSet("RawPhysical", "RawVirtual")]$DiskType,
        [string]$ControllerName) 
   
    process {
    
        $ScsiLun = Import-Csv $CSVPath
        $VM = Get-VM -Name $VMName
   
        if ($ScsiLun.UniqueID.Count -gt 15) {
            Write-Host -ForegroundColor Yellow "Apenas os 15 primeiros discos serao adicionados"
        }
   
        $ScsiLun.UniqueID[0..14].toLower() | ForEach-Object { 
            New-HardDisk -VM $VM -DiskType $DiskType -Controller $ControllerName -DeviceName /vmfs/devices/disks/naa.$_ 
        }
    }
}