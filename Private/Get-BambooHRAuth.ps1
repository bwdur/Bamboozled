<# ---------------------------------------------------------------------------------------------------------------------------------------
    GET-BAMBOOHRAUTH
--------------------------------------------------------------------------------------------------------------------------------------- #>

function Get-BambooHRAuth {
    param(
        [Parameter(Mandatory=$true,Position=0)]$ApiKey
    )

    $token = $apikey + ":" + "x"
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($token)
    $base64 = [System.Convert]::ToBase64String($bytes)
    Return $base64
}