#!/bin/bash

# Setup script for the devcotainer host
# Run this script from the repository root once after cloning the repo

set -e

echo "Setting up container workspace"

if [ ! -d "workspace/.claude" ]; then
    cp -r ".claude" "workspace/.claude"
    echo "Copied local .claude settings to workspace"
else
    echo "workspace/.claude already exists, skipping"
fi

echo "Copying templates for human-in-the-loop mode to workspace"
if [ ! -f "workspace/CLAUDE.md" ]; then
    cp "CLAUDE.md" "workspace/CLAUDE.md"
    echo "Copied CLAUDE.md to workspace"
else
    echo "workspace/CLAUDE.md already exists, skipping"
fi

if [ ! -f "workspace/PROMPT.md" ]; then
    cp "PROMPT_TEMPLATE.md" "workspace/PROMPT.md"
    echo "Copied PROMPT_TEMPLATE.md to workspace/PROMPT.md"
else
    echo "workspace/PROMPT.md already Nexists, skipping"
fi

echo "Copying templates for ralph mode to workspace"
if [ ! -f "workspace/RALPH_PROMPT.md" ]; then
    cp "RALPH_PROMPT_TEMPLATE.md" "workspace/RALPH_PROMPT.md"
    echo "Copied RALPH_PROMPT_TEMPLATE.md to workspace/RALPH_PROMPT.md"
else
    echo "workspace/RALPH_PROMPT.md already exists, skipping"
fi

if [ ! -f "workspace/RALPH_PRD.md" ]; then
    cp "RALPH_PRD_TEMPLATE.md" "workspace/RALPH_PRD.md"
    echo "Copied RALPH_PRD_TEMPLATE.md to workspace/RALPH_PRD.md"
else
    echo "workspace/RALPH_PRD.md already exists, skipping"
fi

if [ ! -f "workspace/RALPH.sh" ]; then
    cp "RALPH.sh" "workspace/RALPH.sh"
    echo "Copied RALPH.sh to workspace/RALPH.sh"
else
    echo "workspace/RALPH.sh already exists, skipping"
fi

touch "workspace/RALPH_PROGRESS.txt"

echo "Disabling own git repository"
if [ -d ".git" ]; then
    mv ".git" ".git.bak"
    echo "Disabled own git"
else
    echo "No .git directory found, skipping"
fi

echo "Host container setup complete! Now \"Dev Containers: Rebuild and Reopen in Container\" (VSCode) to build and start the devcontainer"
