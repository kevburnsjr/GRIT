<VirtualHost *:80>
  ServerName REPO_NAME.hackyhack.net
  DocumentRoot /var/www/REPO_NAME/dev
  Options -Indexes
  ErrorDocument 403 "<h1 style='text-align:center;padding:60px 
0;font-size:100px;'>REPO_NAME.git</$
</VirtualHost>
