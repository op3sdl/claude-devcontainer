#!/bin/bash
set -e

echo "Running post-start setup..."

# VSCode tunnels host SSH agent into container, not secure
/usr/local/bin/remove-vscode-ssh-hole.sh 

# Setup global git hooks (pass current user to configure git for them)
sudo /usr/local/bin/git-hooks-setup.sh "$(whoami)"

# Configure Claude Code CLI plugins
/usr/local/bin/claude-setup.sh

# Initialize firewall rules
sudo /usr/local/bin/init-firewall.sh

echo "Post-start setup complete!"
