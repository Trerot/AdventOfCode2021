$stuff = get-content $env:TEMP\day6.txt
$temparray = New-Object -TypeName System.Collections.ArrayList
($stuff -split ",").ForEach({ $stuffarray.add([int]$_) })



$counter = 0
while ($counter -lt 80) {
    $counter ++
    $stuffarray.ForEach({
            switch ($_) {
                0 { 
                    [void]$temparray.add(6)
                    [void]$temparray.add(8)
                    $temparray.Remove([array]::IndexOf($stuffarray, $_))
                }
                1 {
                    [void]$temparray.add(0)
                    $temparray.Remove([array]::IndexOf($stuffarray, $_))
                }
                2 {
                    [void]$temparray.add(1) 
                    $temparray.Remove([array]::IndexOf($stuffarray, $_))
                }
                3 {
                    [void]$temparray.add(2)
                    $temparray.Remove([array]::IndexOf($stuffarray, $_)) 
                }
                4 {
                    [void]$temparray.add(3)
                    $temparray.Remove([array]::IndexOf($stuffarray, $_)) 
                }
                5 {
                    [void]$temparray.add(4)
                    $temparray.Remove([array]::IndexOf($stuffarray, $_)) 
                }
                6 {
                    [void]$temparray.add(5)
                    $temparray.Remove([array]::IndexOf($stuffarray, $_)) 
                }
                7 {
                    [void]$temparray.add(6)
                    $temparray.Remove([array]::IndexOf($stuffarray, $_)) 
                }
                8 {
                    [void]$temparray.add(7)
                    $temparray.Remove([array]::IndexOf($stuffarray, $_)) 
                }
            }
        })

}

