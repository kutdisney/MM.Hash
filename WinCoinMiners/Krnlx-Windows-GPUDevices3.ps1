$Path = ".\Bin\krnlx-Windows-GPUDevices3\ccminer_x86.exe"
$Uri = "https://github.com/MaynardMiner/Window-Krnlx/releases/download/v1.0/Ccminer_x86_krnlx.zip"

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Devices = $GPUDevices3

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
        Type = "NVIDIA3"
        Path = $Path
        Distro = $Distro
        Devices = $Devices
        Arguments = "-a $($Pools.$_.Algorithm) -o stratum+tcp://$($Pools.$_.Host):$($Pools.$_.Port) -b 0.0.0.0:4071 -u $($Pools.$_.User3) -p $($Pools.$_.Pass3) $($Commands.$_)"
        HashRates = [PSCustomObject]@{$_ = $Stats."$($Name)_$($_)_HashRate".Live}
   API = "Ccminer"
        Port = 4071
        Wrap = $false
        URI = $Uri
        BUILD = $Build
      }
     }
    }
