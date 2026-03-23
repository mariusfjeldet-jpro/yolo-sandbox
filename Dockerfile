FROM mcr.microsoft.com/playwright:v1.58.2-noble

USER root
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y dotnet-sdk-10.0
RUN npm i -g @openai/codex
RUN curl -fsSL https://claude.ai/install.sh | bash
RUN curl -fsSL https://aspire.dev/install.sh | bash
RUN apt-get install -y gh

RUN mkdir -p /home/pwuser/sandbox
RUN chown -R pwuser:pwuser /home/pwuser/sandbox

WORKDIR /home/pwuser/sandbox
USER pwuser

# FIX: Keep the container alive with tail
CMD git config --global user.name "$GIT_USER_NAME" && \
    git config --global user.email "$GIT_USER_EMAIL" && \
    tail -f /dev/null