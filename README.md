# HTTP Probe

A simple tool for probing HTTP APIs in network environments like VPS, ECS, and Kubernetes.

Pull publicly available Docker image:

```bash
docker pull sskender/http-probe:latest
```

Run with your HTTP API endpoint:

```bash
docker run --rm sskender/http-probe:latest https://api.example.com/v1/health
```
