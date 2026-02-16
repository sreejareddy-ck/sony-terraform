terraform {
    source = "../modules/CLICKHOUSE"
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
Clickhouse_service_name = [
                        { 
                        "service_name" : "godavari2-prod", 
                        "priority" : 1, 
                        "message" : "Clickhouse Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_10m",
                        "critical_memory_threshold" : "80",
                        "failed_inserted_queries"   : "10",
                        "Insert_query_count_threshold": "15000",
                        "Insert_query_latency_threshold": "20",
                        "roster"  : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        }
]
}