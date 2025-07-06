# Use this command to run the latest version of this script from GitHub:
# iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Aluulu/spicetify-install-script/main/InstallSpicetifyForWindows.ps1'))

$ErrorActionPreference = 'Stop'

$CheckIfSpicetifyIsInstalled = Test-Path -Path "$home\.spicetify"
if ($CheckIfSpicetifyIsInstalled -eq $True) {
    Spicetify backup apply
}
else {

    function RemoveOldSpicetifyInstall {
    Try {
        Remove-Item "$home\.spicetify" -Recurse
    } Catch {
        Write-Host "Unable to remove ~\.spicetify" -foreground Red
        Write-host "Error message is as followed: " -foreground Red
        $Error[0].exception
        $Error[0].Exception.GetType().FullName
    }

    Try {
        Remove-Item "$home\spicetify-cli" -Recurse
    } Catch {
        Write-Host "Unable to remove ~\spicetify-cli" -foreground Red
        Write-host "Error message is as followed: " -foreground Red
        $Error[0].exception
        $Error[0].Exception.GetType().FullName
    }
    } # End of function RemoveOldSpicetifyInstall

    function DownloadSpicetifyScript {
        Try {
            # The try function will try to run the following code, and then catch any errors. 
            Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.ps1" | Invoke-Expression
        }
        Catch {
            Write-Host "Unable to download and run the script from GitHub" -foreground Red # The catch function will catch any specificied error codes. If left blank it will catch ALL errors.
            Write-host "Error message is as followed: " -foreground Red
            $Error[0].exception
            $Error[0].Exception.GetType().FullName
        }
    } # End of function DownloadSpicetifyScript

    RemoveOldSpicetifyInstall
    DownloadSpicetifyScript
} # End if (if CheckIfSpicetifyIsInstalled) check
