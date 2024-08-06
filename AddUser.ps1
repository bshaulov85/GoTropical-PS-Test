$ScriptBlock = {
$PWD = ConvertTo-SecureString -String "Script3dUs3rP@$$" -AsPlainText -Force
$Name = "ScriptedUser"
$Description = "Local SysAdmin Account"
$AcctExpiration = (Get-date).AddDays(30).ToString('yyyy-MM-dd')
New-LocalUser -Name $Name -FullName $Name -Description $Description -Password $PWD -AccountExpires:$AcctExpiration -PasswordNeverExpires:$True -Disabled:$False -Confirm:$False
Add-LocalGroupMember -Group "Administrators" -Member "ScriptedUser" -Confirm:$False
}
$Servers = Get-Content C:\Users\Administrator\Servers.txt
ForEach ($Server in $Servers)
	{
	$Server
	Invoke-Command -ComputerName $Server -ScriptBlock $ScriptBlock
	}