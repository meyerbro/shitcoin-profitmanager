Write-Host "

Shitcoin-Profit Manager created by Bearlyhealz. Free to use, donations kindly accepted. 

ETH Address: 0xA58B04A5Dc2F3934cB54E087b927268836Ac0159
BTC Address: 3Pz3JPxGsQxsyJT7km58NTohC9C16ndpAN

Credit for XMR-Stak goes to fierce-uk at https://github.com/fireice-uk 
Credit for ARTO-Stak goes to Artocash at https://github.com/artocash

Feature requests and suggestions welcomed! :)

"


$Host.UI.RawUI.WindowTitle = "CryptoNight Profit Manager by BearlyHealz"

# Change path to whatever network drive letter you mapped each computer to.
$path = "u:"

# Set a default coin in the event the application wants to mine a coin that you do not have a wallet for.

$default_coin = "XTL"

# How many minutes do you want the miner to run before checking for a new coin?
$mine_minutes = 5
$mine_seconds = ($mine_minutes*60)

#Pull in the computer name from Windows.
$PC = $env:ComputerName

# Set the fixed difficulty for each computer. The computer name MUST be the exact name as it appears in Windows.
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

#Pull in the best coin, parse symbol from json.
$get_coin = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get 
$best_coin = $get_coin.current

#list all the coins you plan to mine ----the symbol MUST match.
$Array = "XTL","XMR","TRTL","GRFT","ITNS","IPBC","TUBE","AEON","XHV","LOKI","ETN","XMV","XRN","ARTO","MSR"

#Check if the best coin to mine is in your list.
if ($best_coin -in $Array.ToUpper())
{}
else
{
Write-Host "The best coin to mine is $best_coin but it's not in your list."
#Choose a default coin to mine if one of the coins listed above is NOT in your list. Prevents the miner from closing when there isn't a match.
$best_coin = $default_coin
$bypass_check = "yes"
}

Write-Host "...Activating Worker on $pc"

#Check folder structure, create missing folders.
if (Test-Path $path\$pc -PathType Container){
Write-Host "...Checking Folder Structure. (OK!)"
}
else
{
Write-Host "...Creating Folder for $pc"
$fso = new-object -ComObject scripting.filesystemobject
$fso.CreateFolder("$path\$pc")
}

Write-Host "...Best Coin to Mine:" $best_coin

# Change my wallet address to YOUR wallets address on each of the following. You can change the pool you use as well; however, refer you will need to change diff_config (bottom of code).

if ($best_coin -eq 'XTL')
{
Set-Variable -Name "miner_type" -Value "xmr-stak"
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
Write-Host "...Authorizing inbound funds to Wallet:"
Write-Host "...$wallet"

# Check for pools.txt file, delete if exists, will create a new one once mining app launches.
if(Test-Path $path\pools.txt)
{
Write-Host "
...Purging old Pools.txt file (OK!)"
del $path\pools.txt
}
else
{
Write-Host "...Could not find Pools.txt file, there is nothing to delete. (OK!)"
}

# These are the default apps used for mining. Updated software can be found at https://github.com/fireice-uk/xmr-stak/releases.
if ($miner_type -eq 'xmr-stak')
{Set-Variable -Name "miner_app" -Value "$path\Miner-XMRstak\xmr-stak.exe"
}
if ($miner_type -eq 'arto-stak')
{Set-Variable -Name "miner_app" -Value "$path\Miner-ArtoMiner\arto-miner.exe"
}

Write-Host "...Setting Mining Application to $miner_app"

# This section establishes a fixed diff for each worker. The format depends on which pool you connect to.
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

# Configure the attributes for the mining software.
$worker_settings = "--poolconf $path\$pc\pools.txt --config $path\config.txt --currency $algo --url $pool --user $wallet$fixed_diff --rigid $pc --pass w=$pc --cpu $path\$pc\cpu.txt --amd $path\$pc\amd.txt --nvidia $path\$pc\nvidia.txt"

Write-Host "...Starting $miner_type in another window."


$get_coin_check = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get
$best_coin_check = $get_coin_check.current

# Start the mining software.
start-process -FilePath $miner_app -args $worker_settings -WindowStyle Minimized

# Establish the date and time
$TimeStart = Get-Date
# Mine for established time, then look to see if there's a new coin.
$TimeEnd = $timeStart.addminutes($mine_minutes)
Write-Host "

Started Worker:       $TimeStart"
write-host "Check Profitiability: $TimeEnd"

# If we are mining the default coin, pause for 5 minutes.
if ($bypass_check -eq 'yes'){
 Write-Host $TimeNow : "Currently mining default coin:"$best_coin ": Checking again at $TimeEnd"
Start-Sleep -Seconds $mine_seconds
}

# Begin a loop to check if the current coin is the best coin to mine. If not, restart the app and switchin coins.
Do { 
 $TimeNow = Get-Date
  if ($TimeNow -ge $TimeEnd) {
  $get_coin_check = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get
  $best_coin_check = $get_coin_check.current
  
  Write-host $TimeNow : "Checking Coin Profitability."
  Write-Host $TimeNow : "Best Coin to Mine:" $best_coin_check
  if ($best_coin -eq $best_coin_check) {
  
  Write-Host $TimeNow : "Sleeping for another" $set_sleep "seconds, then checking again."
  Start-Sleep -Seconds $set_sleep
  }
 } 
 else {
  
  Write-Host $TimeNow : "Currently mining"$best_coin": Checking again at $TimeEnd"
 }
 Start-Sleep -Seconds 60
}
While ($best_coin -eq $best_coin_check)

Write-Host "Profitability has changed, switching now"
Write-Host "Shutting down miner, please wait..... "

# Stop the mining software.
Stop-Process -Name $miner_type

# Sleep for 8 seconds to give the mining software enough time to stop. Adjust this higher or lower depending on your system stability.
Start-Sleep -s 8

#The miner will reload the Powershell file. You can make changes while it's running, and they will be applied on reload.
.\profit_manager-v2.1.0.ps1