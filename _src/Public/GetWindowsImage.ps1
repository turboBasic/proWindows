function GetWindowsImageName {
<# 
    .SYNOPSIS 
        Locates the specified WIM image name by its index. 
#>

    [CmdletBinding()]
    [OutputType([System.String])]
	
    param (
        # WIM image path
        [Parameter(Mandatory, ValueFromPipeline)] 
		[ValidateNotNullOrEmpty()]
        [System.String] $ImagePath,
        
        # Windows image index
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)] 
		[ValidateNotNullOrEmpty()]
        [System.Int32] $ImageIndex
    )
	
	
    PROCESS {
        WriteVerbose ($localized.LocatingWimImageName -f $ImageIndex);
        Get-WindowsImage -imagePath $ImagePath -verbose:$false |
            Where-Object ImageIndex -eq $ImageIndex |
                Select-Object -expandProperty ImageName;
    } #end process
	
	
} #end function GetWindowsImageName