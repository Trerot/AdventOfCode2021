#task 1
$stuff = get-puzzleinput -day 3 -year 2021
$stuffconv = $stuff | ConvertFrom-Csv -Header binarynum

$length = $stuffconv.binarynum[0].length 
$range = 0..$($length - 1)

$range.foreach({
        New-Variable -Name "0count_$_" -Value 0 -Force
        New-Variable -Name "1count_$_" -Value 0 -Force
    })

$stuffconv.binarynum.foreach({
        $item = $_
        $range.foreach({
                $rangenum = $_
                switch ($item[$rangenum]) {
                    "0" { Set-Variable -name "0count_$rangenum" -Value ((get-variable -name  "0count_$rangenum").Value + 1) }
                    "1" { Set-Variable -name "1count_$rangenum" -Value ((get-variable -name  "1count_$rangenum").Value + 1) }
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
            [void]$arraylist.add("0")
        }
        else {
            [void]$arraylist.add("1")
        }
    })
$gammarate = -join $arraylist

# getting epsilon rate. which is just reverse realy 
$arraylist = New-Object -TypeName System.Collections.ArrayList
$range.foreach({
        if ($zero[$_].Value -lt $one[$_].Value) {
            [void]$arraylist.add("0")
        }
        else {
            [void]$arraylist.add("1")
        }
    })
$epsilonrate = -join $arraylist

$answer = ([convert]::toint32($epsilonrate, 2)) * ([convert]::toint32($gammarate, 2))

$answer | Set-Clipboard


#task 2


$stuff = get-puzzleinput -day 3 -year 2021
$stuffconv = $stuff | ConvertFrom-Csv -Header binarynum
$array = $stuffconv.binarynum
$filter = New-Object -TypeName System.Collections.ArrayList

function get-numbercount {
    param (
        $array = $array
    )
    process {
        $range.foreach({
                New-Variable -Name "0count_$_" -Value 0 -Force
                New-Variable -Name "1count_$_" -Value 0 -Force
            })
    
        $array.foreach({
                $item = $_
                $range.foreach({
                        $rangenum = $_
                        switch ($item[$rangenum]) {
                            "0" { Set-Variable -name "0count_$rangenum" -Value ((get-variable -name  "0count_$rangenum").Value + 1) }
                            "1" { Set-Variable -name "1count_$rangenum" -Value ((get-variable -name  "1count_$rangenum").Value + 1) }
                            Default {}
                        }
                    })
            })

        $global:zero = get-variable -name 0count* | sort-object { [int]($_.name -split "-")[1] }
        $Global:one = get-variable -name 1count* | sort-object { [int]($_.name -split "-")[1] }
    }
}


function new-arraything {
    param (
        $array,
        $num = 0
    )
    get-numbercount -array $array
    
    if ($one.where({ $_.name -eq "1count_$num" }).value -ge $zero.where({ $_.name -eq "0count_$num" }).value ) {
        [void]$global:filter.add("1")
        $global:array = $array.where({ $_ -like "$(-join $filter)*" })
    }
    else {
        [void]$global:filter.add("0")
        $global:array = $array.where({ $_ -like "$(-join $filter)*" })
    }
}


$array = $stuffconv.binarynum
$filter = New-Object -TypeName System.Collections.ArrayList
(0..11).foreach({
new-arraything -array $array -num $_ -zerosies
})
$little = $array
$little

function new-arraything {
    param (
        $array,
        $num = 0,
        [switch]$onsies,
        [switch]$zerosies
    )
    get-numbercount -array $array
    if($onsies){
        if ($one.where({ $_.name -eq "1count_$num" }).value -ge $zero.where({ $_.name -eq "0count_$num" }).value ) {
            [void]$global:filter.add("1")
            $global:array = $array.where({ $_ -like "$(-join $filter)*" })
        }
        else {
            [void]$global:filter.add("0")
            $global:array = $array.where({ $_ -like "$(-join $filter)*" })
        }
    }
    if($zerosies){
        if ($zero.where({ $_.name -eq "0count_$num" }).value  -ge $one.where({ $_.name -eq "1count_$num" }).value  ) {
            [void]$global:filter.add("0")
            $global:array = $array.where({ $_ -like "$(-join $filter)*" })
        }
        else {
            [void]$global:filter.add("1")
            $global:array = $array.where({ $_ -like "$(-join $filter)*" })
        }
    }

}


$array = $stuffconv.binarynum
$filter = New-Object -TypeName System.Collections.ArrayList
(0..11).foreach({
new-arraything -array $array -num $_
})
$little = $array
$little