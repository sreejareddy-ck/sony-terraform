terraform {
    source = "../modules/MONGODB"
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
mongodb_service_name = [
   {
      service_name                  = "sf-live"
      component_name                = "sf-live"
      clustername                   = "sf-live-prod"
      priority                      =  3
      query_time_window             = "last_5m"
      message                       = "Alert triggered for MongoDB"
      runbook                       = ""
      notification_channel          = "@slack-spni_prod_sf_live_alerts @webhook-DD-Squadcast-Integration"
      mongodb_connections_critical          = "800"
      mongodb_disk_read_latency_critical    = "20"
      mongodb_disk_write_latency_critical   = "20"     
      mongodb_replication_lag_critical      = "60"     
      mongodb_memory_used_critical          = "80"    
      mongodb_cpu_user_critical             = "85"     
      mongodb_disk_iops_reads_critical      = "5000"  
      mongodb_disk_iops_writes_critical     = "5000"  
      mongodb_connections_query     = ""  
      mongodb_memory_used_query     = ""
      mongodb_cpu_user_query        = ""
      roster                        = "@slack-spni_prod_sf_live_alerts"
    }
]
  }