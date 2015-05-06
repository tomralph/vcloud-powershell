Param (
[string]
$Cloud
,
[string]
$OrgVdc
,
[string]
$VappT
,
[String]
$User
,
[String]
$Password
,
[String]
$Org
)

Add-PSSnapIn *.Cloud

Connect-CIServer -Server $Cloud -Username $User -Password $Password

$Name = Get-Random

# Make Vapp
New-CIVapp -Name $Name -OrgVdc (Get-Org $Org | get-orgvdc | select-object -Last 1) -VappTemplate (Get-CIVappTemplate -Name $VappT)

# Get what we just made
$Vapp = Get-CIVapp -Name $Name

# Hook up the network
#Get-CIVAppNetwork -VApp $Vapp | Set-CIVappNetwork -ParentOrgNetwork (Get-OrgNetwork -Org $Org)

# Power it on
Get-CIVapp -Name $Name | Start-CIVapp

#Disconnect
Disconnect-CIServer * -Confirm:$False