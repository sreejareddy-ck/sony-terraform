terraform {
    source = "../modules/KAFKA"
}
# include {
#     path = find_in_parent_folders()
# }
locals {
    account = get_env("ACCOUNT_ID")
    datadog_module = get_env("DATADOG_MODULE")
}
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "spn-terraform-tfstate"
    key = "${path_relative_to_include()}/${local.account}/${local.datadog_module}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
   } 
}

inputs ={
# region = "ap-south-1"
datadog_site = "datadoghq.com"
kafka_service_name = [
   {
      service_name                  = "usm"
      component_name                = "usm"
      priority                      =  4
      query_time_window             = "last_5m"
      message                       = "Alert triggered for Mongodb"
      runbook                       = ""
      notification_channel          = "@slack-usm_tech_alerts @webhook-DD-Squadcast-Integration"
      kafka_under_replicated_critical     = "1"
      kafka_under_replicated_query        = ""
      kafka_offline_partitions_critical   = "1"
      kafka_offline_partitions_query      = ""
      kafka_controller_count_query        = ""
      #kafka_controller_count_critical     = "0"
      #kafka_controller_count_warning      = "0.5"
      kafka_disk_used_query               = "" 
      kafka_disk_used_critical            = "90"
      kafka_consumer_lag_query            = ""
      kafka_consumer_lag_critical         = "1000"
      kafka_idle_percent_query            = ""
      kafka_idle_percent_critical         = "10"
      roster                              = "@slack-usm_tech_alerts"
    }
]
  }