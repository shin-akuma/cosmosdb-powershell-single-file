<#
  Example usage of the single file cosmos powershell funcations
  Replace $PSScriptRoot with relative path if running from an IDE
#>

. "$PSScriptRoot\query-cosmos.ps1"

$CosmosDBEndPoint = "https://xxxx.documents.azure.com:443/"
$DatabaseId = "xxx"
$CollectionId = "xxx"
$MasterKey = $($env:cosmosKey)

$Query = "SELECT * FROM c where c.status = 'active'"

$Result = Query-CosmosDb -EndPoint $CosmosDBEndPoint -DataBaseId $DataBaseId -CollectionId $CollectionId -MasterKey $MasterKey -Query $mapQuery

$obj = @{
  id = $(New-Guid).guid
  pk = 'pk1'
  status = 'active'
}

New-Document -EndPoint $CosmosDBEndPoint -DataBaseId $DataBaseId -ContainerId $CollectionId -MasterKey $MasterKey -ItemId $obj.id -ItemDefinition $($obj | ConvertTo-Json) -PartitionKey $obj.pk

Update-Document -EndPoint $CosmosDBEndPoint -DataBaseId $DataBaseId -ContainerId $CollectionId -MasterKey $MasterKey -ItemId $obj.id -ItemDefinition $($obj | ConvertTo-Json) -PartitionKey $obj.pk
