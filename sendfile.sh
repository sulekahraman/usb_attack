#!/bin/sh
HOST='00.00.00.000' 	#IP address of server
USER='user'			#Account credentials with server permissions
PASSWD='password'
FILE='file.txt'			#File to put

ftp -n $HOST <<END_SCRIPT
pass
quote USER $USER
quote PASS $PASSWD
put $FILE
quit
END_SCRIPT
exit 0
