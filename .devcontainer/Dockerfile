FROM node:20

ARG TZ
ENV TZ="$TZ"

ENV DEVCONTAINER=true
ENV PATH=$PATH:/home/node/.local/bin

ARG USERNAME=node
ARG GIT_DELTA_VERSION=0.18.2

# Install system packages in a single layer
RUN apt-get update && apt-get install -y --no-install-recommends \
  less \
  git \
  procps \
  sudo \
  man-db \
  unzip \
  gnupg2 \
  iptables \
  ipset \
  iproute2 \
  dnsutils \
  aggregate \
  jq \
  nano \
  vim \
  wget \
  ca-certificates \
  && wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && rm packages-microsoft-prod.deb \
  && apt-get update \
  && apt-get install -y dotnet-sdk-8.0 dotnet-sdk-9.0 dotnet-sdk-10.0 \
  && ARCH=$(dpkg --print-architecture) \
  && wget "https://github.com/dandavison/delta/releases/download/${GIT_DELTA_VERSION}/git-delta_${GIT_DELTA_VERSION}_${ARCH}.deb" \
  && dpkg -i "git-delta_${GIT_DELTA_VERSION}_${ARCH}.deb" \
  && rm "git-delta_${GIT_DELTA_VERSION}_${ARCH}.deb" \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up directories and permissions
ARG OWNED_DIRS="/usr/local/share/npm-global /commandhistory /workspace /home/node/.claude /home/node/.config/gcloud /home/node/.cache /home/node/.local"
RUN mkdir -p $OWNED_DIRS \
  && mkdir -p /home/node/.local/share/NuGet \
  && mkdir -p /home/node/.nuget \
  && chown -R $USERNAME:$USERNAME /home/node/.local \
  && chown -R $USERNAME:$USERNAME /home/node/.nuget \
  && chown -R $USERNAME $OWNED_DIRS

WORKDIR /workspace

# Copy startup scripts
USER root
COPY .scripts/init-firewall.sh /usr/local/bin/
COPY .scripts/claude-setup.sh /usr/local/bin/
COPY .scripts/git-hooks-setup.sh /usr/local/bin/
COPY .scripts/remove-vscode-ssh-hole.sh /usr/local/bin/
COPY .scripts/post-start.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/init-firewall.sh && \
  chmod 755 /usr/local/bin/claude-setup.sh && \
  chmod 755 /usr/local/bin/git-hooks-setup.sh && \
  chmod 755 /usr/local/bin/remove-vscode-ssh-hole.sh && \
  chmod 755 /usr/local/bin/post-start.sh && \
  echo "node ALL=(root) NOPASSWD: /usr/local/bin/init-firewall.sh, /usr/local/bin/git-hooks-setup.sh" > /etc/sudoers.d/node-firewall && \
  chmod 0440 /etc/sudoers.d/node-firewall && \
  visudo -c

# Install Claude Code
USER node
RUN curl -fsSL https://claude.ai/install.sh | bash