# Parameters
$sourceFile = "C:\path\to\your\file.txt"
$destinationFolder = "C:\destination\folder"
$computerListFile = "C:\path\to\computer_list.txt"

# Read computer list from the text file
$computers = Get-Content $computerListFile

foreach ($computer in $computers) {
    # Create the remote path
    $remotePath = "\\$computer\$($destinationFolder.Replace(':', '$'))"

    # Define new file names
    $remoteFile1 = Join-Path $remotePath "session1.txt"
    $remoteFile2 = Join-Path $remotePath "session2.txt"

    # Check if the remote computer is reachable
    if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
        # Copy the file with new names to the remote folder
        Copy-Item -Path $sourceFile -Destination $remoteFile1 -Force
        Copy-Item -Path $sourceFile -Destination $remoteFile2 -Force

        Write-Host "File copied successfully to $computer" -ForegroundColor Green
    } else {
        Write-Host "Unable to reach $computer" -ForegroundColor Red
    }
}
