# Define variables
$downloadUrl = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=251408_0d8f12bc927a4e2c9f8568ca567db4ee"  # This URL needs to be updated if Oracle changes it
$tempFolder = "C:\Temp"
$jreInstaller = "jre_installer.exe"
$javaPath = Join-Path $tempFolder "java.exe"

# Ensure C:\Temp exists
if (-not (Test-Path -Path $tempFolder)) {
    New-Item -Path $tempFolder -ItemType Directory
}

# Download the latest JRE installer
$webClient = New-Object System.Net.WebClient
Write-Host "Downloading the latest Java JRE..."
$installerPath = Join-Path $tempFolder $jreInstaller
$webClient.DownloadFile($downloadUrl, $installerPath)

# Rename the downloaded installer to java.exe
Rename-Item -Path $installerPath -NewName $javaPath

# Install Java silently
Write-Host "Installing Java JRE..."
Start-Process -FilePath $javaPath -ArgumentList "/s" -Wait

# Verify if Java was installed successfully
$javaInstalled = Get-Command "java" -ErrorAction SilentlyContinue
if ($javaInstalled) {
    Write-Host "Java JRE has been installed/updated successfully."
} else {
    Write-Host "Failed to install Java JRE."
}

# Clean up the installer
Remove-Item -Path $javaPath -Force

Write-Host "Download and installation process completed."
