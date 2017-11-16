########################################################
#  Lokale MPIO-Pfade auswerten  #
#################################

# @autor: Marcel Debray, 16. November 2017
<#
.SYNOPSIS
    Lokale MPIO-Pfade auswerten für den Check_MK Agent
.DESCRIPTION
    Dieses Skript ließtalle lokalen MPIO-Pfade aus und gibt bei weniger als zwei Pfaden Alarm.
.NOTES
    File Name  : mpio.ps1
    Author     : Marcel Debray
    Date       : 16. November 2017
.LINK
    https://zkiwiki.fh-zwickau.de/Netzwerk/Check_MK/Howto_Check_MK

#>

$drives = (gwmi -Namespace root\wmi -Class mpio_disk_info).driveinfo 

if($drives.Count) {
 
    Write-Output `<`<`<local`>`>`> 

     foreach($d in $drives){
        if($d.NumberPaths -eq 0)  {
            $nlevel = 2;
            # Warning bei einem Pfad
        } elseif($d.NumberPaths -eq 1) {
            #Error bei keinem Pfad
            $nlevel = 1;
        } else {
            # OK bei mehr als einem Pfad
            $nlevel = 0;
        }

          Write-Output ("$nlevel MPIO."+$d.SerialNumber+" PfadeAnzahl="+$d.NumberPaths+" MPIO-Speicher mit "+$d.NumberPaths+" aktiven Pfaden") 
     }
   }
