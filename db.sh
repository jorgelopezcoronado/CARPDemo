yum update && yum -y upgrade;
dnf install https://dev.mysql.com/get/mysql57-community-release-fc24-10.noarch.rpm;
dnf install mysql-community-server;
hostname db.demo.carp.telecom-suparis.eu 
sed -i /etc/resolve -e 's/search=.*/ssearch=demo.telecom-sudparis.eu/g'
yum -y install mysql-community-server;
chkconfig mysqld on;
echo "UPDATE mysql.user
    SET authentication_string = PASSWORD('d3m0P4ss++'), password_expired = 'N'
    WHERE User = 'root'; 
FLUSH PRIVILEGES;" > /tmp/mysql_init;
mysqld --skip-grant-tables --skip-networking --user=mysql --init-file=/tmp/mysql_init&
kill -9 `ps -eHf | grep mysqld | grep -v grep | awk '{print $2}'`
rm -f /tmp/mysql_init;
service mysqld start;
mysql -u root -pd3m0P4ss++ -e "CREATE DATABASE wp; CREATE USER 'wordpress_user'@'%' IDENTIFIED BY '94-fP+*.pJ'; GRANT ALL PRIVILEGES ON wp.* TO 'wordpress_user'@'%'; FLUSH PRIVILEGES";
iptables-save > /etc/sysconfig/iptables;
sed -i /etc/sysconfig/iptables -e 's/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT/-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT\n-A IN_public_allow -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT/g';
iptables-restore < /etc/sysconfig/iptables;
service iptables restart;
echo "10.0.255.103 web web.demo.telecom-sudparis.eu" >> /etc/hosts
