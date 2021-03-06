$Path = ".\Bin\ocminer-Windows-CCDevices1-Coin\ccminer.exe"
$Uri = "https://github.com/ocminer/suprminer/releases/download/1.5/suprminer-1.5.7z"

if($CCDevices1 -ne ''){$Devices = $CCDevices1}
if($GPUDevices1 -ne ''){$Devices = $GPUDevices1}
$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

#Algorithms:
#x17
#X16r
#X16s

$Commands = [PSCustomObject]@{
    #"PROTON" = '' #x16r
    #"RVN" = '' #x16r
    #"XMN" = '' #x16r
    #"PGN" = '' #x16s
    #"RABBIT" = '' #x16s
    #"REDN" = '' #x16s
    "MARKS" = '' #X17
    "MLM" = '' #X17
    "XSH-x17" = '' #X17
    "XVG" = '' #X17    
}


$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    if($Algorithm -eq "$($Pools.$_.Algorithm)")
     {
    [PSCustomObject]@{
        MinerName = "ccminer"
        Type = "NVIDIA1"
        Path = $Path
        Devices = $Devices
        Arguments = "-a $($Pools.$_.Algorithm) -o stratum+tcp://$($Pools.$_.Host):$($Pools.$_.Port) -b 0.0.0.0:4069 -u $($Pools.$_.User1) -p $($Pools.$_.Pass1) $($Commands.$_)"
        HashRates = [PSCustomObject]@{$_ = $Stats."$($Name)_$($_)_HashRate".Live}
        Selected = [PSCustomObject]@{$($Pools.$_.Algorithm) = ""}
        API = "Ccminer"
        Port = 4069
        Wrap = $false
        URI = $Uri
        BUILD = $Build
         }
     }
  }