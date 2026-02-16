terraform {
    source = "../modules/KINESIS_STREAM"
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
KINESIS_STREAM_service_name = [
                        { 
                        "service_name" : "gv2", 
                        "component_name" : "beaconapi-kinesis-data-stream-ondemand",
                        "priority" : 1,
                        "message" : "Kinesis stream Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_10m",
                        "GetRecords_iterator_age_metric_critical" : "300000",
                        "write_latency_metric_critical" : "20",
                        "write_throttling_metric_critical" : "100",
                        "read_throttling_metric_critical" : "0.1",
                        "read_latency_metric_critical" : "20",
                        "query" : "",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "gv2", 
                        "component_name" : "batched-kinesis-stream-provisioned",
                        "priority" : 1,
                        "message" : "Kinesis stream Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_10m",
                        "GetRecords_iterator_age_metric_critical" : "300000",
                        "write_latency_metric_critical" : "20",
                        "write_throttling_metric_critical" : "50",
                        "read_throttling_metric_critical" : "0.1",
                        "read_latency_metric_critical" : "20",
                        "query" : "",
                        "roster": "@slack-godavari-beacon-api-tech-alerts"
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                    },
                     { 
                        "service_name" : "godavari", 
                        "component_name" : "godavari-kinesis-data-streams",
                        "priority" : 1,
                        "message" : "Kinesis stream Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_10m",
                        "GetRecords_iterator_age_metric_critical" : "3600000",
                        "write_latency_metric_critical" : "20",
                        "write_throttling_metric_critical" : "0.1",
                        "read_throttling_metric_critical" : "10",
                        "read_latency_metric_critical" : "20",
                        "query" : "",
                        "roster": "@slack-godavari_kinesis_alerts"
                        "notification_channel" : "@slack-godavari_kinesis_alerts @webhook-DD-Squadcast-Integration"
                    },
                     { 
                        "service_name" : "godavari", 
                        "component_name" : "godavari-kinesis-data-streams-1",
                        "priority" : 1,
                        "message" : "Kinesis stream Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_10m",
                        "GetRecords_iterator_age_metric_critical" : "3600000",
                        "write_latency_metric_critical" : "20",
                        "write_throttling_metric_critical" : "0.1",
                        "read_throttling_metric_critical" : "10",
                        "read_latency_metric_critical" : "20",
                        "query" : "",
                        "roster": "@slack-godavari_kinesis_alerts"
                        "notification_channel" : "@slack-godavari_kinesis_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "godavari", 
                        "component_name" : "godavari-kinesis-data-streams-2",
                        "priority" : 1,
                        "message" : "Kinesis stream Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_10m",
                        "GetRecords_iterator_age_metric_critical" : "3600000",
                        "write_latency_metric_critical" : "20",
                        "write_throttling_metric_critical" : "0.1",
                        "read_throttling_metric_critical" : "10",
                        "read_latency_metric_critical" : "20",
                        "query" : "",
                        "roster": "@slack-godavari_kinesis_alerts"
                        "notification_channel" : "@slack-godavari_kinesis_alerts @webhook-DD-Squadcast-Integration"
                    }
]
}