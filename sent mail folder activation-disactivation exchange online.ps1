# Per far si che le mail inviate da una cassetta postale condivisa siano salvate anche nella cartella "Posta Inviata" 
# di quest'ultima bisogna dare i seguenti comandi Powershell

# Per mail inviate come "Sent as.."

set-mailbox <mailbox name> -MessageCopyForSentAsEnabled $True

# Per mail inviate come "Sent On Behalf.."

set-mailbox <mailbox name> -MessageCopyForSendOnBehalfEnabled $True

# Per disabilitare queste proprietà

set-mailbox <mailbox name> -MessageCopyForSentAsEnabled $False

set-mailbox <mailbox name> -MessageCopyForSendOnBehalfEnabled $False

# dove <mailbox name> è il nome della cassetta postale condivisa: può essere utilizzato anche l'alias ottenuto con 
# il comando Get-Mailbox