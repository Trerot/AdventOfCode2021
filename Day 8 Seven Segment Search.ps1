#task 1 done 
$stuff = get-puzzleinput -day 8 -year 2021
$stufflinesplit = $stuff.Split("`n")


$stuffsplit = $stufflinesplit.Split("|")


$even = New-Object -TypeName System.Collections.ArrayList
$odd = New-Object -TypeName System.Collections.ArrayList
0..$stuffsplit.count | ForEach-Object { if ($_ % 2 -eq 0) { $even.add($stuffsplit[$_]) } }
0..$stuffsplit.count | ForEach-Object { if ($_ % 2 -eq 1) { $odd.add($stuffsplit[$_]) } }


$oddsplit = $odd -split " "

$num0 = New-Object -TypeName System.Collections.ArrayList
$num1 = New-Object -TypeName System.Collections.ArrayList
$num2 = New-Object -TypeName System.Collections.ArrayList
$num3 = New-Object -TypeName System.Collections.ArrayList
$num4 = New-Object -TypeName System.Collections.ArrayList
$num5 = New-Object -TypeName System.Collections.ArrayList
$num6 = New-Object -TypeName System.Collections.ArrayList
$num7 = New-Object -TypeName System.Collections.ArrayList
$num8 = New-Object -TypeName System.Collections.ArrayList
$num9 = New-Object -TypeName System.Collections.ArrayList


$oddsplit.foreach({
    switch ($_.length) {
        2 {$num1.add($_)  }
        3 {$num7.add($_)}
        4 {$num4.add($_)}
        7 {$num8.add($_)}
        Default {}
    }
})
$sum = 0
(Get-Variable -name num*).foreach({$sum = $sum + $_.value.count})
$sum

#task two after work. maybe later if i have the time. 