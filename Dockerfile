FROM alpine:3.17

ENV RKE_VERSION=v1.4.1
ENV KUBECTL_VERSION=v1.24.0
ENV HELM_VERSION=v2.17.0
ENV HELM3_VERSION=v3.7.1

WORKDIR /bin

RUN apk update && \
    apk add --no-cache \
    ca-certificates=20220614-r3 \
    git=2.38.2-r0 \
    openssh=9.1_p1-r1 \
    bash=5.2.15-r0 \
    jq=1.6-r2 \
    make=4.3-r1 \
    wget=1.21.3-r2 \ 
    curl=7.87.0-r0 \
    && \
    wget -qO kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    wget -q https://get.helm.sh/helm-${HELM3_VERSION}-linux-amd64.tar.gz -qO - | tar xz && \
    mv ./linux-amd64/helm ./helm3 && rm -rf ./linux-amd64 && \
    wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -qO - | tar xz && \
    wget -q https://github.com/rancher/rke/releases/download/${RKE_VERSION}/rke_linux-amd64 && \
    mv ./linux-amd64/helm ./helm && \
    mv ./linux-amd64/tiller ./ && rm -rf ./linux-amd64 && \
    mv ./rke_linux-amd64 ./rke && \
    chmod +x kubectl helm tiller rke

COPY entrypoint.sh /entrypoint.sh

WORKDIR /code
ENTRYPOINT ["/entrypoint.sh"]
