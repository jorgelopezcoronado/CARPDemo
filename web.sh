yum update && yum -y upgrade;
hostname web.demo.carp.telecom-suparis.eu 
sed -i /etc/resolve -e 's/search=.*/search=demo.telecom-sudparis.eu/g'
yum -y install httpd php php-mysqlnd wget;
chkconfig httpd on;
echo "10.0.255.102 db db.demo.carp.telecom-sudparis.eu" >> /etc/hosts;
iptables-save > /etc/sysconfig/iptables;
sed -i /etc/sysconfig/iptables -e 's/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT\n-A IN_public_allow -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT/g';
iptables-restore < /etc/sysconfig/iptables;
cd /var/www/html;
wget https://wordpress.org/latest.tar.gz;
tar -xzf latest.tar.gz;
cd /var/www/html/wordpress;
cp -p wp-config-sample.php wp-config.php;
sed -i wp-config.php -e 's/database_name_here/wp/';
sed -i wp-config.php -e 's/username_here/wordpress_user/';
sed -i wp-config.php -e 's/password_here/94-fP+*.pJ/';
sed -i wp-config.php -e 's/localhost/db.demo.carp.telecom-sudparis.eu/';
setsebool -P httpd_can_network_connect=1;
sed -i /etc/php.ini -e 's/upload_max_filesize = 2M/upload_max_filesize = 5M/';
chgrp apache wp-content/; 
chmod g+w wp-content/;
service httpd start;
