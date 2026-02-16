terraform {
    source = "../modules/AWS_INTEGRATION"
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
# datadog_api_key = "28c176785900127ca2348e7f2556565f"
# datadog_app_key = "180e010c65ad95e49df741e3e2f1668af34ef3ef"

}