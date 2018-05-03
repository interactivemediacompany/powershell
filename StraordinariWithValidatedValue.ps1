<#$workhours = [ordered]@{"0"="Notturno"
               "1"="Notturno"
               "2"="Notturno"
               "3"="Notturno"
               "4"="Notturno"
               "5"="Notturno"
               "6"="Diurno"
               "7"="Diurno"
               "8"="Diurno"
               "9"="Out"
               "10"="Out"
               "11"="Out"
               "12"="Out"
               "13"="Diurno"
               "14"="Out"
               "15"="Out"
               "16"="Out"
               "17"="Out"
               "18"="Diurno"
               "19"="Diurno"
               "20"="Diurno"
               "21"="Notturno"
               "22"="Notturno"
               "23"="Notturno"            
}#>
<# Nel caso fosse necessario, questo va utilizzato per i giorni feriali 
$workhours = [ordered]@{"0"="Notturno"
               "1"="Notturno"
               "2"="Notturno"
               "3"="Notturno"
               "4"="Notturno"
               "5"="Notturno"
               "6"="Notturno"
               "7"="Diurno"
               "8"="Diurno"
               "9"="Diurno"
               "10"="Out"
               "11"="Out"
               "12"="Out"
               "13"="Out"
               "14"="Diurno"
               "15"="Out"
               "16"="Out"
               "17"="Out"
               "18"="Out"
               "19"="Diurno"
               "20"="Diurno"
               "21"="Diurno"
               "22"="Notturno"
               "23"="Notturno"            
}
#>
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
        return $true
    } else {
        return $false
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

# Test date
# $extarworkday = "01/04/2018"
$type = isHoliday ($extarworkday)


$workhours = [ordered]@{"00"="Notturno"
               "01"="Notturno"
               "02"="Notturno"
               "03"="Notturno"
               "04"="Notturno"
               "05"="Notturno"
               "06"="Notturno"
               "07"="Diurno"
               "08"="Diurno"
               "09"="Diurno"
               "10"="Diurno"
               "11"="Diurno"
               "12"="Diurno"
               "13"="Diurno"
               "14"="Diurno"
               "15"="Diurno"
               "16"="Diurno"
               "17"="Diurno"
               "18"="Diurno"
               "19"="Diurno"
               "20"="Diurno"
               "21"="Diurno"
               "22"="Notturno"
               "23"="Notturno"
               "24"="Notturno"            
}




#$InizioStraordinario = "2018-04-17T16:50:00Z"
#$FineStraordinario = "2018-04-17T21:15:00Z"

$InizioStraordinario = "2018-04-17T21:00:00Z"
#$FineStraordinario = "2018-04-17T21:59:00Z"
$FineStraordinario = "2018-04-22T22:00:00Z"

# Salvo le date e gli orari iniziale e finale dello straordinario provenienti da SharePoint Online
$InizioStraordinarioSPO = $InizioStraordinario
$FineStraordinarioSPO = $FineStraordinario

# Salvo le date iniziale e finale in una stringa con formato yyyy-MM-dd: mi serviranno per la comparazione delle date
$dateStart = Get-Date $InizioStraordinario -Format "yyyy-MM-dd"
$dateEnd = Get-Date $FineStraordinario -Format "yyyy-MM-dd"

# Comparo il giorno di inizio e fine straordinario per vedere se sono uno o più giorni
$cmpStart = [datetime]::ParseExact($dateStart,"yyyy-MM-dd",$null)
$cmpEnd = [datetime]::ParseExact($dateEnd,"yyyy-MM-dd",$null)

$daycount = 0

$hashdays = [ordered]@{}

if ($cmpStart -eq $cmpEnd){
    $hashdays.add("InizioStraordinario1",$InizioStraordinario)
    $hashdays.add("FineStraordinario1",$FineStraordinario)
#    $daycount = 1
} else {  
#    $daycount = ($cmpEnd - $cmpStart).Days + 1
    # Conto i giorni di differenza tra inizio e fine straordinario: mi serve per costruire il ciclo e dare i valori nella hash
    $daycount = ($cmpEnd - $cmpStart).Days
    $indexday = 2
    $hashdays.add("InizioStraordinario1",$InizioStraordinario)
    $dateStart = $dateStart + "T23:59:59Z"
    $dateStart = [datetime]$dateStart
#    $InizioStraordinario = $dateStart.ToUniversalTime()
    $hashdays.add("FineStraordinario1",$dateStart)
    $daycycle = $cmpStart.AddDays(1)
    while ($daycount -lt $indexday) {
        $sdayStart = (Get-Date $daycycle -Format "yyyy-MM-dd") + "T00:00:00Z"
        $hashdays.add("InizioStraordinario" + $indexday, $sdayStart)
        $sdayStop = (Get-Date $daycycle -Format "yyyy-MM-dd") + "T23:59:59Z"
        $hashdays.add("Finestraordinario" + $indexday, $sdayStop)
        $daycycle = $daycycle.AddDays(1)
        $indexday = $indexday + 1
    }
    $dateEnd = $dateEnd + "T00:00:00Z"
    $dateEnd = [datetime]$dateEnd
    $hashdays.add("InizioStraordinario" + $daycount, $dateEnd)
    $hashdays.add("FineStraordinario" + $daycount, $FineStraordinario)
}

#$dtOra = [DateTime]::ParseExact($testOra,"yyyy-MM-ddTHH:mm:ssZ",$null)
#$dtOra = $dtOra.ToUniversalTime()
#Write-Host Giorno Iniziale $dateStart Giorno Finale $dateEnd e test utc $testOra


$day = ""
$type = ""

if (isHoliday($cmpStart)){
    $type = "Festivo"
} else {
# Ottengo il giorno raltivo alla data
    $day = (Get-Date $InizioStraordinario).DayOfWeek

    # A seconda del giorno (Feriale, Sabato o Domenica) calcolo un determinato straordinario
    if ($day -eq "Sunday"){
        $type = "Festivo"
    } elseif ($day -eq "Saturday"){
        $type = "Sabato"
    } else {
        $type = "Feriale"
    }
}


# Se il giorno è feriale, normalizzo l'orario degli straordinari in modo che ricadano nei range previsti dallo straordiario feriale
if ($type -eq "Feriale"){
    switch($hStart){
        {$_ -ge 9 -and $_ -lt 13} {
            $dateStart = $dateStart + "T11:00:00Z"
            $dateStart = [datetime]$dateStart
#            $InizioStraordinario = $dateStart.ToUniversalTime()
        }
        {$_ -ge 14 -and $_ -lt 18} {
            $dateStart = $dateStart + "T16:00:00Z"
            $dateStart = [datetime]$dateStart
#            $InizioStraordinario = $dateStart.ToUniversalTime()            
        }
    }

    switch($hEnd){
        {$_ -gt 9 -and $_ -lt 13} {
            $dateEnd = $dateEnd + "T07:00:00Z"
            $dateEnd = [datetime]$dateEnd
#            $FineStraordinario = $dateEnd.ToUniversalTime()
        }
        {$_ -eq 13} {
            $dateEnd = $dateEnd + "T07:" + $minutoEnd + ":00Z"
            $dateEnd = [datetime]$dateEnd
#            $FineStraordinario = $dateEnd.ToUniversalTime()            
        }
        {$_ -eq 14} {
            $dateEnd = $dateEnd + "T08:" + $minutoEnd + ":00Z"
            $dateEnd = [datetime]$dateEnd
            $FineStraordinario = $dateEnd.ToUniversalTime()            
        }
        {$_ -gt 15 -and $_ -le 18} {
            $dateEnd = $dateEnd + "T12:00:00Z"
            $dateEnd = [datetime]$dateEnd
            $FineStraordinario = $dateEnd.ToUniversalTime()            
        }      
    }
}
    <#
    if ($hStart -ge 9 -and $hStart -lt 13){
        $dateStart = $dateStart + "T11:00:00Z"
        $dateStart = [datetime]$dateStart
        $InizioStraordinario = $dateStart.ToUniversalTime()
    } elseif ($hStart -ge 14 -and $hStart -lt 18){
        $dateStart = $dateStart + "T16:00:00Z"
        $dateStart = [datetime]$dateStart
        $InizioStraordinario = $dateStart.ToUniversalTime()
    } 
    if ($hEnd -gt 9 -and $hEnd -lt 13){
        $dateEnd = $dateEnd + "T07:00:00Z"
        $dateEnd = [datetime]$dateEnd
        $FineStraordinario = $dateEnd.ToUniversalTime()
    } elseif ($hEnd -eq 13){
        $dateEnd = $dateEnd + "T07:" + $minutoEnd + ":00Z"
        $dateEnd = [datetime]$dateEnd
        $FineStraordinario = $dateEnd.ToUniversalTime()
    } elseif ($hEnd -eq 14){
        $dateEnd = $dateEnd + "T08:" + $minutoEnd + ":00Z"
        $dateEnd = [datetime]$dateEnd
        $FineStraordinario = $dateEnd.ToUniversalTime()
    } elseif ($hEnd -gt 15 -and $hEnd -le 18) {
        $dateEnd = $dateEnd + "T12:00:00Z"
        $dateEnd = [datetime]$dateEnd
        $FineStraordinario = $dateEnd.ToUniversalTime()
    }
}
#>

