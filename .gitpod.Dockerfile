FROM gitpod/workspace-full

# More information: https://www.gitpod.io/docs/config-docker/
# the following tools are not crucial tools here, don't need to install a particular version
# * GitHub CLI (install via hd install cli/cli)
# * s2i (hd install openshift/source-to-image)
RUN sudo rm -rf /usr/bin/hd && \
    curl -L https://github.com/LinuxSuRen/http-downloader/releases/download/v0.0.29/hd-linux-amd64.tar.gz | tar xzv && \
    sudo mv hd /usr/local/bin && \
    hd install cli/cli && \
    hd install openshift/source-to-image
