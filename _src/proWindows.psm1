#region initialization of module

  $aliases = @{
    'ExpandWindowsImage' =        'ewi'
    'GetWindowsImage' =        	  'gwi'
    'GetWindowsImageIndex' = 	  'gwii'
    'AddWindowsOptionalFeature' = 'awof'
    'AddWindowsPackage' =         'awp'   
  }

#endregion


#region exported variables

#

#region Create Drives
#endregion


#region add custom Data types
#endregion add custom Data Types


# Get public and private function definition files
$Public  = @( Get-ChildItem -path $PSScriptRoot\Public\*.ps1 -errorAction SilentlyContinue )
$Private = @( Get-ChildItem -path $PSScriptRoot\Private\*.ps1 -errorAction SilentlyContinue )


# dot source the files
foreach( $import in @($Public + $Private) )   {
    Try {
        . $import.fullName
    }
    Catch {
        Write-Error -message "Failed to import function $($import.fullName): $_"
    }
}


# create aliases
$functions = $aliases.Keys

foreach( $function in $functions) {

  foreach($alias in $aliases[$function]) {
    New-Alias -name $alias -value $function
  }
}


# initialise  variables
#$knownFolders = Get-SpecialFolders


# Here I might...
    # Read in or create an initial config file and variable
    # Export Public functions ($Public.BaseName) for WIP modules
    # Set variables visible to the module and its functions only
Export-ModuleMember -function $Public.Basename  -variable @() `
                    -alias    ( $aliases.values | 
                                    ForEach-Object{ $_ | 
                                        ForEach-Object{ $_ } 
                                    }
                              )
