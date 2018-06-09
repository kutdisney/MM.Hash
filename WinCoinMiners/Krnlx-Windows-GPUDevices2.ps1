$Path = ".\Bin\krnlx-Windows-GPUDevices2\ccminer_x86.exe"
$Uri = "https://github.com/MaynardMiner/Window-Krnlx/releases/download/v1.0/Ccminer_x86_krnlx.zip"

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Devices = $GPUDevices2

#Algorithms:
#Xevan

$Commands = [PSCustomObject]@{
"BSD" = '-i 18' #Xevan
"ELLI" = '-i 18' #Xevan
"ELP" = '-i 18' #Xevan
"HASH" = '-i 18' #Xevan
"KRAIT" = '-i 18' #Xevan
"URALS" = '-i 18' #Xevan
}

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    if($Algorithm -eq "$($Pools.$_.Algorithm)")
     {
	[PSCustomObject]@{
        MinerName = "ccminer"
	Type = "NVIDIA2"
        Path = $Path
	Distro = $Distro
	Devices = $Devices
        Arguments = "-a $($Pools.$_.Algorithm) -o stratum+tcp://$($Pools.$_.Host):$($Pools.$_.Port) -b 0.0.0.0:4070 -u $($Pools.$_.User2) -p $($Pools.$_.Pass2) $($Commands.$_)"
        HashRates = [PSCustomObject]@{$_ = $Stats."$($Name)_$($_)_HashRate".Live}
        API = "Ccminer"
        Port = 4070
        Wrap = $false
        URI = $Uri
	BUILD = $Build
      }
     }
    }
