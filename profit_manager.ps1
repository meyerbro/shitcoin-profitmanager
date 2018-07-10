Function Set-WindowSize {
    Param([int]$x = $host.ui.rawui.windowsize.width,
        [int]$y = $host.ui.rawui.windowsize.heigth)

    $size = New-Object System.Management.Automation.Host.Size($x, $y)
    $host.ui.rawui.WindowSize = $size
}

Set-WindowSize 120 50

Write-Host "
                _______________________________________________________________________________________
                Shitcoin-Profit Manager created by Bearlyhealz. Free to use, donations kindly accepted. 

                ETH Address: 0xA58B04A5Dc2F3934cB54E087b927268836Ac0159
                BTC Address: 3Pz3JPxGsQxsyJT7km58NTohC9C16ndpAN

                Credit for XMR-Stak goes to Fierce-UK at https://github.com/fireice-uk 
                Credit for ARTO-Stak goes to Artocash at https://github.com/artocash

                Feature requests and feedback welcomed! :)

                                        ***** DO NOT RESIZE THIS WINDOW *****
                _______________________________________________________________________________________

"


$Host.UI.RawUI.WindowTitle = "CryptoNight Profit Manager by BearlyHealz v3.2.0"

# Pull in settings from file
$get_settings = Get-Content -Path "settings.conf" | Out-String | ConvertFrom-Json

# Set path parameter
$path = $get_settings.path

# Set a default coin in the event the application wants to mine a coin that you do not have a wallet for.
$default_coin = $get_settings.default_coin
# How many minutes do you want the miner to run before checking for a new coin?
$mine_minutes = $get_settings.mining_timer
$mine_seconds = $mine_seconds = [int]$get_settings.mining_timer * [int]60
$set_sleep = $get_settings.sleep_seconds
$enable_voice = $get_settings.voice
$static_mode = $get_settings.static_mode



#Pull in the computer name from Windows.
$PC = $env:ComputerName

#Pull in the best coin, parse symbol from json.
$get_coin = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get 

if ($static_mode -eq "yes"){
    $best_coin = $default_coin
    $bypass_check = "yes"
}
else {
    $best_coin = $get_coin.current
    $bypass_check = "no"
}


#list all the coins you plan to mine.
$Array = $get_settings.my_coins

#Check if the best coin to mine is in your list.
if ($best_coin -in $Array.ToUpper())
{}
else {
    Write-Host "...The best coin to mine is $best_coin but it's not in your list." -ForegroundColor red
    #Choose a default coin to mine if one of the coins listed above is NOT in your list. Prevents the miner from closing when there isn't a match.
    $best_coin = $default_coin
    $bypass_check = "yes"
}

Write-Host "...Activating Worker on $pc"

# Get information about the GPU, print to screen
Write-Host "...This system has the following GPU's:" -ForegroundColor Yellow
foreach ($gpu in Get-WmiObject Win32_VideoController) {
    Write-Host "  "$gpu.Description
}

#Check folder structure, create missing folders.
if (Test-Path $path\$pc -PathType Container) {
    Write-Host "...Checking Folder Structure. (OK!)" -ForegroundColor green
}
else {
    Write-Host "...Creating Folder for $pc" -ForegroundColor yellow
    $fso = new-object -ComObject scripting.filesystemobject
    $fso.CreateFolder("$path\$pc")
}



Write-Host "...Best Coin to Mine:" $best_coin

# Pull in worker config information from settings.conf

$symbol = $get_settings.mining_params | Where-Object { $_.Symbol -like $best_coin } | Select -ExpandProperty symbol
$miner_type = $get_settings.mining_params | Where-Object { $_.Symbol -like $best_coin } | Select -ExpandProperty software
$diff_config = $get_settings.mining_params | Where-Object { $_.Symbol -like $best_coin } | Select -ExpandProperty static_param
$algo = $get_settings.mining_params | Where-Object { $_.Symbol -like $best_coin } | Select -ExpandProperty algo
$pool = $get_settings.mining_params | Where-Object { $_.Symbol -like $best_coin } | Select -ExpandProperty pool
$wallet = $get_settings.mining_params | Where-Object { $_.Symbol -like $best_coin } | Select -ExpandProperty wallet

