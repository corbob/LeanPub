function Get-BookInformation {
    <#
    .SYNOPSIS
    Get Book Information
    
    .DESCRIPTION
    Get the Book Information!
    
    .PARAMETER BookSlug
    The slug of the book...
    
    .EXAMPLE
    Get-BookInformation -BookSlug troubleshooting
    
    .NOTES
    It does the thing.
    #>
    [CmdletBinding()]
    param (
        $BookSlug
    )
    
    begin {
        if ([System.Net.ServicePointManager]::SecurityProtocol -notlike "*Tls12*") {
            [System.Net.ServicePointManager]::SecurityProtocol += "Tls12"
        }
    }
    
    process {
        Invoke-RestMethod -Uri "https://leanpub.com/$BookSlug.json"
    }
    
    end {
    }
}

function Get-TimeSinceLastUpdate {
    [CmdletBinding()]
    param (
        $BookSlug,
        [switch]$Full
    )
    $BookInfo = Get-BookInformation -BookSlug $BookSlug
    $now = Get-Date
    $TimeSpan = New-TimeSpan -Start $BookInfo.last_published_at -End $now
    if($Full){
        Write-Output $TimeSpan
    } else {
        Write-Output $TimeSpan | Select-Object Days,Hours,Minutes
    }
}