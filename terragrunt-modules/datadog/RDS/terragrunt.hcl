terraform {
    source = "../modules/RDS"
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
rds_service_name = [
                        { 
                        "service_name" : "gv2",
                        "component_name": "atomhub-db"
                        "priority" : 1,
                        "message" : "RDS Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_10m",
                        "rds_cpu_metric_critical" : "80"
                        "rds_dbconnections_metric_critical": "100"
                        "rds_freeable_memory_metrics_critical" : "3500000000"
                        "rds_free_storage_threshold" = "15"
                        "roster" : "@slack-godavari-beacon-api-tech-alerts"
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                        "rds_cpu_query" : ""
                        "rds_memory_query": ""
                        "rds_dbconnections_query": ""
                        },
                         { 
                        "service_name" : "td",
                        "component_name": "td"
                        "priority" : 1,
                        "message" : "RDS Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "rds_cpu_metric_critical" : "80"
                        "rds_dbconnections_metric_critical": "1000"
                        "rds_freeable_memory_metrics_critical" : "3500000000"
                        "rds_free_storage_threshold" = "15"
                        "roster" : "@slack-targeted-delivery-api-alerts"
                        "notification_channel" : "@slack-targeted-delivery-api-alerts @webhook-DD-Squadcast-Integration"
                        "rds_cpu_query" : ""
                        "rds_memory_query": ""
                        "rds_dbconnections_query": ""
                        },
                        { 
                        "service_name" : "es",
                        "component_name": "es"
                        "priority" : 1,
                        "message" : "RDS Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "rds_cpu_metric_critical" : "80"
                        "rds_dbconnections_metric_critical": "1000"
                        "rds_freeable_memory_metrics_critical" : "3500000000"
                        "rds_free_storage_threshold" = "15"
                        "roster" : "@slack-spni_prod_es_alerts"
                        "notification_channel" : "@slack-spni_prod_es_alerts @webhook-DD-Squadcast-Integration"
                        "rds_cpu_query" : ""
                        "rds_memory_query": ""
                        "rds_dbconnections_query": ""
                        }
]
}