Write-Host "...Establishing connection to:" $pool
Write-Host "...Switching Algo to:" $Algo
Write-Host "...Authorizing inbound funds to Wallet:"
Write-Host "   $wallet"

# Verify Diff config file is present

If (Test-Path -Path $Path\$pc\$algo.conf) {
    $set_diff_config = "yes"
    $set_diff_value = Get-Content -Path "$path\$pc\$algo.conf"
    write-host "...Diffuculty config for $algo is present, setting to $set_diff_value" -ForegroundColor green
  
}
else { 
    write-host "...No diffuculty config for $algo is present. We will skip setting a fixed difficulty until next run." -ForegroundColor red
    $set_diff_config = "no"
}

# Check for pools.txt file, delete if exists, will create a new one once mining app launches.
if (Test-Path $path\$pc\pools.txt) {
    Write-Host "
...Purging old Pools.txt file (OK!)"
    del $path\$pc\pools.txt
}
else {
    Write-Host "...Could not find Pools.txt file, there is nothing to delete. (OK!)"
}

# These are the default apps used for mining. Updated software can be found at https://github.com/fireice-uk/xmr-stak/releases.
if ($miner_type -eq 'xmr-stak') {
    Set-Variable -Name "miner_app" -Value "$path\Miner-XMRstak\xmr-stak.exe"
}
if ($miner_type -eq 'arto-stak') {
    Set-Variable -Name "miner_app" -Value "$path\Miner-ArtoMiner\arto-miner.exe"
}
if ($miner_type -eq 'bittube-miner') {
    Set-Variable -Name "miner_app" -Value "$path\Miner-Bittube\bittube-miner.exe"
}

Write-Host "...Setting Mining Application to $miner_app"

# This section establishes a fixed diff for each worker. The format depends on which pool you connect to.
if ($set_diff_config -eq 'yes') {
    if ($diff_config -eq '1') {
        Set-Variable -Name "fixed_diff" -Value "+$set_diff_value"
    }
    if ($diff_config -eq '2') {
        Set-Variable -Name "fixed_diff" -Value ".$set_diff_value"
    }
    if ($diff_config -eq '3') {
        Set-Variable -Name "fixed_diff" -Value ".$pc+$set_diff_value"
    }
    if ($diff_config -eq '4') {
        Set-Variable -Name "fixed_diff" -Value ".$pc"
    }
}
else {
    Set-Variable -Name "fixed_diff" -Value ""
}

# Configure the attributes for the mining software.
$worker_settings = "--poolconf $path\$pc\pools.txt --config $path\config.txt --currency $algo --url $pool --user $wallet$fixed_diff --rigid $pc --pass w=$pc --cpu $path\$pc\cpu.txt --amd $path\$pc\amd.txt --nvidia $path\$pc\nvidia.txt"

Write-Host "...Starting $miner_type in another window."


$get_coin_check = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get
$best_coin_check = $get_coin_check.current

# Start the mining software, wait for the process to begin.
start-process -FilePath $miner_app -args $worker_settings -WindowStyle Minimized
Start-Sleep -Seconds 2
$TimeNow = Get-Date
$check_worker_running = Get-Process $miner_type -ErrorAction SilentlyContinue
if ($check_worker_running -eq $null) { Do {
    write-host $timenow : "Waiting for worker to start...." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
    $check_worker_running = Get-Process $miner_type -ErrorAction SilentlyContinue
} until($check_worker_running -eq $True)  }
# Establish the date and time
$TimeStart = Get-Date
# Mine for established time, then look to see if there's a new coin.
$TimeEnd = $timeStart.addminutes($mine_minutes)
Write-Host "

Started Worker:       $TimeStart" -ForegroundColor Green
write-host "Check Profitiability: $TimeEnd

" -ForegroundColor Green

# If we are mining the default coin, pause for 5 minutes.
if ($bypass_check -eq 'yes') {
    $TimeNow = Get-Date
    Write-Host $TimeNow : "Currently mining default coin: $best_coin : Checking again at $TimeEnd" -ForegroundColor White
    Start-Sleep -Seconds $mine_seconds
}

