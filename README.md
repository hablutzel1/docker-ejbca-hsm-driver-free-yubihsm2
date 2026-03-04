# Introduction

Unofficial YubiHSM 2 HSM driver as an alternative to the proprietary `primekey/hsm-driver-yubihsm2`.

# Usage

At the Docker host level connect the HSM to a USB port and start the YubiHSM Connector:

```
$ yubihsm-connector -l 0.0.0.0:12345 -d
```

## Running the Sample

Clone the current repository:

```sh
git clone https://github.com/hablutzel1/docker-ejbca-hsm-driver-free-yubihsm2.git
```

Clone the driver base image repository at the same directory level as this one. The demo uses a sample EJBCA image included in the base image repository.

```sh
cd ..
git clone https://github.com/hablutzel1/docker-ejbca-hsm-driver-free-base.git
```

Then proceed:

1. Modify the environment variables in `compose.yaml` to match your HSM details:
   - Set the IP in `YUBIHSM_CONNECTOR` to the LAN IP of the Docker host.
2. Open a terminal in this directory.
3. Run:
   ```sh
   docker compose up --build
   ```
4. Access EJBCA at https://localhost:8443/ejbca/adminweb
5. And proceed to create a Crypto Token in the EJBCA Admin GUI:
   * Name: YubiHSM 2
   * Type: PKCS #11
   * PKCS#11 : Library: YubiHSM 2
   * PKCS#11 : Reference Type: Slot ID
   * PKCS#11 : Reference: 0
   * Authentication Code: Authentication key ID (e.g. 0001) followed by the password, e.g. "0001password" for the default Authentication Key.
