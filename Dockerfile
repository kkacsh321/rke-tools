FROM alpine:3.15

ENV RKE_VERSION=v1.3.2
ENV KUBECTL_VERSION=v1.22.0
ENV HELM_VERSION=v2.17.0
ENV HELM3_VERSION=v3.7.1

WORKDIR /bin

RUN apk update && \
    apk add --no-cache \
    ca-certificates=20191127-r7 \
    git=2.34.0-r0 \
    openssh=8.8_p1-r1 \
    bash=5.1.8-r0 \
    jq=1.6-r1 \
    make=4.3-r0 \
    wget=1.21.2-r2 \ 
    curl=7.80.0-r0 \
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
