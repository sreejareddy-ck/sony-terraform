terraform {
    source = "../modules/ECS"
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
cluster_service_name = [
                      { 
                        "service_name" : "agl", 
                        "component_name" : "agl-core-listing",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "50",
                        "runbook" : "",
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-agl-alerts",
                        "query" : ""
                      },
                      { 
                        "service_name" : "agl", 
                        "component_name" : "agl-core-playback",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "50",
                        "runbook" : "",
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-agl-alerts",
                        "query" : ""
                      },
                      { 
                        "service_name" : "agl", 
                        "component_name" : "agl-core-umsps",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "50",
                        "runbook" : "",
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-agl-alerts",
                        "query" : ""
                      },
                      { 
                        "service_name" : "agl", 
                        "component_name" : "agl-core-appconfig",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "50",
                        "runbook" : "",
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-agl-alerts",
                        "query" : ""
                      },
                      { 
                        "service_name" : "agl", 
                        "component_name" : "agl-core-cont-watch",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "50",
                        "runbook" : "",
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-agl-alerts",
                        "query" : ""
                      },
                       { 
                        "service_name" : "blitz", 
                        "component_name" : "blitz-core-services",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "80",
                        "runbook" : "Enter Runbook link here",
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-blitz-prod-alerts",
                        "query" : ""
                      },
                      { 
                        "service_name" : "b2b-revamp", 
                        "component_name" : "b2b-revamp-prod-playback",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "80",
                        "runbook" : "Enter Runbook link here",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-spni_prod_b2b_alerts",
                        "query" : ""
                      },
                      { 
                        "service_name" : "b2b-revamp", 
                        "component_name" : "b2b-revamp-prod-common",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "80",
                        "runbook" : "Enter Runbook link here",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-spni_prod_b2b_alerts",
                        "query" : ""
                      }, 
                      { 
                        "service_name" : "b2b-revamp", 
                        "component_name" : "b2b-revamp-prod-playback2",
                        "priority" : 1, 
                        "message" : "ECS Alert triggered",
                        "query_time_window": "last_5m",
                        "cluster_cpu_utilization_threshold_critical" : "80",
                        "cluster_memory_reservation_threshold_critical" : "80",
                        "runbook" : "Enter Runbook link here",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-spni_prod_b2b_alerts",
                        "query" : ""
                      },

]
}