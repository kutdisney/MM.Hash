$Path = '.\Bin\z-enemy-Windows-CCDevices1-Coin\z-enemy.exe'
$URI = 'https://github.com/MaynardMiner/linux-enemy/releases/download/v1.0/z-enemy.1-11-public-final_v3.zip'

if($CCDevices1 -ne ''){$Devices = $CCDevices1}
if($GPUDevices1 -ne ''){$Devices = $GPUDevices1}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

#Algorithms
#X16R
#X16S

$Commands = [PSCustomObject]@{
    "GRV" = '' #x16r
    "PROTON" = '' #x16r
    "RVN" = '' #x16r
    "XMN" = '' #x16r
    "BTNX" = '' #x16s
    "CPR" = '' #x16s
    "PGN" = '' #x16s
    "RABBIT" = '' #x16s
    "REDN" = '' #x16s
    "AEX" = '' #Aergo
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
