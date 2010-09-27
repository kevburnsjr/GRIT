# Directory containing git repositories
export GRIT_REPO_DIR=/var/git

# Directory containing public web doc roots
export GRIT_WWW_DIR=/var/www

# Directory containing wildcard VHost config files
# NOTE: see install/example.httpd.conf for wildcard vhost configuration
export GRIT_VHOST_DIR=/var/www/vhosts

# Directory where this script is located
export GRIT_SCRIPT_DIR=`pwd`

# What's the SSH host:port?
export GRIT_HOST=defiance
export GRIT_PORT=30010

# Who is executing this script?
export GRIT_USER=`whoami`

