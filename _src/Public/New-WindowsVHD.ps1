function New-WindowsVHD {
<# 
    .SYNOPSIS 
Creates VHD/(X) file, initializes, creates partitions, formats volumes on VHD(X). 
Leaves VHD(x) in mounted state.
		
	.EXAMPLE
New-WindowsVHD -vhd b:\test\wadk.vhdx -size 20GB -partitionStyle MBR
			
#>

    [CmdletBinding()]
    Param (
		[Parameter(Mandatory, ValueFromPipelineByPropertyName)] 
		[ValidateNotNull()]
        [string] $Vhd,
		
		[Parameter()]
		[switch] $dynamic = $True,
		
		[Parameter(Mandatory, ValueFromPipelineByPropertyName)] 
		[ValidateScript( { $_ -ge 8GB } )]
        [long] $sizeBytes,
		
		[Parameter(ValueFromPipelineByPropertyName)] 
		[ValidateSet('MBR','GPT')]
        [string] $partitionStyle = $(
			if ($Vhd -like '*.vhdx') {
				'GPT'
			} else {
				'MBR'
			}
		),
		
		[Parameter(ValueFromPipelineByPropertyName)] 
		[ValidateSet('NTFS','FAT32')]
        [string] $fileSystem = 'NTFS',
		
		[Parameter(ValueFromPipelineByPropertyName)] 
        [string] $volumeLabel = ''
	)

	$dynamic | Write-Verbose
	New-VHD -path $Vhd -dynamic:$dynamic -sizeBytes $sizeBytes | 
		Mount-VHD -passthru | 
		Initialize-Disk -partitionStyle $partitionStyle -passthru | 
		New-Partition -assignDriveLetter -useMaximumSize -outVariable Letter |
		Format-Volume -fileSystem $fileSystem -newFileSystemLabel $volumeLabel -confirm:$false -force
		
}