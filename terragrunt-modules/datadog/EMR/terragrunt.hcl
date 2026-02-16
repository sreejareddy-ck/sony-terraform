terraform {
    source = "../modules/EMR"
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
emr_service_name = [
                        { 
                        "service_name" : "gv2", 
                        "component_name":  "priority-emr"
                        "priority" : 1,
                        "message" : "EMR Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "application_failed_metric"       = 50
                        "application_pending_metric"      = 100
                        "cluster_hfdc_utilisation_metric"       = 70
                        "cluster_yarn_memory_utilisation_metric"       = 10
                        "cluster_unhealthy_nodes_metric"       = 20
                        "roster" : "@slack-godavari-beacon-api-tech-alerts"
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                                                { 
                        "service_name" : "gv2", 
                        "component_name":  "trino-emr"
                        "priority" : 1,
                        "message" : "EMR Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "application_failed_metric"       = 10
                        "application_pending_metric"      = 40
                        "cluster_hfdc_utilisation_metric"       = 70
                        "cluster_yarn_memory_utilisation_metric"       = 70
                        "cluster_unhealthy_nodes_metric"       = 20
                        "roster" : "@slack-godavari-beacon-api-tech-alerts"
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "gv2", 
                        "component_name":  "priority-evergent-emr"
                        "priority" : 1,
                        "message" : "EMR Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "application_failed_metric"       = 10
                        "application_pending_metric"      = 40
                        "cluster_hfdc_utilisation_metric"       = 70
                        "cluster_yarn_memory_utilisation_metric"       = 70
                        "cluster_unhealthy_nodes_metric"       = 20
                        "roster" : "@slack-godavari-beacon-api-tech-alerts"
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "gv2", 
                        "component_name":  "godavari-cluster"
                        "priority" : 1,
                        "message" : "EMR Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "application_failed_metric"       = 10
                        "application_pending_metric"      = 40
                        "cluster_hfdc_utilisation_metric"       = 70
                        "cluster_yarn_memory_utilisation_metric"       = 70
                        "cluster_unhealthy_nodes_metric"       = 20
                        "roster" : "@slack-godavari-beacon-api-tech-alerts"
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        }
]
}