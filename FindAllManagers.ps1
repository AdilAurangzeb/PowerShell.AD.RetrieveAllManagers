Import-Module ActiveDirectory

$allUsers = Get-ADUser -Filter {enabled -eq "True"} -SearchBase "OU={ENTERDATAHERE},OU=ENTERDATAHERE},OU=ENTERDATAHERE},DC=ENTERDATAHERE},DC=ENTERDATAHERE}" | select-object SamAccountName -expandproperty SamAccountName

$allManagers = @()

foreach($user in $allUsers)
    {
        $data = Get-ADuser $user -property * | select-object Manager
        $manager = ($data.manager -split "," | ConvertFrom-StringData).CN
        $allManagers = $allManagers + $manager
    }

$allManagers = $allManagers | Sort-Object | Get-Unique
Write-Host "Total Managers:" $allManagers.Count
$allManagers | Out-File ".\Managers.txt"
