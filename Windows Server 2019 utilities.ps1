# Enable SMB1 to joind Windows Server 2003 domain
Enable-WindowsOptionalFeature -Online -FeatureName smb1protocol

# Install Hyper-V role
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart

# Enable ping
Set-NetFirewallRule -Name FPS-ICMP4-ERQ-In -Enabled True
Set-NetFirewallRule -Name FPS-ICMP4-ERQ-Out -Enabled True

# Disable ping
Set-NetFirewallRule -Name FPS-ICMP4-ERQ-In -Enabled False
Set-NetFirewallRule -Name FPS-ICMP4-ERQ-Out -Enabled False

# Enable remoting for connection to Hyper-V Manager
Enable-PSRemoting

# Riga non powershell per abilitare la possibilità di fare lo sharing delle cartelle per copiare le ISO
#netsh advfirewall firewall set rule group=”File and Printer Sharing” new enable=Yes

# Open port for file sharing
Set-NetFirewallRule -Name 'FPS-SMB-In-TCP' -Enabled True

# Command to verify opened ports
Get-NetFirewallRule | Where-Object { $_.Name -like '*FPS*' } | Select-Object Name,Enabled,Direction

# Righe non powershell per join e unjoin al dominio di un server/workstation
# netdom join [computername] /domain:[domain.local] /UserD:[Admin_domain] /PassworD:[Password_domain] /reboot
# netdom remove [computername] /domain:[domain.local] /UserD:[Admin_domain] /PassworD:[Password_domain] /Force /reboot

# Disable net adapter without confirmation (no Yes prompt to reply)
Disable-NetAdapter -Name "Ethernet" -Confirm:$false

