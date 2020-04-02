FROM alpine:3.11.5
ENV RKE_VERSION=v1.0.6
ENV KUBECTL_VERSION=v1.18.0
ENV HELM_VERSION=v2.16.1
ENV HELM3_VERSION=v3.1.2

WORKDIR /bin

RUN apk --update add ca-certificates git openssh bash jq make wget curl && \
    wget -qO kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    wget https://get.helm.sh/helm-${HELM3_VERSION}-linux-amd64.tar.gz -qO - | tar xz && \
    mv ./linux-amd64/helm ./helm3 && rm -rf ./linux-amd64 && \
    wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -qO - | tar xz && \
    wget https://github.com/rancher/rke/releases/download/${RKE_VERSION}/rke_linux-amd64 && \
    mv ./linux-amd64/helm ./helm && \
    mv ./linux-amd64/tiller ./ && rm -rf ./linux-amd64 && \
    mv ./rke_linux-amd64 ./rke && \
    chmod +x kubectl helm tiller rke

ADD entrypoint.sh /entrypoint.sh

WORKDIR /code
ENTRYPOINT ["/entrypoint.sh"]
