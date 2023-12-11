
### INITIATING TABLE ###

$table = New-Object System.Data.DataTable "OwnersTable"
$col1 = New-Object System.Data.DataColumn PC, ([string])
$col2 = New-Object System.Data.DataColumn Username, ([string])
$col3 = New-Object System.Data.DataColumn Mail, ([string])
$col4 = New-Object System.Data.DataColumn Location, ([string])
$col5 = New-Object System.Data.DataColumn Department, ([string])
$col6 = New-Object System.Data.DataColumn Title, ([string])
$table.Columns.Add($col1)
$table.Columns.Add($col2)
$table.Columns.Add($col3)
$table.Columns.Add($col4)
$table.Columns.Add($col5)
$table.Columns.Add($col6)

### GETTING DATA

$PCList = Get-Content "D:\Scripts\GetUsers\comps.txt" |
ForEach-Object {    
    $PC = Get-ADComputer $_ -Properties Description, Location | Select Name, Description, Location #-Filter 'Enabled -eq $true' -Properties Description | Select Name, Description
    $Username = $PC.Description.Split(";")[0]
    $ADUser =  Get-ADUser $Username -Properties Mail, Title, Department
    #$result += $PC.Name + ";" + $Username + ";" + $ADUser.Mail
    $row = $table.NewRow()
    $row.PC = $PC.Name
    $row.Username = $Username
    $row.Mail = $ADUser.Mail
    $row.Location = $PC.Location
    $row.Title = $ADUser.Title
	$row.Department = $ADUser.Department
    $table.Rows.Add($row)
   }
$table | Export-CSV 'D:\Scripts\GetUsers\owners.csv' -Encoding UTF8