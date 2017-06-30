function Get-ptIniFile{
<#
    .SYNOPSIS
        Считывание ini-файла.

    .DESCRIPTION
        Работа с ini-файлом как с объектом со свойствами. 
    
    .EXAMPLE
        Get-ptIniFile -FilePath test.ini
    
    .PARAMETER FilePath
        Путь к ini-файлу

    .NOTES
        Author: maxshalkov
        Date  : 01.07.2017
#>

[cmdletbinding()]
Param(
    [parameter(Mandatory=$true)]
    [string]$FilePath
)

begin{
    if (-not (Test-Path $FilePath)){
        throw "__pt: Указанный файл $FilePath не найден."
    }
} # end begin

process{
    Get-Content $FilePath | Where-Object {$_ -match "^[^;]"} | ForEach-Object {
        $Ini = @{}
    }{
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
    }{
        return $Ini
    }
} # end process

}