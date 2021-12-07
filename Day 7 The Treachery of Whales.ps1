get-puzzleinput -day 7 -year 2021 | set-content $env:TEMP\day7.txt
$stuff = get-content $env:TEMP\day7.txt
$stuffarray = New-Object -TypeName System.Collections.ArrayList
($stuff -split ",").ForEach({ $stuffarray.add([int]$_) })

$measure = ($stuffarray | Measure-Object -AllStats)
$rounddeviation = [math]::round($measure.StandardDeviation)

$calcarray = New-Object -TypeName System.Collections.ArrayList
foreach ($item in $stuffarray) {
    if ($item -ge $rounddeviation) {
        $fuel = $item - $rounddeviation
        $calcarray.Add($fuel)
    }
    if ($item -lt $rounddeviation) {
        $fuel = $rounddeviation - $item
        $calcarray.Add($fuel)
    }
}
$stats = $calcarray | Measure-Object -AllStats
$answer = $stats.sum

#above does not work.

# 350851 is to high
# 335584 is wrong


#this works for the commented out example array and gives me the correct answer. it just doesnt work for the larger data set.
$crabs = get-content $env:TEMP\day7.txt
#$crabs = "16,1,2,0,4,2,7,1,2,14"
$crabarray = New-Object -TypeName System.Collections.ArrayList
($crabs -split ",").ForEach({ [void]$crabarray.add([int]$_) })
$measurecrabs = ($crabarray | Measure-Object -AllStats)
$crabrange = $measurecrabs.Minimum..$measurecrabs.Maximum

$sumarray = New-Object -TypeName System.Collections.ArrayList
$crabrange.foreach({
    $crabnum = [int]$_
    $sum = 0
    $crabarray.ForEach({
        $num = [int]$_
        if($crabnum -ge $num){
            $sum = $sum + $crabnum - $num
        }
        if($num -gt $crabnum){
            $sum = $sum + $num -$crabnum
        }
    })
    $sumarray.add($sum)
})
$sumarray.sort()
$answer = $sumarray[0]