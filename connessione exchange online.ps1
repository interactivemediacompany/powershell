# Eseguire questo comando (con privilegi da amministratore) solo la prima volta che si configura l'accesso in Powershell

Set-ExecutionPolicy RemoteSigned

# Primo passo, registrare le credenziali di accesso ad Exchange Online nella variabile (viene presentata una dialog in cui inserire le credenziali)

$UserCredential = Get-Credential

# Creare una nuova sessione

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

# Importare la sessione

Import-PSSession $Session

#Per fare un test che tutto sia andato a buon fine, dare un comando, per esempio 

Get-Mailbox

# Una volta finite le operazioni, dare il comando di disconnessione dalla sessione

Remove-PSSession $Session