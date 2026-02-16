terraform {
  source = "../modules/REDIS"
}

locals {
  account        = get_env("ACCOUNT_ID")
  datadog_module = get_env("DATADOG_MODULE")
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
  redis_service_name = [
    {
      service_name                                 = "td"
      component_name                               = "td"
      priority                                    = 2,
      message                                     = "Alert triggered for Redis cache",
      query_time_window                           = "last_2m",
      redis_avg_cpu_utilization_critical           = 75
      redis_avg_engine_cpu_utilization_critical    = 80
      redis_avg_get_type_latency_critical          = 150
      redis_avg_memory_utilization_critical        = 80
      redis_avg_set_type_latency_critical          = 150
      redis_connection_count_critical              = 1000
      redis_swap_usage_critical                    = 100
      redis_cache_hit_ratio_critical               = 85
      runbook                                      = ""
      notification_channel                         = "@slack-targeted-delivery-api-alerts @webhook-DD-Squadcast-Integration"
      roster                                       = "@slack-targeted-delivery-api-alerts"
    }
  ]
}