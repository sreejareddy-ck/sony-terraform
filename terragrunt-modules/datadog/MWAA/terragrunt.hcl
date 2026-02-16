terraform {
    source = "../modules/MWAA"
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
mwaa_service_name = [
                        { 
                        "service_name" : "gv2",
                        "component_name" : "godavari2-prod-mwaa-env", 
                        "priority" : 1,
                        "message" : "MWAA Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "mwaa_cpu_metric_critical" : "80",
                        "mwaa_memory_metric_critical": "80",
                        "mwaa_queued_tasks_metric_critical": "10",
                        "mwaa_oldest_task_metric_critical" : "10",
                        "mwaa_dag_run_failure_metric_critical" : "0",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts"
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        }
]
}