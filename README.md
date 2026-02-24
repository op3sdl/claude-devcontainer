# Claude Devcontainer

A devcontainer for running Claude Code in an isolated, restricted environment. Optimised for TypeScript and .NET development. Fork it and make it your own.

## Setup

1. Fork this repository
2. Clone your fork
3. Run `./RUNME.sh`
4. Clone the repositories you want to work with into `workspace/`
5. In VS Code, run `Dev Containers: Rebuild and Reopen in Container`
6. Open the integrated terminal and run `claude`

## Environment variables

Set these on the host machine. [`devcontainer.json`](/.devcontainer/devcontainer.json) forwards them into the container.

| Variable | Purpose |
|---|---|
| `CONTEXT7_MCP_BEARER_TOKEN` | Required for the Context7 MCP server |

## Customisation

This container is intentionally minimal. Fork it and adapt it to your stack:

- Modify [`CLAUDE.md`](/CLAUDE.md) to change Claude's behaviour, coding standards, or tooling instructions
- Edit [`init-firewall.sh`](/.devcontainer/.scripts/init-firewall.sh) to expand or restrict the network allowlist
- Edit [`claude-setup.sh`](/.devcontainer/.scripts/claude-setup.sh) to add or remove MCP servers and plugins
- Edit [`git-hooks-setup.sh`](/.devcontainer/.scripts/git-hooks-setup.sh) to adjust commit and push policies
- Modify the [`Dockerfile`](/.devcontainer/Dockerfile) to add SDKs, runtimes, or tools for your stack

## Features

**Firewall**

An iptables-based allowlist firewall initialises on container start. Outbound traffic is restricted to a fixed set of domains. Everything else is blocked.

Allowed outbound destinations:

- `api.anthropic.com` - Claude API
- `mcp.context7.com` - Context7 MCP server
- `mcp.socket.dev` - Socket security MCP server
- `registry.npmjs.org` - npm package registry (CHANGE IT TO YOUR ORG/SELFHOSTED REGISTRY if possible)
- `nuget.org` - NuGet package registry (CHANGE IT TO YOUR ORG/SELFHOSTED REGISTRY if possible)

DNS is restricted to configured resolvers only, preventing DNS tunnelling. The VSCode SSH forwarding hole is also closed on start.

**Git hooks**

Global git hooks are installed for all repositories in the workspace:

- Commits to `main` or `master` are blocked
- All pushes are blocked

This prevents Claude from accidentally pushing to remote repositories or committing directly to protected branches.

**Claude defaults**

[`CLAUDE.md`](/CLAUDE.md) is the system prompt loaded by Claude on start. It configures Claude to work in a .NET and TypeScript stack with sensible defaults.

[`claude-setup.sh`](/.devcontainer/.scripts/claude-setup.sh) runs on container start and installs:

- **Superpowers plugin** - provides structured skills for brainstorming, TDD, debugging, planning, and code review
- **Context7 MCP** - up-to-date documentation for external libraries
- **Socket MCP** - dependency security scoring

