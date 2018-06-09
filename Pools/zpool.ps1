﻿. .\Include.ps1

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName 
 
 
$Zpool_Request = [PSCustomObject]@{} 
 
 
 try { 
     $Zpool_Request = Invoke-RestMethod "http://www.zpool.ca/api/status" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop 
 } 
 catch { 
     Write-Warning "MM.Hash Contacted ($Name) for a failed API check. "
     return 
 } 
 
 if (($Zpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Measure-Object Name).Count -le 1) { 
     Write-Warning "MM.Hash contacted ($Name) but ($Name) Pool was unreadable. " 
     return
 }     

$Location = "US"

$Zpool_Request | Get-Member -MemberType NoteProperty -ErrorAction Ignore | Select-Object -ExpandProperty Name | Where-Object {$Zpool_Request.$_.hashrate -gt 0} | ForEach-Object {
    $Zpool_Host = "$_.mine.zpool.ca"
    $Zpool_Port = $Zpool_Request.$_.port
    $Zpool_Algorithm = Get-Algorithm $Zpool_Request.$_.name
    $Zpool_Coin = $Zpool_Request.$_.coins
    $Zpool_Fees = $Zpool_Request.$_.fees
    $Zpool_Workers = $Zpool_Request.$_.workers

    $Divisor = 1000000
	
    switch($Zpool_Algorithm)
    {
        "equihash"{$Divisor /= 1000}
        "blake2s"{$Divisor *= 1000}
	    "blakecoin"{$Divisor *= 1000}
        "decred"{$Divisor *= 1000}
	    "x11"{$Divisor *= 100}
	    "keccak"{$Divisor *= 1000}
    }

    if((Get-Stat -Name "$($Name)_$($Zpool_Algorithm)_Profit") -eq $null){$Stat = Set-Stat -Name "$($Name)_$($Zpool_Algorithm)_Profit" -Value ([Double]$Zpool_Request.$_.estimate_last24h/$Divisor*(1-($Zpool_Request.$_.fees/100)))}
    else{$Stat = Set-Stat -Name "$($Name)_$($Zpool_Algorithm)_Profit" -Value ([Double]$Zpool_Request.$_.estimate_current/$Divisor *(1-($Zpool_Request.$_.fees/100)))}


     if($Wallet)
      {
       [PSCustomObject]@{
            Algorithm = $Zpool_Algorithm
            Info = "$Zpool_Coin - Coin(s)"
            Price = $Stat.Live
            Fees = $Zpool_Fees
            Workers = $Zpool_Workers
            StablePrice = $Stat.Week
            MarginOfError = $Stat.Fluctuation
            Protocol = "stratum+tcp"
            Host = $Zpool_Host
            Port = $Zpool_Port
	    User = $Wallet
            User1 = $Wallet1
	    User2 = $Wallet2
	    User3 = $Wallet3
	    User4 = $Wallet4
	    User5 = $Wallet5
	    User6 = $Wallet6
            User7 = $Wallet7
	    User8 = $Wallet8
            Pass = "ID=$RigName,c=$Passwordcurrency"
            Pass1 = "ID=$RigName,c=$Passwordcurrency1"
	    Pass2 = "ID=$RigName,c=$Passwordcurrency2"
	    Pass3 = "ID=$RigName,c=$Passwordcurrency3"
	    Pass4 = "ID=$RigName,c=$Passwordcurrency4"
	    Pass5 = "ID=$RigName,c=$Passwordcurrency5"
	    Pass6 = "ID=$RigName,c=$Passwordcurrency6"
	    Pass7 = "ID=$RigName,c=$Passwordcurrency7"
	    Pass8 = "ID=$RigName,c=$Passwordcurrency8"
            Location = $Location
            SSL = $false
        }
    }
}
