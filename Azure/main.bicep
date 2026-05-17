
@description('Name of the Container App')
param containerAppName string = 'my-container-app'

@description('Name of the Container Apps Environment')
param envName string = 'my-container-env'

@description('Location for all resources')
param location string = resourceGroup().location

@description('Container image to deploy')
param containerImage string = 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'

@description('CPU cores for the container')
param cpu string = '0.5'

@description('Memory for the container')
param memory string = '1.0Gi'

@description('Ingress external availability')
param externalIngress bool = true

param acrName string = 'acr${uniqueString(resourceGroup().id)}'
param acrSku string = 'Basic'

resource acrResource 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: acrName
  location: location
  sku: { name: acrSku }
  properties: { adminUserEnabled: true }
}

// Log Analytics Workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: '${containerAppName}-law'
  location: location
  properties: {
    sku: {
    name: 'PerGB2018'
  }
  retentionInDays: 30
  }
}
// Container Apps Environment
resource environment 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: envName
  location: location
  properties: {
      appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalytics.properties.customerId
        sharedKey: logAnalytics.listKeys().primarySharedKey
      }
    }
  }
}

// Container App
resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerAppName
  location: location
  properties: {
    managedEnvironmentId: environment.id
    configuration: {
      ingress: {
        external: externalIngress
        targetPort: 80
      }
    }
    template: {
      containers: [
        {
          name: 'app'
          image: containerImage
          resources: {
            cpu: cpu
            memory: memory
          }
        }
      ]
    }
  }
}

output containerAppUrl string = containerApp.properties.configuration.ingress.fqdn
output acrUrl string = acrResource.properties.loginServer
