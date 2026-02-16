terraform {
    source = "../modules/S3"
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
s3_service_name = [
   {
      service_name                  = "gv2"
      component_name                = "gv2-atombuild-eks-node"
      priority                      =  4
      query_time_window             = "last_1h"
      message                       = "Alert triggered for S3"
      runbook                       = ""
      notification_channel          = "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
      s3_5xx_critical_threshold     = "0.95"
      s3_unusal_increase_bucket_size = "1"
      s3_5xx_query                  = ""
      s3_bucket_increase_query        = ""
      roster                        = "@slack-godavari-beacon-api-tech-alerts"
    }
]
  }