# task 1
$stuff = Get-Clipboard | Where-Object { $_ }
$stuffconv = $stuff | convertfrom-csv -Delimiter " " -Header "direction", "value"

$up = $stuffconv.where({
        $_.direction -eq "up"
    })
$upsum = 0
$up.value.foreach({
        $upsum = $upsum + [int]$_
    })

$down = $stuffconv.where({
        $_.direction -eq "down"
    })
$downsum = 0
$down.value.foreach({
        $downsum = $downsum + [int]$_
    })

$forward = $stuffconv.where({
        $_.direction -eq "forward"
    })
$forwardsum = 0
$forward.value.foreach({
        $forwardsum = $forwardsum + [int]$_
    })

($downsum - $upsum) * $forwardsum | Set-Clipboard


# task 2
$aim = 0
$forward = 0
$depth = 0

foreach ($item in $stuffconv) {
    switch ($item.direction) {
        down { 
            $aim = $aim + [int]$item.value 
        }
        up { 
            $aim = $aim - [int]$item.value 
        }
        forward {
            $forward = $forward + [int]$item.value
            $depth = $depth + ([int]$item.value * $aim)
        }
        Default {}
    }
}
$forward*$depth | Set-Clipboard