﻿# Per far si che le mail inviate da una cassetta postale condivisa siano salvate anche nella cartella "Posta Inviata" 
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

# Per disabilitare l'autodiscover di una mailbox condivisa, in modo che non compaia nel client, dare questi 2 comandi
# dove [shared mailbox] è l'indirizzo condiviso e [user mailbox] è l'indirizzo dell'utente su cui deve essere disabilitato
# l'autodiscover per quella particolare mail condivisa
# Documento di riferimento Powershell: https://docs.microsoft.com/it-it/powershell/module/exchange/add-mailboxpermission?view=exchange-ps
# Articolo di riferimento: https://learn.microsoft.com/en-us/outlook/troubleshoot/profiles-and-accounts/remove-automapping-for-shared-mailbox
# Articolo per fare enable e disable dell'automapping:https://www.easy365manager.com/how-to-enable-or-disable-automapping-of-shared-mailbox-in-office-365/ 

Remove-MailboxPermission -Identity [shared mailbox] -User [user mailbox] -AccessRights FullAccess

Add-MailboxPermission -Identity [shared mailbox] -User [user mailbox] -AccessRights FullAccess -AutoMapping:$false

