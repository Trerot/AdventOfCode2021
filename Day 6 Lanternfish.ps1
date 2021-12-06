$stuff = get-puzzleinput -day 6 -year 2021
#create initial array
$stuffarraylist = New-Object -TypeName System.Collections.ArrayList
($stuff.split(',') | % { iex $_ }).foreach({ [void]$stuffarraylist.add($_) })

$counter = 0
while ($counter -lt 80) {
    $newarraylist = New-Object -TypeName System.Collections.ArrayList
    $stuffarraylist.foreach({
            switch ($_) {
                0 {
                    [void]$newarraylist.add(6)
                    [void]$newarraylist.add(8)
                }
                Default { [void]$newarraylist.add($_-1) }
            }
        })
        $stuffarraylist = $newarraylist
    $counter ++
    $counter
}

$answer = $stuffarraylist.count
