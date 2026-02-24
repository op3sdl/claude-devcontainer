#!/bin/bash
set -e

# Setup global git hooks to prevent commits/pushes to master branches
echo "Setting up global git hooks..."

HOOKS_DIR="/usr/local/share/git-core/hooks"
TARGET_USER="${1:-node}"

# Create hooks directory (runs as root)
mkdir -p "$HOOKS_DIR"

# Create pre-commit hook
cat > "$HOOKS_DIR/pre-commit" << 'EOF'
#!/bin/bash

# Get current branch name
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

# Block commits to master or main branches
if [ "$BRANCH" = "master" ] || [ "$BRANCH" = "main" ]; then
    echo "ERROR: Direct commits to '$BRANCH' branch are not allowed, create a feature branch instead."
    exit 1
fi

exit 0
EOF

# Create pre-push hook
cat > "$HOOKS_DIR/pre-push" << 'EOF'
#!/bin/bash

# Read stdin for push information
while read local_ref local_sha remote_ref remote_sha
do
    echo "ERROR: Pushes are not allowed, keep changes local."
    exit 1
done

exit 0
EOF

# Make hooks executable
chmod +x "$HOOKS_DIR/pre-commit"
chmod +x "$HOOKS_DIR/pre-push"

# Configure git to use global hooks for the target user
if [ "$(whoami)" = "$TARGET_USER" ]; then
    git config --global core.hooksPath "$HOOKS_DIR"
else
    sudo -u "$TARGET_USER" git config --global core.hooksPath "$HOOKS_DIR"
fi

echo "Global git hooks configured successfully for user: $TARGET_USER"
echo "   - Commits to master/main branches are blocked"
echo "   - Pushes are blocked"
