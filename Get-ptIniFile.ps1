function Get-ptIniFile{

    [cmdletbinding()]
    Param(

        [parameter(Mandatory=$true)]
        [string]$FilePath

    )

    Begin{
        $Ini = @{}
    }
    
    Process{
        Get-Content $FilePath | Where-Object {$_ -match "^[^;]"} | ForEach-Object {
            switch ($_){
                {$_ -match "\["} {
                    $Head = $_ -replace "\[|\]" 
                    $Ini[$Head] = @()
                    return
                }

                {$Head -ne $null} {
                    $Ini[$Head] += ,$_
                }
            }
        }
    }

    End{
        return $Ini
    }
}