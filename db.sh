sed -i /etc/resolv.conf -e 's/search=.*/search=demo.telecom-sudparis.eu/g'
yum update && yum -y upgrade;
dnf -y install https://dev.mysql.com/get/mysql57-community-release-fc24-10.noarch.rpm;
dnf -y install mysql-community-server;
hostname db.demo.carp.telecom-suparis.eu 
yum -y install mysql-community-server;
chkconfig mysqld on;
echo "UPDATE mysql.user
    SET authentication_string = PASSWORD('d3m0P4ss++'), password_expired = 'N'
    WHERE User = 'root'; 
FLUSH PRIVILEGES;" > /tmp/mysql_init;
mysqld --skip-grant-tables --skip-networking --user=mysql --init-file=/tmp/mysql_init&
sleep 5;
mysql -u root -pd3m0P4ss++ -e "shutdown";
rm -f /tmp/mysql_init;
service mysqld start;
mysql -u root -pd3m0P4ss++ -e "CREATE DATABASE wp; CREATE USER 'wordpress_user'@'%' IDENTIFIED BY '94-fP+*.pJ'; GRANT ALL PRIVILEGES ON wp.* TO 'wordpress_user'@'%'; FLUSH PRIVILEGES";
iptables-save > /etc/sysconfig/iptables;
sed -i /etc/sysconfig/iptables -e 's/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT\n-A IN_public_allow -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT/g';
iptables-restore < /etc/sysconfig/iptables;
echo "10.0.255.103 web web.demo.telecom-sudparis.eu" >> /etc/hosts;
myip=`curl -s http://whatismyip.host/ | grep -e ipaddress | grep -v N/A | sed -e 's/.*>\(.*\)<.*/\1/'`;

#get db file
## mysql -u root -pd3m0P4ss++ -D < https://raw.githubusercontent.com/jorgelopezcoronado/CARPDemo/master/db.dump

#mysql -u root -pd3m0P4ss++ -e "UPDATE wp_options SET option_value = replace(option_value, 'http://%.%.%.%', 'http://157.159.233.67') WHERE option_name = 'home' OR option_name = 'siteurl';"

