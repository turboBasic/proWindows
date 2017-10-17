@{
    # Some defaults for all dependencies
    PSDependOptions = @{
        Target = 'c:\Users\mao\WindowsPowershell\Modules'
        AddToPath = $True
    }

    'psake' =            @{ DependencyType = 'psGalleryModule' }
    'psDeploy' =         @{ DependencyType = 'psGalleryModule' }
#   'psScriptAnalyzer' = @{ DependencyType = 'psGalleryModule' }
#   'BuildHelpers' =     @{ DependencyType = 'psGalleryModule' }
<#  'Pester' =           @{ DependencyType = 'psGalleryModule'
                            Version = '4.0.4'
                          }
#>
}