<#
if ($type -eq "Feriale"){
    if ($hStart -ge 9 -and $hStart -lt 13){
        $dateStart = $dateStart + "T11:00:00Z"
        $InizioStraordinario = $dateStart.ToUniversalTime()
    } elseif ($hStart -ge 14 -and $hStart -lt 18){
        $dateStart = $dateStart + "T16:00:00Z"
        $InizioStraordinario = $dateStart.ToUniversalTime()
    } elseif ($hEnd -gt 9 -and $hEnd -le 13){
        $dateStart = $dateStart + "T07:00:00Z"
        $FineStraordinario = $dateEnd.ToUniversalTime()
    } elseif ($hEnd -gt 14 -and $hEnd -le 18) {
        $dateStart = $dateStart + "T12:00:00Z"
        $FineStraordinario = $dateEnd.ToUniversalTime()
    }

}
#>
#$testOraInizio = Get-Date $InizioStraordinario -Format "HH"
#$testMinutoInizio = Get-Date $InizioStraordinario -Format "mm"
<#
$mmStart = 0
$mmEnd = 0
$oreNotturno = 2
$oreDiurno = 2
$mmStart = 60
$mmEnd = 15
#>
#$oreDiurnoFinale = Get-Date -Hour $oreDiurno
#$oreNotturnoFinale = Get-Date -Hour $oreNotturno

