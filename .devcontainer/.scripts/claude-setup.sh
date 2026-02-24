#!/bin/bash
set -e

# Claude Code CLI plugin setup
# This script runs on container start to configure Claude plugins

echo "Setting up Claude Code CLI plugins..."

if ! claude plugin marketplace list 2>/dev/null | grep -q "obra/superpowers-marketplace"; then
  echo "Adding superpowers marketplace..."
  claude plugin marketplace add obra/superpowers-marketplace
else
  echo "Superpowers marketplace already configured"
fi

# Install or update superpowers plugin
if claude plugin list 2>/dev/null | grep -q "superpowers@superpowers-marketplace"; then
  echo "Updating superpowers plugin..."
  claude plugin update superpowers@superpowers-marketplace || true
else
  echo "Installing superpowers plugin..."
  claude plugin install superpowers@superpowers-marketplace
fi

# Install context7 MCP - up-to-date docs for libs
if claude mcp list 2>/dev/null | grep -q "context7"; then
  echo "Context7 MCP already configured"
else
  if [ -n "$CONTEXT7_MCP_BEARER_TOKEN" ]; then
    echo "Installing Context7 MCP..."
    claude mcp add --header "CONTEXT7_API_KEY: $CONTEXT7_MCP_BEARER_TOKEN" --transport http context7 https://mcp.context7.com/mcp
  else
    echo "Warning: CONTEXT7_MCP_BEARER_TOKEN not set, skipping Context7 MCP setup"
  fi
fi

# Install Socket MCP - security audit for installed packages
if claude mcp list 2>/dev/null | grep -q "socket"; then
  echo "Socket MCP already configured"
else
  echo "Installing Socket MCP..."
  claude mcp add --transport http socket https://mcp.socket.dev
fi

echo "Claude Code CLI plugins configured successfully!"
