$Path = '.\Bin\MSFTserver\6'
$Uri = 'https://github.com/MSFTserver/ccminer.git'
$Build = "Linux-Clean"
$Distro = "Linux"

if($CCDevices3 -ne ''){$Devices = $CCDevices3}
if($GPUDevices3 -ne ''){$Devices = $GPUDevices3}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

#Algorithms:
#Lyra2z
#Bitcore
#Hmq1725
#Timetravel

$Commands = [PSCustomObject]@{

    "Lyra2z" = ''
    "Bitcore" = ''
    "Hmq1725" = ''
    "Timetravel" = ''

}

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    if($Algorithm -eq $($Pools.(Get-Algo($_)).Coin))
    {       
        [PSCustomObject]@{
        MinerName = "ccminer"
	    Type = "NVIDIA3"
        Path = $Path
	    Distro = $Distro
	    Devices = $Devices
        Arguments = "-a $_ -o stratum+tcp://$($Pools.(Get-Algo($_)).Host):$($Pools.(Get-Algo($_)).Port) -b 0.0.0.0:4071 -u $($Pools.(Get-Algo($_)).User3) -p $($Pools.(Get-Algo($_)).Pass3) $($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algo($_)) = $Stats."$($Name)_$(Get-Algo($_))_HashRate".Live}
	    Selected = [PSCustomObject]@{(Get-Algo($_)) = ""}
	    Port = 4071
        API = "Ccminer"
        Wrap = $false
        URI = $Uri
        BUILD = $Build
        }
      }
}
