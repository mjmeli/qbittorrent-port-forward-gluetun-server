# qbittorrent-port-forward-gluetun-server

A shell script and Docker container for automatically setting qBittorrent's listening port from Gluetun's control server.

## Config

### Environment Variables

| Variable      | Example                     | Default                      | Description                                                     |
|---------------|-----------------------------|------------------------------|-----------------------------------------------------------------|
| INTERVAL      | `5`                         | `1`                          | Interval in minutes in-which port update will be attempted      |
| QBT_USERNAME  | `username`                  | `admin`                      | qBittorrent username                                            |
| QBT_PASSWORD  | `password`                  | `adminadmin`                 | qBittorrent password                                            |
| QBT_ADDR      | `http://192.168.1.100:8080` | `http://localhost:8080`      | HTTP URL for the qBittorrent web UI, with port.                 |
| GTN_USERNAME  | `username`                  | na                           | Gluetun username set in `config.toml`                           |
| GTN_PASSWORD  | `password`                  | na                           | Gluetun password set in `config.toml`                           |
| GTN_APIKEY    | `4BNUzqoPxdoDTSFJrPguKM`    | na                           | Gluetun api key set in `config.toml`                            |
| GTN_ADDR      | `http://192.168.1.100:8000` | `http://localhost:8000`      | HTTP URL for the gluetun control server, with port.             |

## `compose.yml` Examples
**Before you can use qbittorrent-port-forward-gluetun-server you must first create a `config.toml`, see Gluetun's [Control Server](https://github.com/qdm12/gluetun-wiki/blob/main/setup/advanced/control-server.md#control-server) documentation.** Below are three `compose.yml` examples, one for each authentication method listed in Gluetun's documentation.

### basic
```yaml
  qbittorrent-port-forward-gluetun-server:
    image: mjmeli/qbittorrent-port-forward-gluetun-server
    container_name: qbittorrent-port-forward-gluetun-server
    restart: unless-stopped
    environment:
      QBT_USERNAME: username
      BT_PASSWORD: password
      QBT_ADDR: http://192.168.1.100:8080
      GTN_USERNAME: username
      GTN_PASSWORD: password
      GTN_ADDR: http://192.168.1.100:8000
```

### apikey
```yaml
  qbittorrent-port-forward-gluetun-server:
    image: mjmeli/qbittorrent-port-forward-gluetun-server
    container_name: qbittorrent-port-forward-gluetun-server
    restart: unless-stopped
    environment:
      QBT_USERNAME: username
      QBT_PASSWORD: password
      QBT_ADDR: http://192.168.1.100:8080
      GTN_APIKEY: apikey
      GTN_ADDR: http://192.168.1.100:8000
```

### none
```yaml
  qbittorrent-port-forward-gluetun-server:
    image: mjmeli/qbittorrent-port-forward-gluetun-server
    container_name: qbittorrent-port-forward-gluetun-server
    restart: unless-stopped
    environment:
      QBT_USERNAME: username
      QBT_PASSWORD: password
      QBT_ADDR: http://192.168.1.100:8080
      GTN_ADDR: http://192.168.1.100:8000
```

## Development
**Note that you must first create a `config.toml`, see Gluetun's [Control Server](https://github.com/qdm12/gluetun-wiki/blob/main/setup/advanced/control-server.md#control-server) documentation.**

### Build Image
```bash
docker build . -t qbittorrent-port-forward-gluetun-server
```

### Run Container
```bash
docker run --rm -it /
  -e QBT_USERNAME=admin /
  -e QBT_PASSWORD=adminadmin /
  -e QBT_ADDR=http://192.168.1.100:8080 /
  -e GTN_USERNAME=username /
  -e GTN_PASSWORD=password /
  -e GTN_ADDR=http://192.168.1.100:8000 /
  qbittorrent-port-forward-gluetun-server
```
```bash
docker run --rm -it /
  -e QBT_USERNAME=admin /
  -e QBT_PASSWORD=adminadmin /
  -e QBT_ADDR=http://192.168.1.100:8080 /
  -e GTN_APIKEY=apikey /
  -e GTN_ADDR=http://192.168.1.100:8000 /
  qbittorrent-port-forward-gluetun-server
```
```bash
docker run --rm -it /
  -e QBT_USERNAME=admin /
  -e QBT_PASSWORD=adminadmin /
  -e QBT_ADDR=http://192.168.1.100:8080 /
  -e GTN_ADDR=http://192.168.1.100:8000 /
  qbittorrent-port-forward-gluetun-server
```