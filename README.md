# Claudetainer

Isolates Claude setup into a restricted container with strict firewall and filesystem access.

# Setup
1. Clone this repo
2. Run `./RUNME.sh`
3. Clone repos you want to work with into workspace
4. In VSCode do "Dev Containers: Rebuild and Reopen in Container"
5. Open integrated terminal and run claude

# Claude plugins and MCPs

[`claude-setup.sh`](/.devcontainer/.scripts/claude-setup.sh) runs on container start and installs a minimal set of useful tools. Feel free to extend it to get new ones.

Some of these require env vars to work, set those on host machine, [`devcontainer.json`](/.devcontainer/devcontainer.json) proxies them inside container.

- `CONTEXT7_MCP_BEARER_TOKEN` - needed for context7 mcp to work
