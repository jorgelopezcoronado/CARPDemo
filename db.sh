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
service mysqld start && sleep 5 && service mysqld stop;
mysqld --skip-grant-tables --skip-networking --user=mysql --init-file=/tmp/mysql_init&
sleep 5;
mysql -u root -pd3m0P4ss++ -e "shutdown";
service mysqld start;
mysql -u root -pd3m0P4ss++ -e "CREATE DATABASE wp; CREATE USER 'wordpress_user'@'%' IDENTIFIED BY '94-fP+*.pJ'; GRANT ALL PRIVILEGES ON wp.* TO 'wordpress_user'@'%'; FLUSH PRIVILEGES";
iptables-save > /etc/sysconfig/iptables;
sed -i /etc/sysconfig/iptables -e 's/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT\n-A IN_public_allow -p tcp -m tcp --dport 3306 -m conntrack --ctstate NEW -j ACCEPT/g';
iptables-restore < /etc/sysconfig/iptables;
dnf -y install iptables-services;
systemctl mask firewalld.service;
systemctl enable iptables.service;
systemctl enable ip6tables.service;
systemctl stop firewalld.service;
systemctl start iptables.service;
systemctl start ip6tables.service;
echo "10.0.255.151 web web.demo.telecom-sudparis.eu" >> /etc/hosts;
rm -f /tmp/mysql_init;

#get db file
curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/jorgelopezcoronado/CARPDemo/master/db.dump > /tmp/db.dump
mysql -u root -pd3m0P4ss++ -D wp < /tmp/db.dump
rm -f /tmp/db.dump


