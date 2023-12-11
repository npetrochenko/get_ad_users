$comps = Get-Content comps.txt
ForEach ($comp in $comps) {
    $quser_out = winrs -r:$comp quser
    $split_line = $quser_out -split "`r`n"
    for (($i = 1); $i -lt $split_line.Count; $i++)
        {
        $split_word = $($split_line[$i] -replace '\s', ' ').split()
        Write-Host "$($split_word[1]); $($comp)"
        } 
}