# Articolo di riferimento: https://repost.aws/knowledge-center/data-integrity-s3
# Otteniamo prima l'hash in SHA256, dove [path] è il percorso del file locale (esempio: '.\MAC addresses.txt')
Get-FileHash [path] '.\MAC addresses.txt' | Format-List

# Inseriamo il valore nella variabile $hashString
$hashString = 'valore'

# Trasformiamo il valore in Byte Array
$hashByteArray = [byte[]] ($hashString -replace '..', '0x$&,' -split ',' -ne '')

# Converto il valore in Base64
$ContentSHA256 = [System.Convert]::ToBase64String($hashByteArray)

# Stampo a video il contenuto, che è il mio hash da confrontare con quello del file su AWS
Echo $ContentSHA256
