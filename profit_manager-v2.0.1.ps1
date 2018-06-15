$Host.UI.RawUI.WindowTitle = "CryptoNight Profit Manager by BearlyHealz"
# Change path to whatever network drive letter you mapped each computer to
$path = "z:"
$get_coin = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get 
$best_coin = $get_coin.current
$PC = $env:ComputerName

#list all the coins you plan to mine ----the symbol MUST match and be UPPERCASE
$Array = "XTL","XMR","TRTL","GRFT","ITNS","IPBC","TUBE","AEON","XHV","LOKI","ETN","XMV","XRN","ARTO","MSR"

if ($best_coin -in $Array)
{}
else
{
Write-Host "The best coin to mine is $best_coin but it's not in your list. $array"
#Choose a default coin to mine if one of the coins listed above is NOT in your list. Prevents the miner from closing when there isn't a match
$best_coin = "XTL"
$bypass_check = "yes"
}

Write-Host "...Activating Worker on $pc"


Write-Host "...Best Coin to Mine:" $best_coin

# Change my wallet address to YOUR wallets address on each of the following. You can change the pool you use as well. 

if ($best_coin -eq 'XTL')
{
Set-Variable -Name "miner_type" -Value "xtl-stak"
Set-Variable -Name "diff_config" -Value "2"
Set-Variable -Name "algo" -Value "Stellite"
Set-Variable -Name "pool" -Value "stellite.ingest.cryptoknight.cc:16222"
Set-Variable -Name "wallet" -Value "Se2vEmzaPTGBieSKQvinp6QdQHYTCvacABsxp5GtMhkjgMAb8QJnvsaQ1jWtUwvYMneuLfuz6iygaD3zM6kt5nq22RqYLh1FK"
}

if ($best_coin -eq 'XMR')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "1"
Set-Variable -Name "algo" -Value "monero7"
Set-Variable -Name "pool" -Value "pool.supportxmr.com:5555"
Set-Variable -Name "wallet" -Value "43u7KBue9bKBpCbihpwFWCbj44gkLLi9o9vUG4skf7qMY8vKQD51MZ6JBBRxQ1WvTXNc93joBQXutK5kznKY4UQRJaXDXcb"
}

if ($best_coin -eq 'TRTL')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "2"
Set-Variable -Name "algo" -Value "cryptonight_lite_v7"
Set-Variable -Name "pool" -Value "trtl.pool.mine2gether.com:1115"
Set-Variable -Name "wallet" -Value "TRTLuyjPitkPVZB82QMh3nAj2hpgUfVz6QrkQWg9aLUmCUMDEaZBAoLSAyDLXDPH5N1bDRKnj6f6Ea1kjUAm7fHf5azmJAbkB6W"
}

if ($best_coin -eq 'GRFT')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "1"
Set-Variable -Name "algo" -Value "monero7"
Set-Variable -Name "pool" -Value "pool.graft.hashvault.pro:5555"
Set-Variable -Name "wallet" -Value "G9H3Q62zqznBi2xRNM994vE7p6TMsswZcTCFXkGD1A8QTHVUVK9kbopEXHiUG63JhBKS2HFd4rnjniXQgM1iTntN4YEpvN4"
}

if ($best_coin -eq 'ITNS')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "1"
Set-Variable -Name "algo" -Value "intense"
Set-Variable -Name "pool" -Value "pool.intense.hashvault.pro:80"
Set-Variable -Name "wallet" -Value "iz5ey7qTRzX4X4tdnjo5YZaLgH48iDvoSBtntRdXmZZHZ9HcqekWxPwauHzgUZBWpZLRXRcYLJy756k893AVPZz13CMprdqHn"
}

if ($best_coin -eq 'IPBC')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "2"
Set-Variable -Name "algo" -Value "ipbc"
Set-Variable -Name "pool" -Value "mining.bit.tube:15555"
Set-Variable -Name "wallet" -Value "bxcdyMoQzF8SvfN9KmbS27JB9TPAZYFrnTPkzvAtXcRvBpEV68DJXiW3v5bz827MfJQfvu9mYSLmXFoCdHWwy3Rh2wvidvFBr"
}

