### Sending Gmail from RHEL9

* switch to root 
```
sudo su -
```

* Install Postfix, the SASL authentication framework, and mailx.
 ```
dnf -y install postfix cyrus-sasl-plain mutt
 ```

* Restart Postfix to detect the SASL framework.
```
systemctl restart postfix 
```

* Start Postfix on boot
```
systemctl enable postfix 
```
* Open the /etc/postfix/main.cf file.
```
vim /etc/postfix/main.cf 
```
append the following into the file at the end

```
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
smtpd_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```
```
1. go to gmail and click on your icon and click on manage google account
2. security and Turn on 2-Step Verification
3. then search google app password in browser
4. type anything then it will genarete a password and remove the spaces between password. like this (hajtnhvckztuhqey)
5. and use the above and paswd in linux to configure 
6. 
```
 
*  Configure Postfix SASL Credentials

Add the Gmail credentials for authentication. Create a "/etc/postfix/sasl_passwd" file
```
touch /etc/postfix/sasl_passwd  
```
Add the following line to the file:
```
vim /etc/postfix/sasl_passwd
```
```
[smtp.gmail.com]:587 xyz@gmail.com:AppPassword
 ```

* Create a Postfix lookup table from the sasl_passwd text file by running the following command:
```
postmap /etc/postfix/sasl_passwd 
```

* Verify Openssl config
```
vim /etc/ssl/openssl.cnf
```
Add the following line under the section `[provider_sect]`
```
legacy = legacy
```
* Sending mail
Run the following command to send mail:
```
echo "This is a test mail & Date $(date)" | mutt -s "message" info@joindevops.com
```
 
