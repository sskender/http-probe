# HTTP Probe

A simple tool for probing HTTP APIs in various network environments. Test the availability of your services in local networks, cloud setups, and multi-service environments like Kubernetes clusters. It also includes a Docker image for easy deployment within your infrastructure.

Pull publicly available Docker image:

```bash
docker pull sskender/http-probe:latest
```

Run with your HTTP API endpoint as target:

```bash
docker run --rm sskender/http-probe:latest https://api.example.com/v1/health
```

Example output:

```txt
[2024-09-28 13:54:00] Starting the probe process
[2024-09-28 13:54:00] Target endpoint: https://api.example.com/v1/health
[2024-09-28 13:54:00] Sending the probe
[2024-09-28 13:54:00] Trying to resolve domain: api.example.com
[2024-09-28 13:54:00] Record found: 115.19.142.57
[2024-09-28 13:54:00] Record found: 115.19.141.57
[2024-09-28 13:54:00] Record found: 115.19.138.57
[2024-09-28 13:54:00] Record found: 115.19.140.57
[2024-09-28 13:54:00] Record found: 115.19.139.57
[2024-09-28 13:54:01] HTTP response code: 200
[2024-09-28 13:54:01] Waiting for 10s before sending the next probe
```