if ($best_coin -eq 'TUBE')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "2"
Set-Variable -Name "algo" -Value "ipbc"
Set-Variable -Name "pool" -Value "mining.bit.tube:15555"
Set-Variable -Name "wallet" -Value "bxcdyMoQzF8SvfN9KmbS27JB9TPAZYFrnTPkzvAtXcRvBpEV68DJXiW3v5bz827MfJQfvu9mYSLmXFoCdHWwy3Rh2wvidvFBr"
}

if ($best_coin -eq 'AEON')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "2"
Set-Variable -Name "algo" -Value "cryptonight_lite_v7"
Set-Variable -Name "pool" -Value "aeon.miner.rocks:5555"
Set-Variable -Name "wallet" -Value "WmsE4nrA3aZaTEW6QKWZiuSuioCmks5fxJeaaFv1DteDb6kFYyVCNP9dwrtcScNiXbPQ9DMXbtrGGg1GThFsbVXJ2VLA8FPHD"
}

if ($best_coin -eq 'XHV')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "2"
Set-Variable -Name "algo" -Value "haven"
Set-Variable -Name "pool" -Value "haven.miner.rocks:5555"
Set-Variable -Name "wallet" -Value "hvxyG9JkYPk36PAdQZkZi8M4MLLRnzS1yYLc5PzMoHwuVdUHKqdio2h5oRCK3Kuiyh1bmF41NgK5LeqMhLmWPVyd6s6GY9GfSe"
}

if ($best_coin -eq 'LOKI')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "2"
Set-Variable -Name "algo" -Value "cryptonight_heavy"
Set-Variable -Name "pool" -Value "haven.miner.rocks:5555"
Set-Variable -Name "wallet" -Value "L8uVMY7dgY1Mj32ok3hWBthyamfvYvYSBFgCmWAEbUsgPZ1i8v1jj44KW4GsFXQC2jA8TwKcbfsT32bzZHvGfueA31owMKL"
}

if ($best_coin -eq 'ETN')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "1"
Set-Variable -Name "algo" -Value "cryptonight_v7"
Set-Variable -Name "pool" -Value "pool.electroneum.hashvault.pro:5555"
Set-Variable -Name "wallet" -Value "etnkBeof5ekf2gXnPiFP2w6aGLiVg2qkuVArAVmRaPNAVj12MGLD6UuBdWmWVLTTtqNNugUBsCuS13QxV6n6a3xx2DC7ZsZV1g"
}

if ($best_coin -eq 'XMV')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "1"
Set-Variable -Name "algo" -Value "cryptonight_v7"
Set-Variable -Name "pool" -Value "xmv-us-west.leafpool.com:9992"
Set-Variable -Name "wallet" -Value "43u7KBue9bKBpCbihpwFWCbj44gkLLi9o9vUG4skf7qMY8vKQD51MZ6JBBRxQ1WvTXNc93joBQXutK5kznKY4UQRJaXDXcb"
}

if ($best_coin -eq 'XRN')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "2"
Set-Variable -Name "algo" -Value "cryptonight_heavy"
Set-Variable -Name "pool" -Value "saronite.miner.rocks:5555"
Set-Variable -Name "wallet" -Value "P2PPcpdAPNR2aKfitjoiFDTJ3qfpzrHv8BcVZnRsAZzn75eMS8CyXrHg8F3BhKsrGZQ57qXVxYs9tjEN6BLjpc6SARMc4bBwAU"
}

if ($best_coin -eq 'ARTO')
{
Set-Variable -Name "miner_type" -Value "arto-stak"
Set-Variable -Name "diff_config" -Value "1"
Set-Variable -Name "algo" -Value "arto"
Set-Variable -Name "pool" -Value "pool.arto.cash:5555"
Set-Variable -Name "wallet" -Value "AEpJ4vaYUQVGjVVGeemF6mhTY4hu1GUChNr3RzdAe2oqYLaAZjprJE4df1s5bV9QuWboehuuM3JirQN8nKiA2wgQJEpX96"
}

if ($best_coin -eq 'MSR')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
Set-Variable -Name "diff_config" -Value "1"
Set-Variable -Name "algo" -Value "masari"
Set-Variable -Name "pool" -Value "pool.masaricoin.com:7777"
Set-Variable -Name "wallet" -Value "5pJLM5hVyASHgC5m1h7axDVNdharEC48dcEmMDNdDTbtVWsj3x7fN5EBc5o5drxQD5C4GAb2hU6CrTQXKfe9yZGyFVyippc"
}



