
New-WindowsVHD -VHD b:\temp\test.vhdx -sizeBytes 20GB -dynamic:$true -partitionStyle GPT

ExpandWindowsImage `
	-mediaPath W:\ISOs\17004.1000.170922-2229.RS_PRERELEASE_CLIENTCOMBINED_UUP_X64FRE_EN-US\install.wim `
	-wimImageIndex 10 `
	-vhd $(get-vhd B:\temp\test.vhdx) `
	-partitionstyle GPT `
	-windowsOptionalFeature 'Containers'
	
Dismount-VHD -path b:\temp\test.vhdx

