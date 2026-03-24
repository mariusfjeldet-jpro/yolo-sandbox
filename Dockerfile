FROM mcr.microsoft.com/playwright:v1.58.2-noble

USER root

# 1. Install System Dependencies
RUN apt-get update && apt-get install -y \
    curl \
    dotnet-sdk-10.0 \
    gh \
    bubblewrap \
    podman \
    && rm -rf /var/lib/apt/lists/*

# 2. Install AI CLIs (Using the verified package names)
# NOTE: @anthropic-ai/claude-code is the official terminal tool
RUN npm i -g @anthropic-ai/claude-code @openai/codex

# 3. Install the Aspire CLI (workload no longer needed since Aspire 9 - now pure NuGet)
RUN dotnet tool install --tool-path /usr/local/bin Aspire.Cli

RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local/bin" sh && \
    env UV_TOOL_DIR="/opt/uv-tools" UV_TOOL_BIN_DIR="/usr/local/bin" uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@v0.3.2 && \
    chmod -R 755 /opt/uv-tools

# 4. Setup Workspace
RUN mkdir -p /home/pwuser/sandbox && chown -R pwuser:pwuser /home/pwuser/sandbox
WORKDIR /home/pwuser/sandbox

# 5. Add global aliases for AI Agents
RUN echo 'alias claude-yolo="claude --dangerously-skip-permissions"' >> /etc/bash.bashrc && \
    echo 'alias codex-yolo="codex --yolo"' >> /etc/bash.bashrc

# 6. Set Environment Paths
ENV PATH="/usr/local/bin:/home/pwuser/.dotnet/tools:${PATH}"

USER pwuser

# 7. Simplified CMD to avoid editor highlighting bugs
# This sets git config only if the variables are provided, then keeps alive.
CMD git config --global user.name "${GIT_USER_NAME:-SandboxUser}" && \
    git config --global user.email "${GIT_USER_EMAIL:-user@example.com}" && \
    tail -f /dev/null