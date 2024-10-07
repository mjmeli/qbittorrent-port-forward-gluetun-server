# qbittorrent-port-forward-gluetun-server

A shell script and Docker container for automatically setting qBittorrent's listening port from Gluetun's control server.

## Config

### Environment Variables

| Variable     | Example                     | Default                      | Description                                                     |
|--------------|-----------------------------|------------------------------|-----------------------------------------------------------------|
| QBT_USERNAME | `username`                  | `admin`                      | qBittorrent username                                            |
| QBT_PASSWORD | `password`                  | `adminadmin`                 | qBittorrent password                                            |
| QBT_ADDR     | `http://192.168.1.100:8080` | `http://localhost:8080`      | HTTP URL for the qBittorrent web UI, with port                  |
| GTN_ADDR     | `http://192.168.1.100:8000` | `http://localhost:8000`      | HTTP URL for the gluetun control server, with port              |
| GTN_APIKEY   | `apikey`                    | `CHANGEME`                   | API Key for communication to gluetun control server             |


## Gluetun Control Server Authentication
1. Create a new file on your Gluetun host system with the following contents:
```toml
# See https://github.com/qdm12/gluetun-wiki/blob/main/setup/advanced/control-server.md for more
[[roles]]
name = "qbittorrent"
# Define a list of routes with the syntax "Http-Method /path"
routes = ["GET /v1/openvpn/portforwarded"]
# Define an authentication method with its parameters
auth = "apikey"
apikey = "CHANGEME" # can be generated using "docker run --rm qmcgaw/gluetun genkey"
```
3. Bind mount the file you created to `/gluetun/auth/config.toml` in your gluetun docker instance.

## Example

### Docker-Compose

The following is an example docker-compose:

```yaml
  qbittorrent-port-forward-gluetun-server:
    image: mjmeli/qbittorrent-port-forward-gluetun-server
    container_name: qbittorrent-port-forward-gluetun-server
    restart: unless-stopped
    environment:
      - QBT_USERNAME=username
      - QBT_PASSWORD=password
      - QBT_ADDR=http://192.168.1.100:8080
      - GTN_ADDR=http://192.168.1.100:8000
      - GTN_APIKEY=apikey
```

## Development

### Build Image

`docker build . -t qbittorrent-port-forward-gluetun-server`

### Run Container

`docker run --rm -it -e QBT_USERNAME=admin -e QBT_PASSWORD=adminadmin -e QBT_ADDR=http://192.168.1.100:8080 -e GTN_ADDR=http://192.168.1.100:8000 -e GTN_APIKEY=CHANGEME qbittorrent-port-forward-gluetun-server:latest`
