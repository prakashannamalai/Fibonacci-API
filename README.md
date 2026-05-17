# Fibonacci API
Fibonacci API project is developed using NodeJS programming language and hosted in Azure Container App using Azure DevOps pipeline with Bicep template.
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
## Azure Cloud Environment
1. Azure Container Registry is used to store the container image.
2. Azure Containter App is used to host the application with auto-scaling enabled (Consumption profile type is used in this exercise, but Dedicated profile type can be considered for critical business application)
3. Log Analytics Workspace is used to store Container App's system and console logs
4. System Managed Identity is enabled for Container App to pull the image from Container Registry

## Azure DevOps (CI/CD pipelines)

#### Service Connection
Service Connection is created for ADO pipeline to access/provision Azure Resources.
Steps to create Service Connection
1. Project Settings => Service Connection.
2. New Service Connection => Choose "Azure Resource Manager"
3. Choose "App Registration" as Identity type, Workload Identity Federation as Credential
4. Select the scope (subscription and Resource Group Name) and provide name for service connection
5. Grant access permission to pipelne and save

#### Pipeline 1 (Provisioning Azure Resources)
1. Create Azure DevOps pipeline using this existing azure-bicep-pipeline.yml and please ensure the value of variables are updated as per Azure environment.
2. This pipeline will valdiate "Azure/main.bicep" template and execute if valiation is passed.
3. It will provision ACR and Azure Container Apps with Log anlaytics workspace services.
4. Once the deployment is completed, please update Authentication in Container Apps to "System assigned identity (environment)" connecting to Azure Container Registry (acrPull permission) via Azure portal. Due to time-limitation, I coudln't proceed it with Bicep template.

#### Pipeline 2 (Build Docker image and deploy it in Containter App)
1. Create Azure DevOps pipeline using this existing azure-pipelines.yml and please ensure the value of variables are updated as per Azure environment.
2. This pipeline will build docker image and push it to Azure Container Registry followed by deploying the image into Azure Container Apps.


## Logs/monitoring

1. Log Analtics is enabled for storing Container App's system and console logs, and Alert rules can be enabled based on the query results
2. Alert rules can be enabled based on Metrics (i.e. CPU/Memory consumption, etc..)


## Security best practices

1. Use custom domain to represent your own domain
2. Use CloudFlare or equivalent-to-Cloudflare to enahance appliation security/performance
3. Configure IP ingress restrictions in Azure Container App by allowing CloudFlare or equivalent-to-Cloudflare IPs.


## AI usage

1. Used GitHub CoPilot for creating NodeJS scripts (REST API) & Bicep template with manual assessment and correction as required. 
Referred Microsoft document for valdiating Bicep template. I was able to assess and validate NodeJS script in my local Docker.
2. Used Microsoft Copilot to fix issues in Azure DevOps pipelines. Validated it in test run using my test DevOps organization.
