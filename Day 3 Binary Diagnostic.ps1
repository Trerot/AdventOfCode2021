#task 1
$stuff = get-puzzleinput -day 3 -year 2021
$stuffconv = $stuff | ConvertFrom-Csv -Header binarynum

$length = $stuffconv.binarynum[0].length 
$range = 0..$($length - 1)

$range.foreach({
        New-Variable -Name "0count-$_" -Value 0 -Force
        New-Variable -Name "1count-$_" -Value 0 -Force
    })

$stuffconv.binarynum.foreach({
        $item = $_
        $range.foreach({
                $rangenum = $_
                switch ($item[$rangenum]) {
                    "0" { Set-Variable -name "0count-$rangenum" -Value ((get-variable -name  "0count-$rangenum").Value + 1) }
                    "1" { Set-Variable -name "1count-$rangenum" -Value ((get-variable -name  "1count-$rangenum").Value + 1) }
                    Default {}
                }
            })
    })
    #this sorting gave me such a bother...
$zero = get-variable -name 0count* | sort-object { [int]($_.name -split "-")[1] }
$one = get-variable -name 1count* | sort-object { [int]($_.name -split "-")[1] }

# getting gammarate
$arraylist = New-Object -TypeName System.Collections.ArrayList
$range.foreach({
        if ($zero[$_].Value -gt $one[$_].Value) {
            $arraylist.add("0")
        }
        else {
            $arraylist.add("1")
        }
    })
$gammarate = -join $arraylist

# getting epsilon rate. which is just reverse realy 
$arraylist = New-Object -TypeName System.Collections.ArrayList
$range.foreach({
        if ($zero[$_].Value -lt $one[$_].Value) {
            $arraylist.add("0")
        }
        else {
            $arraylist.add("1")
        }
    })
$epsilonrate = -join $arraylist

$answer = ([convert]::toint32($epsilonrate, 2)) * ([convert]::toint32($gammarate, 2))

$answer | Set-Clipboard
#task 2