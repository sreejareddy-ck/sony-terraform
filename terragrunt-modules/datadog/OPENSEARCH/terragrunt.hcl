terraform {
  source = "../modules/OPENSEARCH"
}

locals {
  account        = get_env("ACCOUNT_ID")
  datadog_module = get_env("DATADOG_MODULE")
  region         = get_env("AWS_REGION", "ap-south-1")
  environment    = get_env("ENVIRONMENT", "dev")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "spn-terraform-tfstate"
    key            = "${path_relative_to_include()}/${local.account}/${local.datadog_module}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}

inputs = {
  datadog_site = "datadoghq.com"
  region      = local.region
  account     = local.account
  environment = local.environment
  opensearch_monitors = [
    {
      service_name                  = "agl"
      component_name                = "agl-core-appconfig"
      notification_channel          = "@slack-agl-alerts @webhook-DD-Squadcast-Integration"
      priority                      = 2,
      message                       = "OpenSearch Alert triggered",
      runbook                       = "",
      query_time_window             = "last_5m",
      roster                        = "@slack-agl-alerts"
      nodes_minimum_critical        = 3
      cpuutilization_maximum_critical = 70
      jvm_memory_pressure_maximum_critical = 75
      cluster_statusred_maximum_critical  = 0.5
      free_storage_space_minimum_critical    = 20000000000  # 20GB
      threadpool_search_rejected_critical = 5
      threadpool_write_rejected_critical  = 5
      iops_throttle_critical               = 0
      throughput_throttle_critical         = 0
    },
    {
      service_name                  = "agl"
      component_name                = "agl-core-cont-watch"
      notification_channel            = "@slack-agl-alerts @webhook-DD-Squadcast-Integration"
      priority                      = 2,
      message                       = "OpenSearch Alert triggered",
      runbook                       = "",
      query_time_window             = "last_5m",
      roster                        = "@slack-agl-alerts"
      nodes_minimum_critical        = 3
      cpuutilization_maximum_critical = 70
      jvm_memory_pressure_maximum_critical = 75
      cluster_statusred_maximum_critical  = 0.5
      free_storage_space_minimum_critical    = 20000000000  # 20GB
      threadpool_search_rejected_critical = 5
      threadpool_write_rejected_critical  = 5
      iops_throttle_critical               = 0
      throughput_throttle_critical         = 0
    },
    {
      service_name                  = "agl"
      component_name                = "agl-core-playback"
      notification_channel            = "@slack-agl-alerts @webhook-DD-Squadcast-Integration"
      priority                      = 2,
      message                       = "OpenSearch Alert triggered",
      runbook                       = "",
      query_time_window             = "last_5m",
      roster                        = "@slack-agl-alerts"
      nodes_minimum_critical        = 3
      cpuutilization_maximum_critical = 70
      jvm_memory_pressure_maximum_critical = 75
      cluster_statusred_maximum_critical  = 0.5
      free_storage_space_minimum_critical    = 20000000000  # 20GB
      threadpool_search_rejected_critical = 5
      threadpool_write_rejected_critical  = 5
      iops_throttle_critical               = 0
      throughput_throttle_critical         = 0
    },
    {
      service_name                  = "agl"
      component_name                = "agl-core-umsps"
      notification_channel            = "@slack-agl-alerts @webhook-DD-Squadcast-Integration"
      priority                      = 2,
      message                       = "OpenSearch Alert triggered",
      runbook                       = "",
      query_time_window             = "last_5m",
      roster                        = "@slack-agl-alerts"
      nodes_minimum_critical        = 3
      cpuutilization_maximum_critical = 70
      jvm_memory_pressure_maximum_critical = 75
      cluster_statusred_maximum_critical  = 0.5
      free_storage_space_minimum_critical    = 20000000000  # 20GB
      threadpool_search_rejected_critical = 5
      threadpool_write_rejected_critical  = 5
      iops_throttle_critical               = 0
      throughput_throttle_critical         = 0
    },
    {
      service_name                  = "agl"
      component_name                = "agl-core-listing"
      notification_channel            = "@slack-agl-alerts @webhook-DD-Squadcast-Integration"
      priority                      = 2,
      message                       = "OpenSearch Alert triggered",
      runbook                       = "",
      query_time_window             = "last_5m",
      roster                        = "@slack-agl-alerts"
      nodes_minimum_critical        = 3
      cpuutilization_maximum_critical = 70
      jvm_memory_pressure_maximum_critical = 75
      cluster_statusred_maximum_critical  = 0.5
      free_storage_space_minimum_critical    = 20000000000  # 20GB
      threadpool_search_rejected_critical = 5
      threadpool_write_rejected_critical  = 5
      iops_throttle_critical               = 0
      throughput_throttle_critical         = 0
    },
    {
      service_name                  = "blitz"
      component_name                = "blitz-migration-opensearch"
      notification_channel            = "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
      priority                      = 2,
      message                       = "OpenSearch Alert triggered",
      runbook                       = "",
      query_time_window             = "last_5m",
      roster                        = "@slack-blitz-prod-alerts"
      nodes_minimum_critical        = 3
      cpuutilization_maximum_critical = 70
      jvm_memory_pressure_maximum_critical = 75
      cluster_statusred_maximum_critical  = 0.5
      free_storage_space_minimum_critical    = 20000000000  # 20GB
      threadpool_search_rejected_critical = 5
      threadpool_write_rejected_critical  = 5
      iops_throttle_critical               = 0
      throughput_throttle_critical         = 0
    },
    {
      service_name                  = "search"
      component_name                = "search-migration-opensearch"
      notification_channel            = "@slack-spni_prod_es_alerts @webhook-DD-Squadcast-Integration"
      priority                      = 2,
      message                       = "OpenSearch Alert triggered",
      runbook                       = "",
      query_time_window             = "last_5m",
      roster                        = "@slack-spni_prod_es_alerts"
      nodes_minimum_critical        = 3
      cpuutilization_maximum_critical = 70
      jvm_memory_pressure_maximum_critical = 75
      cluster_statusred_maximum_critical  = 0.5
      free_storage_space_minimum_critical    = 20000000000  # 20GB
      threadpool_search_rejected_critical = 5
      threadpool_write_rejected_critical  = 5
      iops_throttle_critical               = 0
      throughput_throttle_critical         = 0
    }
  ]
}
