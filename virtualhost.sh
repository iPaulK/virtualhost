#!/bin/bash

# Default config
DOMAIN=$1
DIRECTORY=$2
EMAIL='webmaster@localhost'
SITES_ENABLE='/etc/apache2/sites-enabled/'
SITES_AVAILABLE='/etc/apache2/sites-available/'

# Require Sudo
if [ "$(whoami)" != "root" ]; then
    echo "This script must be run as root"
    exit 1
fi

# Enter domain
while [ "$DOMAIN" = "" ]
do
    echo "Please enter domain. E.g. example.local"
    read DOMAIN
done

# Enter dir
while [ "$DIRECTORY" = "" ]
do
    echo "Please enter domain. E.g. /var/www/example.com/"
    read DIRECTORY
done

# Construct absolute path
DOCUMENT_ROOT=$DIRECTORY

# Check if directory exists or not
if [ ! -d "$DOCUMENT_ROOT" ]; then
    # Create the directory
    mkdir $DOCUMENT_ROOT
    # Permission
    chmod 755 $DOCUMENT_ROOT
    # Add index.html file into the new domains web dir
    echo "<html><head></head><body>Hello World!</body></html>" >> "$DOCUMENT_ROOT/index.html"
fi

# Create virtual host rules file
echo "
<VirtualHost *:80>
    ServerAdmin $EMAIL
    ServerName $DOMAIN
    DocumentRoot $DOCUMENT_ROOT
    <Directory $DOCUMENT_ROOT>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/$DOMAIN-error.log
    CustomLog ${APACHE_LOG_DIR}/$DOMAIN-access.log combined
</VirtualHost>" > $SITES_AVAILABLE$DOMAIN.conf

# Add domain to the hosts file
echo "127.0.0.1 	$DOMAIN" >> /etc/hosts

chown -R $(whoami):$(whoami) $DIRECTORY

# Enable the website
a2ensite $DOMAIN

# Restart Apache
service apache2 restart