terraform {
  source = "../modules/EC2"
}

locals {
  account        = get_env("ACCOUNT_ID")
  datadog_module = get_env("DATADOG_MODULE")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "spn-terraform-tfstate"
    key            = "${path_relative_to_include()}/${local.account}/${local.datadog_module}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}

inputs = {
  datadog_site = "datadoghq.com"

  ec2_service_name = [
    {
      service_name             = "td"
      component_name           = "td"
      priority                 =  1
      query_time_window        = "last_2m"
      message                  = "EC2 alert triggered"
      cpu_threshold_critical   = 80
      memory_threshold_critical = 85
      disk_threshold_critical   = 90
      runbook                  = ""
      notification_channel     = "@slack-ec2-alerts @webhook-DD-Squadcast-Integration"
      roster                   = "@slack-ec2-alerts"
      query                    = ""
    },
    {
      service_name             = "tlb"
      component_name           = "tlb"
      priority                 =  1
      query_time_window        = "last_2m"
      message                  = "EC2 alert triggered"
      cpu_threshold_critical   = 80
      memory_threshold_critical = 85
      disk_threshold_critical   = 90
      runbook                  = ""
      notification_channel      = "@slack-ec2-alerts @webhook-DD-Squadcast-Integration"
      roster                   = "@slack-ec2-alerts"
      query                    = ""
    }
  ]
}


