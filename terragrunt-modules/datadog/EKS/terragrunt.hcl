terraform {
    source = "../modules/EKS"
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
container_service_name = [
                        { 
                        "service_name" : "gv2-priority", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "gv2-batched", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "proxy-service", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-usm_tech_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-usm_tech_alerts @webhook-DD-Squadcast-Integration"
                    },
                     { 
                        "service_name" : "mweb", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-spni_mweb_tech_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-spni_mweb_tech_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "web", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-spni_web_tech_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-spni_web_tech_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "b2b-jio-prod", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-spni_prod_b2b_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "b2b-airtel-prod", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-spni_prod_b2b_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "b2b-common-prod", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-spni_prod_b2b_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "b2b-catalog-prod", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-spni_prod_b2b_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "b2b-ingestion-prod", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-spni_prod_b2b_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "b2b-subscription-prod", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-spni_prod_b2b_alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "coralogix-opentelemetry-collector", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-eks-cluster-infra-alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
                    },
                    { 
                        "service_name" : "coredns", 
                        "priority" : 1,
                        "message" : "EKS Alert triggered",
                        "query_time_window": "last_5m",
                        "runbook" : "",
                        "roster" : "@slack-eks-cluster-infra-alerts",
                        "container_cpu_metric_critical" : "80",
                        "container_memory_metric_critical" : "80",
                        "container_restart_metric_critical" : "5",
                        "container_crashloopbackoff_metric_critical" : "5",
                        "container_oom_metric_critical" : "5",
                        "container_maxhpa_metric_critical" : "80",
                        "container_capacity_critical" : "70",
                        "query" : "",
                        "notification_channel" : "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
                    }
]
}