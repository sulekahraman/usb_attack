# Instructions to setup FTP server on Google Compute Engine

1. Create a new vm instance on Google Compute Engine using the Google API or the command line
```
gcloud compute instances create ftp --zone us-central1-a
```

2. ssh into the vm using the Google API or the command line 
```
gcloud compute ssh ftp
```

3.
```
sudo apt-get install vsftpd
```
