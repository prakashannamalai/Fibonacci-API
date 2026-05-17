# Fibonacci API

Node.js REST API that returns the nth Fibonacci number.

## Endpoints

- `GET /fibonacci/:n` - Returns the Fibonacci number at index `n`.

## Example

Request:

```bash
curl http://localhost:3000/fibonacci/10
```

Response:

```
55
```

## Docker

Build the image:

```bash
docker build -t fibonacci-api .
```

Run the container:

```bash
docker run -p 3000:3000 fibonacci-api
```
## Azure


## Azure DevOps (CI/CD pipelines)



## Logs/monitoring

1. Log Analtics is enabled for storing Container App's system and console logs, and Alert rules can be enabled based on the query results
2. Alert rules can be enabled based on Metrics (i.e. CPU/Memory consumption, etc..)


## Security best practices

1. Use custom domain to represent your own domain
2. Use CloudFlare or equivalent-to-Cloudflare to enahance appliation security/performance
3. Configure IP ingress restrictions in Azure Container App by allowing CloudFlare or equivalent-to-Cloudflare IPs.


## AI usage

1. Used GitHub CoPilot for creating NodeJS scripts (REST API) & Bicep template with manual assessment and correction as required. 
Referred Microsoft document for valdiating Bicep template.
I was able to assess and validate NodeJS script in my local Docker.
 

2. Used Microsoft Copilot to fix issues in Azure DevOps pipelines. Validated it in test run using my test DevOps organization.