# Begin a loop to check if the current coin is the best coin to mine. If not, restart the app and switchin coins.
Do { 
    $TimeNow = Get-Date
    if ($TimeNow -ge $TimeEnd) {
        $get_coin_check = Invoke-RestMethod -Uri "https://minecryptonight.net/api/best" -Method Get
        $best_coin_check = $get_coin_check.current
  
        Write-host $TimeNow : "Checking Coin Profitability."
        Write-Host $TimeNow : "Best Coin to Mine:" $best_coin_check -ForegroundColor Yellow
  
        if ($best_coin -eq $best_coin_check) {
  
            Write-Host $TimeNow : "Sleeping for another" $set_sleep "seconds, then checking again."
        }
    }
    else {
  
        Write-Host $TimeNow : "Currently mining $best_coin : Checking again at $TimeEnd."
    }
    # Check if worker url is working, then get the current hashrate from mining software
    $HTTP_Request = [System.Net.WebRequest]::Create('http://127.0.0.1:8080/api.json')
    $HTTP_Response = $HTTP_Request.GetResponse()
    $HTTP_Status = [int]$HTTP_Response.StatusCode

    If ($HTTP_Status -eq 200) {
    }
    Else {
        Write-Host $TimeNow : "Worker is taking a little longer than expected to start." -ForegroundColor Yellow
        Start-Sleep -Seconds $set_sleep
    }
    $HTTP_Response.Close()


    $get_hashrate = Invoke-RestMethod -Uri "http://127.0.0.1:8080/api.json" -Method Get 
    $worker_hashrate = $get_hashrate.hashrate.total[0]
    $my_results = $get_hashrate.results.shares_good
    $suggested_diff = [math]::Round($worker_hashrate * 30)
    if ($worker_hashrate -match "[0-9]") {
        Write-Host $TimeNow : "Worker Hashrate:" $worker_hashrate "H/s, Accepted Shares: $my_results" -ForegroundColor Green
    
    }
    else {
        Write-Host $TimeNow : "Waiting on worker to warm up before displaying hashrate." -ForegroundColor Cyan
    }
  
    Start-Sleep -Seconds $set_sleep
}
While ($best_coin -eq $best_coin_check)

if ($enable_voice -eq 'yes') {
    # Speak the symbol of the coin when switching.
    $speak_coin = ("$best_coin_check" -split "([a-z0-9]{1})"  | ? { $_.length -ne 0 }) -join " "
    Add-Type -AssemblyName System.Speech
    $synthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $synthesizer.Speak("$pc is switching to $speak_coin") | Out-Null
}
If ( Test-Path -Path $Path\$pc\$algo.conf ) {
    write-host $TimeNow : "Diffuculty config for $algo is present, no need to create a new config." -ForegroundColor Green

}
else {
    Write-Host $TimeNow : "Creating difficulty config file for $algo on this worker. We've calulated the fixed difficulty to be $suggested_diff" -ForegroundColor Green
    $suggested_diff | Out-File $path\$pc\$algo.conf
}

if ($bypass_check -eq 'no') {
    Write-Host $TimeNow : "Profitability has changed, switching coins now." -ForegroundColor yellow
}
else {
    Write-Host $TimeNow : "$best_coin_check is not in your list of coins to mine, mining $best_coin for another $mine_minutes minutes." -ForegroundColor yellow
    Start-Sleep -Seconds $mine_seconds
}
Write-Host $TimeNow : "Shutting down miner, please wait..... "   -ForegroundColor yellow

# Stop the mining software.
Stop-Process -Name $miner_type -Force

# Wait for the executable to stop before continuing.
$worker_running = Get-Process $miner_type -ErrorAction SilentlyContinue
if ($worker_running) {
  # try gracefully first
  $worker_running.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$worker_running.HasExited) {
    $worker_running | Stop-Process -Force
  }
}
Remove-Variable worker_running

#The miner will reload the Powershell file. You can make changes while it's running, and they will be applied on reload.
.\profit_manager.ps1