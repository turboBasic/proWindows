function GetDiskImageDriveLetter {
<#
    .SYNOPSIS
        Return a disk image's associated/mounted drive letter.
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [System.Object] $DiskImage,

        [Parameter(Mandatory)]
        [ValidateSet('Basic', 'System', 'IFS')]
        [System.String] $PartitionType
    )
	
	
    PROCESS {

        # Microsoft.Vhd.PowerShell.VirtualHardDisk
        $driveLetter = Get-Partition -diskNumber $DiskImage.DiskNumber |
            Where-Object Type -eq $PartitionType |
                Where-Object DriveLetter |
                    Select-Object -last 1 -expandProperty DriveLetter;

        if (-not $driveLetter) {

            throw ($localized.CannotLocateDiskImageLetter -f $DiskImage.Path);
        }
        return $driveLetter;
    }
	
} #end function