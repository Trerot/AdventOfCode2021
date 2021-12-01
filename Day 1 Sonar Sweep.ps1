$stuff = get-clipboard | where-object { $_ }
    $arraylist = New-Object -TypeName System.Collections.ArrayList
    $previous = 999999
    
    foreach ($item in $stuff) {
        if ([int]$item -gt [int]$previous) {
            [void]$arraylist.add($item)
        }
        $previous = $item
    }
"Answer is $($arraylist.count)"
