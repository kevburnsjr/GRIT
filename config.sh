# ==============================================================================
# Directory containing git repositories
# ==============================================================================

GRIT_REPO_DIR=/var/git

# ==============================================================================
# Directory containing public web doc roots
# ==============================================================================

GRIT_WWW_DIR=/var/www

# ==============================================================================
# Directory containing wildcard VHost config files
# ==============================================================================

GRIT_VHOST_DIR=/var/www/vhosts

# ==============================================================================
# Directory where this script is located
# ==============================================================================

GRIT_SCRIPT_DIR=`dirname $0`

# ==============================================================================
# What's the SSH host:port?
# ==============================================================================

GRIT_HOST=hackyhack.net
GRIT_PORT=30010

# ==============================================================================
# Who is executing this script?
# ==============================================================================

GRIT_USER=`whoami`