Write-Host "...Establishing connection to:" $pool
Write-Host "...Switching Algo to:" $Algo
Write-Host "...Authorizing inbound funds to Wallet:" $wallet



if(Test-Path $path\pools.txt)
{
Write-Host "...Purging old Pools.txt file (OK!)"
del $path\pools.txt
}
else
{
Write-Host "...Could not find Pools.txt file, there is nothing to delete. (OK!)"
}


# Set the hashrate for each computer. The computer name MUST be the exact name as it appears in Windows.

if ($pc -eq 'GAMINGPC')
{Set-Variable -Name "hashrate" -Value "81000"
}

if ($pc -eq 'MR02')
{Set-Variable -Name "hashrate" -Value "93000"
}

if ($pc -eq 'OGPC01')
{Set-Variable -Name "hashrate" -Value "42000"
}

if ($pc -eq 'MR03')
{Set-Variable -Name "hashrate" -Value "60000"
}

if ($pc -eq 'SERVER')
{Set-Variable -Name "hashrate" -Value "2400"
}

if ($pc -eq 'LAPTOPPC01')
{Set-Variable -Name "hashrate" -Value "300"
}

if ($pc -eq 'DELLPC01')
{Set-Variable -Name "hashrate" -Value "1800"
}


# I use these programs for various reasons.

if ($miner_type -eq 'xtl-stak')
{Set-Variable -Name "miner_app" -Value "$path\Miner-Stellite\xtl-stak.exe"
}
if ($miner_type -eq 'xmr-stak')
{Set-Variable -Name "miner_app" -Value "$path\Miner-XMRstak\xmr-stak.exe"
}
if ($miner_type -eq 'arto-stak')
{Set-Variable -Name "miner_app" -Value "$path\Miner-ArtoMiner\arto-miner.exe"
}

Write-Host "...Setting Mining Application to $miner_app"

if ($diff_config -eq '1')
{Set-Variable -Name "fixed_diff" -Value "+$hashrate"
}
if ($diff_config -eq '2')
{Set-Variable -Name "fixed_diff" -Value ".$hashrate"
}
if ($diff_config -eq '3')
{Set-Variable -Name "fixed_diff" -Value ".$pc+$hashrate"
}
if ($diff_config -eq '4')
{Set-Variable -Name "fixed_diff" -Value ".$pc"
}

Write-Host "...Setting Fixed Diff Config to $fixed_diff"

$worker_settings = "--poolconf $path\pools.txt --config $path\config.txt --currency $algo --url $pool --user $wallet$fixed_diff --rigid $pc --pass w=$pc --cpu $path\$pc\cpu.txt --amd $path\$pc\amd.txt --nvidia $path\$pc\nvidia.txt"

Write-Host "...Starting $miner_type in another window."

start-process -FilePath $miner_app -args $worker_settings
$get_coin_check = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get
$best_coin_check = $get_coin_check.current
$TimeStart = Get-Date
# My default setting is to mine for 5 minutes, then look to see if there's a new coin. You can feel free to change this value.
$TimeEnd = $timeStart.addminutes(5)
Write-Host "Started Worker:       $TimeStart"
write-host "Check Profitiability: $TimeEnd"
Do { 
 $TimeNow = Get-Date
  if ($TimeNow -ge $TimeEnd) {
  $get_coin_check = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get
  $best_coin_check = $get_coin_check.current
  Write-host "...Checking Coin Profitability."
  Write-Host "...Best Coin to Mine:" $best_coin_check
  if ($best_coin -eq $best_coin_check) {
  $set_sleep = "50"
  Write-Host "Sleeping for another" $set_sleep "Seconds"
  Start-Sleep -Seconds $set_sleep
  }
 } 
 else {
  
  Write-Host $TimeNow : "Currently mining"$best_coin": Checking again at $TimeEnd"
 }
 Start-Sleep -Seconds 10
}
While ($best_coin -eq $best_coin_check)
Write-Host "Profitability has changed, switching now"
Write-Host "Shutting down miner, please wait..... "
Stop-Process -Name $miner_type
Start-Sleep -s 8
#The miner will reload the Powershell file. You can make changes while it's running, and they will be applied on reload.
.\profit_manager-v2.0.1.ps1