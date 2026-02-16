terraform {
    source = "../modules/SNS"
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
sns_monitors = [
                        { 
                        "service_name" : "gv2",
                        "component_name" : "gv2-transaction-sns",
                        "priority" : 4,
                        "query_time_window": "last_5m",
                        "message" : "SNS Alert triggered",
                        "sns_failure_rate_threshold_critical" = 5,
                        "sns_failed_notification_count_threshold_critical" = 10,
                        "sns_Number_of_Messages_Published_threshold_critical" = 5000,
                        "runbook" : "",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "roster":"@slack-godavari-beacon-api-tech-alerts",
                        "query" : ""
                      }
]
}