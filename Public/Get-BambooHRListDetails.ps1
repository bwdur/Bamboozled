<# ---------------------------------------------------------------------------------------------------------------------------------------
    GET-BAMBOOHRLISTDETAILS
--------------------------------------------------------------------------------------------------------------------------------------- #>

function Get-BambooHRListDetails {
    param(
        [Parameter(Mandatory=$true,Position=0)]$ApiKey,
        [Parameter(Mandatory=$true,Position=1)]$subDomain
    )

    # Force use of TLS1.2 for compatibility with BambooHR's API server. Powershell on Windows defaults to 1.1, which is unsupported
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    
    # API endpoint URL
    $fieldsUrl = "https://api.bamboohr.com/api/gateway.php/{0}/v1/meta/lists/" -f $subDomain

    # Build a BambooHR credential object using the provided API key
    $bambooHRAuth = Get-BambooHRAuth -ApiKey $apiKey

    $headers=@{} 
    $headers.Add("accept", "application/json")
    $headers.Add("authorization", "Basic $bambooHRAuth") 

    # Attempt to connect to the BambooHR API Service
    try
    {
        # Perform the API query
        $bambooHRListDetails = Invoke-WebRequest $fieldsUrl -method GET -Credential $bambooHRAuth -Headers $headers -UseBasicParsing

        # Convert the output to a PowerShell object
        $bambooHRListDetails = $bambooHRListDetails.Content | ConvertFrom-Json
    }
    catch
    {
        throw "Failed to retrieve list details from BambooHR."
    }

    Return $bambooHRListDetails
}
