# Instructions to setup a FTP server on Google Compute Engine

1. Create a new vm instance on Google Compute Engine using the Google API or the command line
```
gcloud compute instances create ftp --zone us-central1-a
```
2. ssh into the vm using the Google API or the command line 
```
gcloud compute ssh ftp
```
3. Install ftp server for unix-like systems (vsftpd)
```
sudo apt-get install vsftpd
```
4. Generate RSA certificate files
```
openssl genrsa -out server.key 2048
openssl rsa -in server.key -out server.key
openssl req -sha256 -new -key server.key -out server.csr -subj '/CN=localhost'
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt

mv server.crt /etc/ssl/certs/server.crt
mv server.key /etc/ssl/private/server.key
```
5. Configure /etc/vsftpd.conf config file
```
listen=YES
listen_ipv6=NO
anonymous_enable=YES
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES

user_sub_token=$USER
local_root=/home/$USER
chroot_local_user=YES
chroot_list_enable=NO
chown_uploads=YES
allow_writeable_chroot=YES
pam_service_name=vsftpd

rsa_cert_file=/etc/ssl/certs/server.crt
rsa_private_key_file=/etc/ssl/private/server.key
ssl_enable=NO

pasv_enable=YES
pasv_min_port=40000
pasv_max_port=50000
port_enable=YES
pasv_address=34.67.26.213
```
6. Restart vsftpd service and check the status
```
sudo systemctl restart vsftpd
sudo systemctl status vsftpd
```
7. Create user and add permissions
```
sudo adduser ftpuser
chmod a-w /home/ftpuser
```

8. Update networking External IP in Compute Engine console

![](../figures/external_id.png?raw=true)

9. Update firewall rules in [GCP firewall console](https://console.cloud.google.com/networking/firewalls/list) by following the instructions [here](https://cloud.google.com/filestore/docs/configuring-firewall#creating_a_firewall_ingress_rule)

Make sure tcp connection at port `21` (for FTP) and ports `pasv_min_port:pasv_max_port` specified in the `/etc/vsftpd.conf` file are allowed. Don't forget to apply the firewall rule you just created to the VM instance.

![](../figures/gcp_firewall_rules.png?raw=true)

10. Now you can log into the FTP server from any computer on any network using ftp client
```
$ ftp 35.225.115.42

Connected to 35.225.115.42
220 (vsFTPd 3.0.3)
Name (35.225.115.42:piotr): ftpuser
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp>
```



