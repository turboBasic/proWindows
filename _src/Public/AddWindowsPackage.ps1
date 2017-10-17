function AddWindowsPackage {
<# 
    .SYNOPSIS 
        Adds a Windows package to an image. 
#>

    ## Source ISO install.wim
    [CmdletBinding()]
	
    param (
        ## Windows packages (.cab) files to add to the image after expansion
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)] 
		[ValidateNotNull()]
        [System.String[]] $Package,

        ## Path to the .cab files
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)] 
		[ValidateNotNullOrEmpty()]
        [System.String] $PackagePath,
        
        ## Mounted VHD(X) Operating System disk drive
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)] 
		[ValidateNotNullOrEmpty()]
        [System.String] $DestinationPath,
        
        ## DISM log path
        [Parameter()] 
		[ValidateNotNullOrEmpty()]
        [System.String] $LogPath = $DestinationPath
    )
	
	
    PROCESS {
        foreach ($packageName in $Package) {
            WriteVerbose ($localized.AddingWindowsPackage -f $packagename, $DestinationPath);
            $packageFilename = '{0}.cab' -f $packageName;
            $packageFilePath = Join-Path -Path $PackagePath -ChildPath $packageFilename;
            AddDiskImagePackage -Name $packageName -Path $packageFilePath -DestinationPath $DestinationPath;
        } #end foreach package
    } #end process
	
} #end function AddWindowsPackage

