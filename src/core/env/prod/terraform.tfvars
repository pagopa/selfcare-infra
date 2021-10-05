# general
env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "SelfCare"
  Source      = "https://github.com/pagopa/selfcare-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# networking
# main vnet
cidr_vnet                = ["10.1.0.0/16"]
cidr_subnet_k8s          = ["10.1.0.0/17"]
cidr_subnet_appgateway   = ["10.1.128.0/24"]
cidr_subnet_azdoa        = ["10.1.130.0/24"]
cidr_subnet_redis        = ["10.1.132.0/24"]
cidr_subnet_vpn          = ["10.1.133.0/24"]
cidr_subnet_dnsforwarder = ["10.1.134.0/29"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.7.0/24"] # todo ask to SIA
cidr_subnet_apim      = ["10.230.7.0/26"]

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "selfcare"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA SelfCare PROD"
apim_sku            = "Developer_1" # todo change to Premium_1 before launch

# app_gateway
app_gateway_api_certificate_name        = "api-selfcare-pagopa-it"
app_gateway_portal_certificate_name     = "portal-selfcare-pagopa-it"
app_gateway_management_certificate_name = "management-selfcare-pagopa-it"
app_gateway_min_capacity                = 0 # todo change to at least 1
app_gateway_max_capacity                = 2

# todo change to Premium before launch
# redis_sku_name = "Premium"
# redis_family   = "P"

# aks
aks_availability_zones = [1, 2, 3] # TODO to check
aks_node_count         = 6 # TODO to check
aks_vm_size            = "Standard_D8S_v3" # TODO to check
aks_sku_tier           = "Paid" # TODO to check

aks_metric_alerts = {
  node_cpu = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "cpuUsagePercentage"
    operator         = "GreaterThan"
    threshold        = 80
    frequency        = "PT1M"
    window_size      = "PT5M"
    dimension = [
      {
        name     = "host"
        operator = "Include"
        values   = ["*"]
      }
    ],
  }
  node_memory = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "memoryWorkingSetPercentage"
    operator         = "GreaterThan"
    threshold        = 80
    frequency        = "PT1M"
    window_size      = "PT5M"
    dimension = [
      {
        name     = "host"
        operator = "Include"
        values   = ["*"]
      }
    ],
  }
  node_disk = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "DiskUsedPercentage"
    operator         = "GreaterThan"
    threshold        = 80
    frequency        = "PT1M"
    window_size      = "PT5M"
    dimension = [
      {
        name     = "host"
        operator = "Include"
        values   = ["*"]
      },
      {
        name     = "device"
        operator = "Include"
        values   = ["*"]
      }
    ],
  }
  node_not_ready = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "nodesCount"
    operator         = "GreaterThan"
    threshold        = 0
    frequency        = "PT1M"
    window_size      = "PT5M"
    dimension = [
      {
        name     = "status"
        operator = "Include"
        values   = ["NotReady"]
      }
    ],
  }
  pods_failed = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/pods"
    metric_name      = "podCount"
    operator         = "GreaterThan"
    threshold        = 0
    frequency        = "PT1M"
    window_size      = "PT5M"
    dimension = [
      {
        name     = "phase"
        operator = "Include"
        values   = ["Failed"]
      }
    ]
  }
  pods_ready = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/pods"
    metric_name      = "PodReadyPercentage"
    operator         = "LessThan"
    threshold        = 80
    frequency        = "PT1M"
    window_size      = "PT5M"
    dimension = [
      {
        name     = "kubernetes namespace"
        operator = "Include"
        values   = ["*"]
      },
      {
        name     = "controllerName"
        operator = "Include"
        values   = ["*"]
      }
    ]
  }
  container_cpu = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/containers"
    metric_name      = "cpuExceededPercentage"
    operator         = "GreaterThan"
    threshold        = 95
    frequency        = "PT1M"
    window_size      = "PT5M"
    dimension = [
      {
        name     = "kubernetes namespace"
        operator = "Include"
        values   = ["*"]
      },
      {
        name     = "controllerName"
        operator = "Include"
        values   = ["*"]
      }
    ]
  }
  container_memory = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/containers"
    metric_name      = "memoryWorkingSetExceededPercentage"
    operator         = "GreaterThan"
    threshold        = 95
    frequency        = "PT1M"
    window_size      = "PT5M"
    dimension = [
      {
        name     = "kubernetes namespace"
        operator = "Include"
        values   = ["*"]
      },
      {
        name     = "controllerName"
        operator = "Include"
        values   = ["*"]
      }
    ]
  }
  container_oom = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/pods"
    metric_name      = "oomKilledContainerCount"
    operator         = "GreaterThan"
    threshold        = 0
    frequency        = "PT1M"
    window_size      = "PT1M"
    dimension = [
      {
        name     = "kubernetes namespace"
        operator = "Include"
        values   = ["*"]
      },
      {
        name     = "controllerName"
        operator = "Include"
        values   = ["*"]
      }
    ]
  }
  container_restart = {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/pods"
    metric_name      = "restartingContainerCount"
    operator         = "GreaterThan"
    threshold        = 0
    frequency        = "PT1M"
    window_size      = "PT1M"
    dimension = [
      {
        name     = "kubernetes namespace"
        operator = "Include"
        values   = ["*"]
      },
      {
        name     = "controllerName"
        operator = "Include"
        values   = ["*"]
      }
    ]
  }
}
