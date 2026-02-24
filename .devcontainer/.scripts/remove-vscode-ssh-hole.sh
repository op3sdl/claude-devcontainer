#!/bin/bash

# VSCode tunnels host SSH agent into container implicitly. Not secure. Cleaning it up.
find /tmp -maxdepth 1 -name 'vscode-ssh-auth-*.sock' -delete 2>/dev/null