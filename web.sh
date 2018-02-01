sed -i /etc/resolv.conf -e 's/search=.*/search=demo.telecom-sudparis.eu/g'
yum update && yum -y upgrade;
hostname web.demo.carp.telecom-suparis.eu;
dnf -y install https://dev.mysql.com/get/mysql57-community-release-fc24-10.noarch.rpm;
dnf -y install mysql-community-client;
yum -y install httpd php php-mysqlnd wget;
chkconfig httpd on;
echo "10.0.255.150 db db.demo.carp.telecom-sudparis.eu" >> /etc/hosts;
iptables-save > /etc/sysconfig/iptables;
sed -i /etc/sysconfig/iptables -e 's/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT\n-A IN_public_allow -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT/g';
iptables-restore < /etc/sysconfig/iptables;
dnf -y install iptables-services;
systemctl mask firewalld.service;
systemctl enable iptables.service;
systemctl enable ip6tables.service;
systemctl stop firewalld.service;
systemctl start iptables.service;
systemctl start ip6tables.service;
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

myip=`curl -s http://whatismyip.host/ | grep -e ipaddress | grep -v N/A | sed -e 's/.*>\(.*\)<.*/\1/'`;
mysql -u wordpress_user -p94-fP+*.pJ -h db.demo.carp.telecom-sudparis.eu -D wp -e "UPDATE wp_options SET option_value = replace(option_value, 'http://157.159.233.62/', 'http://$myip/') WHERE option_name = 'home' OR option_name = 'siteurl';";

mysql -u wordpress_user -p94-fP+*.pJ -h db.demo.carp.telecom-sudparis.eu -D wp -e "UPDATE wp_posts SET guid = replace(guid, 'http://157.159.233.62/','http://$myip/');";

mysql -u wordpress_user -p94-fP+*.pJ -h db.demo.carp.telecom-sudparis.eu -D wp -e "UPDATE wp_posts SET post_content = replace(post_content, 'http://157.159.233.62/','http://$myip/');";

mysql -u wordpress_user -p94-fP+*.pJ -h db.demo.carp.telecom-sudparis.eu -D wp -e "UPDATE wp_postmeta SET meta_value = replace(meta_value, 'http://157.159.233.62/','http://$myip/');"; 
