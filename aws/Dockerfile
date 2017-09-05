FROM stackfeed/alpine-python3

# Unprivileged args for the target USER
ONBUILD ARG OBUSER=user
ONBUILD ARG OBUID=1000

ARG TF_VERSION=0.10.3

# KOPS_GITISH: Modify to build at an explicit tag/gitish
ARG KOPS_GITISH=release
# KUBECTL_SOURCE: Change to kubernetes-dev/ci for CI
ARG KUBECTL_SOURCE=kubernetes-release/release
# KUBECTL_TRACK: Currently latest from KUBECTL_SOURCE. Change to latest-1.3.txt, etc. if desired.
ARG KUBECTL_TRACK=stable.txt
ARG KUBECTL_ARCH=linux/amd64

# Some of base packages
RUN apk add --no-cache vim sudo

# Install awscli & terraform
RUN pip install awscli && \
    curl -sSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o /tmp/terraform.zip && \
       unzip /tmp/terraform.zip -d /usr/bin && rm -rf /tmp/*

# Get kops and kubectl
RUN set -ex && \
        apk add --no-cache --virtual build-dependencies jq git musl-dev openssl go make && \
        apk add --no-cache vim ca-certificates && \
        \
        mkdir -p /go && \
        export GOPATH=/go && \
        \
        go get -d k8s.io/kops && \
        cd ${GOPATH}/src/k8s.io/kops/ && \
        git checkout ${KOPS_GITISH} && \
        make SHASUMCMD=0 && \
        mv ${GOPATH}/bin/kops /usr/bin/. && \
        \
        KUBECTL_VERSION=$(curl -SsL --retry 5 "https://storage.googleapis.com/${KUBECTL_SOURCE}/${KUBECTL_TRACK}") && \
        curl -SsL --retry 5 "https://storage.googleapis.com/${KUBECTL_SOURCE}/${KUBECTL_VERSION}/bin/${KUBECTL_ARCH}/kubectl" > /usr/bin/kubectl && \
        chmod +x /usr/bin/kubectl &&\
        \
        rm -rf /go && \
        apk del --no-cache build-dependencies && \
        \
        echo "=== Built kops at ${KOPS_GITISH}, fetched kubectl ${KUBECTL_VERSION} ==="

# Add entrypoint to use bash by default
ADD ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# Create unprivileged user
ONBUILD RUN adduser -Du ${OBUID} -s /bin/bash ${OBUSER} && \
            echo "${OBUSER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${OBUSER} && \
            chmod 440 /etc/sudoers.d/${OBUSER}

ONBUILD VOLUME ["/home/${OBUSER}"]
ONBUILD USER ${OBUID}:${OBUID}
