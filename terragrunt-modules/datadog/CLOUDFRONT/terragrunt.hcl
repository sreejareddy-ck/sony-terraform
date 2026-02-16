terraform {
    source = "../modules/CLOUDFRONT"
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
CloudFront_monitors = [
                        { 
                        "service_name" : "agl",
                        "component_name" : "agl-core-appconfig",
                        "priority" : 3,
                        "message" : "Cloud Front Alert triggered",
                        "cloudfront_4xx_errors_threshold_critical" : 2,
                        "cloudfront_total_errors_threshold_critical" : 10000,
                        "cloudfront_5xx_errors_threshold_critical" : 1,
                        "runbook" : "",
                        "query_time_window" : "last_5m",
                        "notification_channel" : "@slack-CloudFront-alerts @webhook-DD-Squadcast-Integration",
                        "roster": "@slack-CloudFront-alerts",
                        "query" : ""
                      }
]
}