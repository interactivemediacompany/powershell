function isHoliday {
    Param($day)

    $Year = get-date $day -Format "yyyy"

    #Calcolo di Pasqua e Pasquetta

        [int]$a = $Year % 19
        [int]$b = [Math]::Truncate($Year / 100)
        [int]$c = $Year % 100
        [int]$d = [Math]::Truncate($b / 4)
        [int]$e = $b % 4
        [int]$f = [Math]::Truncate(($b + 8) / 25)
        [int]$g = [Math]::Truncate(($b - $f + 1) / 3)
        [int]$h = ((19 * $a) + $b - $d - $g + 15) % 30
        [int]$i = [Math]::Truncate($c / 4)
        [int]$j = $c % 4
        [int]$k = (32 + 2 * ($e + $i) - $h - $j) % 7
        [int]$l = [Math]::Truncate(($a + (11 * $h) + (22 * $k)) / 451)
        [int]$m = [Math]::Truncate(($h + $k - (7 * $l) + 114) / 31)
        [int]$d = (($h + $k - (7 * $l) + 114) % 31) + 1

        $Pasqua = Get-Date -Year $Year -Month $m -Day $d
        $Pasquetta = $Pasqua.AddDays(1)
        $PasquaString = Get-Date $Pasqua -Format "dd/MM"
        $PasquettaString = Get-Date $Pasquetta -Format "dd/MM"

    $holidays =@{"01/01"="Capodanno"
                 "06/01"="Epifania"
                 "25/04"="Festa della Liberazione"
                 "01/05"="Festa dei lavoratori"
                 "02/06"="Festa della Repubblica"
                 "29/06"="Santi Pietro e Paolo"
                 "15/08"="Assunzione di Maria"
                 "01/11"="Festa dei Santi"
                 "08/12"="Immacolata Concezione"
                 "25/12"="Natale"
                 "26/12"="Santo Stefano"
    }

    $holidays.add($PasquaString, "Pasqua")
    $holidays.add($PasquettaString,"Pasquetta")

    $temp = get-date $day -Format "dd/MM"
    if($temp -in $holidays.keys){
        return "Festivo"
    } else {
        return "Non Festivo"
    }

<#
    if($temp -in $holidays.keys){
        write-output $true
    } else {
        write-output $false
    }
    $temp2 = get-date $day
    if ($temp2.DayOfWeek -eq 'Sunday'){
        write-output "$day is Sunday"
    } else {
        Write-Output "$day is not Sunday"
    }    
#>
}

$extarworkday = "01/04/2018"
$type = isHoliday ($extarworkday)
Write-Output $type