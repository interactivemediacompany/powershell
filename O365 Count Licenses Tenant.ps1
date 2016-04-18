# Importa il modulo di Azure Active Direcory
Import-Module MSOnline

# cmdlet per connettersi col servizio online
Connect-MsolService

# Salva nella variabile tutti gli SKU di cui la società è proprietaria
$AccountSku = Get-MsolAccountSku

# Numero di licenze disponibile al Tenant
$AccountSku.Count