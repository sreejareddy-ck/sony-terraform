terraform {
    source = "../modules/LAMBDA"
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
lambda_monitors = [
                        { 
                        "function_name" : "agl-common-ext-process-lambda",
                        "service_name" : "agl-common-ext-process-lambda",
                        "component_name" : "agl-common-ext-process-lambda",
                        "priority" : 1,
                        "query_time_window"    = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_1h"
                            throttles       = "last_15m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "0.2",
                        "pct_errors_threshold_critical" : "20",
                        "throttles_threshold_critical" : "0.2",
                        "runbook" : "",
                        "notification_channel" : "@slack-lambda-alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-lambda-alerts",
                        "query" : ""
                      },
                      { 
                        "function_name" : "godavari2-prod-schema-registry",
                        "service_name" : "gv2",
                        "component_name" : "schema-registry-lambda",
                        "priority" : 1,
                        "query_time_window"    = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_10m"
                            throttles       = "last_10m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "0.2",
                        "pct_errors_threshold_critical" : "20",
                        "throttles_threshold_critical" : "0.2",
                        "runbook" : "",
                        "notification_channel" : "@slack-usm_tech_alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-lambda-alerts",
                        "query" : ""
                      },
                      { 
                        "function_name" : "godavari2-prod-job-trigger",
                        "service_name" : "gv2",
                        "component_name" : "job-trigger-lambda",
                        "priority" : 1,
                        "query_time_window"    = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_10m"
                            throttles       = "last_10m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "0.2",
                        "pct_errors_threshold_critical" : "20",
                        "throttles_threshold_critical" : "0.2",
                        "runbook" : "",
                        "notification_channel" : "@slack-usm_tech_alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-lambda-alerts",
                        "query" : ""
                      },
                       { 
                        "function_name" : "b2b-granular-config-handler-prod",
                        "service_name" : "b2b",
                        "component_name" : "b2b-granular-config-handler-prod",
                        "priority" : 1,
                        "query_time_window"    = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_5m"
                            throttles       = "last_5m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "0.2",
                        "pct_errors_threshold_critical" : "20",
                        "throttles_threshold_critical" : "0.2",
                        "runbook" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-spni_prod_b2b_alerts",
                        "query" : ""
                      },
                      { 
                        "function_name" : "b2b-push-notification-es",
                        "service_name" : "b2b",
                        "component_name" : "b2b-push-notification-es",
                        "priority" : 1,
                        "query_time_window"    = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_5m"
                            throttles       = "last_5m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "0.2",
                        "pct_errors_threshold_critical" : "20",
                        "throttles_threshold_critical" : "0.2",
                        "runbook" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-spni_prod_b2b_alerts",
                        "query" : ""
                      },
                       { 
                        "function_name" : "b2b-push-notifications",
                        "service_name" : "b2b",
                        "component_name" : "b2b-push-notifications",
                        "priority" : 1,
                        "query_time_window"    = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_5m"
                            throttles       = "last_5m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "5",
                        "pct_errors_threshold_critical" : "20",
                        "throttles_threshold_critical" : "0.2",
                        "runbook" : "",
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-spni_prod_b2b_alerts",
                        "query" : ""
                      },
                       { 
                        "function_name" : "spn-search-os-updates-prod",
                        "service_name" : "es",
                        "component_name" : "spn-search-os-updates-prod",
                        "priority" : 1,
                        "query_time_window"    = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_10m"
                            throttles       = "last_10m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "0.2",
                        "pct_errors_threshold_critical" : "20",
                        "throttles_threshold_critical" : "0.2",
                        "runbook" : "",
                        "notification_channel" : "@slack-spni_prod_es_alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-spni_prod_es_alerts",
                        "query" : ""
                      },
                       { 
                        "function_name" : "spn-os-updates-prod",
                        "service_name" : "es",
                        "component_name" : "spn-os-updates-prod",
                        "priority" : 1,
                        "query_time_window"    = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_10m"
                            throttles       = "last_10m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "0.2",
                        "pct_errors_threshold_critical" : "20",
                        "throttles_threshold_critical" : "0.2",
                        "runbook" : "",
                        "notification_channel" : "@slack-spni_prod_es_alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-spni_prod_es_alerts",
                        "query" : ""
                      },
                        { 
                        "function_name" : "sonyliv-prod-godavari-csv-builder",
                        "service_name"  : "godavari",
                        "component_name": "godavari",
                        "priority"      : 1,
                        "query_time_window" = {
                            cold_start_rate = "last_15m"
                            pct_errors      = "last_5m"
                            throttles       = "last_5m"
                        }
                        "message" : "Lambda Alert triggered",
                        "cold_start_threshold_critical" : "0.2",
                        "pct_errors_threshold_critical" : "1",
                        "throttles_threshold_critical"  : "1",
                        "runbook" : "",
                        "notification_channel" : "@slack-godavari_lambda_alerts @webhook-DD-Squadcast-Integration",
                        "roster" : "@slack-godavari_lambda_alerts",
                        "query"  : ""
                      }

]
}