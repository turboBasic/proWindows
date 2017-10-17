function AddWindowsOptionalFeature {
<# 
    .SYMOPSIS 
        Enables Windows optional features to an image. 
#>

    [CmdletBinding()]
	
    param (
        ## Source package file path
        [Parameter(Mandatory, ValueFromPipeline)] 
		[ValidateNotNullOrEmpty()]
        [System.String] $ImagePath,
        
        ## Mounted VHD(X) Operating System disk drive
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)] 
		[ValidateNotNullOrEmpty()]
        [System.String] $DestinationPath,
        
        ## Windows packages to add to the image after expansion
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)] 
		[ValidateNotNull()]
        [System.String[]] $WindowsOptionalFeature,
        
        ## DISM log path
        [Parameter()] [ValidateNotNullOrEmpty()]
        [System.String] $LogPath = $DestinationPath
    )
	
	
    PROCESS {
        WriteVerbose ($localized.AddingWindowsFeature -f ($WindowsOptionalFeature -join ','), $DestinationPath);
		
        $enableWindowsOptionalFeatureParams = @{
            Source = $ImagePath;
            Path = $DestinationPath;
            LogPath = $LogPath;
            FeatureName = $WindowsOptionalFeature;
            LimitAccess = $true;
            All = $true;
		}
	}		
	
} #end function AddDiskImageOptionalFeature
