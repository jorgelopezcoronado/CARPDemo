myip=`curl -s http://whatismyip.host/ | grep -e ipaddress | grep -v N/A | sed -e 's/.*>\(.*\)<.*/\1/'`;
mysql -u wordpress_user -p94-fP+*.pJ -h db.demo.carp.telecom-sudparis.eu -D wp -e "UPDATE wp_options SET option_value = replace(option_value, 'http://157.129.233.29/', 'http://$myip/') WHERE option_name = 'home' OR option_name = 'siteurl';";

mysql -u wordpress_user -p94-fP+*.pJ -h db.demo.carp.telecom-sudparis.eu -D wp -e "UPDATE wp_posts SET guid = replace(guid, 'http://157.129.233.29/','http://$myip/');";

mysql -u wordpress_user -p94-fP+*.pJ -h db.demo.carp.telecom-sudparis.eu -D wp -e "UPDATE wp_posts SET post_content = replace(post_content, 'http://157.129.233.29/','http://$myip/');";

mysql -u wordpress_user -p94-fP+*.pJ -h db.demo.carp.telecom-sudparis.eu -D wp -e "UPDATE wp_postmeta SET meta_value = replace(meta_value, 'http://157.129.233.29/','http://$myip/');"; 
