$Path = ".\Bin\EWBF-Windows-EWBFDevices1-Coin\miner.exe"
$Uri = "https://github.com/MaynardMiner/EWB/releases/download/v1.0/EWBF.Equihash.miner.v0.3.zip"

if($EWBFDevices1 -ne ''){$Devices = $EWBFDevices1}
if($GPUDevices1 -ne '')
 {
  $GPUEDevices1 = $GPUDevices1 -replace ',',' '
  $Devices = $GPUEDevices1
 }

$Commands = [PSCustomObject]@{
"VOT" = ''
"CMM" = ''
}


$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
  if($Algorithm -eq "$($Pools.$_.Algorithm)")
  {
    [PSCustomObject]@{
	    MinerName = "miner"
        Type = "NVIDIA1"
        Path = $Path
	      Distro =  $Distro
	      Devices = $Devices
        Arguments = "--algo 192_7 --pers ZERO_PoW --api 0.0.0.0:42001 --server $($Pools.$_.Host) --port $($Pools.$_.Port) --user $($Pools.$_.User1) --pass $($Pools.$_.Pass1) $($Commands.$_)"
        HashRates = [PSCustomObject]@{$_ = $Stats."$($Name)_$($_)_HashRate".Live}
        Selected = [PSCustomObject]@{$($Pools.$_.Algorithm) = ""}
        API = "EWBF"
        Port = 42001
        Wrap = $false
        URI = $Uri
        BUILD = $Build
      }
    }
}
