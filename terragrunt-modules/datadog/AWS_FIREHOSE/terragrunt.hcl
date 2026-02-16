terraform {
    source = "../modules/AWS_FIREHOSE"
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
Firehose_service_name = [
                        { 
                        "service_name" : "gv2", 
                        "component_name" : "gv2-batched-kinesis-firehose",
                        "priority" : 1, 
                        "message" : "Firehose Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "s3_success_rate" : "0.9",
                        "s3_data_freshness" : "699",
                        "throttled_get_records" : "400",
                        "roster"  :  "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                        { 
                        "service_name" : "gv2", 
                        "component_name" : "gv2-priority-kinesis-firehose",
                        "priority" : 1, 
                        "message" : "Firehose Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "s3_success_rate" : "0.9",
                        "s3_data_freshness" : "720",
                        "throttled_get_records" : "400",
                        "roster"  :  "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                        { 
                        "service_name" : "gv2", 
                        "component_name" : "gv2-on-demand-kinesis-firehose",
                        "priority" : 1, 
                        "message" : "Firehose Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "s3_success_rate" : "0.9",
                        "s3_data_freshness" : "720",
                        "throttled_get_records" : "400",
                        "roster"  :  "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        }                 
]
}
