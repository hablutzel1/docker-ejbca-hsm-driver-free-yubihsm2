FROM ghcr.io/hablutzel1/ejbca-hsm-driver-free-base:0.2.4-al10

RUN microdnf install -y wget tar gzip

# TODO try to move the RPM (and dependencies) installation to builder_yubihsm2.
RUN microdnf install -y pcsc-lite libedit
RUN cd /tmp && wget https://developers.yubico.com/YubiHSM2/Releases/yubihsm2-sdk-2025-06-fedora42-amd64.tar.gz && \
    tar xvf yubihsm2-sdk-2025-06-fedora42-amd64.tar.gz
# TODO `dnf install /tmp/yubihsm2-sdk/yubihsm-shell-2.7.0-1.fc42.x86_64.rpm` could avoid the previous installation of dependencies. Check if microdnf has something similar.
RUN rpm -ivh /tmp/yubihsm2-sdk/yubihsm-shell-2.7.0-1.fc42.x86_64.rpm
# TODO check: does the following really reduce the size of the image?
RUN rm -Rf /tmp/yubihsm2-sdk

ENV YUBIHSM_PKCS11_CONF="/opt/yubihsm2/yubihsm_pkcs11.conf"
COPY environment-hsm /opt/yubihsm2/environment-hsm

ENV HSM_PKCS11_LIBRARY="/lib64/pkcs11/yubihsm_pkcs11.so"
ENV HSM_PKCS11_LIBRARY_NAME="YubiHSM 2"
