# Documenti di riferimento:
# Connect to Exchange Online PowerShell - https://learn.microsoft.com/en-us/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps
# Connect-ExchangeOnline - https://learn.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps
# Disconnect-ExchangeOnline - https://learn.microsoft.com/en-us/powershell/module/exchange/disconnect-exchangeonline?view=exchange-ps

# Eseguire questo comando (con privilegi da amministratore) solo la prima volta che si configura l'accesso in Powershell

Set-ExecutionPolicy RemoteSigned

# Primo passo, registrare le credenziali di accesso ad Exchange Online nella variabile (viene presentata una dialog in cui inserire le credenziali)

$UserCredential = Get-Credential

# Connessione a Exchange Online

Connect-ExchangeOnline -Credential $UserCredential

# Test verifica accesso

Get-Mailbox

# Disconnessione da Exchange Online senza prompt di conferma

Disconnect-ExchangeOnline -Confirm:$false

