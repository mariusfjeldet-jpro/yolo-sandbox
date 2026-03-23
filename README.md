# yolo-sandbox

A containerized AI development sandbox with Claude Code, OpenAI Codex, .NET Aspire, and Playwright pre-installed. Designed for running AI coding agents in an isolated, persistent environment on Windows via Podman.

## What's included

- **Claude Code** (`@anthropic-ai/claude-code`) — Anthropic's AI coding CLI
- **OpenAI Codex** (`@openai/codex`) — OpenAI's AI coding CLI
- **Playwright** (base image) — Browser automation framework with all browsers
- **.NET 10 SDK + Aspire workload** — Full .NET Aspire development stack
- **Aspire CLI** — `aspire` command for project scaffolding
- **uv + specify-cli** — Python tooling and spec-driven development

## Prerequisites

- [Podman Desktop](https://podman-desktop.io/) (or Docker) installed on Windows
- A `.env` file in this directory (see below)

## Setup

1. **Create a `.env` file** in the project root:

   ```env
   GIT_USER_NAME=Your Name
   GIT_USER_EMAIL=you@example.com
   PROJECTS_PATH=C:\path\to\your\projects
   MAX_MEMORY=8g
   MAX_CPUS=4
   ```

2. **Start the sandbox:**

   ```powershell
   .\up.ps1
   ```

   This will build the image (first run only), start the container, and drop you into a bash shell.

## Usage

Once inside the container, your projects are available at `/home/pwuser/sandbox`. Your home directory (including all auth files, shell history, and tool configs) is persisted via a Docker volume — so credentials and settings survive container restarts.

To start Claude Code:

```bash
claude
```

## Ports

| Port  | Purpose                        |
|-------|--------------------------------|
| 18888 | Exposed for dev server / Aspire dashboard use |

## Persistence

| What | Where |
|------|-------|
| Home directory (auth, config, history) | `home_data` Docker volume |
| Your code | Bind-mounted from `PROJECTS_PATH` on the host |
