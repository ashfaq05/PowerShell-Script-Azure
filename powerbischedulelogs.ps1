

#$username = ""
#$passwd = ""


$secpasswd = ConvertTo-SecureString -String $passwd -AsPlainText -Force
$myCred = New-Object Management.Automation.PSCredential ($username, $secpasswd)
Connect-PowerBIServiceAccount -Credential $myCred


$Workspace = Get-PowerBIWorkspace –All

try {
    Invoke-RestMethod ... your parameters here ... 
} catch {
    # Dig into the exception to get the Response details.
    # Note that value__ is not a typo.
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
}

$DataSets =

   ForEach ($workspace in $Workspace)

    {

    Write-Host $workspace.Name

    ForEach ($dataset in (Get-PowerBIDataset -WorkspaceId $workspace.Id))

        {
            #$DataSetsSchedule = Invoke-PowerBIRestMethod -URL "groups/$($workspace.Id)/datasets/$($dataset.Id)/refreshSchedule" -Method GET

            $DataSetsSchedule = Invoke-PowerBIRestMethod -URL "groups/$($workspace.Id)/datasets/$($dataset.Id)/refreshSchedule" -Method GET 


            [pscustomobject]@{

                #WorkspaceName = $Workspace.Name

                #WorkspaceID = $workspace.Id

                #DatasetName = $dataset.Name

                DatasetID = $dataset.Id
                #DataSetsSchedule = $DataSetsSchedule
                DataSetsSchedule = $DataSetsSchedule


           

            }

        }

    }



 $Dir = "D:\l1.csv"

 #$DataSets | ConvertTo-Json  $Dir 

 #convertto-csv -inputobject $date -delimiter ";" -notypeinformation

 #$jsonFilePath = $Dir
 
 #$DataSets | Out-File -FilePath $jsonFilePath -Force
 
 #$DataSets | ConvertTo-Json -depth 100 | Out-File "D:\MyWorkspace6.json"
 $DataSets | Export-Csv $Dir -NoTypeInformation -Encoding UTF8
