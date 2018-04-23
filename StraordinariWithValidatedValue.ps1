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
$FineStraordinario = "2018-04-17T21:59:00Z"

# Salvo le date e gli orari iniziale e finale dello straordinario provenienti da SharePoint Online
$InizioStraordinarioSPO = $InizioStraordinario
$FineStraordinarioSPO = $FineStraordinario

# Salvo le date iniziale e finale in una stringa con formato yyyy-MM-dd
$dateStart = Get-Date $InizioStraordinario -Format "yyyy-MM-dd"
$dateEnd = Get-Date $FineStraordinario -Format "yyyy-MM-dd"

#$dtOra = [DateTime]::ParseExact($testOra,"yyyy-MM-ddTHH:mm:ssZ",$null)
#$dtOra = $dtOra.ToUniversalTime()
#Write-Host Giorno Iniziale $dateStart Giorno Finale $dateEnd e test utc $testOra


$day = ""
$type = ""

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

# Se il giorno è feriale, normalizzo l'orario degli straordinari in modo che ricadano nei range previsti dallo straordiario feriale
if ($type -eq "Feriale"){
    switch($hStart){
        {$_ -ge 9 -and $_ -lt 13} {
            $dateStart = $dateStart + "T11:00:00Z"
            $dateStart = [datetime]$dateStart
            $InizioStraordinario = $dateStart.ToUniversalTime()
        }
        {$_ -ge 14 -and $_ -lt 18} {
            $dateStart = $dateStart + "T16:00:00Z"
            $dateStart = [datetime]$dateStart
            $InizioStraordinario = $dateStart.ToUniversalTime()            
        }
    }

    switch($hEnd){
        {$_ -gt 9 -and $_ -lt 13} {
            $dateEnd = $dateEnd + "T07:00:00Z"
            $dateEnd = [datetime]$dateEnd
            $FineStraordinario = $dateEnd.ToUniversalTime()
        }
        {$_ -eq 13} {
            $dateEnd = $dateEnd + "T07:" + $minutoEnd + ":00Z"
            $dateEnd = [datetime]$dateEnd
            $FineStraordinario = $dateEnd.ToUniversalTime()            
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

Write-Host Ore Diurne di Straordinario $oreDiurnoFinale Ore Notturne di Straordinario $oreNotturnoFinale