#$oreDiurnoFinale = Get-Date -Hour $oreDiurno -Minute $mmStart -Format "HH:mm"
#$oreNotturnoFinale = Get-Date -Hour $oreNotturno -Minute $mmEnd -Format "HH:mm"


#$utcDate = (Get-Date $FineStraordinario).AddHours(3)

#Write-Host Ora Inizio $testOraInizio Minuto Inizio $testMinutoInizio
#Write-Host Aggiunta di 3 ore per test giorno seguente $utcDate
#$hStart=2

# Get-Date con -Format "HH" o "mm" restituisce una string, quindi c'è bisogno di un cast ad int per le variabili in modo che sia utilizzabile per le somme in seguito
[int]$hStart = Get-Date $InizioStraordinario -Format "HH"
[int]$hEnd = Get-Date $FineStraordinario -Format "HH"
[int]$minutoStart = Get-Date $InizioStraordinario -Format "mm"
[int]$minutoEnd = Get-Date $FineStraordinario -Format "mm"
$minutoStartType = $workhours[$hStart]
$minutoEndType = $workhours[$hEnd]
$hhStart = 0
#$hhEnd = 0
$mmStart = 0
$mmEnd = 0
$diff = 0
$sommaminuti = 0
$restominuti = 0
$oreNotturno = 0
$oreDiurno = 0

if (($hEnd -eq 23) -and ($minutoEnd -eq 59)){
    $hEnd = 24
    $minutoEnd = 0
}

if ($minutoStart -eq 0){
    $hhStart = $hStart
} else {
    $mmStart = (60-$minutoStart)
    $hhStart = $hStart + 1
}

$mmEnd = $minutoEnd

#Valorizzo la variabile con l'orario di fine straordinario
$key = $hEnd
$diff = $key-$hhStart

# Fino a quando la differenza tra l'orario di fine e inizio straordinario è diversa da 0 faccio un ciclo identifica il tipo di straordinario
while ($diff -gt 0) {
    $key = $key - 1
    if ($workhours[$key+1] -eq "Notturno"){
        $oreNotturno = $oreNotturno + 1
    } else {
        $oreDiurno = $oreDiurno + 1
    }
    $diff = $key - $hhStart
}

if ($minutoStartType -eq $minutoEndType){
    $sommaminuti = $mmStart + $mmEnd
    $restominuti = $sommaminuti % 60   
    if ($restominuti -eq 0){
        $orespare = $sommaminuti / 60
    } else {
        $orespare = ($sommaminuti - $restominuti)/60
    }
    switch ($minutoStartType){
        "Diurno"{
            $oreDiurnoFinale = Get-Date -Hour ($oreDiurno + $orespare) -Minute $restominuti -Format "HH:mm"
            $oreNotturnoFinale = Get-Date -Hour $oreNotturno -Minute 0 -Format "HH:mm"
        }
        "Notturno"{
            $oreDiurnoFinale = Get-Date -Hour $oreDiurno -Minute 0 -Format "HH:mm"
            $oreNotturnoFinale = Get-Date -Hour ($oreNotturno + $orespare) -Minute $restominuti -Format "HH:mm"
        }
    }
} else {
    switch ($minutoStartType){
        "Diurno"{  
            $oreDiurnoFinale = Get-Date -Hour $oreDiurno -Minute $mmStart -Format "HH:mm"
            $oreNotturnoFinale = Get-Date -Hour $oreNotturno -Minute $mmEnd -Format "HH:mm"            
        }
        "Notturno"{
            $oreDiurnoFinale = Get-Date -Hour $oreDiurno -Minute $mmEnd -Format "HH:mm"
            $oreNotturnoFinale = Get-Date -Hour $oreNotturno -Minute $mmStart -Format "HH:mm"            
        }
    }        
}

$hashTojson = [ordered]@{}
$hashTojson.add("OreDiurnoFinale", $oreDiurnoFinale)
$hashTojson.add("OreNotturnoFinale", $oreNotturnoFinale)

Write-Host Ore Diurne di Straordinario $oreDiurnoFinale Ore Notturne di Straordinario $oreNotturnoFinale