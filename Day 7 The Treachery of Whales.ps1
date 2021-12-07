
$test = get-puzzleinput -day 7 -year 2021
$crabs = New-Object -TypeName System.Collections.ArrayList
($test -split ",").foreach({ $crabs.add($_) })

$crabarray = $crabs
$measurecrabs = ($crabarray | Measure-Object -AllStats)
$crabrange = $measurecrabs.Minimum..$measurecrabs.Maximum

$sumarray = New-Object -TypeName System.Collections.ArrayList
$crabrange.foreach({
        $crabnum = [int]$_
        $sum = 0
        $crabarray.ForEach({
                $num = [int]$_
                if ($crabnum -ge $num) {
                    $sum = $sum + $crabnum - $num
                }
                if ($num -gt $crabnum) {
                    $sum = $sum + $num - $crabnum
                }
            })
        $sumarray.add($sum)
    })
$sumarray.sort()
$answer = $sumarray[0]

#task 2 
# had to do some stuff because above method was to slow.
$test = get-puzzleinput -day 7 -year 2021
$crabs = New-Object -TypeName System.Collections.ArrayList
($test -split ",").foreach({ $crabs.add([int]$_) })
$test.count
$measurement = $crabs | Measure-Object -AllStats
$range = $measurement.Minimum..$measurement.Maximum
$range.foreach({
        New-Variable -name "counter_$_" -Value $([int64]0) -Force
    })
$crabs.sort()

$crabs.ForEach({
        $item = $_
        Set-Variable -Name "counter_$item" -Value $((Get-Variable -name "counter_$item" -ValueOnly) + 1)
    })
$counterhash = @{}
$arraylist = New-Object -TypeName System.Collections.ArrayList
(get-variable -Name counter_*).foreach({
        $key = [int]($_.name -replace "counter_", "")
        $value = $_.value
        $counterhash.Add($key, $value)
    })
$sumarray = New-Object -TypeName System.Collections.ArrayList
$range.foreach({
    $crabnum = [Int64]$_
    $sum = [int64]0
    $counterhash.Keys.ForEach({
        $crabkey = $_
        $crabamount = $counterhash.$_
        $distance = [math]::abs($crabnum - $crabkey)
        $sum = $sum + (($distance*($distance+1)/2)*$crabamount)
        })
    $sumarray.add($sum)
})
$sumarray.sort()
$answer = $sumarray[0]