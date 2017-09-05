FROM stackfeed/alpine-python3

# Unprivileged args for the target USER
ONBUILD ARG OBUSER=user
ONBUILD ARG OBUID=1000

ARG TF_VERSION=0.10.3
ARG KOPS_RELEASE=1.7.0

# KUBECTL_SOURCE: Change to kubernetes-dev/ci for CI
ARG KUBECTL_SOURCE=kubernetes-release/release
# KUBECTL_TRACK: Currently latest from KUBECTL_SOURCE. Change to latest-1.3.txt, etc. if desired.
ARG KUBECTL_TRACK=stable.txt

# Additional packages for the toolbox
RUN apk add --no-cache vim sudo jq fping

# Install awscli & terraform
RUN pip install awscli && \
    curl -sSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o /tmp/terraform.zip && \
       unzip /tmp/terraform.zip -d /usr/bin && rm -rf /tmp/*

# Get kops and kubectl
RUN curl -SsL --retry 5 -o /usr/bin/kops https://github.com/kubernetes/kops/releases/download/${KOPS_RELEASE}/kops-linux-amd64 && \
    KUBECTL_VERSION=$(curl -SsL --retry 5 "https://storage.googleapis.com/${KUBECTL_SOURCE}/${KUBECTL_TRACK}") && \
    curl -SsL --retry 5 "https://storage.googleapis.com/${KUBECTL_SOURCE}/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" > /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl /usr/bin/kops

# Add entrypoint to use bash by default
ADD ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# Create unprivileged user
ONBUILD RUN adduser -Du ${OBUID} -s /bin/bash ${OBUSER} && \
            echo "${OBUSER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${OBUSER} && \
            chmod 440 /etc/sudoers.d/${OBUSER}

ONBUILD VOLUME ["/home/${OBUSER}"]
ONBUILD USER ${OBUID}:${OBUID}
